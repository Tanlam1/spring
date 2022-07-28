package com.tshop.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;

import com.tshop.domain.CartItem;
import com.tshop.domain.Customer;
import com.tshop.domain.Order;
import com.tshop.domain.OrderDetail;
import com.tshop.domain.Product;
import com.tshop.repository.CartItemRepository;
import com.tshop.repository.CustomerRepository;
import com.tshop.repository.OrderDetailRepository;
import com.tshop.repository.OrderRepository;
import com.tshop.repository.ProductRepository;
import com.tshop.service.CartItemService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.FluentQuery.FetchableFluentQuery;
import org.springframework.stereotype.Service;

@Service
public class CartItemServiceImpl implements CartItemService {
	
	@Autowired
	CartItemRepository cartItemRepository;
	@Autowired
	OrderRepository orderRepository;
	@Autowired
	CustomerRepository customerRepository;
	@Autowired
	OrderDetailRepository orderDetailRepository;
	@Autowired
	ProductRepository productRepository;
	
	@Override
	public boolean checkout(Long customerId, double totalPrice) {
		List<CartItem> list = cartItemRepository.findByCustomerId(customerId);
		if(list.size() == 0) return false;
		boolean ok = false;
		for(CartItem item : list) {
			if(item.isSelected()) {
				ok = true;break;
			}
		}
		if(!ok) return false;
		
		Optional<Customer> customerOptional = customerRepository.findById(customerId);
		if(!customerOptional.isPresent()) return false;

		Order order = new Order();
		order.setAmount(totalPrice);		
		order.setCustomer(customerOptional.get());
		order.setStatus((short) 0);
		order.setOrderDate(new Date());
		Order orderSave = orderRepository.save(order);
		
		for(CartItem item : list) {
			if(item.isSelected()) {
				
				Optional<Product> product = productRepository.findById(item.getProductId());				
				
				OrderDetail orderDetail = new OrderDetail();
				orderDetail.setQuantity(item.getQuantity());
				orderDetail.setUnitPrice(item.getUnitPrice());
				orderDetail.setOrder(orderSave);
				orderDetail.setProduct(product.get());
				
				orderDetailRepository.save(orderDetail);
				cartItemRepository.delete(item);
			}
		}
		
		return true;
	}

	@Override
	public CartItem findByProductIdAndCustomerId(Long productId, Long customerId) {
		return cartItemRepository.findByProductIdAndCustomerId(productId, customerId);
	}

	@Override
	public List<CartItem> findByCustomerId(Long customerId) {
		return cartItemRepository.findByCustomerId(customerId);
	}

	@Override
	public <S extends CartItem> S save(S entity) {
		return cartItemRepository.save(entity);
	}

	@Override
	public <S extends CartItem> Optional<S> findOne(Example<S> example) {
		return cartItemRepository.findOne(example);
	}

	@Override
	public List<CartItem> findAll() {
		return cartItemRepository.findAll();
	}

	@Override
	public Page<CartItem> findAll(Pageable pageable) {
		return cartItemRepository.findAll(pageable);
	}

	@Override
	public List<CartItem> findAll(Sort sort) {
		return cartItemRepository.findAll(sort);
	}

	@Override
	public List<CartItem> findAllById(Iterable<Long> ids) {
		return cartItemRepository.findAllById(ids);
	}

	@Override
	public Optional<CartItem> findById(Long id) {
		return cartItemRepository.findById(id);
	}

	@Override
	public <S extends CartItem> List<S> saveAll(Iterable<S> entities) {
		return cartItemRepository.saveAll(entities);
	}

	@Override
	public void flush() {
		cartItemRepository.flush();
	}

	@Override
	public boolean existsById(Long id) {
		return cartItemRepository.existsById(id);
	}

	@Override
	public <S extends CartItem> S saveAndFlush(S entity) {
		return cartItemRepository.saveAndFlush(entity);
	}

	@Override
	public <S extends CartItem> List<S> saveAllAndFlush(Iterable<S> entities) {
		return cartItemRepository.saveAllAndFlush(entities);
	}

	@Override
	public <S extends CartItem> Page<S> findAll(Example<S> example, Pageable pageable) {
		return cartItemRepository.findAll(example, pageable);
	}

	@Override
	public void deleteInBatch(Iterable<CartItem> entities) {
		cartItemRepository.deleteInBatch(entities);
	}

	@Override
	public <S extends CartItem> long count(Example<S> example) {
		return cartItemRepository.count(example);
	}

	@Override
	public void deleteAllInBatch(Iterable<CartItem> entities) {
		cartItemRepository.deleteAllInBatch(entities);
	}

	@Override
	public long count() {
		return cartItemRepository.count();
	}

	@Override
	public <S extends CartItem> boolean exists(Example<S> example) {
		return cartItemRepository.exists(example);
	}

	@Override
	public void deleteById(Long id) {
		cartItemRepository.deleteById(id);
	}

	@Override
	public void deleteAllByIdInBatch(Iterable<Long> ids) {
		cartItemRepository.deleteAllByIdInBatch(ids);
	}

	@Override
	public void delete(CartItem entity) {
		cartItemRepository.delete(entity);
	}

	@Override
	public <S extends CartItem, R> R findBy(Example<S> example, Function<FetchableFluentQuery<S>, R> queryFunction) {
		return cartItemRepository.findBy(example, queryFunction);
	}

	@Override
	public void deleteAllById(Iterable<? extends Long> ids) {
		cartItemRepository.deleteAllById(ids);
	}

	@Override
	public void deleteAllInBatch() {
		cartItemRepository.deleteAllInBatch();
	}

	@Override
	public CartItem getOne(Long id) {
		return cartItemRepository.getOne(id);
	}

	@Override
	public void deleteAll(Iterable<? extends CartItem> entities) {
		cartItemRepository.deleteAll(entities);
	}

	@Override
	public void deleteAll() {
		cartItemRepository.deleteAll();
	}

	@Override
	public CartItem getById(Long id) {
		return cartItemRepository.getById(id);
	}

	@Override
	public CartItem getReferenceById(Long id) {
		return cartItemRepository.getReferenceById(id);
	}

	@Override
	public <S extends CartItem> List<S> findAll(Example<S> example) {
		return cartItemRepository.findAll(example);
	}

	@Override
	public <S extends CartItem> List<S> findAll(Example<S> example, Sort sort) {
		return cartItemRepository.findAll(example, sort);
	}
	
	
}
