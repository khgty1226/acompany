<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>MEMBER ROLE</title>

<%@include file="/WEB-INF/include/top.jsp" %>

<style>
.searchBtn {
	border: none;
	width: 61px;
	font-weight: 500;
	color: #FFF;
	background: #0077b5;
}
.centered-div {
    display: flex;
    justify-content: center;
    align-items: center;
}
.div_button {
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 50px;
}
.td_right {
    padding-left: 20px;
}
</style>
</head>
<body id="page-top">

<script type="text/javascript">
if("${login.memNo }" == null || "${login.memNo}" == '' || "${sessionScope.login.roleCode}" != "AD"){
	location.href = "${pageContext.request.contextPath }/startView?msg=none";
}

$(document).ready(function() {
    // 페이지가 로드될 때 실행될 함수를 정의합니다
    function checkRoleCheckbox() {
        const selectedRole = $("input[name='role']").val();
        $("input[type='radio'][name='userRole']").each(function() {
            if ($(this).val() === selectedRole) {
                $(this).prop("checked", true);
            } else {
                $(this).prop("checked", false);
            }
        });
    }
    // 페이지가 로드될 때 함수를 호출하여 기존에 선택된 role에 맞게 체크박스를 설정합니다
    checkRoleCheckbox();
});

function fn_submit(){
	let result = confirm("권한을 수정하시겠습니까?");
	if(result){
		let f= $("form[name='memberRoleForm']");
		f.submit();
	}
}
</script>
<!-- Spinner Start -->
<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-border position-relative text-primary" style="width: 6rem; height: 6rem;" role="status"></div>
    <img class="position-absolute top-50 start-50 translate-middle" src="img/icons/icon-1.png" alt="Icon">
</div>
<!-- Spinner End -->

<!-- Page Header Start -->
<div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
    <div class="container py-5">
        <h1 class="display-1 text-white animated slideInDown">MEMBER ROLE</h1>
        <nav aria-label="breadcrumb animated slideInDown">
            <ol class="breadcrumb text-uppercase mb-0">
                <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
                <li class="breadcrumb-item text-primary active" aria-current="page">MEMBER ROLE</li>
            </ol>
        </nav>
    </div>
</div>
<!-- Page Header End -->

<!-- Team Start -->
<div class="container-xxl">
	<div class="container" style="">
		<div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
		    <h4 class="section-title">MEMBER ROLE</h4>
		    <h1 class="display-5 mb-4">직급</h1>
		</div>
	</div>
</div>
<!-- Team End -->

     <!-- 전체 영역잡기 -->
     <div class="contents">
         <!-- 사용할 영역잡기 -->
         <div class="content01">
             <!-- 회원 정보 테이블 -->
             <div id="div_table">
           			<form name="memberRoleForm" action="<c:url value="/memberRoleUpdate" />" method="post">
             				<input type="hidden" name="memNo" value="${member.memNo }">
             				<div class="centered-div">
		             			<table>
									<tbody>
										<tr>
											<td class="td_left">아이디</td>
											<td class="td_right">${member.memNo }</td>
										</tr>
										<tr>
											<td class="td_left">이름</td>
											<td class="td_right">${member.memName }</td>
										</tr>
								 		<tr>
											<td class="td_left">권한</td>
											<td class="td_right">
												<c:forEach items="${roleInfoList }" var="roleInfo">
													<label for="${roleInfo.roleCode }">${roleInfo.roleName }</label>
													<input type="radio" id="${roleInfo.roleCode }" name="userRole" value="${roleInfo.roleCode }">
													&nbsp;
												</c:forEach>
												<input type="hidden" name="role" value="${member.roleCode }">
											</td>
										</tr>
									</tbody>
								</table>
             				</div>
							<div class="div_button">
			                     <input type="button" class="write-btn" onclick="window.location.href='<c:url  value='/memberList' />'" value="목록">
			                     <input type="button" class="write-btn" onclick="fn_submit()" value="수정">
			                </div>
		                </form>
             </div>
         </div>
     </div>

<%@include file="/WEB-INF/include/foot.jsp" %>
</body>
</html>
