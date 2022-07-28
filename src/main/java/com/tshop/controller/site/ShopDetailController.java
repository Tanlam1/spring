package com.tshop.controller.site;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.tshop.domain.Category;
import com.tshop.domain.Product;
import com.tshop.model.DataLayoutMaster;
import com.tshop.model.ProductDTO;
import com.tshop.service.ProductService;

@Controller
@RequestMapping("/shopdetail")
public class ShopDetailController {
	@Autowired
	ProductService productService;
	private static DataLayoutMaster dataLayoutMaster = new DataLayoutMaster();
	private String layout = "site/client_layout";

	static {
		dataLayoutMaster.setTitle("Home shop");
		dataLayoutMaster.setView("shopdetail/shopdetail.jsp");
	}

	@GetMapping("/{productId}")
	public String index(Model model, @PathVariable("productId") Long productId) {
		Map<String, Object> objs = new HashMap<String, Object>();
//		objs.put("banner", true);
		objs.put("hero_normal", true);

		Optional<Product> optional = productService.findById(productId);
		if(optional.isPresent()) {
			
			Product product = optional.get();
			
			ProductDTO productDTO = new ProductDTO();
			
			BeanUtils.copyProperties(product, productDTO);
			
			objs.put("product", productDTO);
		}
		
		dataLayoutMaster.setObjs(objs);
		model.addAttribute("content", dataLayoutMaster);
		return layout;
	}
}
