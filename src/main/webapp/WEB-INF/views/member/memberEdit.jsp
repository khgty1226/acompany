<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/MyPage.css" rel="stylesheet">
<meta charset="UTF-8">
<title>마이페이지</title>

<style type="text/css">
/* 이미지 미리보기를 위한 CSS 스타일 */
.image-preview img {
width: 150px; /* 원하는 너비 크기로 조정 (예: 150px) */
height: 150px; /* 원하는 높이 크기로 조정 (예: 150px) */
border-radius: 50%; /* 둥근 모서리를 생성하여 원 모양으로 만듦 (원형 프로필 사진처럼) */
}
.profile_image {
  display: flex;
  flex-direction: column; /* 요소들을 수직으로 정렬 */
  justify-content: center;
  align-items: center;
  /* 기타 스타일 정의 */
}
.profile_image ul,
.profile_image input {
  margin: 10px; /* 각 요소들 사이의 간격을 설정하거나 필요한 여백을 추가하세요 */
}
.description p {
  text-align: center; /* <p> 태그 내용을 가운데로 정렬 */
  margin: 10px; /* 각 <p> 태그 사이의 간격을 설정하거나 필요한 여백을 추가하세요 */
}
input[type=date] {
    height: 18px;
    line-height: 20px;
    padding: 2px 4px;
    border: 1px solid #d5d5d5;
    color: #353535;
    font-size: 12px;
}
input[type="text"]{
  width: 200px;
}
.write-btn {
	width: 120px;
	height: 50px;
	margin-right: 10px;
	margin-top: 20px;
	border: solid 1px #0077b5;
	padding:5px 20px;
	color: #0077b5;
	border-radius: 5px;
	font-size:1.2rem;
	font-weight: 500;
	background-color: #FFF;
	margin-left: 10px;}
.write-btn:hover {border: solid 1px #0077b5; background-color: #0077b5; color: #FFF;}
.div_button {
            display: flex; /* Flexbox 사용 */
            justify-content: center; /* 수평 중앙 정렬 */
            align-items: center; /* 수직 정렬 (중앙 정렬을 위해 추가) */
        }
#modal_div1{
	width: 100%;
	height: 100%;
	position: fixed; 
	top: 0; right: 0; bottom: 0; left: 0;
	background-color: rgba(0,0,0,0.4);	
	z-index: 1;
	display: none;
}
#modal_div2{
	width: 400px;
	height: 200px;
	background-color: lightgrey;
	text-align: center;
	position: fixed;
	left: calc(50% - 200px);
	top: calc(50% - 200px);
}
.section-title {
    color: #0077b5;
    font-weight: 600;
    letter-spacing: 5px;
    text-transform: uppercase;
}
</style>
</head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function fn_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
           // var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
/*
            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }

            } 
*/            
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("memAdd").value = addr;
        }
    }).open();
}
</script>
<script type="text/javascript">
if("${login.memNo }" == null || "${login.memNo}" == '' || "${sessionScope.login.memNo}" != "${member.memNo}"){
	location.href = "${pageContext.request.contextPath }/startView?msg=none";
}

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
				let left = 45.7;
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
function fn_memberModify(){
	
	console.log("fn_memberModify");
	
	let memBirthday = $("#memBirthday").val();
	let mobile1 = $("#mobile1").val();
	let mobile2 = $("#mobile2").val();
	let mobile3 = $("#mobile3").val();
	let memAdd = $("#memAdd").val();
	let memEmail = $("#memEmail").val();
	
	console.log("memBirthday : ", memBirthday)
	console.log("mobile1 : ", mobile1)
	console.log("mobile2 : ", mobile2)
	console.log("mobile3 : ", mobile3)
	console.log("memAdd : ", memAdd)
	console.log("memEmail : ", memEmail)
	
	if(memBirthday == ""){
		alert("생일이 입력되지 않았습니다.");
		memBirthday.next("label").addClass("warning");
		return;
	}
	
	if(mobile2 == ""){
		alert("전화번호 앞자리가 입력되지 않았습니다.");
		memPhone.next("label").addClass("warning");
		return;
	}
	
	if(mobile3 == ""){
		alert("전화번호 뒷자리가 입력되지 않았습니다.");
		memPhone.next("label").addClass("warning");
		return;
	}
	
	if(memAdd == ""){
		alert("주소가 입력되지 않았습니다.");
		memAdd.next("label").addClass("warning");
		return;
	}
	if(memEmail == ""){
		alert("이메일이 입력되지 않았습니다.");
		memEmail.next("label").addClass("warning");
		return;
	}
	
	let checkMemPhone = /^\d{4}$/; // 4자리 숫자만 허용
	if(! checkMemPhone.test(mobile2)){
		alert("전화번호 앞자리는 4자리 숫자로 입력해주세요");
		return;
	}
	if(! checkMemPhone.test(mobile3)){
		alert("전화번호 뒷자리는 4자리 숫자로 입력해주세요");
		return;
	}
	
	let memEmailVal = $("#memEmail").val();
	let memNoVal = $('.memNoVal').text().trim();
	let emailCheck = false;
	
	console.log(memEmailVal, memNoVal);
	
	$.ajax({
		 url:"<c:url  value='/memberEdit/emailCheck' />"
		,type:"post"
		,data:{"memEmail" : memEmailVal, "memNo" : memNoVal}
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
	
	let ret = confirm("마이페이지를 수정하시겠습니까?");
	if(!ret){
		return;
	}
	
	$("form[name='memberModifyForm']").submit(); 
}

function fn_back(){
	let ret = confirm("수정을 취소하시겠습니까? 확인을 누르시면 이전 페이지로 돌아갑니다.");
	if(ret){
		history.back();
	}
}
</script>
<script>
function getImageFiles(e) {
	const files = e.currentTarget.files;
	const imagePreview = document.querySelector('.image-preview');
	const file = files[0];
	const reader = new FileReader();
	reader.readAsDataURL(file);
	reader.onload =  function(e){
		const preview = createElement(e, file);
		console.log("preview : ", preview);
		
		let imageLiTag = document.querySelector('.image-preview > li');
		if(imageLiTag){
			imagePreview.removeChild(imagePreview.firstElementChild);
		}
		imagePreview.appendChild(preview);
	};
}

function createElement(e, file) {
	const li = document.createElement('li');
	const img = document.createElement('img');
	img.setAttribute('src', e.target.result);
	img.setAttribute('data-file', file.name);
	li.appendChild(img);
	return li;
}

$(function(){
	const realUpload = document.querySelector('.real-upload');
	const upload = document.querySelector('.upload');
	upload.addEventListener('click', function(e){
		realUpload.click();
	});
realUpload.addEventListener('change', getImageFiles);
});

</script>
<script type="text/javascript">
function fn_memberPassModify(){
	console.log("fn_memberModify");
	
	let memPassNew = $("#memPassNew").val();
	let memPassNew_check = $("#memPassNew_check").val();
	if(memPassNew == "" ||  memPassNew_check == ""){
		alert("신규 비밀번호 또는 신규비밀번호 확인이 입력되지 않았습니다.");
		return;
	}
	
	let checkString = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,25}$/;
	
	if(! checkString.test(memPassNew)){
		alert("비밀번호는 영문,숫자 조합 8자리 이상이여야 합니다. 다시 입력해주세요.");
		$("#memPassNew").val("");
		$("#memPassNew").next("label").addClass("warning");
		$("#memPassNew_check").val("");
		$("#memPassNew_check").next("label").addClass("warning");
		return;
	}
	
	if(memPassNew != memPassNew_check){
		alert("신규 비밀번호와 신규 비밀번호 확인 값이 일치 하지 않습니다. 다시 입력 해주세요.");
		$("#memPassNew").val("");
		$("#memPassNew_check").val("");
		return;
	}
	
	let memNo = $('.memNoPassVal').text().trim();
	let memPass = $("#memPass").val();
	let passCheck = false;
	
	console.log("memPass : ", memPass);
	console.log("memNo : ", memNo);
	
	$.ajax({
		 url:"<c:url  value='/memberEdit/passCheck' />"
		,type:"post"
		,data:{"memNo" : memNo, "memPass" : memPass}
		,async:false
		,success:function(data){
			//alert("data: " + data);
			if(data){
				passCheck = true;
			}else{
				$("#memPass").val("");
				alert("기존 비밀번호가 일치하지 않습니다.");
			}
		}
		,error:function(){
			alert("error");
		}
	});
	
	if(!passCheck){
		return;
	}
	
	let ret = confirm("비밀번호를 변경하시겠습니까?");
	if(!ret){
		return;
	}
	
	$("form[name='memberModifyPassForm']").submit(); 
}

function fn_cancel(){
	let ret = confirm("수정을 취소하시겠습니까? 확인을 누르시면 이전 페이지로 돌아갑니다.");
	if(ret){
		history.back();
	}
}
</script>
<script type="text/javascript">
function fn_memberEditPass(){
	console.log("fn_memberEditPass");
	$("#modal_div1").fadeIn();
}

function fn_cancel(){
	$("#modal_div1").fadeOut();
}
</script>
<div style="height: 42px"></div>
<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
	<h4 class="section-title">My Page</h4>
	<h1 class="display-5 mb-4">마이페이지</h1>
</div>
<form:form name="memberModifyForm" action="${pageContext.request.contextPath }/memberModify" method="post" modelAttribute="member" enctype="multipart/form-data">
	<input type="hidden" name="memNo" value="${member.memNo }">
	<div class="profile_image">
		<div class="upload">
			<!-- 사진이 보여줄 위치 -->
		</div>
		<ul class="image-preview">
			<c:if test="${not empty member.atchNo }">
				<li>
					<img alt="프로필사진" src="<c:url value='/image/${member.atchNo } '/>">
				</li>
			</c:if>
			<c:if test="${empty member.atchNo }">
				<li>
					<!-- 이미지 미리보기를 위해 image-preview 클래스를 추가합니다 -->
					<img class="img-fluid image-preview" src="${pageContext.request.contextPath}/resources/img/base_img.png" alt="기본프로필" />
				</li>
			</c:if>
		</ul>
		<input type="file" class="real-upload" name="profilePhoto" accept="image/*" required multiple>
	</div>
	<div class="parent">
		<div id="contents">
			<div class="contents" style="width: 950px;">
				<div class="xans-element- xans-myshop xans-myshop-asyncbenefit">
					<div class="ec-base-box typeMember gMessage ">
						<div class="information">
								<div class="description">
									<p>저희 ACompany를 이용해 주셔서 감사합니다. <strong class="txtEm">${member.memName }</strong>님의 직급은 
									<strong>[ <c:forEach items="${roleInfoList }" var="roleInfo">
													<c:if test="${roleInfo.roleCode eq member.roleCode}">
													${roleInfo.roleName}
													</c:if>
												</c:forEach> ]</strong> 입니다.</p>
									<p>보유하신 <strong class="txtEm">마일리지</strong>는 총 <strong class="txtEm">${member.memMileage }</strong>원입니다.</p>
									<input type="hidden" name="role" value="${member.roleCode }">
								</div>
							</div>
						</div>
					</div>
				<div class="ec-base-table typeWrite">
					<table border="1" summary="">
						<caption>회원 기본정보</caption>
						<colgroup>
							<col style="width: 150px;">
							<col style="width: auto;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">사원번호 </th>
								<td class="memNoVal">
								${member.memNo }
								</td>
							</tr>
							<tr style="display: 1">
								<th scope="row" id="">이름 </th>
								<td>
								${member.memName } (${member.memGender })
								</td>
							</tr>
							<tr style="display: 1">
								<th scope="row" id="">부서/팀 </th>
								<td>
								<c:forEach items="${deptList }" var="deptCode">
									<c:if test="${deptCode.commCd eq member.memDept}">
									${deptCode.commNm}
									</c:if>
								</c:forEach>
								 / 
								<c:forEach items="${teamList }" var="teamCode">
									<c:if test="${teamCode.commCd eq member.memTeam}">
									${teamCode.commNm}
									</c:if>
								</c:forEach>
								</td>
							</tr>
							<tr style="display: 1">
								<th scope="row" id="">생일 <img
									src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif"
									alt="필수"></th>
								<td>
									<input id="memBirthday" name="memBirthday" 
									value="${fn:substring(member.memBirthday, 0, 10) }" type="date">
								</td>
							</tr>
							<tr class="displaynone">
								<th scope="row"></th>
								<td></td>
							</tr>
							<c:set var="memPhone" value="${member.memPhone}" />
							<c:set var="extractedMemPhone1" value="${memPhone.substring(0, 3)}" />
							<c:set var="extractedMemPhone2" value="${memPhone.substring(3, 7)}" />
							<c:set var="extractedMemPhone3" value="${memPhone.substring(7, 11)}" />
							<tr>
								<th scope="row">휴대전화 <img
									src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif"
									class="" alt="필수"></th>
								<td>
								<select id="mobile1" name="memPhone1" style="width: 50px; margin: 0 4px;">
									<option value="010" ${extractedMemPhone1 == '010' ? 'selected' : ''}>010</option>
									<option value="011" ${extractedMemPhone1 == '011' ? 'selected' : ''}>011</option>
									<option value="016" ${extractedMemPhone1 == '016' ? 'selected' : ''}>016</option>
									<option value="017" ${extractedMemPhone1 == '017' ? 'selected' : ''}>017</option>
									<option value="018" ${extractedMemPhone1 == '018' ? 'selected' : ''}>018</option>
									<option value="019" ${extractedMemPhone1 == '019' ? 'selected' : ''}>019</option>
								</select>-<input id="mobile2" name="memPhone2" style="width: 50px; margin: 0 4px;" maxlength="4" 
									placeholder="" value="${extractedMemPhone2 }" type="text">-<input
									id="mobile3" name="memPhone3" style="width: 50px; margin: 0 4px;" maxlength="4"
									placeholder="" value="${extractedMemPhone3 }" type="text">
								</td>
								<td>
									<%-- <input id="memPhone" name="memPhone" class="inputTypeText" value="${extractedMemPhone1 }" type="text">
									<input id="memPhone" name="memPhone" class="inputTypeText" value="${extractedMemPhone2 }" type="text">
									<input id="memPhone" name="memPhone" class="inputTypeText" value="${extractedMemPhone3 }" type="text"> --%>
								</td>
							</tr>
							<tr class="displaynone" id="confirm_verify_mobile">
								<th scope="row">인증번호 <img
									src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif"
									alt="필수"></th>
							</tr>
							<tr>
								<th scope="row">주소 <img
									src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif"
									class="" alt="필수"></th>
								<td>
									<input id="memAdd" name="memAdd"
									class="inputTypeText" placeholder=""
									value="${member.memAdd }" type="text" readonly="readonly">
									<a href="#none"
									class="btnNormal"
									onclick="fn_execDaumPostcode()" id="postBtn">우편번호</a>
									<br>
								</td>
							</tr>
							<tr>
								<th scope="row">이메일 <img
									src="//img.echosting.cafe24.com/skin/base/common/ico_required_blue.gif"
									alt="필수"></th>
								<td>
									<input id="memEmail" name="memEmail"
									placeholder="" value="${member.memEmail }" type="text">
									<button type="button" id="mailAuth" class="btnNormal displaynone">인증번호받기</button>
									<ul class="txtInfo gBlank5 displaynone" id="result_send_verify_mobile_success">
										<li>인증번호를 받지 못하셨다면 이메일을 확인해 주세요.</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th scope="row">이메일 수신여부 </th>
								<td><input id="is_news_mail0" name="is_news_mail" value="T"
									type="radio"><label for="is_news_mail0">수신함</label> <input
									id="is_news_mail1" name="is_news_mail" value="F" type="radio"
									checked="checked"><label for="is_news_mail1">수신안함</label>
									<ul class="txtInfo gBlank5 displaynone" id="result_send_verify_mobile_success">
										<li>ACompany에서 제공하는 유익한 이벤트 소식을 이메일로 받으실 수 있습니다.</li>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
						<div class="div_button">
							<input type="button" class="write-btn" onclick="fn_memberModify()" value="저장">
							<input type="button" class="write-btn" style="width: 180px" onclick="fn_memberEditPass()" value="비밀번호 변경">
							<input type="button" class="write-btn" onclick="fn_back()" value="취소">
						</div>
					</div>
				</div>
			</div>
		</div>
	</form:form>
	
	<div id="modal_div1">
		<div id="modal_div2">
			<div style="height: 40px"></div>
			<form:form name="memberModifyPassForm" action="${pageContext.request.contextPath }/memberModifyPass" method="post" modelAttribute="member" enctype="multipart/form-data">
			<input type="hidden" name="memNo" value="${member.memNo }">
				<table border="1">
					<caption>회원 기본정보</caption>
					<colgroup>
						<col style="width: 150px;">
						<col style="width: auto;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row" style="height: 24px;">사원번호 </th>
							<td class="memNoPassVal">
							${member.memNo }
							</td>
						</tr>
						<tr>
							<th scope="row" style="height: 24px;">기존 비밀번호</th>
							<td>
								<form:password path="memPass"/>
								<form:errors path="memPass"/>
							</td>
						</tr>
						<tr>
							<th scope="row" style="height: 24px;">신규 비밀번호</th>
							<td>
								<form:password path="memPassNew"/>
								<form:errors path="memPassNew"/>
							</td>
						</tr>
						<tr>
							<th scope="row" style="height: 24px;">신규 비밀번호 확인</th>
							<td>
								<input type="password" id="memPassNew_check" pattern="\w{4,}" value="" title="알파벳과 숫자로 4글자 이상 입력" >
							</td>
						</tr>
					</tbody>
				</table>
				<div class="div_button" style="padding-top: 20px;">
					<input type="button" onclick="fn_memberPassModify()" value="저장">
					<input type="button" onclick="fn_cancel()" value="취소">
				</div>
			</form:form>
		</div>
	</div>
</html>
