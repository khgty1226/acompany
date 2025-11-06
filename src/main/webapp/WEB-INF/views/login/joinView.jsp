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
<title>회원가입</title>
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
/* padding: 20px; */
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
/* a {
text-decoration: none;
color: #9B9B9B;
font-size: 14px;
} */
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
.email-input-container {
  position: relative;
  display: inline-block;
}
#mailAuth {
  position: absolute;
  right: 7px;
  top: 7px;
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
<style>
/* 이미지 미리보기를 위한 CSS 스타일 */
.image-preview img {
width: 150px; /* 원하는 너비 크기로 조정 (예: 150px) */
height: 150px; /* 원하는 높이 크기로 조정 (예: 150px) */
border-radius: 50%; /* 둥근 모서리를 생성하여 원 모양으로 만듦 (원형 프로필 사진처럼) */
}
/* ul 태그의 스타일을 변경하여 기호 없애기 */
ul.image-preview {
list-style-type: none; /* 기호 없애기 */
padding-left: 0; /* 왼쪽 패딩 제거 */
}
</style>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function(){
	$("#memNo").click(function(){
		$(this).next().removeClass("warning");
	});
	$("#memEmail").click(function(){
		$(this).next().removeClass("warning");
	});
	$("#memPass").click(function(){
		$(this).next().removeClass("warning");
	});
	$("#memPassCheck").click(function(){
		$(this).next().removeClass("warning");
	});
	
	$("#mailAuth").on("click", function(){
		
		//사용자가 입력한 메일 정보를 받아서 검증하고 서버단에 메일주소를 보내주기
		let memEmail = $("#memEmail");
		console.log("memEmail: ", memEmail.val());
		
		let checkMemEmail = /^[-_a-zA-z0-9]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,4}$/i;
		console.log("checkMemEmail: ", checkMemEmail.test(memEmail.val()) );
		if( ! checkMemEmail.test(memEmail.val()) ){
			alert("이메일 양식이 틀립니다. 다시 입력해주세요.");
			memEmail.val("");
			memEmail.next("label").addClass("warning");
			   return;
		}
		
		$.ajax({
			url:"<c:url value='/joinView/mailAuth' />"
			,type:"post"
			,data:{"mail" : memEmail.val()}
			,success:function(data){
				//alert("success");
				console.log("data :", data);
				
				let popupWidth = 600;
				let popupHeight = 150;
				let winWidth = document.body.offsetWidth;
				let winHeight = document.body.offsetHeight;
				let popupX = (winWidth/2) - (popupWidth/2);
				let popupY = (winHeight/2) - (popupHeight/2);
				
				if(data){
					let myWin = window.open("<c:url value='/joinView/mailWindow'/>"
						,"mywin"
						,"left="+popupX+"px,"
						+"top="+popupY+"px, "
						+"width="+popupWidth+"px, "
						+"height="+popupHeight+"px");
				}else{
					alert("메일 발송 처리도중 문제가 발생하였습니다. 전산실에 문의 부탁드립니다.042-719-8850");
				}
				
			}
			,error:function(){
				alert("error");
			}
			//메일 인증 버튼을 누르면 gif 출력시키
			,beforeSend:function(){
				let width = 150;
				let height = 150;
				let top = 40;
				let left = 46.3;
				$('body').append('<div id="div_ajax_load_image" style="position:absolute; top:'
					+ top + '%; left:'
					+ left + '%; width:'
					+ width + 'px; height:'
					+ height + 'px; z-index:9999;'
					+'background:transparent; '
					+'filter:alpha(opacity=50); '
					+'opacity:alpha*0.5; '
					+'margin:auto; '
					+'padding:0; ">'
					+'<img src="<c:url value ='/images/ajax_loader6.gif'/>"'
					+'style="width:150px; height:150px;"></div>');
			}
			,complete:function(){
				$("#div_ajax_load_image").remove();
			}
		});
	});
});
function join(){
	
	//값 유무 검증
	let memNo = $("#memNo");
	let memEmail = $("#memEmail");
	let memPass = $("#memPass");
	let memPassCheck = $("#memPassCheck");
	
	if(memNo.val() == ""){
		alert("사원번호를 입력해주세요.");
		memNo.next("label").addClass("warning");
		return;
	}else if(memEmail.val() == ""){
		alert("이메일을 입력해주세요.");
		memEmail.next("label").addClass("warning");
		return;
	}else if(memPass.val() == ""){
		alert("패스워드 입력해주세요.");
		memPass.next("label").addClass("warning");
		return;
	}else if(memPassCheck.val() == ""){
		alert("패스워드 확인을 입력해주세요");
		memPassCheck.next("label").addClass("warning");
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
	
	if(! checkId.test(memNo.val())){
		alert("사원번호 형식이 틀립니다. 다시 입력해주세요.");
		memNo.val("");
		memNo.next("label").addClass("warning");
		return;
	}
	
	let checkString = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
	
	if(! checkString.test(memPass.val())){
		alert("비밀번호는 영문,숫자 조합 8자리 이상이여야 합니다. 다시 입력해주세요.");
		memPass.val("");
		memPass.next("label").addClass("warning");
		memPassCheck.val("");
		memPassCheck.next("label").addClass("warning");
		return;
	}
	
	// 패스워드 와 재확인 패스워드 비교 검증
	if(memPass.val() != memPassCheck.val()){
		alert("재확인 패스워드가 일치하지 않습니다. 다시 입력해주세요.");
		memPassCheck.val("");
		memPassCheck.next("label").addClass("warning");
		return;
	}
	
	let memNoVal = $("#memNo").val();
	let idCheck = false;
	
	$.ajax({
		 url:"<c:url  value='/joinView/idCheck' />"
		,type:"post"
		,data:{"memNo" : memNoVal}
		,async:false
		,success:function(data){
			//alert("data: " + data);
			if(data){
				idCheck = true;
			}else{
				$("#memNo").val("");
				alert("없는 사원번호 또는 이미 사용중인 사원번호입니다.");
			}
		}
		,error:function(){
			alert("error");
		}
	});
	
	if(!idCheck){
		return;
	}
	
	let memEmailVal = $("#memEmail").val();
	let emailCheck = false;
	
	$.ajax({
		 url:"<c:url  value='/joinView/emailCheck' />"
		,type:"post"
		,data:{"memEmail" : memEmailVal}
		,async:false
		,success:function(data){
			//alert("data: " + data);
			if(data){
				emailCheck = true;
			}else{
				$("#memEmail").val("");
				alert("이미 사용중인 이메일입니다.");
			}
		}
		,error:function(){
			alert("error");
		}
	});
	
	if(!emailCheck){
		return;
	}
	
	let mailAuthCheck = false;
	
	$.ajax({
		 url:"<c:url  value='/joinView/checkMailAuth' />"
		,type:"post"
		,data:{"memEmail" : memEmailVal}
		,async:false
		,success:function(data){
			//alert("data: " + data);
			if(data){
				mailAuthCheck = true;
			}else{
				alert("이메일 인증을 해주세요.");
			}
		}
		,error:function(){
			alert("error");
		}
	});
	
	if(!mailAuthCheck){
		return;
	}
	
	let f =  document.contactForm;
	console.log("f : ", f);
	
	//console.log("memNo: ", $("input[name='memNo']").val() );
	//console.log("memEmail: ", $("input[name='memEmail']").val() );
	//console.log("memPass: ", $("input[name='memPass']").val() );
	
	f.submit();
}

document.addEventListener("DOMContentLoaded", function() {
    var joinButton = document.getElementById("btn");

    // 엔터 키의 키 코드는 13입니다.
    document.addEventListener("keydown", function(event) {
        if (event.keyCode === 13) {
            joinButton.click(); // 가입하기 버튼의 클릭 이벤트를 호출
        }
    });
});
</script>
</head>
<body>
<div class="centered-content">
	<div style="margin-bottom: 20px;">
		<h2 class="page-section-heading text-center text-uppercase text-primary mb-0 title">JOIN</h2>
	</div>
	<!-- <div style="margin-bottom: 12px;">
		<img class="img-fluid rounded-circle mb-4" src="https://dummyimage.com/150x150/6c757d/dee2e6.jpg" alt="..." />
	</div> -->
	<!-- 키 값을 name으로 지정(메소드의 파라미터 값과 이름이 같아야 함) -->
	<form id="contactForm" name="contactForm" 
		action="<c:url value="/joinDo" />" 
		method="POST" 
		enctype="multipart/form-data"> <!-- MemberController 메소드 => "/joinDo" -->
		<div class="profile_image">
			<div class="upload">
				<!-- 사진이 보여줄 위치 -->
			</div>
			<ul class="image-preview">
				<li>
					<!-- 이미지 미리보기를 위해 image-preview 클래스를 추가합니다 -->
					<img class="img-fluid image-preview" src="${pageContext.request.contextPath}/resources/img/base_img.png" alt="기본프로필" />
				</li>
			</ul>
			<input type="file" class="real-upload" name="profilePhoto" accept="image/*" style="margin-bottom: 23px; margin-left: 33px;">
		</div>
		<!-- 쿠키에 rememberId 키값이 존재하면 input 태그 value에 해당 아이디 적어주기 -->
		<input id="memNo" name="memNo" type="text" placeholder="아이디(사원번호)"/>
		<label for="memNo"></label>
		<div class="email-input-container">
			<input id="memEmail" name="memEmail" type="email" placeholder="이메일"/>
			<label for="memEmail"></label>
			<button type="button" id="mailAuth">인증</button>
		</div>
		<div>
		<input id="memPass" name="memPass" type="password" placeholder="비밀번호" style="margin-bottom: 2.5px;"/> <!-- 로그인 메소드의 파라미터인 MemberVO 때문에 name값을 memPw로 바꿔줌 -->
		<label for="memPass"></label>
		<a style="font-size: 14px;">비밀번호 : 영문/숫자 조합 8자리 이상</a>
		</div>
		<input id="memPassCheck" name="memPassCheck" type="password" placeholder="비밀번호 확인" style="margin-top: 7px;"/> <!-- 로그인 메소드의 파라미터인 MemberVO 때문에 name값을 memPw로 바꿔줌 -->
		<label for="memPassCheck"></label>
		<!-- Submit Button -->
		<input type="button" id="btn" value="가입하기" onclick="join()"><br>
	</form>
</div>
<script>
function getImageFiles(e) {
	const files = e.currentTarget.files;
	const imagePreview = document.querySelector('.image-preview');
	const file = files[0];
	const reader = new FileReader();
	reader.onload =  function(e){
		const preview = createElement(e, file);
		let imageLiTag = document.querySelector('.image-preview > li');
		if(imageLiTag){
			imagePreview.removeChild(imagePreview.firstElementChild);
		}
		imagePreview.appendChild(preview);
	};
	reader.readAsDataURL(file);
}
function createElement(e, file) {
	const li = document.createElement('li');
	const img = document.createElement('img');
	img.setAttribute('src', e.target.result); //img.setAttribute('src', reader.result);
	img.setAttribute('data-file', file.name);
	li.appendChild(img);
	return li;
}
const realUpload = document.querySelector('.real-upload');
const upload = document.querySelector('.upload');
upload.addEventListener('click', function(e){
	realUpload.click();
});
realUpload.addEventListener('change', getImageFiles);
</script>
</body>
</html>