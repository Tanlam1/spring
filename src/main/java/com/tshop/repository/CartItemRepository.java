package com.tshop.repository;

import java.util.List;

import com.tshop.domain.CartItem;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {
	
	List<CartItem> findByCustomerId(Long customerId);
	
	CartItem findByProductIdAndCustomerId(Long productId, Long customerId);
}
