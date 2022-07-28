package com.tshop.model;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DataLayoutMaster {
	private String title;
	private String heading_text;
	private String view;
	private Map<String, Object> objs;
}
