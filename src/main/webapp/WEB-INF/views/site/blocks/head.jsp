<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="data" value="${content}"></c:set>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${data.title}</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="/assets/site/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/site/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/site/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/assets/site/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/assets/site/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/site/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/site/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/assets/site/css/style.css" type="text/css">
</head>