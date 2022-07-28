package com.tshop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tshop.service.SessionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AdminIsLoginAuthenticationInerceptor implements HandlerInterceptor {
	
	@Autowired
	SessionService sessionService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(sessionService.get("admin_kodoku_KShop", null) == null) {
			return true;
		}
		
		response.sendRedirect("/admin");
		return false;
	}
	
	
}
