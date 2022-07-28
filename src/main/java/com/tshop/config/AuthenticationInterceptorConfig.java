package com.tshop.config;

import com.tshop.interceptor.AdminAuthenticationInterceptor;
import com.tshop.interceptor.AdminIsLoginAuthenticationInerceptor;
import com.tshop.interceptor.ClientAuthenticationInterceptor;
import com.tshop.interceptor.ClientIsLoginAuthenticationInerceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class AuthenticationInterceptorConfig implements WebMvcConfigurer {
	
	@Autowired
	private AdminAuthenticationInterceptor adminAuthenticationInterceptor;
	@Autowired
	private AdminIsLoginAuthenticationInerceptor adminIsLoginAuthenticationInerceptor;
	@Autowired
	private ClientAuthenticationInterceptor clientAuthenticationInterceptor;
	@Autowired
	private ClientIsLoginAuthenticationInerceptor clientIsLoginAuthenticationInerceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(adminAuthenticationInterceptor)
			.addPathPatterns("/admin/**"); // kiểm tra nếu thuộc /admin/* thì gọi authen interceptor
		
		registry.addInterceptor(adminIsLoginAuthenticationInerceptor)
			.addPathPatterns("/dashboard/login");
		
		registry.addInterceptor(clientAuthenticationInterceptor)
			.addPathPatterns("/profile/**");
		
		registry.addInterceptor(clientAuthenticationInterceptor)
		.addPathPatterns("/cart/**");
		registry.addInterceptor(clientAuthenticationInterceptor)
		.addPathPatterns("/checkout/**");
		
		registry.addInterceptor(clientIsLoginAuthenticationInerceptor)
			.addPathPatterns("/auth/login", "/auth/register");
	}

}
