package com.tshop.service;


public interface SessionService {

	void remove(String name);

	void set(String name, Object value);

	<T> T get(String name, T defaultValue);

	<T> T get(String name);

}
