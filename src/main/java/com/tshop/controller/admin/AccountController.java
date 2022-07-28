package com.tshop.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.tshop.domain.Account;
import com.tshop.domain.Category;
import com.tshop.model.AccountDTO;
import com.tshop.model.CategoryDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.service.AccountService;
import com.tshop.service.CategoryService;

import org.apache.jasper.tagplugins.jstl.core.If;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import ch.qos.logback.core.joran.util.beans.BeanUtil;

@Controller
@RequestMapping("/admin/accounts")
public class AccountController {
	
	@Autowired
	AccountService accountService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	HttpServletRequest request;
	
	static DataLayoutMaster dataLayoutAdmin = new DataLayoutMaster();
	
	static {
		dataLayoutAdmin.setHeading_text("Accounts");
		dataLayoutAdmin.setTitle("Accounts | Tshop");
	}
	
	@GetMapping("/add")
	public String add(Model model) {
		
		Map<String, Object> objs = new HashMap<String, Object>();		
		objs.put("accountsActive", "active");
		
		dataLayoutAdmin.setView("accounts/addOrEdit.jsp");
		dataLayoutAdmin.setObjs(objs);
		
		model.addAttribute("content", dataLayoutAdmin);
		model.addAttribute("account", new AccountDTO());
		return "admin/dashboard_layout";
	}
	
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(
			ModelMap model, 
			@Valid @ModelAttribute("account") AccountDTO dto,
			BindingResult result) {
		
		String oldPassword = request.getParameter("old_password");
		boolean equalOldPass = true;
		
		if(oldPassword != null) {
			
			Optional<Account> optional = accountService.findById(dto.getUsername());
			
			equalOldPass = bCryptPasswordEncoder.matches(oldPassword, optional.get().getPassword());
		}
		
		if(result.hasErrors() || !equalOldPass) {
			dataLayoutAdmin.setView("accounts/addOrEdit.jsp");
			if(!dto.getIsFromAdd()) dto.setIsEdit(true);
			
			Map<String, Object> objs = new HashMap<String, Object>();
			objs.put("account", dto);
			objs.put("accountsActive", "active");
			dataLayoutAdmin.setObjs(objs);
			
			model.addAttribute("content", dataLayoutAdmin);			
			if(!equalOldPass) model.addAttribute("error_edit_account", "Mật khẩu cũ chưa đúng");
			return new ModelAndView("admin/dashboard_layout", model);
		}
				
		Account entity = new Account();
		BeanUtils.copyProperties(dto, entity);
		
		accountService.save(entity);
		
		return new ModelAndView("redirect:/admin/accounts", model);
	}
	
	@GetMapping("edit/{accountUsername}")
	public ModelAndView edit(ModelMap model, 
			@PathVariable("accountUsername") String accountUsername) {
		
		Optional<Account> optional = accountService.findById(accountUsername);
		AccountDTO dto = new AccountDTO();
		if(optional.isPresent()) {

			Map<String, Object> objs = new HashMap<String, Object>();	
			
			Account entity = optional.get();
			
			BeanUtils.copyProperties(entity, dto);
			
			dto.setIsEdit(true);
			dto.setIsFromAdd(false);
			
			objs.put("account", dto);
			
			objs.put("accountsActive", "active");
			
			dataLayoutAdmin.setView("accounts/addOrEdit.jsp");
			dataLayoutAdmin.setObjs(objs);
			
			model.addAttribute("content", dataLayoutAdmin);
			return new ModelAndView("admin/dashboard_layout", model);
		}
		
		model.addAttribute("message", "Không tồn tại account");
		
		return new ModelAndView("redirect:/admin/accounts", model);
	}
	
	@GetMapping("delete/{accountUsername}")
	public ModelAndView delete(ModelMap model, @PathVariable("accountUsername") String accountUsername) {
		
		Optional<Account> entity = accountService.findById(accountUsername);
		String msg = "Account không tồn tại";
		if(entity.isPresent()) {
			accountService.deleteById(accountUsername);
			msg = "Xóa thành công " + entity.get().getUsername();
		}
		
		model.addAttribute("message", msg);
		return new ModelAndView("redirect:/admin/accounts", model);
	}
	
	@GetMapping("") 
	public String list(ModelMap model, 
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "page", required = false) Optional<Integer> page,
			@RequestParam(name = "size", required = false) Optional<Integer> size) {

		Map<String, Object> objs = new HashMap<String, Object>();
		
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(10);
		
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize);
		Page<Account> resultPage = null;
		
		if(StringUtils.hasText(keyword)) {
			resultPage = accountService.findByUsernameContaining(keyword, pageable);
			objs.put("keyword", keyword);
		} else {
			resultPage = accountService.findAll(pageable);
		}
		
		int totalPages = resultPage.getTotalPages();
		
		if(totalPages > 0) {
			int start = Math.max(1, currentPage - 2);
			int end   = Math.min(currentPage + 2, totalPages);
			
			if(totalPages > 5) {
				if(end == totalPages) start = end - 5;
				else if (start == 1) end = start + 5;
			}
			
			List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
					.boxed()
					.collect(Collectors.toList());
			
			objs.put("pageNumbers", pageNumbers);
		}
		
		objs.put("accountPage", resultPage);
		objs.put("accountsActive", "active");
		
		dataLayoutAdmin.setView("accounts/accounts.jsp");
		dataLayoutAdmin.setObjs(objs);

		model.addAttribute("content", dataLayoutAdmin);
		return "admin/dashboard_layout";
	}
	
	
}
