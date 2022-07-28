<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<!DOCTYPE html>
<html lang="vi">

    <jsp:include page="./blocks/head.jsp">
        <jsp:param name="title" value="${not empty content.title ? content.title : 'KShop online shop - Kodoku'}" />
    </jsp:include>


<body class="fixed-bottom-padding">

    <jsp:include page="./blocks/nav.jsp"></jsp:include>

    <section class="osahan-main-body osahan-signin-main">
        <div class="container">
            <jsp:include page="./${content.view}"/>
        </div>
    </section>
    
    <jsp:include page="./blocks/nav_mobile.jsp"></jsp:include>

    <jsp:include page="./blocks/foot.jsp"></jsp:include>
</body>


</html>