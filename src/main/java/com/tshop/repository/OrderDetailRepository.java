package com.tshop.repository;

import java.util.List;

import com.tshop.domain.OrderDetail;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
		
	@Query("SELECT o FROM OrderDetail o WHERE o.order.orderId = ?1")
	List<OrderDetail> findByOrderid(Long orderId);
}
