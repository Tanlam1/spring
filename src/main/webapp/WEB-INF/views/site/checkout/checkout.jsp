<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="data" value="${content.objs}"/>

<div class="row">
    <c:if test="${not empty messageError}">
        <div class="col-lg-12">
            <span style=" width: 100%; text-align: center; display: block; margin: 10px 0 20px; font-size: 16px; color: #e41378; font-weight: bold; ">${messageError}<a href="/cart">Về giỏ hàng</a> </span>
        </div>
    </c:if>
    <div class="col-lg-8">
        <div class="bg-white rounded shadow-sm overflow-hidden">
            <div class="address p-3 bg-light">
                <h6 class="m-0 text-dark d-flex align-items-center">Address <span class="small ml-auto"><a
                            href="#" class="font-weight-bold text-decoration-none text-success"
                            data-toggle="modal" data-target="#exampleModal"><i
                                class="icofont-location-arrow"></i> Change</a></span></h6>
            </div>
            <div class="p-3">
                <div class="d-flex align-items-center">
                    <p class="mb-2 font-weight-bold">Home</p>
                    <p class="mb-2 badge badge-danger ml-auto">Default</p>
                </div>
                <p class="small text-muted m-0">1001 Veterans Blvd</p>
                <p class="small text-muted m-0">Redwood City, CA 94063</p>
            </div>
            <div class="address p-3 bg-light">
                <h6 class="m-0 text-dark">Payment Method</h6>
            </div>
            <div class="p-3">
                <a href="#" class="text-success text-decoration-none w-100" data-toggle="modal"
                    data-target="#paymentModal">
                    <div class="d-flex align-items-center">
                        <i class="icofont-credit-card"></i> <span class="ml-3">Edit Payment Method</span> <i
                            class="icofont-rounded-right ml-auto"></i>
                    </div>
                </a>
            </div>
            <div class="address p-3 bg-light">
                <h6 class="text-dark m-0">Promo Code</h6>
            </div>
            <div>
                <div class="accordion" id="accordionExample">
                    <div class="d-flex align-items-center" id="headingThree">
                        <a class="p-3 d-flex align-items-center text-decoration-none text-success w-100"
                            type="button" data-toggle="collapse" data-target="#collapseThree"
                            aria-expanded="false" aria-controls="collapseThree">
                            <i class="icofont-badge mr-3"></i> Add Promo Code
                            <i class="icofont-rounded-down ml-auto"></i>
                        </a>
                    </div>
                    <div id="collapseThree" class="collapse p-3 border-top" aria-labelledby="headingThree"
                        data-parent="#accordionExample">
                        <div class="clearfix">
                            <div class="input-group-sm mb-2 input-group">
                                <input placeholder="Enter promo code" type="text" class="form-control">
                                <div class="input-group-append"><button id="button-addon2" type="button"
                                        class="btn btn-success"><i class="icofont-percent"></i>
                                        APPLY</button></div>
                            </div>
                            <div class="mb-0 input-group">
                                <div class="input-group-prepend"><span class="input-group-text"><i
                                            class="icofont-ui-message"></i></span></div>
                                <textarea placeholder="Any suggestions? We will pass it on..."
                                    aria-label="With textarea" class="form-control"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-4">
        <div class="sticky_sidebar">
            <div class="bg-white rounded overflow-hidden shadow-sm mb-3 checkout-sidebar">
                <div class="d-flex align-items-center osahan-cart-item-profile border-bottom bg-white p-3">
                    <img alt="osahan" src="/assets/client/img/starter1.jpg" class="mr-3 rounded-circle img-fluid">
                    <div class="d-flex flex-column">
                        <h6 class="mb-1 font-weight-bold">Tshop Online Store</h6>
                        <p class="mb-0 small text-muted"><i class="feather-map-pin"></i> 169, Dong Thap . Viet Nam</p>
                    </div>
                </div>
                <div>
                    <div class="bg-white p-3 clearfix">
                        <p class="font-weight-bold small mb-2">Bill Details</p>
                        <p class="mb-1">Item Total <span class="small text-muted">(${cartItems.size()} item)</span> <span
                                class="float-right text-dark">$<fmt:formatNumber type="number" maxFractionDigits="2" value="${totalPrice}"/> </span></p>
                        <p class="mb-1">VAT (included in the product price)  <span class="float-right text-dark">$0</span></p>
                        <p class="mb-3">
                            Ship <span data-toggle="tooltip" data-placement="top"
                                title="Delivery partner fee - $1" class="text-info ml-1"><i class="icofont-info-circle"></i></span>
                                <span class="float-right text-dark">Free</span>
                        </p>
                        <h6 class="mb-0 text-success">
                            Total Discount<span
                                class="float-right text-success">$<fmt:formatNumber type="number" maxFractionDigits="2" value="${totalPrice}"/></span>
                        </h6>
                    </div>
                    <div class="p-3 border-top">
                        <h5 class="mb-0">TO PAY <span class="float-right text-danger">$<fmt:formatNumber type="number" maxFractionDigits="2" value="${totalPrice}"/></span></h5>
                    </div>
                </div>
            </div>
            <a href="/checkout/send" class="btn btn-success btn-lg btn-block mt-3 mb-3">Place Order</a>
            <p class="text-success text-center">Your Total Savings on this order 
                $<fmt:formatNumber type="number" maxFractionDigits="2" value="${totalSaving}"/>
            </p>
        </div>
    </div>
</div><div class="modal fade" id="paymentModal" tabindex="-1" role="dialog" aria-labelledby="paymentModalLabel"
aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="paymentModalLabel">Edit Payment Method</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <div class="schedule">
                <ul class="nav nav-tabs justify-content-center nav-fill" id="myTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a class="nav-link active text-dark" id="credit-tab" data-toggle="tab" href="#credit"
                            role="tab" aria-controls="credit" aria-selected="true">
                            <p class="mb-0 font-weight-bold"><i class="icofont-credit-card mr-2"></i>
                                Credit/Debit Card</p>
                        </a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link text-dark" id="banking-tab" data-toggle="tab" href="#banking"
                            role="tab" aria-controls="banking" aria-selected="false">
                            <p class="mb-0 font-weight-bold"><i class="icofont-globe mr-2"></i> Net Banking</p>
                        </a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link text-dark" id="cash-tab" data-toggle="tab" href="#cash" role="tab"
                            aria-controls="cash" aria-selected="false">
                            <p class="mb-0 font-weight-bold"><i class="icofont-dollar mr-2"></i> Cash on
                                Delivery</p>
                        </a>
                    </li>
                </ul>
                <div class="tab-content bg-white" id="myTabContent">
                    <div class="tab-pane fade show active" id="credit" role="tabpanel"
                        aria-labelledby="credit-tab">
                        <div class="osahan-card-body pt-3">
                            <h6 class="m-0">Add new card</h6>
                            <p class="small">WE ACCEPT <span class="osahan-card ml-2 font-weight-bold">( Master
                                    Card / Visa Card / Rupay )</span></p>
                            <form>
                                <div class="form-row">
                                    <div class="col-md-12 form-group">
                                        <label class="form-label font-weight-bold small">Card number</label>
                                        <div class="input-group">
                                            <input placeholder="Card number" type="number" class="form-control">
                                            <div class="input-group-append"><button id="button-addon2"
                                                    type="button" class="btn btn-outline-secondary"><i
                                                        class="icofont-credit-card"></i></button></div>
                                        </div>
                                    </div>
                                    <div class="col-md-8 form-group"><label
                                            class="form-label font-weight-bold small">Valid
                                            through(MM/YY)</label><input
                                            placeholder="Enter Valid through(MM/YY)" type="number"
                                            class="form-control"></div>
                                    <div class="col-md-4 form-group"><label
                                            class="form-label font-weight-bold small">CVV</label><input
                                            placeholder="Enter CVV Number" type="number" class="form-control">
                                    </div>
                                    <div class="col-md-12 form-group"><label
                                            class="form-label font-weight-bold small">Name on card</label><input
                                            placeholder="Enter Card number" type="text" class="form-control">
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" id="custom-checkbox1"
                                                class="custom-control-input">
                                            <label title="" type="checkbox" for="custom-checkbox1"
                                                class="custom-control-label small pt-1">Securely save this card
                                                for a faster checkout next time.</label>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="banking" role="tabpanel" aria-labelledby="banking-tab">
                        <div class="osahan-card-body pt-3">
                            <form>
                                <div class="btn-group btn-group-toggle w-100" data-toggle="buttons">
                                    <label class="btn btn-outline-secondary active">
                                        <input type="radio" name="options" id="option1" checked=""> HDFC
                                    </label>
                                    <label class="btn btn-outline-secondary">
                                        <input type="radio" name="options" id="option2"> ICICI
                                    </label>
                                    <label class="btn btn-outline-secondary">
                                        <input type="radio" name="options" id="option3"> AXIS
                                    </label>
                                </div>
                                <div class="form-row pt-3">
                                    <div class="col-md-12 form-group">
                                        <label class="form-label small font-weight-bold">Select Bank</label><br>
                                        <select class="custom-select form-control">
                                            <option>Bank</option>
                                            <option>KOTAK</option>
                                            <option>SBI</option>
                                            <option>UCO</option>
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="cash" role="tabpanel" aria-labelledby="cash-tab">
                        <div class="custom-control custom-checkbox pt-3">
                            <input type="checkbox" class="custom-control-input" id="customControlAutosizing">
                            <label class="custom-control-label" for="customControlAutosizing">
                                <b>Cash</b><br>
                                <p class="small text-muted m-0">Please keep exact change handy to help us serve
                                    you better</p>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer p-0 border-0">
            <div class="col-6 m-0 p-0">
                <button type="button" class="btn border-top btn-lg btn-block"
                    data-dismiss="modal">Close</button>
            </div>
            <div class="col-6 m-0 p-0">
                <button type="button" class="btn btn-success btn-lg btn-block">Proceed</button>
            </div>
        </div>
    </div>
</div>
</div>