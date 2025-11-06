<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardDetail</title>
</head>
<body id="page-top">
<script type="text/javascript">
	if("${login.memNo }" == null || "${login.memNo}" == ''){
		location.href = "${pageContext.request.contextPath }/startView?msg=none";
	}
</script>

<%@include file="/WEB-INF/include/top.jsp"%>

	<!-- Spinner Start -->
	<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
		<div class="spinner-border position-relative text-primary" style="width: 6rem; height: 6rem;" role="status"></div>
		<img class="position-absolute top-50 start-50 translate-middle" src="img/icons/icon-1.png" alt="Icon">
	</div>
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
			<h1 class="page-section-heading text-center text-uppercase text-secondary"
				style="margin: 50px auto 30px auto; font-size: 80px;">Board</h1>
		
			<div class="form-group">
			<!-- Contact Section Heading-->
			<h2 class="maintit d-flex justify-content-start">${board.boardTitle }</h2>
			<!-- Contact Section Form-->
				<div class="form-group d-flex justify-content-start">
					<h5 style="margin-right: 20px">작성자&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${board.memNo }</h5>
				</div>
				<div class="form-group d-flex justify-content-start">
					<h5 style="margin-right: 20px">조회수&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${board.boardHit }회</h5>
					<h5 style="margin-right: 20px">분류&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${board.boardCategory }</h5>
					<h5>작성일&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${board.boardDate }</h5>
				</div>

				<div class="form-group">
					<label for="sg_text"
						style="margin: 10px 10px 10px 0; color: #252525; font-size: 20px;">내용</label>
					<div class="form-control" style="background-color: #FFF;" name="boardContent" id="sg_text" readonly>${board.boardContent }</div>
				</div>
				
				<!-- 게시글 좋아요 버튼 -->
				<c:if test="${board.boardCategory ne '공지사항' }">
				<div id="contentHeart">
					<div class="review_icon">
						<ul class="fixedclear row">
							<li class="col-6" id="heartLi" style="list-style:none;">
								<form class="heartBtn" name="like_form" method="post">
									<!-- 하트 버튼 들어갈 곳 -->
									<input type="hidden" name="boardNo" value="${board.boardNo}">
									<input type="hidden" name="memNo" value="${login.memNo }">
									<input type="hidden" id="heartDelYn" name="heartDelYn" value="${heart.heartDelYn }">
									<!-- 클릭시 마다 데이터 값 변경 할 곳 -->
									<button class="likeBtn" id="btn_like">
									    <c:if test="${heart.memNo == null}">
									        <i class="fa-regular fa-heart" id="iLike" style="color:black;"></i>
									    </c:if>
									    <c:if test="${heart.memNo != null}">
									        <i class="fa-regular fa-solid fa-heart fa-beat" id="iLike" style="color:red;"></i>
									    </c:if>
									</button>
								</form>
							</li>
							
							<li class="col-6 d-flex justify-content-end" id="saveLi" style="list-style: none;">
	 							<form class="saveBtn" name="save_form" method="post">
									<input type="hidden" name="boardNo" value="${board.boardNo}">
									<input type="hidden" name="memNo" value="${login.memNo }">
									<input type="hidden" name="saveDelYn" name="saveDelYn" value="${save.saveDelYn }">
									
									<button class="saveBtn" id="btn_save">
										<c:if test="${save.memNo == null }">
											<i class="fa-regular fa-bookmark" id="iSave"></i>
										</c:if>
										<c:if test="${save.memNo != null }">
											<i class="fa-solid fa-bookmark" id="iSave"></i>
										</c:if>
									</button>
								</form>
							</li>
							<li class="like_count" id="heartCnt">좋아요 ${heartCnt }개</li>
						</ul>
					</div>
				</div>
				</c:if>
				<div class="board_active row" style="margin-top: 30px; color: #252525; text-align: center;">
				    <c:choose>
				        <c:when test="${login.memNo eq board.memNo and board.boardCategory == '아나바다'}">
				            <div class="col-5">
				                <form action="${pageContext.request.contextPath }/boardShareDo">
				                    <select class="reply_select" id="id_selectMemNo" name="selectMemNo" required>
				                        <option value="">전체</option>
				                        <c:forEach items="${replySelectList}" var="replySelectItem">
				                            <c:choose>
				                                <c:when test="${login.memNo ne replySelectItem.memNo}">
				                                    <option value="${replySelectItem.memNo}" ${selectList.memNo eq replySelectItem.memNo ? "selected='selected'" : ""}>${replySelectItem.memNo}</option>
				                                </c:when>
				                            </c:choose>
				                        </c:forEach>
				                    </select>
				                    <c:choose>
				                        <c:when test="${login.memNo eq stateList.memNo}">
				                            <input type="hidden" name="memNo" value="${login.memNo }">
				                            <input type="hidden" name="boardNo" value="${board.boardNo }">
				                            <c:choose>
				                                <c:when test="${stateList.shState == 'P' }">
				                                    <button class="write-btn" type="submit">나눔완료</button>
				                                </c:when>
				                                <c:otherwise>
				                                    <button class="write-btn" type="button" onclick="fn_check()">나눔완료</button>
				                                </c:otherwise>
				                            </c:choose>
				                        </c:when>
				                    </c:choose>
				                </form>
				            </div>
				        </c:when>
				        <c:when test="${login.memNo eq stateList.memNo }">
				            <div class="col-5 d-flex justify-content-start">
				                <form action="${pageContext.request.contextPath }/boardStateUpdate">
				                    <c:choose>
				                        <c:when test="${login.memNo eq stateList.memNo}">
				                            <input type="hidden" name="memNo" value="${login.memNo }">
				                            <input type="hidden" name="boardNo" value="${board.boardNo }">
				                            <c:choose>
				                                <c:when test="${stateList.shState == 'P' }">
				                                    <button class="write-btn" type="submit">나눔완료</button>
				                                </c:when>
				                                <c:otherwise>
				                                    <button class="write-btn" type="button" onclick="fn_success()">나눔완료</button>
				                                </c:otherwise>
				                            </c:choose>
				                        </c:when>
				                    </c:choose>
				                </form>
				            </div>
				        </c:when>
				    </c:choose>
				
					<!-- 게시글 목록으로 가는 버튼 -->
					<c:if test="${login.memNo ne board.memNo and login.memNo ne stateList.memNo}">
					<div class="col-5"></div>
					</c:if>
					<c:if test="${login.memNo eq board.memNo and board.boardCategory != '아나바다'}">
					<div class="col-5"></div>
					</c:if>
					<div class="d-flex justify-content-end col-7">
						<button class="list-btn" onclick="history.back()">L I S T</button>
						
						<!-- 게시글 입력자와 로그인 정보가 같을 시 수정, 삭제버튼 -->
						<c:if test="${login.memNo == board.memNo }">
						<form action="${pageContext.request.contextPath }/boardEditView"
							method="POST">
							<input type="hidden" name="boardNo" value="${board.boardNo }">
							<button class="write-btn" type="submit">E D I T</button>
						</form>
						<form id="delForm"
							action="${pageContext.request.contextPath }/boardDelDo"
							method="POST">
							<input type="hidden" name="boardNo" value="${board.boardNo }">
							<button class="write-btn" type="button" onclick="fn_del()">DELETE</button>
						</form>
					</c:if>
					</div>
				</div>
			<!-- 댓글 등록 -->
			<div class="content02">
				<div id="reply_list_div" style="margin-bottom:30px;">
					<!-- 댓글 리스트  -->
				</div>
				<div id="reply_div">
					<form name="reply_form" method="post">
						<input type="hidden" name="reCategory" value="FREE"> 
						<input type="hidden" name="reParentNo" value="${board.boardNo}">
						<input type="hidden" id="memNo" name="memNo" value="${login.memNo }">
						<input type="hidden" name="reIp" value="${pageContext.request.remoteAddr}">
						
						<div class="reply_text row">
							<textarea class="reContent col-10" name="reContent" rows="2" cols="70" placeholder="댓글 달기..."></textarea>
							<!--button에 type 속성이 없으면 submit으로 처리된다.  -->
							
							<div class="reply_regist col-2">
							<button class="btn_reply_regist" id="btn_reply_regist">
								<i class="fa-regular fa-face-laugh-squint" style="font-size:24px;"></i>
							</button>
							</div>
							
						</div>
					</form>
				</div>
			</div>
		</div>
		</div>
	</section>

	<%@include file="/WEB-INF/include/foot.jsp"%>

<script type="text/javascript">

  	function fn_del(){
  		if(confirm("정말로 삭제하시겠습니까?")){
  			// form태그에 action을 실행시켜주고 submit해준다.
  			let formA = document.getElementById("delForm");
  			// let formB = document.querySelector("#delForm");
  			// let formC = $("#delFrom");
  			
  			formA.submit();
  		}
  	}
  	
  	// 저장하기 클릭시 로그인 정보 체크 후 저장 버튼 이벤트 발생
  	// 저장한 정보 가지고 디비에 저장
  	$("#saveLi").on("click", "#btn_save", function(e){
  		e.preventDefault();
  		// alert(".saveBtn");
  		
  		let saveForm = $("form[name='save_form']");
  		console.log("sava_form.serialize(): ", saveForm.serialize());
  		
  		$.ajax({
			  url : "<c:url value='/heartSave/saveCheck'/>"
			, type : "post"
			, data : saveForm.serialize()
			, success : function(result){
				if(result === 'save'){
					console.log("save: ", result);
					$("#iSave").removeClass("fa-regular").addClass("fa-solid");
				} else {
					console.log("save: ", result);
					$("#iSave").removeClass("fa-solid").addClass("fa-regular");
				}
			}
  		});
  		
  	});
  	
	/* 좋아요 클릭시 로그인정보 체크 후 좋아요 수 +1, -1 */
	$("#heartLi").on("click", "#btn_like", function(e){
		e.preventDefault();
		
		const likeForm = $("form[name='like_form']");
		console.log("like_form.serialize()", likeForm.serialize());
		
		$.ajax({
			  url:"<c:url value='/heartSave/heartCheck'/>"
			, type:"post"
			, data:likeForm.serialize()
			, success:function(result){
				if(result === 'like'){
					// 좋아요 버튼을 눌렀을 때, 아이콘 클래스를 변경하여 채워진 하트로 표시
					console.log("like", result);
					$("#iLike").removeClass("fa-heart").addClass("fa-solid fa-heart fa-beat");
					$("#iLike").css("color", "red");
					
					const $cnt = $("#heartCnt");
					console.log("$cnt", $cnt);
					const $heartYn = $("")
					let currentCnt = parseInt($cnt.text().split(" ")[1]); // 현재 좋아요 수 가져오기
					$cnt.text("좋아요 " + (currentCnt + 1) + "개"); // 좋아요 수를 1 증가시켜서 표시
					
				} else {
					console.log("delete", result);
					$("#iLike").removeClass("fa-solid fa-heart fa-beat").addClass("fa-heart");
					$("#iLike").css("color", "black");
					
					const $cnt = $("#heartCnt");
					console.log("$cnt", $cnt);
					let currentCnt = parseInt($cnt.text().split(" ")[1]); // 현재 좋아요 수 가져오기
					$cnt.text("좋아요 " + (currentCnt - 1) + "개"); // 좋아요 수를 1 감소시켜서 표시
				}
				
			}
		})
		
	})
	
  	// <!-- 댓글 등록 -->
  	$("#btn_reply_regist").on("click", function(e){
  		e.preventDefault();
  		
  		let replyForm = $("form[name='reply_form']");
  		console.log("replyForm.serialize()", replyForm.serialize());
  		
  		$.ajax({
  			//url: "${pageContext.request.contextPath}/reply/replyRegister"
  			url:"<c:url value='/reply/replyRegister'/>"
  			,type:"post"
  			,data: replyForm.serialize()
  			,success:function(){
  				$("textarea[name='reContent']").val("");
  				
  				$("#reply_list_div").html("");
  				fn_reply_list();
  			} 
  			,error:function(){
  				alert("error");
  			}
  		});
  	});
  	
  	// <!-- 댓글 삭제 -->
  	$(function(){
  		fn_reply_list();
  		$("#reply_list_div")
		.on("click", "button[name='btn_reply_delete']", function(e){
			let reNo = $(this).closest(".replyList_row").data("reno");
			
			let memNo = "${login.memNo}";
			let param = {"reNo": reNo, "memNo": memNo};
			
			let ret = confirm("댓글을 정말 삭제하시겠습니까?");
			if(ret){
				$.ajax({
					url:"<c:url value='/reply/replyDelete' />"
					,type: "post"
					,data: param
					,success: function(data){
						console.log("data.result: ", data.result);
						if(data.result){
							alert("댓글이 삭제 되었습니다.");
							$("#reply_list_div").html("");
							fn_reply_list();
						}else{
							alert("처리도중 에러가 발생하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850");
							$("#reply_list_div").html("");
							fn_reply_list();
						}
					}
					,error:function(){
						alert("처리도중 에러가 발생하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850");
					}
				});
			}
		});
  	
 	 // <!-- 수정 버튼 클릭하면  저장, 취소 버튼 변경 하고 사용자가 댓글 수정할수 있게 변경하기 -->
	let temp_content ="";
	$("#reply_list_div").on('click', 'button[name="btn_reply_edit"]', function(e){   
	
		let reNo = $(this).closest(".replyList_row").data('reno');  
		console.log("reNo : ", reNo);
		
		let memNo = "${login.memNo }";  
		console.log("memNo : ", memNo);
		
		let ret = confirm("댓글을 수정 하시겠습니까?");
		if(ret){
 			let reply_button = $(this).parent();
 			let reply_content = reply_button.prev();
 			console.log("reply_content", reply_content);

 			temp_content = reply_content.find("pre").text();
 			console.log("temp_content", temp_content);
 			
 			reply_content.html("");
 			
 			let str1 = '';
 			str1 += '<form name="reply_update" method="post"> ';
			str1 += '	<input type="hidden" name="reCategory" value="FREE"> ';
		 	str1 += '	<input type="hidden" name="reNo" value=""> ';  
		 	str1 += '	<input type="hidden" name="memNo" value=""> ';  
			str1 += '	<div style="text-align: center;"> ';
			str1 += '		<textarea name="reContent" style="width: 90%; margin:20px;" rows="2" cols="70">'+temp_content+'</textarea> ';
			str1 += '	</div>';
 			str1 += '</form>';
 			
			reply_content.append(str1);
 			
			
			reply_button.html("");
			let str2 = '';
			str2 += '<button type="button" name="btn_reply_update">저장</button>';
			str2 += '<button type="button" name="btn_reply_cancel">취소</button>';
			reply_button.append(str2);
			
		}
	});
	
	// <!-- 취소버튼을 클릭하면 이전 상태로 변경하기 -->
	$("#reply_list_div").on('click', 'button[name="btn_reply_cancel"]', function(e){  
			
			let reNo = $(this).closest(".replyList_row").data('reno');
			console.log("reNo : ", reNo);
			
			let memNo = "${login.memNo }";  
			console.log("memNo : ", memNo);
			
			let ret = confirm("댓글을 취소 하시겠습니까?");
			if(ret){
	 			let reply_button = $(this).parent()
	 			let reply_content = reply_button.next();
	 			console.log(reply_content);
	
	 			console.log("temp_content", temp_content);
	 			
	 			reply_content.html("");
	 			
	 			let str1 = '';
				str1 += '	<div> ';
				str1 += '		<pre>'+temp_content+'</pre> ';
				str1 += '	</div>';
	 			
				reply_content.append(str1);
	 			
				
				reply_button.html("")
				let str2 = '';
				str2 += '<button type="button" name="btn_reply_edit">수정</button>';
				str2 += '<button type="button" name="btn_reply_delete">삭제</button>';
				reply_button.append(str2);
				
			}
		});
	
	// <!-- 댓글을 수정한 후 저장 버튼을 클릭하면 수정한 내용 저장하기 --> 
	$("#reply_list_div").on('click', 'button[name="btn_reply_update"]', function(e){ 
		
		let replyListRow = $(this).closest(".replyList_row")
		let replyNo = replyListRow.data('reno');
		console.log("replyNo", replyNo);
		
		let replyUpdate = replyListRow.find("form[name='reply_update']");
		replyUpdate.find("input[name='reNo']").val(replyNo);
		
		let memNo = $("form[name='reply_form']").find("input[name='memNo']").val();
		replyUpdate.find("input[name='memNo']").val(memNo);
		
		console.log("replyUpdate.serialize(): ", replyUpdate.serialize());

	 	$.ajax({
			url:"<c:url value='/reply/replyUpdate'/>"  
			,type:"post"
			,data: replyUpdate.serialize()
			,success: function(data){
				console.log("btn_reply_update success");
			 	
				if(data.result){
					alert("댓글이 수정 되었습니다.");
					$("#reply_list_div").html("");
					fn_reply_list();
				}else{
					alert("처리도중 에러가 발생하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850");
					$("#reply_list_div").html("");
					fn_reply_list();
				}
				
				
			}
			,error: function(err){
				console.log("err.status : ", err.status);
				alert("댓글 수정에 실패하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850");
			}
			
			
		});
	});
	
});
  	
	// <!-- 댓글 리스트 -->
	function fn_reply_list(curPage){
		let url = "<c:url value='/reply/replyList'  />"
			$("#reply_list_div").load(
					url
					,{"reCategory":"FREE"
					, "reParentNo": "${board.boardNo}" 
					, "curPage": curPage} 
			)
	}
	
	function fn_check(){
		alert("나눔 완료 처리 되었습니다.");
	}
	
	function fn_success(){
		alert("나눔 완료 처리 되었습니다.");
	}

</script>

</body>
</html>