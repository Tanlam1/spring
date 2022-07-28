<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="data" value="${content.objs}" />

<div class="bg-success row d-flex justify-content-center">
    <div class="col-md-6">
        <div class="p-5 text-center">
            <i class="icofont-check-circled display-1 text-warning"></i>
            <h1 class="text-white font-weight-bold">Your order has been successful</h1>
            <p class="text-white">Check your order status in <a
                    href="https://askbootstrap.com/design/features-of-zomato-online-food-order-delivery-app/"
                    class="font-weight-bold text-decoration-none text-white">My Order</a> about next steps
                information.</p>
        </div>

        <div class="bg-white rounded p-3 m-5 text-center">
            <h6 class="font-weight-bold mb-2">Preparing your order</h6>
            <p class="small text-muted">Your order will be prepared and will come soon</p>
            <a href="status_onprocess.html" class="btn rounded btn-warning btn-lg btn-block">Track My
                Order</a>
        </div>
    </div>
</div>