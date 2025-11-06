<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 페이 결제</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

<body>
<script type="text/javascript">
	$(function(){
		$("#kakaoPayBtn").click(function(){
			// alert("버튼클릭");
			$.ajax({
				  type : 'POST'
				, url : "<c:url value='/kakaoPay/ready'/>"
				, data : {
					  item_name : "아이폰 14 pro"
					, quantity : "1"
					, total_amount : "1400000"
					, tax_free_amount : "0"
				},
				success : function(res){
					console.log("res=", res);
					location.href = res.next_redirect_pc_url;
				}
			})
		});
	});
</script>
	<button id="kakaoPayBtn" style="background: #Fee500; color: #000; border-radius: 12px; padding: 10px 20px;">카카오페이
	</button>
</body>
</html>