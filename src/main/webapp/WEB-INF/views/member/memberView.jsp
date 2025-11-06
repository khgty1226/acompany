<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/MyPage.css" rel="stylesheet">
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
.section-title {
    color: #0077b5;
    font-weight: 600;
    letter-spacing: 5px;
    text-transform: uppercase;
}
</style>
</head>
<script type="text/javascript">
if("${login.memNo }" == null || "${login.memNo}" == '' || "${sessionScope.login.memNo}" != "${member.memNo}"){
	location.href = "${pageContext.request.contextPath }/startView?msg=none";
}

function fn_memberEdit(memNo){
	console.log("memNo : " + memNo);
	
	let hostIndex = location.href.indexOf(location.host) + location.host.length;
	let contextPath = location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
	
	console.log("hostIndex : ", hostIndex);
	console.log("contextPath : ", contextPath);
	
	//location.href = "${pageContext.request.contextPath}/member/memberEdit?memId="+memId;
	location.href = contextPath + "/memberEdit?memNo=" + memNo;
}

function fn_closeWindow(){
	window.close(); // 현재 창을 닫는 JavaScript 명령
}

$(function(){
	let msg = $("#msg").val();
	if(msg == "success"){
		alert("마이페이지가 수정되었습니다.");
		window.location.href = '<c:url value='/memberView?memNo=${sessionScope.login.memNo}'/>';
		
	}else if(msg == "fail"){
		alert("마이페이지 수정을 실패하였습니다.");
		window.location.href = '<c:url value='/memberView?memNo=${sessionScope.login.memNo}'/>';
	}
});
</script>
<input id="msg" type="hidden" value="${msg }">
<div style="height: 110px"></div>
<div class="text-center mx-auto wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
	<h4 class="section-title">My Page</h4>
	<h1 class="display-5 mb-4">마이페이지</h1>
</div>
<div class="profile_image">
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
</div>
<div class="parent">
	<div id="contents">
		<div class="contents" style="width: 800px;">
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
							<td>
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
							<th scope="row" id="">생일 </th>
							<td>
								${fn:substring(member.memBirthday, 0, 10) }
							</td>
						</tr>
							<c:set var="memPhone" value="${member.memPhone}" />
							<c:set var="extractedMemPhone1" value="${memPhone.substring(0, 3)}" />
							<c:set var="extractedMemPhone2" value="${memPhone.substring(3, 7)}" />
							<c:set var="extractedMemPhone3" value="${memPhone.substring(7, 11)}" />
						<tr>
							<th scope="row">휴대전화 </th>
							<td>
							${extractedMemPhone1 }-${extractedMemPhone2 }-${extractedMemPhone3 }
							</td>
						</tr>
						<tr class="displaynone" id="confirm_verify_mobile">
							<th scope="row">인증번호 </th>
						</tr>
						<tr class="">
							<th scope="row">주소 </th>
							<td>
								${member.memAdd }&nbsp;
							</td>
						</tr>
						<tr>
							<th scope="row">이메일 </th>
							<td>
								${member.memEmail }
							</td>
						</tr>
					</tbody>
				</table>
				<div class="div_button">
					<%-- <input type="button" class="write-btn" onclick="window.location.href='<c:url  value='/welcomeView' />'" value="HOME"> --%>
					<input type="button" class="write-btn" onclick="fn_memberEdit('${member.memNo }')" value="수정">
					<input type="button" class="write-btn" onclick="fn_closeWindow()" value="닫기">
				</div>
			</div>
		</div>
	</div>
</div>
</html>