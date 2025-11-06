<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

<c:forEach items="${replyList}" var="reply">
	<div class="replyList_row" data-reNo="${reply.reNo }">
		<div><span class="reply_span"></span></div>
		<div class="row" style="font-weight: 600; font-size: 1.2rem;">
			<span class="col-6">@${reply.memNo}</span>
			<span class="col-6" style="text-align: right;">-${reply.reRegDate}</span>
		</div>
		<div class="reply_content">
			<pre style="font-size:1.1rem;">${reply.reContent}</pre>
		</div>
		<c:if test="${reply.memNo == login.memNo }">
			<div class="reply_button d-flex justify-content-end">
				<button class="btn_reply_regist" type="button" name="btn_reply_edit" style="font-size: 18px; margin: auto 0; color:#1E3050">
					<i class="fa-regular fa-pen-to-square"></i>
				</button>
				<button class="btn_reply_regist" type="button" name="btn_reply_delete" style="font-size: 18px; margin: auto 0; color:red">
					<i class="fa-regular fa-trash-can"></i>
				</button>
			</div>
		</c:if>
	</div>
</c:forEach>
