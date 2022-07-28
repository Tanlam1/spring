
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set var="data" value="${content.objs}"/>

<div class="row">
    <div class="col-lg-6">
        <div class="recommend-slider mb-3">
            <!-- <div class="osahan-slider-item">
                <img src="/assets/client/img/recommend/r1.jpg" class="img-fluid mx-auto shadow-sm rounded"
                    alt="Responsive image">
            </div>
            <div class="osahan-slider-item">
                <img src="/assets/client/img/recommend/r2.jpg" class="img-fluid mx-auto shadow-sm rounded"
                    alt="Responsive image">
            </div> -->
            <div class="osahan-slider-item">
                <img src="/uploads/images/${data.product.image}" class="img-fluid mx-auto shadow-sm rounded"
                    alt="Responsive image">
            </div>
        </div>
        <div class="pd-f d-flex align-items-center mb-3">
            <a href="/cart/add/product/${data.product.productId}/1"
                class="btn btn-warning p-3 rounded btn-block d-flex align-items-center justify-content-center mr-3 btn-lg"><i
                    class="icofont-plus m-0 mr-2"></i> ADD TO CART</a>
            <a href="/cart/add/product/${data.product.productId}/1"
                class="btn btn-success p-3 rounded btn-block d-flex align-items-center justify-content-center btn-lg m-0"><i
                    class="icofont-cart m-0 mr-2"></i> BUY NOW</a>
        </div>
    </div>
    <div class="col-lg-6">
        <div class="p-4 bg-white rounded shadow-sm">
            <div class="pt-0">
                <h2 class="font-weight-bold">${data.product.name}</h2>
                <p class="font-weight-light text-dark m-0 d-flex align-items-center">
                    Price : <b class="h6 text-dark m-0">$${data.product.unitPrice}</b>
                    <span class="badge badge-danger ml-2">${status[(data.product.status).intValue()]}</span>
                </p>
                <a href="review.html">
                    <div class="rating-wrap d-flex align-items-center mt-2">
                        <ul class="rating-stars list-unstyled">
                            <li>
                                <i class="icofont-star text-warning"></i>
                                <i class="icofont-star text-warning"></i>
                                <i class="icofont-star text-warning"></i>
                                <i class="icofont-star text-warning"></i>
                                <i class="icofont-star"></i>
                            </li>
                        </ul>
                        <p class="label-rating text-muted ml-2 small"> (245 Reviews)</p>
                    </div>
                </a>
            </div>
            <div class="pt-2">
                <div class="row">
                    <div class="col-6">
                        <p class="font-weight-bold m-0">Delivery</p>
                        <p class="text-muted m-0">Free</p>
                    </div>
                    <div class="col-6 text-right">
                        <p class="font-weight-bold m-0">Available in:</p>
                        <p class="text-muted m-0">1 kg, 2 kg, 5 kg</p>
                    </div>
                </div>
            </div>
            <div class="details">
                <div class="pt-3 bg-white">
                    <div class="d-flex align-items-center">
                        <div class="btn-group osahan-radio btn-group-toggle" data-toggle="buttons">
                            <label class="btn btn-secondary active">
                                <input type="radio" name="options" id="option1" checked> 4 pcs
                            </label>
                            <label class="btn btn-secondary">
                                <input type="radio" name="options" id="option2"> 6 pcs
                            </label>
                            <label class="btn btn-secondary">
                                <input type="radio" name="options" id="option3"> 1 kg
                            </label>
                        </div>
                        <a class="ml-auto" href="#">
                            <form id='myform' class="cart-items-number d-flex" method='POST' action='#'>
                                <input type='button' value='-' class='qtyminus btn btn-success btn-sm'
                                    field='quantity' />
                                <input type='text' name='quantity' value='1' class='qty form-control' />
                                <input type='button' value='+' class='qtyplus btn btn-success btn-sm'
                                    field='quantity' />
                            </form>
                        </a>
                    </div>
                </div>
                <div class="pt-3">
                    <div class="input-group mb-3 border rounded shadow-sm overflow-hidden bg-white">
                        <div class="input-group-prepend">
                            <button class="border-0 btn btn-outline-secondary text-success bg-white"><i
                                    class="icofont-search"></i></button>
                        </div>
                        <input type="text" class="shadow-none border-0 form-control form-control-lg pl-0"
                            placeholder="Type your city (e.g Chennai, Pune)" aria-label=""
                            aria-describedby="basic-addon1">
                    </div>
                    <p class="font-weight-bold mb-2">Product Details</p>
                    <p class="text-muted small mb-0">
                        ${data.product.description}
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<h5 class="mt-3 mb-3">Maybe You Like this.</h5>
<div class="row">
    <c:forEach var="item" items="${data.productRand}">
        <div class="col-sm-3 col-md-3 mb-3">
            <div class="list-card bg-white h-100 rounded overflow-hidden position-relative shadow-sm">
                <div class="list-card-image">
                    <a href="/product/detail/${item.productId}" class="text-dark">
                        <div class="member-plan position-absolute"><span
                                class="badge m-3 badge-danger">${item.discount}%</span></div>
                        <div class="p-3">
                            <img src="/uploads/images/${item.image}" class="img-fluid item-img w-100 mb-3">
                            <h6 class="name-product">${item.name}</h6>
                            <div class="d-flex align-items-center">
                                <h6 class="price m-0 text-success">$${item.unitPrice}</h6>
                                <a data-toggle="collapse" href="#collapseExample1" role="button"
                                    aria-expanded="false" aria-controls="collapseExample1"
                                    class="btn btn-success btn-sm ml-auto">+</a>
                                <div class="collapse qty_show" id="collapseExample1">
                                    <div>
                                        <span class="ml-auto" href="#">
                                            <form id='myform' class="cart-items-number d-flex" method='POST'
                                                action='#'>
                                                <input type='button' value='-'
                                                    class='qtyminus btn btn-success btn-sm' field='quantity' />
                                                <input type='text' name='quantity' value='1'
                                                    class='qty form-control' />
                                                <input type='button' value='+'
                                                    class='qtyplus btn btn-success btn-sm' field='quantity' />
                                            </form>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>