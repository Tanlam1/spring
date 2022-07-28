<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set var="data" value="${content.objs}"/>
<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-6">
		<form:form method="post" action="/admin/categories/saveOrUpdate" modelAttribute="category">
			<div class="card ">
				<div class="card-header card-header-rose card-header-icon">
					<div class="card-icon">
						<i class="material-icons">category</i>
					</div>
					<h4 class="card-title">${data.category.isEdit ? 'Edit Category' : 'Add New Category'}</h4>
				</div>
				<div class="card-body ">
					<div class="form-group mb-4 mt-5">
						<label for="categoryId" class="bmd-label-floating"> Category ID </label>
						<input style=" background: #eeeeee; " value="${data.category.categoryId}" type="text" class="form-control" id="categoryId" name="categoryId" readonly>
						<form:errors cssClass="category form-category" path="categoryId" />
					</div>
					<div class="form-group mb-4 mt-5">
						<label for="name" class="bmd-label-floating"> Category Name </label>
						<input value="${data.category.name}" type="text" class="form-control" id="name" name="name">
						<form:errors cssClass="category form-category" path="name" />
					</div>
				</div>
				<div class="card-footer ml-auto mr-auto">
					<a href="/admin/categories" class="btn btn-outline-light btn-block confirm-button">List Categories</a>
					<button type="submit" class="btn btn-rose">${data.category.isEdit ? 'Edit' : 'Save'}</button>
				</div>
			</div>
		</form:form>
	</div>
	<div class="col-md-3"></div>
</div>