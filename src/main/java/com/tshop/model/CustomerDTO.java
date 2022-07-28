package com.tshop.model;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomerDTO implements Serializable {
	private Long customerId;
	@NotEmpty(message = "Vui lòng nhập tên của bạn")
	private String name;
	@NotEmpty(message = "Vui lòng nhập đúng định dạng email")
	private String email;
	@Length(min = 3, message = "Password tối thiểu 3 ký tự")
	private String password;
	@NotEmpty(message = "Vui lòng nhập số điện thoại")
	private String phone;
	private String address;
	private Date registeredDate = new Date();
	private short status;
}
