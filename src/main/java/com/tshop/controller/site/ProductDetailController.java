package com.tshop.controller.site;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import com.tshop.domain.Category;
import com.tshop.domain.Product;
import com.tshop.model.CategoryDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.model.ProductDTO;
import com.tshop.service.CategoryService;
import com.tshop.service.ProductService;
import com.tshop.service.SessionService;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/product/detail")
public class ProductDetailController {
	
	@Autowired
	CategoryService categoryService;
	@Autowired
	ProductService productService;
	
	private static DataLayoutMaster dataLayoutMaster = new DataLayoutMaster();
	private static String layout = "site/client_layout";
	
	static {
		dataLayoutMaster.setHeading_text("Home");
		dataLayoutMaster.setTitle("Tshop");
	}
	
	@ModelAttribute("status")
	public Map<Integer, String> getStatus(){
		
		Map<Integer, String> map = new HashMap<>();
		
		map.put(0, "Siêu sale");
		map.put(1, "HOT");
		map.put(2, "Phổ biến");
		map.put(3, "Freeship");
		map.put(4, "Best seller");
		
		
		return map;
	}
	
	@GetMapping("{productId}")
	public String admin(Model model,
			@PathVariable("productId") Long productId) {
		
		Map<String, Object> objs = new HashMap<String, Object>();		
		Optional<Product> productOpt = productService.findById(productId);
		
		if(productOpt.isPresent()) {
			
			Product product = productOpt.get();
			
			ProductDTO productDTO = new ProductDTO();
			
			BeanUtils.copyProperties(product, productDTO);
			
			Optional<Category> categotyOpt = categoryService.findById(product.getCategory().getCategoryId());
			
			if(categotyOpt.isPresent()) {
				
				Category category = categotyOpt.get();
				
				CategoryDTO categoryDTO = new CategoryDTO();
				
				BeanUtils.copyProperties(category, categoryDTO);
				
				productDTO.setCategoryId(category.getCategoryId());
				
				objs.put("category", categoryDTO);
			}
			
			objs.put("product", productDTO);
			dataLayoutMaster.setTitle(product.getName() + " | Tshop");
		}
		
		List<Product> listProduct = productService.randomProduct(8);
		
		List<ProductDTO> listProductDTO = new ArrayList<>();
		
		for(Product product : listProduct) {
			ProductDTO productDTO = new ProductDTO();
			
			BeanUtils.copyProperties(product, productDTO);
			
			listProductDTO.add(productDTO);
		}
		
		objs.put("productRand", listProductDTO);	
		
		dataLayoutMaster.setView("product_detail/product_detail.jsp");
		dataLayoutMaster.setObjs(objs);
		
		model.addAttribute("content", dataLayoutMaster);
		return layout;
	}
}
