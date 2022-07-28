package com.tshop.model;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDTO implements Serializable {
	
	private Long productId;
	
	@Length(min = 5, message = "Vui lòng nhập tên sản phẩm từ 5 ký tự trở lên")
	private String name;
	
	@Min(value = 1, message = "Vui lòng nhập số lượng lớn hơn 0")
	private int quantity;
	
	@Min(value = 1, message = "Vui lòng nhập giá lớn hơn 0")
	private double unitPrice;
	private String image;
	
	private MultipartFile imageFile;
	
	@Length(min = 5, message = "Vui lòng nhập mô tả sản phẩm từ 5 ký tự trở lên")
	private String description;
	
	@Min(value = 0, message = "Vui lòng nhập % giảm giá lớn hơn 0")
	@Max(value = 100, message = "Vui lòng nhập % giảm giá bé hơn 100")
	private double discount;
	
	private Date enterDate = new Date();
	
	@NotNull(message= "Vui lòng chọn status sản phẩm")
	private short status;
	
	@NotNull(message= "Vui lòng chọn category sản phẩm")
	private Long categoryId;
	
	private Boolean isEdit = false;
}
