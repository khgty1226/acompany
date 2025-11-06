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


</head>
<body id="page-top">
<script type="text/javascript">
if("${login.memNo }" == null || "${login.memNo}" == ''){
	location.href = "${pageContext.request.contextPath }/startView?msg=none";
}
</script>

<%@include file="/WEB-INF/include/top.jsp" %>

<%@include file="/WEB-INF/include/boardHead.jsp" %>

		<!-- Contact Section Form-->
		<div class="row justify-content-center">
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
					<c:forEach items="${boardList }" var="board">
						<tr class="boardTr">
							<%-- <td>${board.boardNo }</td> --%>
							<td>
							    <p class="year">${fn:substringBefore(board.boardDate, '.')}</p> <!-- "2023" 출력 -->
							    <p class="md" style="margin-bottom:0px;">${fn:substringAfter(board.boardDate, '.')}</p>  <!-- "07/21" 출력 -->
							</td>
							<td><a href="${pageContext.request.contextPath }/boardDetailView?boardNo=${board.boardNo }">${board.boardTitle }</a></td>
							<td>${board.boardCategory }</td>
							<%-- <td>${board.boardTitle }</td> --%>
							<td>${board.memNo }</td>
							<td>${board.boardHit }</td>
							<td>${board.boardLike }</td>
							<td></td>
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
				<a href="<c:url value="/boardView" />">
					<button type="button" class="write-btn">BOARD</button>
				</a>
				<a href="<c:url value="/boardWriteView" />">
					<button type="button" class="write-btn">WRITE</button>
				</a>
			</div>
		</div>
	</div>
</section>
<%@include file="/WEB-INF/include/foot.jsp" %>
</body>
</html>
