package com.tshop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tshop.service.SessionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class ClientIsLoginAuthenticationInerceptor implements HandlerInterceptor {
	
	@Autowired
	SessionService sessionService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(sessionService.get("userLogin", null) == null) {
			return true;
		}
		
		response.sendRedirect("/profile");
		return false;
	}
	
	
}
