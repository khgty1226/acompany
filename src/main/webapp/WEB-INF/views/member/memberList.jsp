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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
#memMileage{
	width: 105px;
}
</style>
<script>
if("${login.memNo }" == null || "${login.memNo}" == '' || "${sessionScope.login.roleCode}" != "AD"){
	location.href = "${pageContext.request.contextPath }/startView?msg=none";
}

$(function(){
	let msg = $("#msg").val();
	if(msg == "success"){
		alert("직급이 수정되었습니다.");
		window.location.href = '<c:url value='/memberList?memNo=${sessionScope.login.memNo}'/>';
	}else if(msg == "fail"){
		alert("직급 수정을 실패하였습니다.");
		window.location.href = '<c:url value='/memberList?memNo=${sessionScope.login.memNo}'/>';
	}
	if(msg == "successDel"){
		alert("선택하신 회원이 삭제되었습니다.")
		window.location.href = '<c:url value='/memberList?memNo=${sessionScope.login.memNo}'/>';
	}else if(msg == "failDel"){
		alert("회원 삭제를 실패하였습니다.")
		window.location.href = '<c:url value='/memberList?memNo=${sessionScope.login.memNo}'/>';
	}
});
function updateAllRows() {
	let ret = confirm("회원목록을 수정하시겠습니까?");
	if(!ret){
		return;
	}
	
    var allRows = []; // 모든 행의 데이터를 담을 배열

    // 모든 행을 선택합니다.
    var rows = document.getElementsByClassName("boardTr");
    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        
        var memNo = row.querySelector('a').textContent; // 사원번호
        var memDept = row.querySelector('.id_memberDept').value; // 부서
        var memTeam = row.querySelector('.id_memberTeam').value; // 팀
        var memMileage = row.querySelector('#memMileage').value; // 마일리지
        
        console.log("memNo", memNo);
        console.log("memDept", memDept);
        console.log("memTeam", memTeam);
        console.log("memMileage", memMileage);
        
        // 모든 행의 데이터를 객체로 만들어 배열에 추가합니다.
        allRows.push({
            memNo: memNo,
            memDept: memDept,
            memTeam: memTeam,
            memMileage: memMileage
        });
        
        console.log("allRows", allRows);
    }

    // 모든 행 데이터를 JSON 형태로 만듭니다.
    var jsonData = JSON.stringify(allRows);
    
    console.log("jsonData", jsonData);

    // JSON 데이터를 컨트롤러로 보냅니다.
    sendDataToController(jsonData);
}

 
$( function () {
	console.log("sessionStorage.reloadAfterPageLoad:",sessionStorage.reloadAfterPageLoad);
    if ( sessionStorage.reloadAfterPageLoad != "fail" && sessionStorage.reloadAfterPageLoad != undefined) {
        setTimeout(() => {
	        alert("회원목록이 수정되었습니다.");
		}, 300);
        sessionStorage.reloadAfterPageLoad = "fail";
    }
});


function sendDataToController(jsonData) {
    // 여기에서 AJAX 또는 원하는 데이터 전송 방식을 사용하여 컨트롤러에 데이터를 전송합니다.
    // AJAX 예시:
    $.ajax({
        type: "POST",
        url: "<c:url  value='/memberListUpdate' />",
        data: {memberJson : jsonData},
        /* dataType: "json", */
        success: function(response) {
            // 성공 시 처리
          sessionStorage.reloadAfterPageLoad = "success";
            
          location.reload();
        },
        error: function(error) {
            // 오류 시 처리
           alert("회원목록 수정을 실패하였습니다.");
        }
    });
}
</script>
<title>MEMBERS</title>

<%@include file="/WEB-INF/include/top.jsp" %>

</head>
<input id="msg" type="hidden" value="${msg }">
<body id="page-top">

<%@include file="/WEB-INF/include/memberHead.jsp" %>

		<!-- 리스트 -->
		<form name="listForm" action="<c:url value="/memberListUpdate" />" method="post">
			<div class="row justify-content-center">
				<div class="col-xl-12">
					<table class="table">
						<thead>
							<tr class="mHeadTr">
								<th></th>
								<th><input type="checkbox" id="check_all"/></th>
								<th>순번</th>
								<th>사원번호</th>
								<th>이름</th>
								<th>전화번호</th>
								<th>입사날짜</th>
								<th>부서</th>
								<th>팀</th>
								<th>마일리지</th>
								<th style="width:70px;"></th>
							</tr>
						</thead>
						<tbody class="boardTbody">
							<c:forEach items="${memberList }" var="member">
								<tr class="boardTr">
									<td><input type="checkbox" name="check_list" value="${member.memNo }" /></td>
									<td>${member.rnum }</td>
									<%-- <td><a href="<c:url value='/memberRole?memNo=${member.memNo }'/>">${member.memNo }</a></td> --%>
									<td><a href="${pageContext.request.contextPath }/memberRole?memNo=${member.memNo }">${member.memNo }</a></td>
									<td>${member.memName }</td>
									<td>${member.memPhone }</td>
									<td>${member.memJoinDate}</td>
									<c:forEach items="${deptList }" var="dept">
										<c:if test="${dept.commCd eq member.memDept }">
											<td name="mem_dept_td">
												<select class="id_memberDept" name="memDept">
													<c:forEach items="${deptList }" var="deptCode">
														<option value="${deptCode.commCd }" ${deptCode.commNm eq dept.commNm ? "selected='selected'" : ""}>${deptCode.commNm }</option>
													</c:forEach>
												</select>
											</td>
										</c:if>
									</c:forEach>
									<c:forEach items="${teamList }" var="team">
										<c:if test="${team.commCd eq member.memTeam }">
											<td name="mem_team_td">
												<select class="id_memberTeam" name="memTeam">
													<c:forEach items="${teamList}" var="teamCode">
														<option class="memTeams" value="${teamCode.commCd}" ${teamCode.commNm eq team.commNm ? "selected='selected'" : ""} data-deptCode="${teamCode.commParent }">${teamCode.commNm}</option>
													</c:forEach>
												</select>
											</td>
										</c:if>
									</c:forEach>
									<td>
									<input id="memMileage" type="number" step="1000" value="${member.memMileage }">
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			<%@include file="/WEB-INF/include/paging.jsp" %>
				<div class="col-xl-12 d-flex justify-content-end">
					<input type="button" class="write-btn" onclick="updateAllRows()" value="수정">
					<input type="button" class="write-btn" onclick="fn_delete()" value="삭제">
				</div>
			</div>
		</form>
	</div>
</section>

<form name="memMultiDelete" action="${pageContext.request.contextPath }/memberMultiDelete" method="post">
	<input type="hidden" name="memMultiId" value="">
</form>

<%@include file="/WEB-INF/include/foot.jsp" %>
</body>
</html>
