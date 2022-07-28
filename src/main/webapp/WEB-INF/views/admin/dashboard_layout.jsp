<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">


<meta http-equiv="content-type" content="text/html;charset=utf-8" />

<jsp:include page="./blocks/head.jsp">
    <jsp:param name="title" value="${not empty content.title ? content.title : 'KShop Dashboard - Kodoku'}" />  
</jsp:include>

<body class="">
    <!-- Extra details for Live View on GitHub Pages -->
    <div class="wrapper ">
        <jsp:include page="./blocks/sidebar.jsp">
            <jsp:param name="data" value="${data}" />
        </jsp:include>

        <div class="main-panel">

            <jsp:include page="./blocks/navbar.jsp">
                <jsp:param 
                    name="heading_text" 
                    value="${not empty content.heading_text ? content.heading_text : 'Dashboard'}"
                />
            </jsp:include>

            <div class="content">
                
                <div class="container-fluid">

                    <jsp:include page="./${content.view}"/>

                </div>
            </div>
            <jsp:include page="./blocks/footer.jsp"/>
        </div>
    </div>
    <jsp:include page="./blocks/foot.jsp"/>
</body>

</html>