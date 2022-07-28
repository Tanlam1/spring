package com.tshop.model;

import java.io.Serializable;

import org.hibernate.validator.constraints.Length;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class CategoryDTO implements Serializable {

	private Long categoryId;

	@Length(min = 5, message = "Vui lòng nhập tên danh mục từ 5 ký tự trở lên")
	private String name;

	private Boolean isEdit = false;
}
