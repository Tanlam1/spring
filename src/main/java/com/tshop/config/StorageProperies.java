package com.tshop.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import lombok.Data;

@ConfigurationProperties("storage")
@Configuration
@Data
public class StorageProperies {
	private String location;
	
}
