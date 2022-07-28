<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set var="data" value="${content.objs}"/>

<div class="row">
    <div class="col-md-12 mt-3 mb-4">
        <form action="/admin/products/">
            <div class="d-flex align-items-center">
                <input value="${param.name}" class="form-control mr-2" type="text" id="name" name="name"
                    placeholder="Search products..">
                <input type="hidden" name="size" value="${param.size}">
                <input type="hidden" name="page" value="${param.page}">
                <button style="padding: 9px 27px;margin-left: 12px;"
                    class="btn btn-outline-primary">Search</button>
            </div>
        </form>
    </div>
    <div class="col-md-12">
        <div class="card">
            <div class="card-header card-header-rose card-header-icon">
                <div class="card-icon">
                    <i class="material-icons">assignment</i>
                </div>
                <h4 class="card-title">Product list</h4>
            </div>
            <div class="card-body">
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
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <span class="card-title">
                        <c:if test="${not empty param.name}">
                            Kết quả tìm kiếm: <strong><i>${param.name}</i></strong>
                        </c:if>
                    </span>
                    <a href="/admin/products/add" class="pull-right btn btn-outline-info">Add new
                        product</a>
                </div>
                <c:choose>
                    <c:when test="${data.productPage.hasContent()}">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th class="text-left">#</th>
                                        <th class="text-left">Image</th>
                                        <th>Product</th>
                                        <th class="text-left">Quantity</th>
                                        <th class="text-left">Unit Price</th>
                                        <th class="text-left">Discount</th>
                                        <th class="text-left">Status</th>
                                        <th class="text-left">Category</th>
                                        <th class="text-right">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${data.productPage.content}">
                                        <tr>
                                            <td class="td-name">
                                                <a href="#jacket">${item.productId}</a>
                                            </td>
                                            <td class="td-image">
                                                <div class="img-container">
                                                    <img src="/uploads/images/${item.image}"
                                                        alt="${item.name}">
                                                </div>
                                            </td>
                                            <td class="td-name">
                                                <a href="#jacket">${item.name}</a>
                                                <small>${item.description}</small>
                                            </td>
                                            <td class="td-number">
                                                ${item.quantity}
                                            </td>
                                            <td class="td-number">
                                                <small>&dollar;</small>${item.unitPrice}
                                            </td>
                                            <td class="td-number">
                                                ${item.discount} <small>&percnt;</small>
                                            </td>
                                            <td class="td-number">
                                                <c:out value="${status[(item.status).intValue()]}"/>
                                            </td>
                                            <td class="td-number">
                                                ${item.category.name}
                                            </td>
                                            <td class="td-actions text-right">
                                                <a href="/admin/products/edit/${item.productId}"
                                                    rel="tooltip" class="btn btn-success">
                                                    <i class="material-icons">edit</i>
                                                </a>
                                                <button onclick="showModelDeleteSure('${item.productId}', '${item.name}', '/admin/products/delete/')" class="btn btn-danger" data-toggle="modal" data-target="#myModal10">
                                                    <i class="material-icons">close</i> 
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <div class="col">
                                <div class="alert alert-danger" role="alert">
                                    <strong>No Categories Found</strong>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="card-footer text-mutted">
                    <c:if test="${data.productPage.totalPages > 0}">
                        <form action="/admin/products/?${query_string}">
                            <input type="hidden" name="name" value="${param.name}">
                            <input type="hidden" name="page" value="${param.page}">
                            <div class="form-group d-flex align-items-center">
                                <select class="selectpicker" data-size="7"
                                    data-style="btn btn-primary btn-round" title="Size on page"
                                    onchange="this.form.submit()" name="size" id="size">
                                    <option disabled selected>Size on page</option>
                                    <option ${data.productPage.size==5 ? 'selected' : '' } value="5">Size: 5
                                    </option>
                                    <option ${data.productPage.size==10 ? 'selected' : '' } value="10">Size:
                                        10</option>
                                    <option ${data.productPage.size==15 ? 'selected' : '' } value="15">Size:
                                        15</option>
                                    <option ${data.productPage.size==20 ? 'selected' : '' } value="20">Size:
                                        20</option>
                                    <option ${data.productPage.size==30 ? 'selected' : '' } value="30">Size:
                                        30</option>
                                </select>
                            </div>
                        </form>
                        <nav aria-label="Page navigation">
                            <ul style="margin-bottom: 0;" class="pagination justify-content-center">
                                <li class="page-item ${data.productPage.number + 1 == 1 ? 'active': ''}">
                                    <a class="page-link"
                                        href="/admin/products/?name=${data.name}&size=${data.productPage.size}&page=1"
                                        aria-label="Previous">
                                        <span>&laquo; First</span>
                                    </a>
                                </li>
                                <c:if test="${data.productPage.totalPages > 1}">
                                    <c:forEach var="pageNumber" items="${data.pageNumbers}"
                                        varStatus="loop">
                                        <li
                                            class="page-item ${pageNumber == data.productPage.number + 1 ? 'active' : ''}">
                                            <a class="page-link"
                                                href="/admin/products/?name=${data.name}&size=${data.productPage.size}&page=${pageNumber}">${pageNumber}</a>
                                        </li>
                                    </c:forEach>
                                </c:if>
                                <li
                                    class="page-item ${data.productPage.number + 1 == data.productPage.totalPages ? 'active': ''}">
                                    <a class="page-link"
                                        href="/admin/products/?name=${data.name}&size=${data.productPage.size}&page=${data.productPage.totalPages}"
                                        aria-label="Previous">
                                        <span>Last &raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </div>
                <a href="/admin/products/" class="btn btn-outline-success">Reset</a>
            </div>
        </div>
    </div>
</div>