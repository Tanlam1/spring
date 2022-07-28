<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>


<hr>
<div class="container bootstrap snippet">
<div class="row">
	<div class="col-sm-10"><h1>User name</h1></div>
	<div class="col-sm-2"><a href="/users" class="pull-right"><img title="profile image" class="img-circle img-responsive" src="http://www.gravatar.com/avatar/28fd20ccec6865e2d5f0e1f4446eb7bf?s=100"></a></div>
</div>
<div class="row">	
	<div class="col-sm-9">
		<ul class="nav nav-tabs">
			<li class="active"><a data-toggle="tab" href="#home">About</a></li>
			<li><a data-toggle="tab" href="#messages">Edit</a></li>
			</ul>

			
		<div class="tab-content">
		<div class="tab-pane active" id="home">
			<hr>
				<form class="form" action="##" method="post" id="registrationForm">
					<div class="form-group">
						
						<div class="col-xs-6">
							<label for="first_name"><h4>CustomerId</h4></label>
							<input readonly value="${customer.customerId}" type="text" class="form-control" name="customerId" id="customerId" placeholder="first name" title="enter your first name if any.">
						</div>
					</div>
					<div class="form-group">
						
						<div class="col-xs-6">
						<label for="last_name"><h4>Name</h4></label>
							<input readonly value="${customer.name}" type="text" class="form-control" name="name" id="name" placeholder="last name" title="enter your last name if any.">
						</div>
					</div>
		
					<div class="form-group">
						
						<div class="col-xs-6">
							<label for="phone"><h4>Phone</h4></label>
							<input readonly value="${customer.phone}" type="text" class="form-control" name="phone" id="phone" placeholder="enter phone" title="enter your phone number if any.">
						</div>
					</div>
					
					<div class="form-group">
						
						<div class="col-xs-6">
							<label for="email"><h4>Email</h4></label>
							<input readonly value="${customer.email}" type="text" class="form-control" name="email" id="email" placeholder="you@email.com" title="enter your email.">
						</div>
					</div>
					<div class="form-group">
						
						<div class="col-xs-6">
							<label for="email"><h4>Address</h4></label>
							<input readonly value="${customer.address}" type="text" class="form-control" name="address" id="address" title="enter a location">
							
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<br>
						</div>
					</div>
			</form>
			
			<hr>
			
			</div><!--/tab-pane-->
			<div class="tab-pane" id="messages">
			
			<h2></h2>
			
			<hr>
				<form:form class="form" action="/profile/update" method="post" modelAttribute="customer">
					<div class="form-group">
						
						<div class="col-xs-6">
							<label for="first_name"><h4>CustomerId</h4></label>
							<input readonly value="${customer.customerId}" type="text" class="form-control" name="customerId" id="customerId" placeholder="first name" title="enter your first name if any.">
						</div>
					</div>
					<div class="form-group">
						
						<div class="col-xs-6">
						<label for="last_name"><h4>Name</h4></label>
							<input value="${customer.name}" type="text" class="form-control" name="name" id="name" placeholder="name" title="enter your last name if any.">
						</div>
					</div>
		
					<div class="form-group">
						
						<div class="col-xs-6">
							<label for="phone"><h4>Phone</h4></label>
							<input value="${customer.phone}" type="text" class="form-control" name="phone" id="phone" placeholder="enter phone" title="enter your phone number if any.">
						</div>
					</div>
		
					<div class="form-group">
						
						<div class="col-xs-6">
							<label for="email"><h4>Email</h4></label>
							<input value="${customer.email}" type="text" class="form-control" name="email" id="email" placeholder="you@email.com" title="enter your email.">
						</div>
					</div>
					<div class="form-group">
						
						<div class="col-xs-6">
							<label for="email"><h4>Address</h4></label>
							<input value="${customer.address}" type="text" class="form-control" name="address" id="address" placeholder="where" title="enter a location">
							<input value="${customer.password}" type="hidden" class="form-control" name="password" id="password" placeholder="where" title="enter a location">
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<br>
							<button class="btn btn-lg btn-success" type="submit"><i class="glyphicon glyphicon-ok-sign"></i> Save</button>
						</div>
					</div>
			</form:form>
			
			</div><!--/tab-pane-->
		</div><!--/tab-content-->

	</div><!--/col-9-->
</div><!--/row-->
													