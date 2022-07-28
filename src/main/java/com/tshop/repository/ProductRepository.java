package com.tshop.repository;

import java.util.List;

import com.tshop.domain.Product;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
	List<Product> findByNameContaining(String name);
	Page<Product> findByNameContaining(String name, Pageable pageable);
	
	@Query(value = "SELECT TOP 8 * FROM Products ORDER BY NEWID()", nativeQuery = true)
	List<Product> randomProduct(Integer limit);
}
