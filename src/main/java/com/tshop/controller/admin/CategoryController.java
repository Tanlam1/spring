package com.tshop.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.validation.Valid;

import com.tshop.domain.Category;
import com.tshop.model.CategoryDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.service.CategoryService;

import org.apache.jasper.tagplugins.jstl.core.If;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
@RequestMapping("/admin/categories")
public class CategoryController {
	
	@Autowired
	CategoryService categoryService;
	
	static DataLayoutMaster dataLayoutAdmin = new DataLayoutMaster();
	
	static {
		dataLayoutAdmin.setHeading_text("Categories");
		dataLayoutAdmin.setTitle("Categories | Tshop");
	}
	
	
	
	@GetMapping("/add")
	public String add(Model model) {
		
		Map<String, Object> objs = new HashMap<String, Object>();		
		objs.put("categoriesActive", "active");
		
		dataLayoutAdmin.setView("categories/addOrEdit.jsp");
		dataLayoutAdmin.setObjs(objs);
		
		model.addAttribute("content", dataLayoutAdmin);
		model.addAttribute("category", new CategoryDTO());
		return "admin/dashboard_layout";
	}
	
	@GetMapping("edit/{categoryId}")
	public ModelAndView edit(ModelMap model, @PathVariable("categoryId") Long categoryId) {
		
		Optional<Category> optional = categoryService.findById(categoryId);
		CategoryDTO dto = new CategoryDTO();
		if(optional.isPresent()) {

			Map<String, Object> objs = new HashMap<String, Object>();	
			
			Category entity = optional.get();
			
			BeanUtils.copyProperties(entity, dto);
			
			dto.setIsEdit(true);
			
			objs.put("category", dto);
			
			objs.put("categoriesActive", "active");
			
			dataLayoutAdmin.setView("categories/addOrEdit.jsp");
			dataLayoutAdmin.setObjs(objs);
			
			model.addAttribute("content", dataLayoutAdmin);
			return new ModelAndView("admin/dashboard_layout", model);
		}
		
		model.addAttribute("message", "Không tồn tại category");
		
		return new ModelAndView("redirect:/admin/categories", model);
	}
	
	@GetMapping("delete/{categoryId}")
	public ModelAndView delete(ModelMap model, @PathVariable("categoryId") Long categoryId) {
		
		Optional<Category> entity = categoryService.findById(categoryId);
		String msg = "Category không tồn tại";
		if(entity.isPresent()) {
			categoryService.deleteById(categoryId);
			msg = "Xóa thành công Category";
		}
		
		model.addAttribute("message", msg);
		return new ModelAndView("redirect:/admin/categories", model);
	}
	
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(
			ModelMap model, 
			@Valid @ModelAttribute("category") CategoryDTO dto, 
			BindingResult result) {
		
		if(result.hasErrors()) {
			dataLayoutAdmin.setView("categories/addOrEdit.jsp");
			if(dto.getCategoryId() != null) {
				dto.setIsEdit(true);
			}
			
			Map<String, Object> objs = new HashMap<String, Object>();
			objs.put("category", dto);
			objs.put("categoriesActive", "active");
			dataLayoutAdmin.setObjs(objs);
			
			model.addAttribute("content", dataLayoutAdmin);
			return new ModelAndView("admin/dashboard_layout", model);
		}
		System.out.println(dto.getName());		
		Category entity = new Category();
		BeanUtils.copyProperties(dto, entity);
		
		categoryService.save(entity);
		
		return new ModelAndView("redirect:/admin/categories", model);
	}
	
	@GetMapping("") 
	public String list(ModelMap model, 
			@RequestParam(name = "name", required = false) String name,
			@RequestParam(name = "page", required = false) Optional<Integer> page,
			@RequestParam(name = "size", required = false) Optional<Integer> size) {

		Map<String, Object> objs = new HashMap<String, Object>();
		
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(10);
		
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("categoryId"));
		Page<Category> resultPage = null;
		
		if(StringUtils.hasText(name)) {
			resultPage = categoryService.findByNameContaining(name, pageable);
			objs.put("name", name);
		} else {
			resultPage = categoryService.findAll(pageable);
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
		
		objs.put("categoryPage", resultPage);
		objs.put("categoriesActive", "active");
		
		dataLayoutAdmin.setView("categories/categories.jsp");
		dataLayoutAdmin.setObjs(objs);

		model.addAttribute("content", dataLayoutAdmin);
		return "admin/dashboard_layout";
	}
	
	/**
	@GetMapping("search")
	public String search(ModelMap model, 
			@RequestParam(name = "name", required = false) String name) {
		
		List<Category> list = null;
		if(StringUtils.hasText(name)) {
			list = categoryService.findByNameContaining(name);
		} else {
			list = categoryService.findAll();
		}
		
		model.addAttribute("categories", list);
		
		return "admin/categories/search";
	}
	
	@GetMapping("search/paginated")
	public String search(ModelMap model, 
			@RequestParam(name = "name", required = false) String name,
			@RequestParam("page") Optional<Integer> page,
			@RequestParam("size") Optional<Integer> size) {
		
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(5);
		
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name"));
		Page<Category> resultPage = null;
		
		if(StringUtils.hasText(name)) {
			resultPage = categoryService.findByNameContaining(name, pageable);
			model.addAttribute("name", name);
		} else {
			resultPage = categoryService.findAll(pageable);
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
			
			model.addAttribute("pageNumbers", pageNumbers);
		}
		
		model.addAttribute("categoryPage", resultPage);
		
		return "admin/categories/searchpaginated";
	} */
}
