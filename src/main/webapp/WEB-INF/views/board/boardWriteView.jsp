<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardWrite</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
</head>
<body id="page-top">
	
	<script type="text/javascript">
	if("${login.memNo }" == null || "${login.memNo}" == ''){
		location.href = "${pageContext.request.contextPath }/startView?msg=none";
	}
	</script>
	
	<%@include file="/WEB-INF/include/top.jsp"%>

	<!-- 서머노트를 위해 추가해야할 부분 -->
	
	<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
	<script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
	<!--  -->
	
	<script type="text/javascript">
	<!-- SummerNote Editor -->
	$(document).ready(function() {  

		var toolbar = [
			    // 글꼴 설정
			    ['fontname', ['fontname']],
			    // 글자 크기 설정
			    ['fontsize', ['fontsize']],
			    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    // 글자색
			    ['color', ['forecolor','color']],
			    // 표만들기
			    ['table', ['table']],
			    // 글머리 기호, 번호매기기, 문단정렬
			    ['para', ['ul', 'ol', 'paragraph']],
			    // 줄간격
			    ['height', ['height']],
			    // 그림첨부, 링크만들기, 동영상첨부
			    ['insert',['picture']]
			  ];

		var setting = {
	            height : 300,
	            minHeight : null,
	            maxHeight : null,
	            focus : true,
	            lang : 'ko-KR',
	            toolbar : toolbar,
	            callbacks : { //여기 부분이 이미지를 첨부하는 부분
	            onImageUpload : function(files, editor,
	            welEditable) {
	            for (var i = files.length - 1; i >= 0; i--) {
	            uploadSummernoteImageFile(files[i],this);
	            		} 
	            	}
	            }
	         };

	        $('#summernote').summernote(setting);
	        
	        });
	
	</script>

	<!-- Spinner Start -->
<!-- 	<div id="spinner"
		class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
		<div class="spinner-border position-relative text-primary"
			style="width: 6rem; height: 6rem;" role="status"></div>
		<img class="position-absolute top-50 start-50 translate-middle"
			src="img/icons/icon-1.png" alt="Icon">
	</div> -->
	<!-- Spinner End -->

	<!-- Page Header Start -->
	<div class="container-fluid page-header py-5 mb-5 wow fadeIn"
		data-wow-delay="0.1s">
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
	


	<!-- 회원 게시판 폼 -->
	<section class="page-section mt-5" id="contact">
		<div class="container col-5">
			<!-- Contact Section Heading-->
			<h1
				class="page-section-heading text-center text-uppercase text-secondary"
				style="margin: 50px auto 30px auto; font-size: 80px;">Board</h1>

			<h2 class="maintit d-flex justify-content-start">W R I T E</h2>
			<!-- Contact Section Form-->
			<form action="${pageContext.request.contextPath }/boardWriteDo" method="POST">
				<div class="form-group">
					<div class="form-group">
						<label for="sg_title">제목</label> 
						<input type="text" class="form-control" name="boardTitle" id="sg_title" required="Y">
					</div>
					<div class="form-group">
						<label for="sg_cate">분류</label> 
						<c:if test="${login.memName eq '관리자' }">
							<select type="text" class="form-control" name="boardCategory" id="sg_cate" required="Y">
							<option value="">-전체-</option>
							<c:forEach items="${boardInfoList}" var="boardInfo">
								<c:if test="${boardInfo.boardCategoryName eq '공지사항'}">
								<option value="${boardInfo.boardCategoryName}" >${boardInfo.boardCategoryName}</option>
								</c:if>
							</c:forEach>
							</select>
						</c:if>
						<c:if test="${login.memName != null and login.memName != '' and login.memName ne '관리자'}">
							<select type="text" class="form-control" name="boardCategory" id="sg_cate" required="Y">
								<option value="">-전체-</option>
								<c:forEach items="${boardInfoList}" var="boardInfo">
									<c:if test="${boardInfo.boardCategoryName ne '공지사항' }">
										<option value="${boardInfo.boardCategoryName}" >${boardInfo.boardCategoryName}</option>
									</c:if>
								</c:forEach>
							</select>
						</c:if>
					</div>
					<div class="form-group">
						<label for="sg_name">작성자</label> 
						<input type="text" class="form-control" name="memNo" id="sg_name" placeholder="${login.memNo }" readonly>
					</div>
					<div class="form-group">
						<label for="summernote">내용</label>
						<textarea class="summernote" name="boardContent" id="summernote"></textarea>
					</div>
					<div class="d-flex justify-content-end">
						<button class="list-btn" type="button" onclick="window.history.go(-1)">L I S T</button>
						<button class="write-btn" type="submit">SIGN UP</button>
					</div>
				</div>
			</form>
		</div>
	</section>
	
<script type="text/javascript">
    function uploadSummernoteImageFile(file, el) {
    	
		const data = new FormData();
		data.append("file", file);
		console.log("file:", file);
		console.log("el = ", el);
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/upload'/>",
			processData : false,
			contentType : false,
			enctype : 'multipart/form-data',
			data : data,
			success : function(data) {
				console.log("data.url = ", data.url);
				$(el).summernote('editor.insertImage', data.url);
			},error: function(err) {
				console.log("err",err);
			}
		});
		
	}
</script>
	
<%@include file="/WEB-INF/include/foot.jsp" %>



</body>
</html>