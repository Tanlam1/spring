package com.tshop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tshop.service.SessionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AdminAuthenticationInterceptor implements HandlerInterceptor {

	@Autowired
	private SessionService sessionService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("pre handler of request " + request.getRequestURI());
		if(sessionService.get("admin_kodoku_KShop", null) != null) { // có session username => login ok => ko làm gì
			return true;
		}
		
		sessionService.set("redirect-uri", request.getRequestURI()); // lưu lại uri hiện tại cho session redirect-uri
		response.sendRedirect("/dashboard/login"); // chuyển qua trang login
		
		return false;
	}
	
}
