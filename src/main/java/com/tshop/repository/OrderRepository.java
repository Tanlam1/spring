package com.tshop.repository;

import java.util.List;
import java.util.Set;

import com.tshop.domain.Order;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
	
	@Query("SELECT o FROM Order o WHERE o.orderId like ?1 or o.customer.customerId like ?2")
	Page<Order> serachOrders(Long orderId, Long customerId, Pageable pageable);
	
	@Query("SELECT o FROM Order o WHERE o.orderId like ?1 or o.customer.customerId like ?2")
	List<Order> serachOrders(Long orderId, Long customerId);
	
	@Query(value = "SELECT * FROM Orders WHERE order_id = :oid", nativeQuery = true)
	List<Order> testJPA(@Param("oid") Integer oId);
	
	@Query("SELECT o FROM Order o WHERE o.customer.customerId like ?1")
	Set<Order> fyByCustomerId( Long customerId);
}
