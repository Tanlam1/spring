<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">


<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<jsp:include page="./blocks/head.jsp">
    <jsp:param name="title" value="${not empty content.title ? content.title : 'Dashboard KShop - Kodoku'}" />
</jsp:include>


<body class="off-canvas-sidebar">
    <!-- Navbar -->
    <jsp:include page="./blocks/navbar.jsp">
        <jsp:param name="heading_text" value="${not empty content.heading_text ? content.heading_text : 'Dashboard'}" />
    </jsp:include>
    <!-- End Navbar -->
    <div class="wrapper wrapper-full-page">
        <div class="page-header login-page header-filter" filter-color="black"
            style="background-image: url('/assets/admin/img/login.jpg'); background-size: cover; background-position: top center;">
            <div class="container">
                
                <jsp:include page="./${content.view}" />

            </div>
            <jsp:include page="./blocks/footer.jsp" />
        </div>
    </div>
    <jsp:include page="./blocks/foot.jsp" />
</body>


</html>