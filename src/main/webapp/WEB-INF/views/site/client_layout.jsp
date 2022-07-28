<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="vi">
<jsp:include page="./blocks/head.jsp"></jsp:include>
<body>
    <jsp:include page="./blocks/load.jsp"></jsp:include>
    <!-- Humberger End -->

    <!-- Header Section Begin -->
    <jsp:include page="./blocks/header.jsp"></jsp:include>
    <!-- Header Section End -->

    <!-- Hero Section Begin -->
    <jsp:include page="./blocks/nav.jsp"></jsp:include>
    <!-- Hero Section End -->

    <jsp:include page="./${content.view}"></jsp:include>

    <!-- Footer Section Begin -->
    <jsp:include page="./blocks/footer.jsp"></jsp:include>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
    <jsp:include page="./blocks/foot.jsp"></jsp:include>



</body>

</html>