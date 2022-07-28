<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set var="orderDetails" value="${content.objs.order.orderDetails}"/>
<c:set var="order" value="${content.objs.order}"/>


<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header card-header-rose card-header-icon">
                <div class="card-icon">
                    <i class="material-icons">library_books</i>
                </div>
                <h4 class="card-title">Detail order #${order.orderId}</h4>
            </div>
            
            <div class="card-body">
                <div class="table-responsive">
                    <div class="alert alert-primary" role="alert">
                        Trạng thái đơn hàng: <strong>${status[(order.status).intValue()]}</strong>
                    </div>
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
                        <c:when test="${empty orderDetails}">
                            <div class="row">
                                <div class="col">
                                    <div class="alert alert-danger" role="alert">
                                        <strong>No Detail Order Found</strong>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table class="table-hover table">
                                <thead>
                                    <tr>
                                        <th class="text-left">
                                            <strong>#ID</strong>
                                        </th>
                                        <th class="text-left">
                                            <strong>Quantity</strong>
                                        </th>
                                        <th class="text-left">
                                            <strong>Unit price</strong>
                                        </th>
                                        <th class="text-left">
                                            <strong>Total</strong>
                                        </th>
                                        <th class="text-left">
                                            <strong>Product</strong>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="orderDetail" items="${orderDetails}" varStatus="loop">
                                        <tr>
                                            <td class="text-left">${orderDetail.orderDetailId}</td>
                                            <td class="text-left">${orderDetail.quantity}</td>
                                            <td class="text-left">$${orderDetail.unitPrice}</td>
                                            <td class="text-left">$${orderDetail.quantity * orderDetail.unitPrice}</td>
                                            <td class="text-left">
                                                <a href="/product/detail/${orderDetail.productId}">${item.name}Product link</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                    <a href="/admin/orders/detail/${order.orderId}" class="btn btn-outline-success">Reset</a>
                </div>
            </div>
        </div>
    </div>
</div>