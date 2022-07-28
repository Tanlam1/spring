package com.tshop.controller.site;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

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
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/list")
public class ProductListController {
	
	@Autowired
	CategoryService categoryService;
	@Autowired
	ProductService productService;
	
	private static DataLayoutMaster dataLayoutMaster = new DataLayoutMaster();
	private static String layout = "site/client_layout";
	
	static {
		dataLayoutMaster.setHeading_text("Home");
		dataLayoutMaster.setTitle("List Product | Tshop");
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
	
	@GetMapping("")
	public String admin(Model model, 
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "page", required = false) Optional<Integer> page,
			@RequestParam(name = "size", required = false) Optional<Integer> size) {
		
		Map<String, Object> objs = new HashMap<String, Object>();
		
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(10);
		
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Direction.DESC, "productId");
		Page<Product> resultPage = null;
		
		if(StringUtils.hasText(keyword)) {
			resultPage = productService.findByNameContaining(keyword, pageable);
			objs.put("keyword", keyword);
		} else {
			resultPage = productService.findAll(pageable);
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
		objs.put("productPage", resultPage);
		
		dataLayoutMaster.setView("products/products.jsp");
		dataLayoutMaster.setObjs(objs);
		
		model.addAttribute("content", dataLayoutMaster);
		return layout;
	}
}
