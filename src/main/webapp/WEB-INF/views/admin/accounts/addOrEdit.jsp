<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set var="data" value="${content.objs}"/>
<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-6">
		<form:form method="post" action="/admin/accounts/saveOrUpdate" modelAttribute="account">
			<div class="card ">
				<div class="card-header card-header-rose card-header-icon">
					<div class="card-icon">
						<i class="material-icons">person</i>
					</div>
					<h4 class="card-title">${data.account.isEdit ? 'Edit Account' : 'Add New Account'}</h4>
				</div>
				<div class="card-body ">
					<div class="form-group mb-4 mt-5">
						<label for="username" class="bmd-label-floating"> Username </label>
						<input type="hidden" name="isFromAdd" value="${data.account.isFromAdd == null ? true : data.account.isFromAdd}">
						<input value="${data.account.username}" type="text" class="form-control" id="username" name="username" ${data.account.isEdit ? 'readonly' : ''}>
						<form:errors cssClass="category form-category" path="username" />
					</div>
					<c:if test="${data.account.isEdit}">
						<div class="form-group mb-4 mt-5">
							<label for="old_password" class="bmd-label-floating"> Old Password </label>
							<input type="password" class="form-control" id="old_password" name="old_password">
							<c:if test="${not empty error_edit_account}">
								<span class="category form-category">${error_edit_account}</span>
							</c:if>
						</div>
					</c:if>
					<div class="form-group mb-4 mt-5">
						<label for="password" class="bmd-label-floating"> ${data.account.isEdit ? 'New Password' : 'Password'} </label>
						<input type="password" class="form-control" id="password" name="password">
						<form:errors cssClass="category form-category" path="password" />
					</div>
				</div>
				<div class="card-footer ml-auto mr-auto">
					<a href="/admin/accounts" class="btn btn-outline-light btn-block confirm-button">List Accounts</a>
					<button type="submit" class="btn btn-rose">${data.account.isEdit ? 'Edit' : 'Save'}</button>
				</div>
			</div>
		</form:form>
	</div>
	<div class="col-md-3"></div>
</div>