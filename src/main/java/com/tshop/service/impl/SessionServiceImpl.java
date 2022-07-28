package com.tshop.service.impl;

import javax.servlet.http.HttpSession;

import com.tshop.service.SessionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SessionServiceImpl implements SessionService {
	
	@Autowired
	HttpSession session;
	
	@Override
	@SuppressWarnings("unchecked")
	public <T> T get(String name) {
		return (T) session.getAttribute(name);
	}
	
	@Override
	public <T> T get(String name, T defaultValue) {
		T value = get(name);
		
		return value != null ? value : defaultValue;
	}
	
	@Override
	public void set(String name, Object value) {
		session.setAttribute(name, value);
	}
	
	@Override
	public void remove(String name) {
		session.removeAttribute(name);
	}
}
