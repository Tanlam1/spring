package com.tshop.controller.site;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tshop.domain.Category;
import com.tshop.domain.Product;
import com.tshop.model.CategoryDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.model.ProductDTO;
import com.tshop.service.CategoryService;
import com.tshop.service.ProductService;

@Controller
@RequestMapping("/")
public class HomeController {
	@Autowired
	CategoryService categoryService;
	@Autowired
	ProductService productService;
	private static DataLayoutMaster dataLayoutMaster = new DataLayoutMaster();
	private String layout = "site/client_layout";
	
	static {
		dataLayoutMaster.setTitle("Home shop");
		dataLayoutMaster.setView("home/home.jsp");
	}
	
	@GetMapping("index")
	public String index(Model model) {
		Map<String, Object> objs = new HashMap<String, Object>();
		objs.put("banner", true);
//		objs.put("hero_normal", true);
		dataLayoutMaster.setObjs(objs);
		List<Category> list = categoryService.findAll();
		List<CategoryDTO> list1 = new ArrayList<CategoryDTO>();
		for (Category  item : list) {
			
			CategoryDTO categoryDTO = new CategoryDTO();
			
			BeanUtils.copyProperties(item, categoryDTO);
			
			list1.add(categoryDTO);
		}
		objs.put("categorySite", list1);
		
		List<Product> list2 = productService.findAll();
		List<ProductDTO> list3 = new ArrayList<ProductDTO>();
		for (Product  item : list2) {
			
			ProductDTO productDTO = new ProductDTO();
			
			BeanUtils.copyProperties(item, productDTO);
			
			productDTO.setCategoryId(item.getCategory().getCategoryId());
			
			list3.add(productDTO);
		}
		objs.put("productSite", list3);
		dataLayoutMaster.setObjs(objs);
		model.addAttribute("content", dataLayoutMaster);
		return layout;
	}
}
