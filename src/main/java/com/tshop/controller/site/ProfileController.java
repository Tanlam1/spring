package com.tshop.controller.site;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.tshop.domain.Category;
import com.tshop.domain.Customer;
import com.tshop.domain.Order;
import com.tshop.model.CategoryDTO;
import com.tshop.model.CustomerDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.service.CustomerService;
import com.tshop.service.OrderService;
import com.tshop.service.SessionService;

@Controller
@RequestMapping("/profile")
public class ProfileController {
	@Autowired
	SessionService sessionService;
	@Autowired
	CustomerService customerService;
	@Autowired
	OrderService orderService;
	private static DataLayoutMaster dataLayoutMaster = new DataLayoutMaster();
	private String layout = "site/client_layout";
	
	static {
		dataLayoutMaster.setTitle("Home shop");
		dataLayoutMaster.setView("profile/profile.jsp");
	}
	
	@GetMapping("")
	public String index(Model model) {
		Map<String, Object> objs = new HashMap<String, Object>();
//		objs.put("banner", true);
		objs.put("hero_normal", true);
		model.addAttribute("content", dataLayoutMaster);
		Customer customer = sessionService.get("userLogin");
		CustomerDTO customerDTO = new CustomerDTO();
		BeanUtils.copyProperties(customer, customerDTO);
		model.addAttribute("customer", customerDTO);
		dataLayoutMaster.setObjs(objs);
		return layout;
	}
	@PostMapping("update")
	public ModelAndView Update(ModelMap model,@ModelAttribute("customer") CustomerDTO dto, 
			BindingResult result) {
		Customer customer = new Customer();
		BeanUtils.copyProperties(dto, customer);
		Set<Order> oders = orderService.fyByCustomerId(dto.getCustomerId());
		customer.setOrders(oders);
		Optional<Customer> customer1 =  customerService.findById(dto.getCustomerId());
		customer.setPassword(customer1.get().getPassword());
		customerService.save(customer);
		sessionService.set("userLogin", customer);
		return new ModelAndView("redirect:/profile", model);
	}
}
