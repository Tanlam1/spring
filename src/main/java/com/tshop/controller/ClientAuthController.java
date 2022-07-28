package com.tshop.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.tshop.domain.Account;
import com.tshop.domain.Customer;
import com.tshop.model.AdminLoginDTO;
import com.tshop.model.CustomerDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.service.AccountService;
import com.tshop.service.CookieService;
import com.tshop.service.CustomerService;
import com.tshop.service.SessionService;

import org.springframework.beans.BeanUtils;
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
@RequestMapping("/auth")
public class ClientAuthController {
	
	@Autowired
	private AccountService accountService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private SessionService sessionService;
	@Autowired
	private CookieService cookieService;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	@Autowired
	private HttpServletRequest request;
	
	static private DataLayoutMaster dataLayoutMaster = new DataLayoutMaster();
	static private String layout = "auth_site/auth_layout";
	
	static {
		dataLayoutMaster.setTitle("Login page | Tshop");
		dataLayoutMaster.setHeading_text("Login page");
	}

	@GetMapping("/login")
	public String login(Model model) {
		Map<String, Object> objs = new HashMap<String, Object>();
		
		objs.put("loginActive", "active");
		
		dataLayoutMaster.setObjs(objs);
		dataLayoutMaster.setView("login/login.jsp");
		
		model.addAttribute("content", dataLayoutMaster);
		model.addAttribute("account", new CustomerDTO());
		return layout;
	}
	
	@PostMapping("/login")
	public ModelAndView postLogin(ModelMap model,
			@Valid @ModelAttribute("account") CustomerDTO dto,
			BindingResult result) {
		
		Customer customer = customerService.login(dto.getEmail(), dto.getPassword());


		if(customer == null) {
			Map<String, Object> objs = new HashMap<String, Object>();
			objs.put("account", dto);
			dataLayoutMaster.setObjs(objs);
			
			model.addAttribute("message", "Thất bại! Tên đăng nhập hoặc mật khẩu không đúng.");			
			model.addAttribute("content", dataLayoutMaster);
			return new ModelAndView(layout, model);	
		}
		
		
		
		sessionService.set("userLogin", customer);
		
		return new ModelAndView("redirect:/profile");
	}

	@GetMapping("/register")
	public String register(Model model) {
		Map<String, Object> objs = new HashMap<String, Object>();
				
		dataLayoutMaster.setObjs(objs);
		dataLayoutMaster.setView("register/register.jsp");
		dataLayoutMaster.setTitle("Register page | Tshop");
		
		model.addAttribute("content", dataLayoutMaster);
		model.addAttribute("account", new CustomerDTO());
		return layout;
	}

	@PostMapping("/register")
	public String register(ModelMap model,
			@Valid @ModelAttribute("account") CustomerDTO dto,
			BindingResult result) {
		
		if(result.hasErrors() || 
				!dto.getPassword().equals(request.getParameter("confirm_password")) || 
				!customerService.checkUniqueEmail(dto.getEmail())) {
			
			Map<String, Object> objs = new HashMap<String, Object>();
			objs.put("account", dto);
						
			dataLayoutMaster.setObjs(objs);
			dataLayoutMaster.setView("register/register.jsp");
			dataLayoutMaster.setTitle("Register page | Tshop");
			
			if(!dto.getPassword().equals(request.getParameter("confirm_password"))) 
				model.addAttribute("errorConfirmPassword", "Nhập lại password chưa đúng");
			if(!customerService.checkUniqueEmail(dto.getEmail()))
				model.addAttribute("errorUniqueEmail", "Email của bạn đã tồn tại!");
			
			model.addAttribute("content", dataLayoutMaster);
			return layout;
		}
		
		Customer customer = new Customer();
		
		BeanUtils.copyProperties(dto, customer);
		customer.setPassword(bCryptPasswordEncoder.encode(customer.getPassword()));
		
		customerService.save(customer);
		
		return "redirect:/auth/register";
	}
	
	@GetMapping("/logout")
	public String logout() {
		
		sessionService.remove("userLogin");
		return "redirect:/index";
	}
}
