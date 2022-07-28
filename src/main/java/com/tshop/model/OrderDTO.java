package com.tshop.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDTO implements Serializable {
	private Long orderId;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date orderDate;
	private Long customerId;
	private double amount;
	private short status;
	
	private List<OrderDetailDTO> orderDetails;
}
