<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="orderContent" value="${content.objs.order}"></c:set>
<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-6">
		<form:form method="post" action="/admin/orders/saveOrUpdate" modelAttribute="order">
			<div class="card ">
				<div class="card-header card-header-rose card-header-icon">
					<div class="card-icon">
						<i class="material-icons">library_books</i>
					</div>
					<h4 class="card-title">Theo dõi đơn hàng</h4>
				</div>
				<div class="card-body ">
					<c:if test="${ not empty param.message}">
						<div class="alert alert-success">
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<i class="material-icons">close</i>
							</button>
							<span>
								<b> Success - </b> ${param.message}
							</span>
						</div>
					</c:if>
					<div class="form-group mb-4 mt-5">
						<label for="orderId" class="bmd-label-floating"> order ID </label>
						<input style=" background: #eeeeee; " value="${orderContent.orderId}" type="text" class="form-control" id="orderId" name="orderId" readonly>
						<form:errors cssClass="category form-category" path="orderId" />
					</div>
					<div class="form-group mb-4 mt-5">
						<label for="amount" class="bmd-label-floating"> Amount </label>
						<input readonly value="${orderContent.amount}" type="text" class="form-control" id="amount" name="amount">
						<form:errors cssClass="category form-category" path="amount" />
					</div>
					<div class="form-group mb-4 mt-5">
						<label for="orderDate" class="bmd-label-floating"> Date </label>
						<input readonly value="${orderContent.orderDate}" type="date" class="form-control" id="orderDate" name="orderDate">
						<form:errors cssClass="category form-category" path="orderDate" />
					</div>
					<div class="form-group mb-4 mt-5 select-full">
						<form:select data-style="btn btn-primary btn-round" class="selectpicker" path="status" items="${status}">
						</form:select><br>
						<form:errors cssClass="category form-category" path="status" />
					</div>
					<style>
						.select-full > div {
							width: 100%!important;
						}
					</style>
					<div class="form-group mb-4 mt-5">
						<label for="customerId" class="bmd-label-floating"> CustomerId </label>
						<input readonly value="${orderContent.customerId}" type="text" class="form-control" id="customerId" name="customerId">
						<form:errors cssClass="category form-category" path="customerId" />
					</div>
				</div>
				<div class="card-footer ml-auto mr-auto">
					<a href="/admin/orders" class="btn btn-outline-light btn-block confirm-button">&leftarrow; List Orders</a>
					<c:if test="${orderContent.status != 4}">
						<button type="submit" class="btn btn-rose">${data.order.isEdit ? 'Edit' : 'Save'}</button>
					</c:if>
					<a href="/admin/orders/detail/${orderContent.orderId}" class="btn btn-primary btn-block confirm-button">Order detail &rightarrow;</a>
				</div>
			</div>
		</form:form>
	</div>
	<div class="col-md-3"></div>
</div>