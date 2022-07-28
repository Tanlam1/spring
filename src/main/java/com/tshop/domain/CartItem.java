package com.tshop.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name = "CartItems")
public class CartItem implements Serializable{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long cartItemId;
	
	@Column(nullable = false)
	private Long productId;
		
	@Column(nullable = false)
	private int quantity;	
	
	@Column(nullable = false)
	private double unitPrice;
	
	@Column(nullable = false)
	private Long customerId;
	
	@Column(nullable = false)
	private boolean selected;
}
