package com.tshop.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartItemDTO {
	private Long cartItemId;
	private Long productId;
	private Long customerId;
	private int quantity;
	private double unitPrice;
	private boolean selected;
	private ProductDTO product;
}
