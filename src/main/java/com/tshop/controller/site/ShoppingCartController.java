package com.tshop.controller.site;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tshop.model.DataLayoutMaster;

@Controller
@RequestMapping("/shoppingcart")
public class ShoppingCartController {
	
	private static DataLayoutMaster dataLayoutMaster = new DataLayoutMaster();
	private String layout = "site/client_layout";
	
	static {
		dataLayoutMaster.setTitle("Home shop");
		dataLayoutMaster.setView("shoppingcart/shoppingcart.jsp");
	}
	
	@GetMapping("")
	public String index(Model model) {
		Map<String, Object> objs = new HashMap<String, Object>();
//		objs.put("banner", true);
		objs.put("hero_normal", true);
		dataLayoutMaster.setObjs(objs);
		model.addAttribute("content", dataLayoutMaster);
		
		return layout;
	}
}
