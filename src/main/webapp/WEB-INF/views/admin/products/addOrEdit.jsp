<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set var="data" value="${content.objs}"/>

<div class="row">
	<div class="col-md-12">
		<div class="col-md-12">
			<div class="card ">
				<div class="card-header card-header-rose card-header-text">
					<div class="card-text">
						<h4 class="card-title">${data.product.isEdit ? "Edit product" : "Add product"}</h4>
					</div>
				</div>
				<div class="card-body">
					<form:form method="post" action="/admin/products/saveOrUpdate" modelAttribute="product" enctype="multipart/form-data">
						<div class="row">
							<div class="col-md-8">
								<h4 class="title">Base info</h4>
								<div class="row">
									<div class="col-md-12 mb-4">
										<div class="row">
											<label id="productId" class="col-sm-2 col-form-label">Product Id</label>
											<div class="col-sm-10">
												<div class="form-group">
													<input readonly value="${data.product.productId}" id="productId" placeholder="Product Id.." name="productId" type="text" class="form-control">
													<span class="bmd-help">Product tự động sinh và không thể chỉnh sửa.</span><br>
													<form:errors cssClass="category form-category" path="productId" />
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-12 mb-4">
										<div class="row">
											<label id="name" class="col-sm-2 col-form-label">Product Name</label>
											<div class="col-sm-10">
												<div class="form-group">
													<input value="${data.product.name}" id="name" placeholder="Product Name.." name="name" type="text" class="form-control">
													<span class="bmd-help">Product trên 5 ký tự.</span><br>
													<form:errors cssClass="category form-category" path="name" />
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-12 mb-4">
										<div class="row">
											<label id="quantity" class="col-sm-2 col-form-label">Quantity</label>
											<div class="col-sm-10">
												<div class="form-group">
													<input value="${data.product.quantity}" id="quantity" placeholder="Product quantity.." name="quantity" type="number" class="form-control">
													<span class="bmd-help">Product quantity phải lớn hơn 0.</span><br>
													<form:errors cssClass="category form-category" path="quantity" />
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-12 mb-4">
										<div class="row">
											<label id="unitPrice" class="col-sm-2 col-form-label">Unit price</label>
											<div class="col-sm-10">
												<div class="form-group">
													<input value="${data.product.unitPrice}" id="unitPrice" placeholder="Product unitPrice.." name="unitPrice" type="number" class="form-control">
													<span class="bmd-help">unitPrice.</span><br>
													<form:errors cssClass="category form-category" path="unitPrice" />
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-12 mb-4">
										<div class="row">
											<label id="discount" class="col-sm-2 col-form-label">Discount</label>
											<div class="col-sm-10">
												<div class="form-group">
													<input value="${data.product.discount}" id="discount" placeholder="Product discount.." name="discount" type="number" class="form-control">
													<span class="bmd-help">discount.</span><br>
													<form:errors cssClass="category form-category" path="discount" />
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-12 mb-4 mt-4">
										<div class="row">
											<label class="col-sm-2 col-form-label">Options</label>
											<div class="col-sm-4">
												<form:select data-style="btn btn-primary btn-round" class="selectpicker" path="categoryId" items="${categories}">
												</form:select><br>
												<form:errors cssClass="category form-category" path="categoryId" />
											</div>
											<div class="col-sm-6">
												<form:select data-style="btn btn-primary btn-round" class="selectpicker" path="status" items="${status}">
												</form:select><br>
												<form:errors cssClass="category form-category" path="status" />
											</div>
										</div>										
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<h4 class="title">Choose Image</h4>
								<div class="fileinput fileinput-new text-center" data-provides="fileinput">
									<div class="fileinput-new thumbnail">
										<input class="imageOther" type="hidden" value="${data.product.image}" name="image">
										<img src="${not empty data.product.image ? data.product.image : '/assets/admin/img/image_placeholder.jpg'}" alt="Product image">
									</div>
									<div class="fileinput-preview fileinput-exists thumbnail"></div>
									<div>
										<span class="btn btn-rose btn-round btn-file">
											<span class="fileinput-new">Select image</span>
											<span class="fileinput-exists">Change</span>
											<input onchange="setImageOther()" type="file" name="imageFile" />
										</span>
										<a href="#pablo" class="btn btn-danger btn-round fileinput-exists"
											data-dismiss="fileinput"><i class="fa fa-times"></i> Remove</a>
									</div>
								</div>
							</div>
							<div class="col-md-12 mb-4 mt-4">
								<div class="row">
									<label style=" margin-left: -65px; " id="description" class="col-sm-2 col-form-label">Description</label>
									<div class="col-sm-10">
										<div class="form-group">
											<textarea rows="5" cols="50" id="description" placeholder="Product description.." name="description" type="number" class="form-control">${data.product.description}</textarea>
											<form:errors cssClass="category form-category" path="description" />
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer ">
							<a href="/admin/products" class="btn">
								<span class="btn-label">
								  <i class="material-icons">keyboard_arrow_left</i>
								</span>
								Product List
							  <div class="ripple-container"></div>
							</a>
							<button type="submit" class="btn btn-fill btn-rose">
								${data.product.isEdit ? "Edit" : "Add"}
								<div class="ripple-container">
								</div>
							</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</div>