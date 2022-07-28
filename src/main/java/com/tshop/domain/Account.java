package com.tshop.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name = "Accounts")
public class Account implements Serializable {
	@Id
	@Column(length = 32)
	private String username;
	@Column(length = 60, nullable = false)
	private String password;
}