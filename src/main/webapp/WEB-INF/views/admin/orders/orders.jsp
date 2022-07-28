<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set 
    var="query_string" 
    value="${requestScope['javax.servlet.forward.query_string']}" 
/>
<div class="row">
    <div class="col-md-12 mt-3 mb-4">
        <form action="/admin/orders/">
            <div class="d-flex align-items-center">
                <input value="${param.keyword}" class="form-control mr-2" type="text" id="keyword" name="keyword" placeholder="Search Orders..">
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
                    <i class="material-icons">library_books</i>
                </div>
                <h4 class="card-title">Orders</h4>
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
                        <c:when test="${!data.orderPage.hasContent()}">
                            <div class="row">
                                <div class="col">
                                    <div class="alert alert-danger" role="alert">
                                        <strong>No Orders Found</strong>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <span class="card-title">
                                <c:if test="${not empty param.keyword}">
                                    Kết quả tìm kiếm: <strong><i>${param.keyword}</i></strong>
                                </c:if>
                            </span>
                            <table class="table-hover table">
                                <thead>
                                    <tr>
                                        <th class="text-left">
                                            <strong>Order ID</strong>
                                        </th>
                                        <th class="text-left">
                                            <strong>Order Date</strong>
                                        </th>
                                        <th class="text-left">
                                            <strong>Status</strong>
                                        </th>
                                        <th class="text-left">
                                            <strong>Amount</strong>
                                        </th>
                                        <th class="text-left">
                                            <strong>CustomerId</strong>
                                        </th>
                                        <th class="text-right">
                                            <strong>Actions</strong>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${data.orderPage.content}" varStatus="loop">
                                        <tr>
                                            <td class="text-left">${order.orderId}</td>
                                            <td class="text-left">${order.orderDate}</td>
                                            <td class="text-left">${status[(order.status).intValue()]}</td>
                                            <td class="text-left">$${order.amount}</td>
                                            <td class="text-left">${order.customer.customerId}</td>
                                            <td class="td-actions text-right">
                                                <a href="/admin/orders/view/${order.orderId}" type="button" rel="tooltip" class="btn btn-success">
                                                    <i class="material-icons">edit</i>
                                                </a>
                                                <button onclick="showModelDeleteSure('${order.orderId}', 'Order id: ${order.orderId}', '/admin/orders/delete/')" class="btn btn-danger" data-toggle="modal" data-target="#myModal10">
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
                        <c:if test="${data.orderPage.totalPages > 0}">
                            <form action="/admin/orders/?${query_string}">
                                <input type="hidden" name="keyword" value="${param.keyword}">
                                <input type="hidden" name="page" value="${param.page}">
                                <div class="form-group d-flex align-items-center">
                                    <select class="selectpicker" data-size="7" data-style="btn btn-primary btn-round" title="Size on page" onchange="this.form.submit()" name="size"
                                    id="size">
                                        <option disabled selected>Size on page</option>
                                        <option ${data.orderPage.size==5 ? 'selected' : '' } value="5">Size: 5</option>
                                        <option ${data.orderPage.size==10 ? 'selected' : '' } value="10">Size: 10</option>
                                        <option ${data.orderPage.size==15 ? 'selected' : '' } value="15">Size: 15</option>
                                        <option ${data.orderPage.size==20 ? 'selected' : '' } value="20">Size: 20</option>
                                        <option ${data.orderPage.size==30 ? 'selected' : '' } value="30">Size: 30</option>
                                    </select>
                                </div>
                            </form>
                            <nav aria-label="Page navigation">
                                <ul style="margin-bottom: 0;" class="pagination justify-content-center">
                                    <li class="page-item ${data.orderPage.number + 1 == 1 ? 'active': ''}">
                                        <a class="page-link"
                                            href="/admin/orders/?name=${data.name}&size=${data.orderPage.size}&page=1"
                                            aria-label="Previous">
                                            <span>&laquo; First</span>
                                        </a>
                                    </li>
                                    <c:if test="${data.orderPage.totalPages > 1}">
                                        <c:forEach var="pageNumber" items="${data.pageNumbers}" varStatus="loop">
                                            <li class="page-item ${pageNumber == data.orderPage.number + 1 ? 'active' : ''}"><a
                                                    class="page-link"
                                                    href="/admin/orders/?name=${data.name}&size=${data.orderPage.size}&page=${pageNumber}">${pageNumber}</a>
                                            </li>
                                        </c:forEach>
                                    </c:if>
                                    <li class="page-item ${data.orderPage.number + 1 == data.orderPage.totalPages ? 'active': ''}">
                                        <a class="page-link"
                                            href="/admin/orders/?name=${data.name}&size=${data.orderPage.size}&page=${data.orderPage.totalPages}"
                                            aria-label="Previous">
                                            <span>Last &raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                    <a href="/admin/orders/" class="btn btn-outline-success">Reset</a>
                </div>
            </div>
        </div>
    </div>
</div>