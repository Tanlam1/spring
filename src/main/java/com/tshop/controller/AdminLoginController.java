package com.tshop.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.tshop.domain.Account;
import com.tshop.model.AdminLoginDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.service.AccountService;
import com.tshop.service.CookieService;
import com.tshop.service.SessionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/dashboard")
public class AdminLoginController {
	
	@Autowired
	private AccountService accountService;
	@Autowired
	private SessionService sessionService;
	@Autowired
	private CookieService cookieService;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	static private DataLayoutMaster dataLayoutAdmin = new DataLayoutMaster();
	static private String layout = "auth/auth_layout";
	
	static {
		dataLayoutAdmin.setTitle("Admin Login Tshop");
		dataLayoutAdmin.setHeading_text("Login Page");
		dataLayoutAdmin.setView("login/login.jsp");
	}

	@GetMapping("/login")
	public String login(Model model) {
		Map<String, Object> objs = new HashMap<String, Object>();
		
		objs.put("loginActive", "active");
		objs.put("u_rmbC", cookieService.getValue("u_rmbC", ""));
		objs.put("p_rmbC", cookieService.getValue("p_rmbC", ""));
		objs.put("cbox_rmbC", cookieService.getValue("cbox_rmbC", ""));
		
		dataLayoutAdmin.setObjs(objs);
		
		model.addAttribute("content", dataLayoutAdmin);
		model.addAttribute("account", new AdminLoginDTO());
		return layout;
	}
	
	@PostMapping("/login")
	public ModelAndView postLogin(ModelMap model,
			@Valid @ModelAttribute("account") AdminLoginDTO dto,
			BindingResult result) {
		
		if(result.hasErrors()) {
			
			model.addAttribute("content", dataLayoutAdmin);
			return new ModelAndView(layout, model);
		}
		
		Account account = accountService.login(dto.getUsername(), dto.getPassword());
		
		if(account == null) {
			
			model.addAttribute("content", dataLayoutAdmin);
			model.addAttribute("message", "Thất bại! Tên đăng nhập hoặc mật khẩu không đúng.");
			System.out.println("Sai đăng nhập");
			return new ModelAndView(layout, model);
		}
		
		//Remember account
		if(dto.getRememberMe() != null) {
			cookieService.add("u_rmbC", dto.getUsername(), 720, "/dashboard/login");
			cookieService.add("p_rmbC", dto.getPassword(), 720, "/dashboard/login");
			cookieService.add("cbox_rmbC", "checked", 720, "/dashboard/login");
		} else {
			cookieService.remove("u_rmbC", "/dashboard/login");
			cookieService.remove("p_rmbC", "/dashboard/login");
			cookieService.remove("cbox_rmbC", "/dashboard/login");
		}
		
		sessionService.set("admin_kodoku_KShop", account.getUsername());
		
		Object rUri = sessionService.get("redirect-uri", null);
		
		if(rUri != null) { // kiểm tra xem có uri trước khi redirect qua login ko
			sessionService.remove("redirect-uri");
			return new ModelAndView("redirect:" + rUri);
		}
		
		return new ModelAndView("redirect:/admin");
		
	}
	
	@GetMapping("/logout") 
	public String logout() {
		
		sessionService.remove("admin_kodoku_KShop");
		
		return "redirect:/dashboard/login";
	}
}
