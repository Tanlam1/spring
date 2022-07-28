package com.tshop.controller.site;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import com.tshop.domain.CartItem;
import com.tshop.domain.Category;
import com.tshop.domain.Customer;
import com.tshop.domain.Product;
import com.tshop.model.CartItemDTO;
import com.tshop.model.CategoryDTO;
import com.tshop.model.DataLayoutMaster;
import com.tshop.model.ProductDTO;
import com.tshop.service.CartItemService;
import com.tshop.service.CategoryService;
import com.tshop.service.CustomerService;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {
	
	@Autowired
	CartItemService cartItemService;
	@Autowired
	ProductService productService;
	@Autowired
	CustomerService customerService;
	@Autowired
	SessionService sessionService;
	
	private static DataLayoutMaster dataLayoutMaster = new DataLayoutMaster();
	private static String layout = "site/client_layout";
	
	static {
		dataLayoutMaster.setHeading_text("Home");
		dataLayoutMaster.setTitle("Checkout | Tshop");
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
	
	@ModelAttribute("totalSaving")
	public Double getTotalSaving() {
		List<CartItemDTO> list = getCartItems();
		
		Double total = 0.0;
		
		for(CartItemDTO item : list) {
			if(item.isSelected())
				total = total + (item.getUnitPrice() * (1 + (item.getProduct().getDiscount() / 100)) * item.getQuantity());
		}
		
		return total - getTotalPrice();
	}
	
	@ModelAttribute("totalPrice")
	public Double getTotalPrice() {
		List<CartItemDTO> list = getCartItems();
		
		Double total = 0.0;
		
		for(CartItemDTO item : list) {
			if(item.isSelected()) 
				total = total + (item.getUnitPrice() * item.getQuantity());
		}
		
		return total;
	}
	
	@ModelAttribute("cartItems") 
	public List<CartItemDTO> getCartItems() {
		Customer customer = sessionService.get("userLogin");
		List<CartItem> cartItems = cartItemService.findByCustomerId(customer.getCustomerId());
		List<CartItemDTO> cartItemDTOs = new ArrayList<>();
		for(CartItem cartItem : cartItems) {
			CartItemDTO cartItemDTO = new CartItemDTO();
			BeanUtils.copyProperties(cartItem, cartItemDTO);
			
			Optional<Product> productOptional = productService.findById(cartItem.getProductId());
			ProductDTO productDTO = new ProductDTO();			
			if(productOptional.isPresent()) {
				BeanUtils.copyProperties(productOptional.get(), productDTO);
				cartItemDTO.setProduct(productDTO);
			}
			
			cartItemDTOs.add(cartItemDTO);
		}
		
		return cartItemDTOs;
	}
	
	@GetMapping("")
	public String admin(Model model) {
		
		
		Map<String, Object> objs = new HashMap<String, Object>();	
		
		dataLayoutMaster.setView("checkout/checkout.jsp");
		dataLayoutMaster.setObjs(objs);
		
		model.addAttribute("content", dataLayoutMaster);
		return layout;
	}
	
	@GetMapping("/send")
	public String send(Model model) {
		Customer customer = sessionService.get("userLogin");
		
		boolean checkout = cartItemService.checkout(customer.getCustomerId(), getTotalPrice());
		
		if(!checkout) {
			model.addAttribute("messageError", "Thất bại! Bạn chưa chọn sản phẩm cần thanh toán.");
			
			return "forward:/checkout";
		}
				
		return "redirect:/checkout/successfully";
	}
	
	@GetMapping("successfully")
	public String success(Model model) {
		
		model.getAttribute("bill");
		
		Map<String, Object> objs = new HashMap<String, Object>();	
		
		dataLayoutMaster.setView("checkout/success.jsp");
		dataLayoutMaster.setObjs(objs);
		
		model.addAttribute("content", dataLayoutMaster);
		return layout;
	}
	
}
