package com.tshop.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name = "Customers")
public class Customer implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long customerId;

	@Column(columnDefinition = "nvarchar(50) not null")
	private String name;

	@Column(columnDefinition = "nvarchar(49) not null")
	private String email;

	@Column(length = 62, nullable = false)
	private String password;

	@Column(length = 20, nullable = false)
	private String phone;

	@Column(columnDefinition = "nvarchar(500)")
	private String address;

	@Temporal(TemporalType.DATE)
	private Date registeredDate;

	@Column(nullable = false)
	private short status;

	@OneToMany(mappedBy = "customer", cascade = CascadeType.ALL)
	private Set<Order> orders;
}
