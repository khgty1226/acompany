<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>Board</title>

<%@include file="/WEB-INF/include/top.jsp" %>
<style>
.searchBtn {
	border: none;
	width: 61px;
	font-weight: 500;
	color: #FFF;
	background: #0077b5;
}
</style>
</head>
<body id="page-top">

<script type="text/javascript">
if("${login.memNo }" == null || "${login.memNo}" == ''){
	location.href = "${pageContext.request.contextPath }/startView?msg=none";
}
</script>
<script>
$(document).ready(function() {
	$("#id_btn_search").on("click", function() {
        
		$("#searchForm").submit();

        $("input[name='searchWord']").val(""); // 검색어를 빈 문자열로 설정
    });
});
</script>

<script>
function fn_boardViewCode(boardCode){
	
	let bc = boardCode;
	let mn = $("input[name=memNo]").val();
	let st = $("select[name='searchType']").val();
	let sw = $("input[name='searchWord']").val();
	let sc = $("select[name='searchCategory']").val();
	
	console.log("mn=", mn);
	console.log("bc=", bc);
	
	let cp = $("input[name='curPage']").val();
	let rpp = $("input[name='rowSizePerPage']").val();
	console.log("st : ",st, ", sw: ", sw, ", sc:", sc, ", bc:", bc);
	location.href="${pageContext.request.contextPath}/myWriteList?boardCode="+bc+"&memNo="+mn+"&searchType="+st+"&searchWord="+sw+"&rowSizePerPage="+rpp;
	
}

$(function(){

	$('#id_rowSizePerPage').change(function() {
		sf.find("input[name='curPage']").val(1);
		sf.find("input[name='rowSizePerPage']").val($(this).val());
		sf.submit();
	});


	let sf =$("form[name='search']");
	let curPage= sf.find("input[name='curPage']");
	let rowSizePerPage = sf.find("input[name='rowSizePerPage']");
	$('ul.pagination li a').click(function(e) {
		e.preventDefault();

		console.log($(e.target).data("curpage"));  
		
		curPage.val($(e.target).data("curpage")); 
		rowSizePerPage.val($(this).data("rowsizeperpage")); 
		sf.submit();
	});


	sf.find("button[type=submit]").click(function(e) {
		e.preventDefault();
		curPage.val(1);
		rowSizePerPage.val(10);
		sf.submit();
	});

	
	$('#id_btn_reset').click(function() {
		sf.find("select[name='searchType'] option:eq(0)").attr("selected", "selected");	
		sf.find("select[name='searchCategory'] option:eq(0)").prop("selected", "selected");	
		sf.find("input[name='searchWord']").val("");
		sf.find("input[name='boardCode']").val();
		sf.find("input[name='curPage']").val(1);
		sf.find("input[name='rowSizePerPage']").val(10);
		location.href="${pageContext.request.contextPath}/myWriteList";
	});
	
	
	
});


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
        <h1 class="display-1 text-white animated slideInDown">BOARDS</h1>
        <nav aria-label="breadcrumb animated slideInDown">
            <ol class="breadcrumb text-uppercase mb-0">
                <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
                <li class="breadcrumb-item text-primary active" aria-current="page">BOARDS</li>
            </ol>
        </nav>
    </div>
</div>
<!-- Page Header End -->

<!-- Team Start -->
<div class="container-xxl">
	<div class="container" style="">
		<div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
		    <h4 class="section-title">BOARDS</h4>
		    <h1 class="display-5 mb-4">게시판을 활용하여 사원들과의 소통과 교류를 즐기세요.</h1>
		</div>
	</div>
</div>
<!-- Team End -->

<!-- 회원 게시판 폼 -->
<section class="page-section mt-5" id="contact" >

	<div class="container col-7">
		<!-- Contact Section Heading-->
		
		<!-- 게시판 상단 카테고리 버튼 -->
 		<div class="sub_btn wow fadeInUp" data-wow-delay="0.1s">
			<c:forEach items="${boardInfoList}" var="boardInfo">
				<a href="#" class="boardLink${param.boardCode eq boardInfo.boardCode ? ' selected' : ''}"
				onclick="fn_boardViewCode('${boardInfo.boardCode}')">${boardInfo.boardCategoryName}
				<input type="hidden" name="boardCode" value="${boardInfo.boardCode }">
				<input type="hidden" name="memNo" value="${login.memNo }"></a>
			</c:forEach>
		</div>
	
		<!-- 카테고리별 검색 창 -->
		<div class="div_search">
			<div class="div_div_search row">
			
				<div class="rowSizePerPage_1 col-2">
				</div>
				
				<div class="rowSizePerPage col-8" style="display: flex; justify-content: center;">
					<form name="search" id="searchForm">
						<input type="hidden" name="curPage" value="${searchVO.curPage}"> 
						<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage}">
						<input type="hidden" name="boardCode" value="${searchVO.boardCode }">
						<div class="searchForm">
							<label for="id_searchType">검색</label>
							&nbsp;&nbsp;
							<select id="id_searchType" name="searchType">
								<!-- <option value="">-- 전체 --</option> -->
								<option value="T" ${searchVO.searchType eq "T" ? "selected='selected'" : ""} >제목</option>
								<option value="W" ${searchVO.searchType eq "W" ? "selected='selected'" : ""} >작성자</option>
								<option value="C" ${searchVO.searchType eq "C" ? "selected='selected'" : ""} >내용</option>
							</select>
							<input type="text" name="searchWord" style="border:solid 1px;" value="${searchVO.searchWord }" placeholder="검색어">
							&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button class="searchBtn" type="submit">검 색</button>
							<button class="searchBtn" type="button" id="id_btn_reset">초기화</button>
						</div>
					</form>
				</div>
				
				<div class="rowSizePerPage_1 col-2" style="display: flex; justify-content: end;">
					<div style="height:35px; font-size:16px;">
						전체 ${searchVO.totalRowCount } 건 조회
						<select id="id_rowSizePerPage" name="rowSizePerPage">
							<c:forEach begin="10" end="50" step="10" var="i">
								<option value="${i }" ${searchVO.rowSizePerPage eq i ? "selected='selected'" : "" }>${i }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
		</div>

		<!-- Contact Section Form-->
		<div class="div_table">
			<div class="col-xl-12">
				<table class="table">
					<thead>
						<tr class="tHeadTr">
							<th style="width:0;"></th>
							<!-- <th>No.</th> -->
							<th>Date.</th>
							<th class="col-5">Title.</th>
							<th>Category.</th>
							<th>Writer.</th>
							<th>Hit.</th>
							<th>Like.</th>
							<th style="width:70px;"></th>
						</tr>
					</thead>
					
					<tbody class="boardTbody">
					<c:forEach items="${myWriteList }" var="myWriteList">
						<tr class="boardTr">
							<%-- <td>${categoryList.boardNo }</td> --%>
							<td>
								<p class="year">${fn:substringBefore(myWriteList.boardDate, '.')}</p> <!-- "2023" 출력 -->
							    <p class="md" style="margin-bottom:0px;">${fn:substringAfter(myWriteList.boardDate, '.')}</p>  <!-- "07/21" 출력 -->
							</td>
							<td><a href="${pageContext.request.contextPath }/boardDetailView?boardNo=${myWriteList.boardNo }">${myWriteList.boardTitle }</a></td>
							<td>${myWriteList.boardCategory }</td>
							<%-- <td>${board.boardTitle }</td> --%>
							<td>${myWriteList.memNo }</td>
							<td>${myWriteList.boardHit }</td>
							<td>${myWriteList.boardLike }</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="d-flex justify-content-end" style="padding: 0px 22px;">
				<a href="<c:url value='/myWriteList'/>">
					<button class="likeBtn" style="margin-left: 12px; color:#777;">
					<i class="fa-solid fa-gear" style="margin-right: 5px;"></i>내가 쓴 게시글
					</button>
				</a>
				<a href="<c:url value='/mySaveList'/>">
					<button class="likeBtn" style="margin-left: 12px; color:#777;">
					<i class="fa-solid fa-gear" style="margin-right: 5px;"></i>저장 한 게시글
					</button>
				</a>
			</div>
<%@include file="/WEB-INF/include/paging.jsp" %>
			<div class="col-xl-12 d-flex justify-content-end">
				<a href="<c:url value='/boardView' />">
					<button type="button" class="write-btn">BOARD</button>
				</a>
				<a href="<c:url value='/boardWriteView' />">
					<button type="button" class="write-btn">WRITE</button>
				</a>
			</div>
		</div>
	</div>
</section>
<%@include file="/WEB-INF/include/foot.jsp" %>
</body>
</html>
