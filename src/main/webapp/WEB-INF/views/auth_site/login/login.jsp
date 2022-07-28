<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<c:set var="data" value="${content.objs}"/>

<div class="row d-flex align-items-center justify-content-center vh-100">
    <div class="landing-page shadow-sm bg-success col-lg-6">
        <a class="position-absolute btn-sm btn btn-outline-light m-4 zindex" href="home.html">Skip <i
                class="icofont-bubble-right"></i></a>
        <div class="osahan-slider m-0">
            <div class="osahan-slider-item text-center">
                <div class="d-flex align-items-center justify-content-center vh-100 flex-column">
                    <i class="icofont-sale-discount display-1 text-warning"></i>
                    <h4 class="my-4 text-white">Best Prices & Offers</h4>
                    <p class="text-center text-white-50 mb-5 px-4">Cheaper prices than your
                        local<br>supermarket, great cashback offers to top it off.</p>
                </div>
            </div>
            <div class="osahan-slider-item text-center">
                <div class="d-flex align-items-center justify-content-center vh-100 flex-column">
                    <i class="icofont-cart display-1 text-warning"></i>
                    <h4 class="my-4 text-white">Wide Assortment</h4>
                    <p class="text-center text-white-50 mb-5 px-4">Choose from 5000+ products across
                        food<br>, personal care, household & other categories.</p>
                </div>
            </div>
            <div class="osahan-slider-item text-center">
                <div class="d-flex align-items-center justify-content-center vh-100 flex-column">
                    <i class="icofont-support-faq display-1 text-warning"></i>
                    <h4 class="my-4 text-white">Easy Returns</h4>
                    <p class="text-center text-white-50 mb-5 px-4">Not satisfied with a product? Return<br>
                        it at the doorstep & get a refund within hours.</p>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-6 pl-lg-5">
        <div class="osahan-signin shadow-sm bg-white p-4 rounded">
            <div class="p-3">
                <h2 class="my-0">Welcome Back</h2>
                <p class="small mb-4">Sign in to Continue.</p>
                <form:form action="/auth/login" modelAttribute="account">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Email</label>
                        <input value="${data.account.email}" placeholder="Enter Email" type="email" name="email" class="form-control"
                            id="exampleInputEmail1" aria-describedby="emailHelp">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Password</label>
                        <input name="password" placeholder="Enter Password" type="password" class="form-control"
                            id="exampleInputPassword1">
                    </div>
                    <span style="display: block;margin: 0 0 20px;color: #f12186">${message}</span>
                    <button type="submit" class="btn btn-success btn-lg rounded btn-block">Sign in</button>
                </form:form>
                <p class="text-muted text-center small m-0 py-3">or</p>
                <a href="verification.html" class="btn btn-dark btn-block rounded btn-lg btn-apple">
                    <i class="icofont-brand-apple mr-2"></i> Sign up with Apple
                </a>
                <a href="verification.html"
                    class="btn btn-light border btn-block rounded btn-lg btn-google">
                    <i class="icofont-google-plus text-danger mr-2"></i> Sign up with Google
                </a>
                <p class="text-center mt-3 mb-0"><a href="/auth/register" class="text-dark">Don't have an
                        account? Sign up</a></p>
            </div>
        </div>
    </div>
</div>