package com.tshop.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.validation.Valid;

import com.tshop.domain.Category;
import com.tshop.domain.Customer;
import com.tshop.domain.Order;
import com.tshop.domain.OrderDetail;
import com.tshop.model.CategoryDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.model.OrderDTO;
import com.tshop.model.OrderDetailDTO;
import com.tshop.service.CategoryService;
import com.tshop.service.CustomerService;
import com.tshop.service.OrderDetailService;
import com.tshop.service.OrderService;

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
@RequestMapping("/admin/orders")
public class OrderController {
	
	@Autowired
	OrderService orderService;
	@Autowired
	CustomerService customerService;
	@Autowired
	OrderDetailService orderDetailService;
	
	static DataLayoutMaster dataLayoutAdmin = new DataLayoutMaster();
	static private String layout = "admin/dashboard_layout";
	
	static {
		dataLayoutAdmin.setHeading_text("Orders");
		dataLayoutAdmin.setTitle("Orders | Tshop");
	}
	
	@ModelAttribute("status")
	public Map<Integer, String> getStatus() {
		
		Map<Integer, String> map = new HashMap<Integer, String>();
		map.put(0, "Đang xử lý");
		map.put(1, "Đã xác nhận");
		map.put(2, "Đang giao hàng");
		map.put(3, "Giao hàng thành công");
		map.put(4, "Đã hủy");
		
		return map;
	}
	
//	@GetMapping("/view/{orderId}")
//	public String add(Model model,  @PathVariable("orderId") Long orderId) {
//		
//		Map<String, Object> objs = new HashMap<String, Object>();		
//		objs.put("ordersActive", "active");
//		
//		dataLayoutAdmin.setView("orders/addOrEdit.jsp");
//		
//		model.addAttribute("content", dataLayoutAdmin);
//		model.addAttribute("order", new OrderDTO());
//		return "admin/dashboard_layout";
//	}
	
	@GetMapping("view/{orderId}")
	public ModelAndView edit(ModelMap model, @PathVariable("orderId") Long orderId) {
		
		Optional<Order> optional = orderService.findById(orderId);
		OrderDTO dto = new OrderDTO();
		if(optional.isPresent()) {

			Map<String, Object> objs = new HashMap<String, Object>();	
			
			Order entity = optional.get();
			
			BeanUtils.copyProperties(entity, dto);
			dto.setCustomerId(entity.getCustomer().getCustomerId());
						
			objs.put("order", dto);
			
			objs.put("ordersActive", "active");
			
			dataLayoutAdmin.setView("orders/addOrEdit.jsp");
			dataLayoutAdmin.setObjs(objs);
			
			model.addAttribute("content", dataLayoutAdmin);
			model.addAttribute("order", dto);
			return new ModelAndView(layout, model);
		}
		
		model.addAttribute("message", "Không tồn tại order id: " + orderId);
		
		return new ModelAndView("redirect:/admin/orders", model);
	}
	
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(
			ModelMap model, 
			@Valid @ModelAttribute("order") OrderDTO dto, 
			BindingResult result) {
		
		if(result.hasErrors()) {
			dataLayoutAdmin.setView("orders/addOrEdit.jsp");
			
			Map<String, Object> objs = new HashMap<String, Object>();
			objs.put("order", dto);
			objs.put("ordersActive", "active");
			dataLayoutAdmin.setObjs(objs);
			
			model.addAttribute("content", dataLayoutAdmin);
			return new ModelAndView("admin/dashboard_layout", model);
		}
		Optional<Order> optOrder = orderService.findById(dto.getOrderId());
		
		if(optOrder.isPresent()) {
			
			if(optOrder.get().getStatus() == 4) return new ModelAndView("redirect:/admin/orders", model);
			
			if (optOrder.get().getStatus() > dto.getStatus()) {
				
				model.addAttribute("message", "Cập nhật tình trạng đơn hàng không hợp lệ.");
				return new ModelAndView("redirect:/admin/orders/view/" + optOrder.get().getOrderId(), model);
			}
			
		}
				
		Order entity = new Order();
		BeanUtils.copyProperties(dto, entity);
		Optional<Customer> optional = customerService.findById(dto.getCustomerId());
		
		if(optional.isPresent()) {
			entity.setCustomer(optional.get());
			
			orderService.save(entity);
		}
		
		return new ModelAndView("redirect:/admin/orders", model);
	}
	
	@GetMapping("delete/{orderId}")
	public ModelAndView delete(ModelMap model, @PathVariable("orderId") Long orderId) {
		
		Optional<Order> entity = orderService.findById(orderId);
		String msg = "Order không tồn tại";
		if(entity.isPresent()) {
			orderService.deleteById(orderId);
			msg = "Xóa thành công Order";
		}
		
		model.addAttribute("message", msg);
		return new ModelAndView("redirect:/admin/orders", model);
	}
	
	@GetMapping("") 
	public String list(ModelMap model, 
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "page", required = false) Optional<Integer> page,
			@RequestParam(name = "size", required = false) Optional<Integer> size) {

		Map<String, Object> objs = new HashMap<String, Object>();
		
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(10);
		
		Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("orderId"));
		Page<Order> resultPage = null;
		
		if(StringUtils.hasText(keyword)) {
			resultPage = orderService.serachOrders(Long.parseLong(keyword), Long.parseLong(keyword), pageable);
			objs.put("keyword", keyword);
		} else {
			resultPage = orderService.findAll(pageable);
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
		
		objs.put("orderPage", resultPage);
		objs.put("ordersActive", "active");
		
		dataLayoutAdmin.setView("orders/orders.jsp");

		model.addAttribute("data", objs);
		model.addAttribute("content", dataLayoutAdmin);
		return layout;
	}
	
	@GetMapping("detail/{orderId}")
	public String detailOrder(Model model, 
			@PathVariable("orderId") Long orderId) {
		
		
		Optional<Order> optional = orderService.findById(orderId);
		OrderDTO dto = new OrderDTO();	
		
		if(optional.isPresent()) {
			
			List<OrderDetail> list = orderDetailService.findByOrderid(orderId);
			List<OrderDetailDTO> dtos = new ArrayList<>();
			
			for(OrderDetail orderDetail : list) {
				OrderDetailDTO detailDTO = new OrderDetailDTO();
				
				BeanUtils.copyProperties(orderDetail, detailDTO);
				detailDTO.setProductId(orderDetail.getProduct().getProductId());
				detailDTO.setOrderId(orderDetail.getOrder().getOrderId());
				
				dtos.add(detailDTO);
			}
			
			Map<String, Object> objs = new HashMap<String, Object>();	
			
			Order entity = optional.get();
			
			BeanUtils.copyProperties(entity, dto);			
			dto.setCustomerId(entity.getCustomer().getCustomerId());
			dto.setOrderDetails(dtos);
						
			objs.put("order", dto);			
			objs.put("ordersActive", "active");
			
			dataLayoutAdmin.setHeading_text("Detail order");
			dataLayoutAdmin.setTitle("Detail order | Tshop");
			dataLayoutAdmin.setView("orders/orderDetail.jsp");
			dataLayoutAdmin.setObjs(objs);
			
			model.addAttribute("content", dataLayoutAdmin);
			return layout;			
		}
				
		model.addAttribute("message", "Không tồn tại order id: " + orderId);
		
		return "redirect:/admin/orders";
	}
	
	
}
