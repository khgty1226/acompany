<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/wow/wow.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>
<script src="lib/counterup/counterup.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600&family=Teko:wght@400;500;600&display=swap" rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/animate/animate.min.css" rel="stylesheet">
<link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
<link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- Template Stylesheet -->
<link href="css/style.css" rel="stylesheet">

<!-- Navbar Start -->            
<iframe src="chats/chatmain" id="alertModal" 
style ="doverflow-y: visible;
    position: fixed;
    bottom: 0;
    right: 0;
    background-color: transparent;
    padding: 10px;
    width: auto;
    height: 30vh;
    z-index: 15;"></iframe>

<nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top py-lg-0 px-lg-5 wow fadeIn row" data-wow-delay="0.1s">
    <a href="${pageContext.request.contextPath }/welcomeView" class="navbar-brand ms-4 ms-lg-0 col-3">
        <h1 class="text-primary m-0"><img class="me-3" src="img/Acompany.png" style="width:250px; height:64px;" alt="Icon"></h1>
    </a>
    <div class="collapse navbar-collapse col-6" id="navbarCollapse" style="justify-content: center;">
        <div class="navbar-nav p-4 p-lg-0">
            <a href="${pageContext.request.contextPath }/boardView" class="nav-item nav-link">Board</a>
            <c:choose>
            	<c:when test="${login.memName == '관리자'}">
		            <a href="${pageContext.request.contextPath }/carPoolAdminView" class="nav-item nav-link">CarPool</a>
            	</c:when>
            	<c:otherwise>
		            <a href="${pageContext.request.contextPath }/carPoolView" class="nav-item nav-link">CarPool</a>
            	</c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath }/mileageShopView" class="nav-item nav-link">MileageShop</a>
        </div>
		<div class="nav-item dropdown">
		    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">${sessionScope.login.memName }님</a>
		    <!-- 로그인 정보가 관리자일 경우 -->
		    <div class="dropdown-menu border-0 m-0">
		    	<c:if test="${sessionScope.login.roleCode eq 'AD' }">
		        <a href="<c:url value='/memberList?memNo=${sessionScope.login.memNo}'/>" class="dropdown-item">회원목록</a>
		        <a class="dropdown-item" onclick="showPopup()">마이페이지</a>
		        <a href="#" onclick="fn_logout()" class="dropdown-item">로그아웃</a>
		        </c:if>
		    <!-- 로그인 정보가 회원일 경우 -->
		    	<c:if test="${sessionScope.login.roleCode ne 'AD' }">
		        <%-- <a href="<c:url value='/memberView?memNo=${sessionScope.login.memNo}'/>" class="dropdown-item">마이페이지</a> --%>
		        <a class="dropdown-item" onclick="showPopup()">마이페이지</a>
		        <a href="<c:url value='/mileageShopCartView'/>" class="dropdown-item">장바구니</a>
		        <a href="<c:url value='/mileageShopOrderLogView'/>" class="dropdown-item">주문내역</a>
		        <a href="#" onclick="fn_logout()" class="dropdown-item">로그아웃</a>
		        </c:if>
		    </div>
		</div>
    </div>
    <div class="col-3">

    </div>
</nav>
<!-- Navbar End -->
<script type="text/javascript">
function fn_logout(){
	let ret = confirm("로그아웃하시겠습니까?");
	if(ret){
		location.href = "<c:url value='/logout'/>";
	}
}

function showPopup(){
	var popupX = (window.screen.width / 2) - (1250 / 2);
	// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

	var popupY= (window.screen.height / 2) - (1050 / 2);
	// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
	
	window.open("<c:url value='/memberView?memNo=${sessionScope.login.memNo}'/>","팝업 테스트","width=1250, height=1050, left="+ popupX + ", top="+ popupY);
}
</script>