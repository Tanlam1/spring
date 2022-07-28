<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div class="row">
    <div class="col-lg-5 col-md-6 col-sm-8 ml-auto mr-auto">
        <form:form method="post" action="/dashboard/login" modelAttribute="account">
            <div class="card card-login card-hidden">
                <div class="card-header card-header-rose text-center">
                    <h4 class="card-title">Login</h4>
                    <div class="social-line">
                        <a href="#pablo" class="btn btn-just-icon btn-link btn-white">
                            <i class="fa-brands fa-facebook"></i>
                        </a>
                        <a href="#pablo" class="btn btn-just-icon btn-link btn-white">
                            <i class="fa-brands fa-twitter"></i>
                        </a>
                        <a href="#pablo" class="btn btn-just-icon btn-link btn-white">
                            <i class="fa-brands fa-google"></i>
                        </a>
                    </div>
                </div>
                <div class="card-body ">
                    <p class="card-description text-center">Or Be Classical</p>
                    <span class="bmd-form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="material-icons">email</i>
                                </span>
                            </div>
                            <input value="${not empty param.username ? param.username : content.objs.u_rmbC}" name="username" type="text" class="form-control"
                                placeholder="Username...">
                        </div>
                        <form:errors style=" display:block;padding: 10px 20px 20px; " cssClass="category form-category" path="username" />
                    </span>
                    <span class="bmd-form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">
                                    <i class="material-icons">lock_outline</i>
                                </span>
                            </div>
                            <input value="${content.objs.p_rmbC}" name="password" type="password" class="form-control"
                                placeholder="Password...">
                        </div>
                        <form:errors style=" display:block;padding: 10px 20px 20px; " cssClass="category form-category" path="password" />
                    </span><br>
                    <c:if test="${not empty message}">
                        <span class="alert alert-primary" style="display: block; margin: 0 0px 20px 16px; font-weight: bold;padding: 10px;">
                            ${message}
                        </span>
                    </c:if>
                    <span style=" padding: 0 20px; " class="bmd-form-group form-check">
                        <label class="form-check-label">
                            <input name="rememberMe" class="form-check-input" type="checkbox" ${content.objs.cbox_rmbC}>
                            <span class="form-check-sign">
                                <span class="check"></span>
                            </span>
                            Remember me
                        </label>
                    </span>
                </div>
                <div class="card-footer justify-content-center">
                    <button class="btn btn-rose btn-link btn-lg">Login now</button>
                </div>
            </div>
        </form:form>
    </div>
</div>