package com.tshop.repository;

import java.util.List;

import com.tshop.domain.Account;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepostitory extends JpaRepository<Account, String> {
	List<Account> findByUsernameContaining(String name);
	Page<Account> findByUsernameContaining(String name, Pageable pageable);
}
