package com.tshop.controller.site;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tshop.domain.Category;
import com.tshop.domain.Product;
import com.tshop.model.CategoryDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.model.ProductDTO;
import com.tshop.service.CategoryService;
import com.tshop.service.ProductService;


@Controller
@RequestMapping("/shop")
public class ShopController {
	@Autowired
	CategoryService categoryService;
	@Autowired
	ProductService productService;
	private static DataLayoutMaster dataLayoutMaster = new DataLayoutMaster();
	private String layout = "site/client_layout";

	static {
		dataLayoutMaster.setTitle("Home shop");
		dataLayoutMaster.setView("shop/shop.jsp");
	}

	@GetMapping("")
	public String index(Model model, @RequestParam(name = "name", required = false) String name, 
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "page", required = false) Optional<Integer> page,
			@RequestParam(name = "size", required = false) Optional<Integer> size) {
		Map<String, Object> objs = new HashMap<String, Object>();
//		objs.put("banner", true);
		objs.put("hero_normal", true);
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

		int currentPage = page.orElse(1);
		int pageSize = size.orElse(6);
		
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
		objs.put("shopPage", resultPage);
		dataLayoutMaster.setObjs(objs);
		model.addAttribute("content", dataLayoutMaster);
		return layout;
	}
}
