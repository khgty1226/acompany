<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600&family=Teko:wght@400;500;600&display=swap" rel="stylesheet">
<!-- Icon Font Stylesheet -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
<!-- Libraries Stylesheet -->
<!-- <link href="lib/animate/animate.min.css" rel="stylesheet">
<link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
<link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" /> -->
<!-- Customized Bootstrap Stylesheet -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<!-- Template Stylesheet -->
<link href="css/style.css" rel="stylesheet">

<meta charset="UTF-8">
<title>로그인</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap');

* {
font-family: 'Noto Sans KR', sans-serif;
}

body {
background-color: #EEEFF1;
}

div {
margin: auto;
width: 300px;
background-color: #EEEFF1;
border-radius: 5px;
text-align: center;
}

input {
width: 100%;
padding: 10px;
box-sizing: border-box;
border-radius: 5px;
border: none;
}

.in {
margin-bottom: 10px;
}

#btn {
background-color: #0077b5;
margin-bottom: 30px;
color: white;
}

a {
text-decoration: none;
color: #9B9B9B;
font-size: 14px;
}

.img-fluid {
max-width: 100%;
height: auto;
}
    
.image-with-margin {
margin-bottom: 100px;
}

.menu{
display: flex;
justify-content: space-between;
align-items: center;
}
.title {
font-size: 90px; /* LOGIN 텍스트의 크기를 조정합니다 */
}
.centered-content {
transform: scale(1.1);
}
    
html, body {
height: 100%;
display: flex;
justify-content: center;
align-items: center;
padding-bottom: 20px;
}
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
input:-webkit-autofill:active {
transition: background-color 5000s ease-in-out 0s;
-webkit-transition: background-color 9999s ease-out;
-webkit-box-shadow: 0 0 0px 1000px white inset !important;
}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#memNo").click(function(){
		$(this).next().removeClass("warning");
	});
	$("#memPass").click(function(){
		$(this).next().removeClass("warning");
	});
});

function fn_login(){
	
	//값 유무 검증
	let memNo = $("#memNo");
	let memPass = $("#memPass");
	
	if(memNo.val() == ""){
		alert("사원번호를 입력해주세요.");
		memNo.next("label").addClass("warning");
		return;
	}else if(memPass.val()==""){
		alert("패스워드 입력해주세요.");
		memPass.next("label").addClass("warning");
		return;
	}
	
	//아이디, 이름, 패스워드 공백 검증
	let checkBlank =  /\s/;
	
	if(checkBlank.test(memNo.val())){
		alert("사원번호에 공백이 존재합니다. 다시 입력해주세요.");
		memNo.val("");
		memNo.next("label").addClass("warning");
		return;
	}else if(checkBlank.test(memPass.val())){
		alert("패스워드에 공백이 존재합니다. 다시 입력해주세요.");
		memPass.val("");
		memPass.next("label").addClass("warning");
		return;
	}
	
	// 아이디, 패스워드 글자수 및 영문 , 숫자, 한글제외 검증
	let checkId = /^\d{4}-\d{2}-\d{4}$/;
	let checkPass = /^\w{4,10}$/;
	
	if(! checkId.test(memNo.val()) && memNo.val() !== "admin"){
		alert("사원번호 형식이 틀립니다. 다시 입력해주세요.");
		memNo.val("");
		memNo.next("label").addClass("warning");
		return;
	}else if(! checkPass.test(memPass.val())){
		alert("패스워드는 최소 4글자 이상 10글자 이하(특수문자 제외) 이어야 합니다.");
		memPass.val("");
		memPassCheck.val("");
		memPass.next("label").addClass("warning");
		memPassCheck.next("label").addClass("warning");
		return;
	}
	
	let memNoVal = $("#memNo").val();
	
	$.ajax({
		 url:"<c:url  value='/loginView/delEmailCheck' />"
		,type:"post"
		,data:{"memNo" : memNoVal}
		,async:false
		,success:function(data){
			if(data){
				delEmailCheck = true;
			}else{
				$("#memNo").val("");
				$("#memPass").val("");
				alert("탈퇴한 사원번호입니다.");
			}
		}
		,error:function(){
			alert("error");
		}
	});
	
	if(!delEmailCheck){
		return;
	}
	
	let memPassVal = $("#memPass").val();
	let loginCheck = false;
	
	$.ajax({
		 url:"<c:url  value='/loginView/loginCheck' />"
		,type:"post"
		,data:{"memNo" : memNoVal, "memPass" : memPassVal}
		,async:false
		,success:function(data){
			if(data){
				loginCheck = true;
				//alert("true");
			}else{
				$("#memNo").val("");
				$("#memPass").val("");
				alert("아이디 또는 비밀번호가 틀립니다.");
			}
		}
		,error:function(){
			alert("error");
		}
	});
	
	if(!loginCheck){
		return;
	}
	
	let f = document.getElementById("contactForm");
	f.submit();
}

document.addEventListener("DOMContentLoaded", function() {
    var loginButton = document.getElementById("btn");

    // 엔터 키의 키 코드는 13입니다.
    document.addEventListener("keydown", function(event) {
        if (event.keyCode === 13) {
            loginButton.click(); // 로그인 버튼의 클릭 이벤트를 호출
        }
    });
});
$(function(){
	let msg = $("#msg").val();
	if(msg == "success"){
		alert("회원가입을 성공하였습니다.");
		window.location.href = '<c:url value='/loginView'/>';
	}else if(msg == "fail"){
		alert("회원가입을 실패하였습니다.");
	}else if(msg == "passchange"){
		alert("비밀번호를 변경하였습니다. 다시 로그인해주세요.");
		window.location.href = '<c:url value='/loginView'/>';
	}
});
</script>
</head>
<body>
<input id="msg" type="hidden" value="${msg }">
<div class="centered-content">
	<div style="margin-bottom: 20px;">
		<h2 class="page-section-heading text-center text-uppercase text-primary mb-0 title">LOGIN</h2>
	</div>
	<div>
		<form id="contactForm" action="<c:url value="/loginDo" />" method="POST"> <!-- MemberController 메소드 => "/loginDo" -->
			<!-- 키 값을 name으로 지정(메소드의 파라미터 값과 이름이 같아야 함) -->
			<!-- 쿠키에 rememberId 키값이 존재하면 input 태그 value에 해당 아이디 적어주기 -->
			<input id="memNo" name="memNo" type="text" value="${cookie.rememberId.value }" placeholder="아이디(사원번호)"/>
			<label for="memNo"></label>
			<input id="memPass" name="memPass" type="password" placeholder="비밀번호"/> <!-- 로그인 메소드의 파라미터인 MemberVO 때문에 name값을 memPw로 바꿔줌 -->
			<label for="memPass"></label>
			<!-- 로그인 이전 페이지 링크 기억용 -->
			<input name="fromUrl" value="${fromUrl }" type="hidden">
			<!-- 탈퇴 이메일 여부 확인용 -->
			<input name="emailDelYn" type="hidden">
			<!-- Submit Button -->
			<input type="button" id="btn" value="로그인" onclick="fn_login()"><br>
			<div class="menu">
				<a href="<c:url value="/joinView" />">회원가입</a>
				<a href="#none">비밀번호를 잊어버리셨나요?</a>
			</div>
			<div class="mb-3" style="text-align:left; margin-top: 20px;">
				<input class="form-check-input" id="rememberCheck" name="rememberId" type="checkbox" ${cookie.rememberId == null ? "" : "checked"} />
				<label class="form-check-label" for="rememberCheck" style="font-size: 13px;">&nbsp;아이디 기억하기</label>
			</div>
		</form>
	</div>
</div>
</body>
</html>