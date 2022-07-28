package com.tshop.config;

import com.tshop.interceptor.AdminAuthenticationInterceptor;
import com.tshop.interceptor.AdminIsLoginAuthenticationInerceptor;
import com.tshop.interceptor.ClientAuthenticationInterceptor;
import com.tshop.interceptor.ClientIsLoginAuthenticationInerceptor;
import com.tshop.interceptor.SessionInterceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class SessionInterceptorConfig implements WebMvcConfigurer {
	
	@Autowired
	SessionInterceptor sessionInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(sessionInterceptor)
			.addPathPatterns("/**");
		
	}

}
