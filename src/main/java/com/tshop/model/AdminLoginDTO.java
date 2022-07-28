package com.tshop.model;

import java.io.Serializable;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class AdminLoginDTO implements Serializable {
	
	@NotEmpty(message = "Vui lòng nhập username")
	private String username;
	
	@NotEmpty(message = "Vui lòng nhập password")
	private String password;
	
	private Boolean rememberMe;
}
