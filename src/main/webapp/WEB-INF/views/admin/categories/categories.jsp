<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set 
    var="query_string" 
    value="${requestScope['javax.servlet.forward.query_string']}" 
/>

<c:set var="data" value="${content.objs}"/>
<div class="row">
    <div class="col-md-12 mt-3 mb-4">
        <form action="/admin/categories/">
            <div class="d-flex align-items-center">
                <input value="${param.name}" class="form-control mr-2" type="text" id="name" name="name" placeholder="Search categories..">
                <input type="hidden" name="size" value="${param.size}">
                <input type="hidden" name="page" value="${param.page}">
                <button style="padding: 9px 27px;margin-left: 12px;" class="btn btn-outline-primary">Search</button>
            </div>
        </form>
    </div>
    <div class="col-md-12">
        <div class="card">
            <div class="card-header card-header-rose card-header-icon">
                <div class="card-icon">
                    <i class="material-icons">category</i>
                </div>
                <h4 class="card-title">Categories</h4>
            </div>
            <div class="card-body">
                <div class="table-responsive">
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
                    <c:choose>
                        <c:when test="${!data.categoryPage.hasContent()}">
                            <div class="row">
                                <div class="col">
                                    <div class="alert alert-danger" role="alert">
                                        <strong>No Categories Found</strong>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <span class="card-title">
                                <c:if test="${not empty param.name}">
                                    Kết quả tìm kiếm: <strong><i>${param.name}</i></strong>
                                </c:if>
                            </span>
                            <table class="table-hover table">
                                <thead>
                                    <tr>
                                        <th class="text-left">
                                            <strong>Category ID</strong>
                                        </th>
                                        <th class="text-left">
                                            <strong>Category Name</strong>
                                        </th>
                                        <th class="text-right">
                                            <strong>Actions</strong>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="category" items="${data.categoryPage.content}" varStatus="loop">
                                        <tr>
                                            <td class="text-left">${category.categoryId}</td>
                                            <td class="text-left">${category.name}</td>
                                            <td class="td-actions text-right">
                                                <a href="/admin/categories/edit/${category.categoryId}" type="button" rel="tooltip" class="btn btn-success">
                                                    <i class="material-icons">edit</i>
                                                </a>
                                                <button onclick="showModelDeleteSure('${category.categoryId}', '${category.name}', '/admin/categories/delete/')" class="btn btn-danger" data-toggle="modal" data-target="#myModal10">
                                                    <i class="material-icons">close</i> 
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                    <div class="card-footer text-mutted">
                        <c:if test="${data.categoryPage.totalPages > 0}">
                            <form action="/admin/categories/?${query_string}">
                                <input type="hidden" name="name" value="${param.name}">
                                <input type="hidden" name="page" value="${param.page}">
                                <div class="form-group d-flex align-items-center">
                                    <select class="selectpicker" data-size="7" data-style="btn btn-primary btn-round" title="Size on page" onchange="this.form.submit()" name="size"
                                    id="size">
                                        <option disabled selected>Size on page</option>
                                        <option ${data.categoryPage.size==5 ? 'selected' : '' } value="5">Size: 5</option>
                                        <option ${data.categoryPage.size==10 ? 'selected' : '' } value="10">Size: 10</option>
                                        <option ${data.categoryPage.size==15 ? 'selected' : '' } value="15">Size: 15</option>
                                        <option ${data.categoryPage.size==20 ? 'selected' : '' } value="20">Size: 20</option>
                                        <option ${data.categoryPage.size==30 ? 'selected' : '' } value="30">Size: 30</option>
                                    </select>
                                </div>
                            </form>
                            <nav aria-label="Page navigation">
                                <ul style="margin-bottom: 0;" class="pagination justify-content-center">
                                    <li class="page-item ${data.categoryPage.number + 1 == 1 ? 'active': ''}">
                                        <a class="page-link"
                                            href="/admin/categories/?name=${data.name}&size=${data.categoryPage.size}&page=1"
                                            aria-label="Previous">
                                            <span>&laquo; First</span>
                                        </a>
                                    </li>
                                    <c:if test="${data.categoryPage.totalPages > 1}">
                                        <c:forEach var="pageNumber" items="${data.pageNumbers}" varStatus="loop">
                                            <li class="page-item ${pageNumber == data.categoryPage.number + 1 ? 'active' : ''}"><a
                                                    class="page-link"
                                                    href="/admin/categories/?name=${data.name}&size=${data.categoryPage.size}&page=${pageNumber}">${pageNumber}</a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                    <li class="page-item ${data.categoryPage.number + 1 == data.categoryPage.totalPages ? 'active': ''}">
                                        <a class="page-link"
                                            href="/admin/categories/?name=${data.name}&size=${data.categoryPage.size}&page=${data.categoryPage.totalPages}"
                                            aria-label="Previous">
                                            <span>Last &raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                    <a href="/admin/categories/add" class="btn btn-outline-info">Add new category</a>
                    <a href="/admin/categories/" class="btn btn-outline-success">Reset</a>
                </div>
            </div>
        </div>
    </div>
</div>