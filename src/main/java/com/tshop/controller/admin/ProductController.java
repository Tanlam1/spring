package com.tshop.controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.mail.FetchProfile.Item;
import javax.validation.Valid;

import com.tshop.domain.Category;
import com.tshop.domain.Product;
import com.tshop.model.ProductDTO;
import com.tshop.model.CategoryDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.service.CategoryService;
import com.tshop.service.ProductService;
import com.tshop.service.StorageService;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
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

import lombok.experimental.var;


@Controller
@RequestMapping("/admin/products")
public class ProductController {
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	StorageService storageService;
	
	@Autowired
	static DataLayoutMaster dataLayoutAdmin = new DataLayoutMaster();
	
	static {
		dataLayoutAdmin.setHeading_text("Product");
		dataLayoutAdmin.setTitle("Product | Tshop");
	}
	
	@ModelAttribute("categories")
	public Map<Long, String> getCategories(){
		
		Map<Long, String> map = new HashMap<>();
		
		for(Category item : categoryService.findAll()) {
			map.put(item.getCategoryId(), item.getName());
		}
		
		return map;
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
	
	@GetMapping("/add")
	public String add(Model model) {
		
		Map<String, Object> objs = new HashMap<String, Object>();		
		objs.put("productsActive", "active");
		
		dataLayoutAdmin.setView("products/addOrEdit.jsp");
		dataLayoutAdmin.setTitle("Add new product | Tshop");
		dataLayoutAdmin.setObjs(objs);
		
		model.addAttribute("content", dataLayoutAdmin);
		model.addAttribute("product", new ProductDTO());
		return "admin/dashboard_layout";
	}
	
	@GetMapping("edit/{productId}")
	public ModelAndView edit(ModelMap model, @PathVariable("productId") Long productId) {
		
		Optional<Product> optional = productService.findById(productId);
		ProductDTO dto = new ProductDTO();
		if(optional.isPresent()) {

			Map<String, Object> objs = new HashMap<String, Object>();	
			
			Product entity = optional.get();
			
			BeanUtils.copyProperties(entity, dto);
			dto.setCategoryId(entity.getCategory().getCategoryId());
			
			dto.setIsEdit(true);
			dto.setImage("/uploads/images/" + dto.getImage());
			
			objs.put("product", dto);
			
			objs.put("productsActive", "active");
			
			dataLayoutAdmin.setView("products/addOrEdit.jsp");
			dataLayoutAdmin.setTitle("Edit product | Tshop");
			dataLayoutAdmin.setObjs(objs);
			
			model.addAttribute("content", dataLayoutAdmin);
			model.addAttribute("product", dto);
			return new ModelAndView("admin/dashboard_layout", model);
		}
		
		model.addAttribute("message", "Không tồn tại category");
		
		return new ModelAndView("redirect:/admin/products", model);
	}
	
	@GetMapping("delete/{productId}")
	public ModelAndView delete(ModelMap model, @PathVariable("productId") Long productId) {
		
		Optional<Product> entity = productService.findById(productId);
		String msg = "Product không tồn tại";
		if(entity.isPresent()) {
			if(StringUtils.isEmpty(entity.get().getImage())) {
				try {
					storageService.delete(entity.get().getImage());
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			productService.deleteById(productId);
			msg = "Xóa thành công Product";
		} else {
			msg = "Không tìm thấy Product";
		}
		
		model.addAttribute("message", msg);
		return new ModelAndView("redirect:/admin/products", model);
	}
	
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(
			ModelMap model, 
			@Valid @ModelAttribute("product") ProductDTO dto, 
			BindingResult result) {
		
		if(dto.getProductId() != null) {
			dto.setIsEdit(true);
			dataLayoutAdmin.setTitle("Edit product | Tshop");
		}
		
		if(result.hasErrors()) {
			dataLayoutAdmin.setView("products/addOrEdit.jsp");
			
			
			Map<String, Object> objs = new HashMap<String, Object>();
			objs.put("product", dto);
			objs.put("productsActive", "active");
			dataLayoutAdmin.setObjs(objs);
			
			model.addAttribute("content", dataLayoutAdmin);
			return new ModelAndView("admin/dashboard_layout", model);
		}
				
		Product entity = new Product();
		BeanUtils.copyProperties(dto, entity);
		
		Category category = new Category();
		category.setCategoryId(dto.getCategoryId());
		entity.setCategory(category);
		
		if(dto.getProductId() == null) {
			if(!dto.getImageFile().isEmpty()) {
				UUID uuid = UUID.randomUUID();
				String uuidString = uuid.toString();
				
				entity.setImage(storageService.getStoredFileName(dto.getImageFile(), uuidString));
				storageService.store(dto.getImageFile(), entity.getImage());
			}
		} else {
			Optional<Product> product = productService.findById(dto.getProductId());
			
			if(product.isPresent()) {
				
				Product prod = product.get();
				
				String[] images = dto.getImage().split("/");
				
				String imagePresentLoad = images[images.length - 1];
				
				
				if(!imagePresentLoad.equals(prod.getImage()) || prod.getImage().equals("change_other")) {
					UUID uuid = UUID.randomUUID();
					String uuidString = uuid.toString();
					
					try {
						storageService.delete(prod.getImage());						
					} catch (Exception e) {
						
					}
					try {
						entity.setImage(storageService.getStoredFileName(dto.getImageFile(), uuidString));
						storageService.store(dto.getImageFile(), entity.getImage());
					} catch (Exception e) {
						
					}
				} else {
					entity.setImage(prod.getImage());
				}
			}
		}
		
		productService.save(entity);
		
		return new ModelAndView("redirect:/admin/products", model);
	}
	
	@GetMapping("") 
	public String list(ModelMap model, 
			@RequestParam(name = "name", required = false) String name,
			@RequestParam(name = "page", required = false) Optional<Integer> page,
			@RequestParam(name = "size", required = false) Optional<Integer> size) {

		Map<String, Object> objs = new HashMap<String, Object>();
		
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(10);
		
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize/* ,Direction.DESC */, Sort.by("productId"));
		Page<Product> resultPage = null;
		
		if(StringUtils.hasText(name)) {
			resultPage = productService.findByNameContaining(name, pageable);
			objs.put("name", name);
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
		objs.put("productsActive", "active");
		
		dataLayoutAdmin.setView("products/products.jsp");
		dataLayoutAdmin.setTitle("Product | Tshop");
		dataLayoutAdmin.setObjs(objs);

		model.addAttribute("content", dataLayoutAdmin);
		return "admin/dashboard_layout";
	}
}
