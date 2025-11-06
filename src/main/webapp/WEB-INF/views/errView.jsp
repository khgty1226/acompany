<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>에러페이지</title>
        
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/favicon.ico" />
        
    </head>
    <body id="page-top">

        <!-- 모든 페이지 상단에 포함되는 부분 -->
        <%@ include file="/WEB-INF/include/top.jsp" %>

        <!-- Masthead-->
        <header class="masthead bg-primary text-white text-center">
            <div class="container d-flex align-items-center flex-column">
                <!-- Masthead Avatar Image-->
                <img class="masthead-avatar mb-5" src="assets/img/avataaars.svg" alt="..." />
                <!-- Masthead Heading-->
                <h1 class="masthead-heading text-uppercase mb-0">에러 페이지입니다.</h1>
                <!-- Icon Divider-->
                <div class="divider-custom divider-light">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Masthead Subheading-->
                <p class="masthead-subheading font-weight-light mb-0">${errMsg }</p>
            </div>
        </header>


        
        <!-- 모든 페이지 하단에 포함되는 부분 -->
        <%@ include file="/WEB-INF/include/foot.jsp" %>
        
    </body>
</html>
