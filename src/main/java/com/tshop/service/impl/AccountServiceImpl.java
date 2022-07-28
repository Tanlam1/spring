package com.tshop.service.impl;

import java.util.List;
import java.util.Optional;
import java.util.function.Function;

import com.tshop.domain.Account;
import com.tshop.repository.AccountRepostitory;
import com.tshop.service.AccountService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.FluentQuery.FetchableFluentQuery;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AccountServiceImpl implements AccountService {
	
	@Autowired
	private AccountRepostitory accountRepostitory;
	
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Override
	public Account login(String username, String password) {
		
		Optional<Account> optional = accountRepostitory.findById(username);
		
		if(optional.isPresent() && bCryptPasswordEncoder.matches(password, optional.get().getPassword())) {
			
			optional.get().setPassword("");
			
			return optional.get();
		}
		
		return null;
	}
	
	@Override
	public List<Account> findByUsernameContaining(String name) {
		return accountRepostitory.findByUsernameContaining(name);
	}

	@Override
	public Page<Account> findByUsernameContaining(String name, Pageable pageable) {
		return accountRepostitory.findByUsernameContaining(name, pageable);
	}

	@Override
	public <S extends Account> S save(S entity) {
		
		entity.setPassword(bCryptPasswordEncoder.encode(entity.getPassword()));
		
		return accountRepostitory.save(entity);
	}

	@Override
	public <S extends Account> Optional<S> findOne(Example<S> example) {
		return accountRepostitory.findOne(example);
	}

	@Override
	public List<Account> findAll() {
		return accountRepostitory.findAll();
	}

	@Override
	public Page<Account> findAll(Pageable pageable) {
		return accountRepostitory.findAll(pageable);
	}

	@Override
	public List<Account> findAll(Sort sort) {
		return accountRepostitory.findAll(sort);
	}

	@Override
	public List<Account> findAllById(Iterable<String> ids) {
		return accountRepostitory.findAllById(ids);
	}

	@Override
	public Optional<Account> findById(String id) {
		return accountRepostitory.findById(id);
	}

	@Override
	public <S extends Account> List<S> saveAll(Iterable<S> entities) {
		return accountRepostitory.saveAll(entities);
	}

	@Override
	public void flush() {
		accountRepostitory.flush();
	}

	@Override
	public boolean existsById(String id) {
		return accountRepostitory.existsById(id);
	}

	@Override
	public <S extends Account> S saveAndFlush(S entity) {
		return accountRepostitory.saveAndFlush(entity);
	}

	@Override
	public <S extends Account> List<S> saveAllAndFlush(Iterable<S> entities) {
		return accountRepostitory.saveAllAndFlush(entities);
	}

	@Override
	public <S extends Account> Page<S> findAll(Example<S> example, Pageable pageable) {
		return accountRepostitory.findAll(example, pageable);
	}

	@Override
	public void deleteInBatch(Iterable<Account> entities) {
		accountRepostitory.deleteInBatch(entities);
	}

	@Override
	public <S extends Account> long count(Example<S> example) {
		return accountRepostitory.count(example);
	}

	@Override
	public void deleteAllInBatch(Iterable<Account> entities) {
		accountRepostitory.deleteAllInBatch(entities);
	}

	@Override
	public long count() {
		return accountRepostitory.count();
	}

	@Override
	public <S extends Account> boolean exists(Example<S> example) {
		return accountRepostitory.exists(example);
	}

	@Override
	public void deleteById(String id) {
		accountRepostitory.deleteById(id);
	}

	@Override
	public void deleteAllByIdInBatch(Iterable<String> ids) {
		accountRepostitory.deleteAllByIdInBatch(ids);
	}

	@Override
	public void delete(Account entity) {
		accountRepostitory.delete(entity);
	}

	@Override
	public <S extends Account, R> R findBy(Example<S> example, Function<FetchableFluentQuery<S>, R> queryFunction) {
		return accountRepostitory.findBy(example, queryFunction);
	}

	@Override
	public void deleteAllById(Iterable<? extends String> ids) {
		accountRepostitory.deleteAllById(ids);
	}

	@Override
	public void deleteAllInBatch() {
		accountRepostitory.deleteAllInBatch();
	}

	@Override
	public Account getOne(String id) {
		return accountRepostitory.getOne(id);
	}

	@Override
	public void deleteAll(Iterable<? extends Account> entities) {
		accountRepostitory.deleteAll(entities);
	}

	@Override
	public void deleteAll() {
		accountRepostitory.deleteAll();
	}

	@Override
	public Account getById(String id) {
		return accountRepostitory.getById(id);
	}

	@Override
	public Account getReferenceById(String id) {
		return accountRepostitory.getReferenceById(id);
	}

	@Override
	public <S extends Account> List<S> findAll(Example<S> example) {
		return accountRepostitory.findAll(example);
	}

	@Override
	public <S extends Account> List<S> findAll(Example<S> example, Sort sort) {
		return accountRepostitory.findAll(example, sort);
	}
	
	
}
