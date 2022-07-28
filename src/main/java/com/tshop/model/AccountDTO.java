package com.tshop.model;

import java.io.Serializable;

import org.hibernate.validator.constraints.Length;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class AccountDTO implements Serializable {

	@Length(min = 6, max = 32, message = "Vui lòng nhập username từ 6 - 32 kí tự")
	private String username;

	@Length(min = 6, max = 32, message = "Vui lòng nhập password từ 6 - 32 kí tự")
	private String password;

	private Boolean isEdit;
	private Boolean isFromAdd = true;
}
