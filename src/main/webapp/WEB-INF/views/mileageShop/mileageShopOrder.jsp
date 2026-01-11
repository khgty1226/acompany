<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>ACompany MileageShop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600&family=Teko:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <!-- Spinner Start -->
    <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-border position-relative text-primary" style="width: 6rem; height: 6rem;" role="status"></div>
        <img class="position-absolute top-50 start-50 translate-middle" src="img/icons/icon-1.png" alt="Icon">
    </div>
    <!-- Spinner End -->

	<%@ include file="/WEB-INF/include/top.jsp" %>


    <!-- Page Header Start -->
    <div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container py-5">
            <h1 class="display-1 text-white animated slideInDown">Mileage Shop</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb text-uppercase mb-0">
                    <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                    <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
                    <li class="breadcrumb-item text-primary active" aria-current="page">Order</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- Feature Start -->
    <div class="container-fluid py-5">
        <div class="container">
        	  <div class="row g-5" style="width: 1500px">
            	<div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
			                <h4 class="section-title">Order Page</h4>
			                <h1 class="display-5 mb-4">결제하기</h1>
	            </div>           
            </div>
            <div class="row g-5" style="width: 1500px">
            	  <div class="col-lg-9">
            	  	<table id="cartTable" style="border:1px solid black">
            	  		<colgroup>
            	  			<col width="550px"/>
            	  			<col width="100px"/>
            	  			<col width="140px"/>
            	  			<col width="50px"/>
            	  			<col width="140px"/>
            	  		</colgroup>
            	  		<thead style="text-align: center; background-color: var(--light)">
            	  			<tr>
            	  				<th>상품정보</th>
            	  				<th>단위</th>
            	  				<th>단가</th>
            	  				<th>수량</th>
            	  				<th>합계</th>
            	  			</tr>
            	  		</thead>
            	  		<tbody style="color : #333">
            	  				<tr class="cartProd">
            	  					<td>
	   	  								<input type="hidden" class="cartNo" name="cartNo" value="1">
            	  						<div class="row">
            	  							<div class="col-4">
            	  								<img alt="" style="border: 1px solid #eee" src="/resources/product/prod_img/2559.jpg">
            	  							</div>
            	  							<div class="col-8">
            	  								<p id="prodNoP" style="color : var(--primary)">00002559</p>
            	  								<p id="prodNameP">아인 지우개</p>
            	  							</div>
            	  						</div>
            	  					</td>
            	  					<td style="text-align: center">개(1)</td>
            	  					<td style="text-align: center" id="price">500</td>
            	  					<td><input id="prodCntP" type="number" name="prodCnt" style="width: 70px; text-align: center" value="1"><button type="button" class="changeCnt" style="font-size: 14px;">수량변경</button></td>
            	  					<td id="prodPriceSumP" style="text-align: center">500</td>
            	  				</tr>
                                <tr class="cartProd">
                                    <td>
                                        <input type="hidden" class="cartNo" name="cartNo" value="1">
                                        <div class="row">
                                            <div class="col-4">
                                                <img alt="" style="border: 1px solid #eee" src="/resources/product/prod_img/29.jpg">
                                            </div>
                                            <div class="col-8">
                                                <p id="prodNoP" style="color : var(--primary)">00000029</p>
                                                <p id="prodNameP">스카치 테이프</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td style="text-align: center">개(1)</td>
                                    <td style="text-align: center" id="price">1000</td>
                                    <td><input id="prodCntP" type="number" name="prodCnt" style="width: 70px; text-align: center" value="1"><button type="button" class="changeCnt" style="font-size: 14px;">수량변경</button></td>
                                    <td id="prodPriceSumP" style="text-align: center">1000</td>
                                </tr>
            	  		</tbody>
            	  	</table>
            	  	<div style="width: 100%; margin-top: 15px; margin-bottom:10px; color:black ; font-size: 30px; font-weight: bold;">
            	  	 할인정보
            	  	</div>
            	  	<div style="width: 93%; border: 0.5px solid black">
            	  		<div style="width: 15%; border-right: 0.5px solid black ; display: inline-block; text-align: center">마일리지</div>
            	  		<div style="width: 83% ; display: inline-block; text-align: right;">
            	  			보유 마일리지: <p style="display: inline" id="memMileage">2400</p>&nbsp;&nbsp;
            	  			<input id="mileageInput" type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="0" style="text-align: right"/>
            	  			<button id="mileageBtn" type="button">적용</button>
            	  		</div>
            	  	</div>
            	  	
                </div>
                <div class="col-lg-3" style="border: 0.5px solid gray; padding-top: 5px">
                    <div class="categoryDiv-header">Order Info</div>
                    <div class="row g-4" style="margin-top:10px">
                        <div class="col-12" style="border-bottom: 0.5px solid lightgray">
                            <div class="d-flex align-items-start">
	                             <div class="col-4" style="padding-left:23px">
                                    <p style="font-size:1.4rem">상품금액</p>
                                </div>
                                <div class="col-8" style="height: 100%">
                                	<div style="width: 500px; height: 40px; float: right;  text-align:right;">
                                		<p id="prodPriceSum" class="price-p">1500</p>
                                		<p class="price-p">원</p>
                                	</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12" style="border-bottom: 0.5px solid lightgray">
                            <div class="d-flex align-items-start">
	                             <div class="col-4" style="padding-left:23px">
                                    <p style="font-size:1.4rem">할인금액</p>
                                </div>
                                <div class="col-8" style="height: 100%">
                                	<div style="width: 500px; height: 40px; float: right;  text-align:right;">
                                		<p id="priceDiscount" class="price-p">1000</p>
                                		<p class="price-p">원</p>
                                	</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12" style="border-bottom: 0.5px solid lightgray">
                            <div class="d-flex align-items-start">
	                            <div class="col-4" style="padding-left:23px">
                                    <p style="font-size:1.4rem">합계</p>
                                </div>
                                <div class="col-8" style="height: 100%">
                                	<div style="width: 400px; height: 40px; float: right;  text-align:right;">
                                		<p id="prodPriceSumFinal"  class="total-price-p">500</p>
                                		<p class="total-price-p">원</p>
                                	</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-12">
                            <div class="d-flex align-items-start">
	                                <div class="col-12" style="height: 100%">
	                                	<div style="width: 100%; height: 110px;">
<%--	                                			<form id="orderForm" action="${pageContext.request.contextPath }/mileageShopOrderDo">--%>
<%--	                                				<input type="hidden" name="cartNoStr" value="">--%>
<%--	                                			</form>--%>
						                       <button id="orderBtn" type="button" class="btn btn-outline-primary">결제하기</button><br>
	                                	</div>
	                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
			 
            
        </div>
    </div>
    <!-- Feature End -->
        

    <!-- Footer Start -->
    <div class="container-fluid bg-dark text-body footer mt-5 pt-5 px-0 wow fadeIn" data-wow-delay="0.1s">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <h3 class="text-light mb-4">Address</h3>
                    <p class="mb-2"><i class="fa fa-map-marker-alt text-primary me-3"></i>123 Street, New York, USA</p>
                    <p class="mb-2"><i class="fa fa-phone-alt text-primary me-3"></i>+012 345 67890</p>
                    <p class="mb-2"><i class="fa fa-envelope text-primary me-3"></i>info@example.com</p>
                    <div class="d-flex pt-2">
                        <a class="btn btn-square btn-outline-body me-1" href=""><i class="fab fa-twitter"></i></a>
                        <a class="btn btn-square btn-outline-body me-1" href=""><i class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-square btn-outline-body me-1" href=""><i class="fab fa-youtube"></i></a>
                        <a class="btn btn-square btn-outline-body me-0" href=""><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h3 class="text-light mb-4">Services</h3>
                    <a class="btn btn-link" href="">Architecture</a>
                    <a class="btn btn-link" href="">3D Animation</a>
                    <a class="btn btn-link" href="">House Planning</a>
                    <a class="btn btn-link" href="">Interior Design</a>
                    <a class="btn btn-link" href="">Construction</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h3 class="text-light mb-4">Quick Links</h3>
                    <a class="btn btn-link" href="">About Us</a>
                    <a class="btn btn-link" href="">Contact Us</a>
                    <a class="btn btn-link" href="">Our Services</a>
                    <a class="btn btn-link" href="">Terms & Condition</a>
                    <a class="btn btn-link" href="">Support</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h3 class="text-light mb-4">Newsletter</h3>
                    <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                    <div class="position-relative mx-auto" style="max-width: 400px;">
                        <input class="form-control bg-transparent w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                        <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid copyright">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                        &copy; <a href="#">Your Site Name</a>, All Right Reserved.
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                        Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    
    <script type="text/javascript">
	<%--if("${login.memNo }" == null || "${login.memNo}" == ''){--%>
	<%--	location.href = "${pageContext.request.contextPath }/startView?msg=none";--%>
	<%--}--%>
	
    <%--	$(function(){--%>
    <%--		--%>
    <%--		$(".changeCnt").click(function(){--%>
    <%--			let cartNo = $($(this).parent().parent().children()[0]).find("input[name='cartNo']").val();--%>
    <%--			console.log(cartNo);--%>
    <%--			--%>
    <%--			let prodCnt = $(this).parent().find("input[name='prodCnt']").val();--%>
    <%--			console.log(prodCnt);--%>
    <%--			--%>
    <%--			if(prodCnt < 1){--%>
    <%--				alert("구매 수량은 1개 이상 선택 가능합니다. 다시 선택해주세요.")--%>
    <%--				location.reload();--%>
    <%--				return;--%>
    <%--			}--%>
    <%--			--%>
    <%--			if(cartNo == ""){--%>
    <%--				$("#prodPriceSum").html((Number($("#price").html().replace(",", "")) * prodCnt).toLocaleString());--%>
    <%--	    		$("#prodPriceSumFinal").html((Number($("#prodPriceSum").html().replace(",", "")) + Number($("#priceDiscount").html().replace(",", ""))).toLocaleString());--%>
    <%--	    		$("#prodPriceSumP").html((Number($("#price").html().replace(",", "")) * prodCnt).toLocaleString());--%>
    <%--			}else{--%>
	<%--    			$.ajax({--%>
	<%--    				url: "${pageContext.request.contextPath }/changeCartProdCnt"--%>
	<%--    				, type: "post"--%>
	<%--    				, data: {--%>
	<%--    					cartNo : cartNo--%>
	<%--    					, prodCnt: prodCnt--%>
	<%--    				}--%>
	<%--    				, success: function(result){--%>
	<%--    					if(result){--%>
	<%--	    					location.reload();--%>
	<%--    					}else{--%>
	<%--	    					alert("수량 변경에 실패했습니다. 전산실에 문의해주세요.");--%>
	<%--    					}--%>
	<%--    				}--%>
	<%--    				, error: function(){--%>
	<%--    					alert("서버와의 연결에 실패했습니다. 전산실에 문의해주세요.");--%>
	<%--    				}--%>
	<%--    			});--%>
    <%--			}--%>
    <%--		});--%>
    <%--		--%>
    <%--		let prodPriceSum = 0;--%>
    <%--		$(".cartProd").each(function(){--%>
    <%--			let prodTotalPrice = Number($($(this).children()[4]).html().replace(",", ""));--%>
    <%--			console.log("prodTotalPrice=", prodTotalPrice);--%>
    <%--			prodPriceSum += prodTotalPrice;--%>
    <%--		});--%>
    <%--		--%>
    <%--		$("#prodPriceSum").html(prodPriceSum.toLocaleString());--%>
    <%--		$("#prodPriceSumFinal").html($("#prodPriceSum").html());--%>
    <%--		--%>
    <%--	/* 	$("#orderAllBtn").click(function(){--%>
    <%--			let cartNoArr = []--%>
    <%--			$(".cartNo").each(function(){--%>
    <%--				cartNoArr.push($(this).val());--%>
    <%--			});--%>
    <%--			console.log(cartNoArr);--%>
    <%--			let cartNoStr = JSON.stringify(cartNoArr);--%>
    <%--			--%>
    <%--			let of = $("#orderForm");--%>
    <%--			of.find("input[name='cartNoStr']").val(cartNoStr);--%>
    <%--			--%>
    <%--			of.submit();--%>
    <%--		});--%>
    <%--		--%>
    <%--		$("#orderSelBtn").click(function(){--%>
    <%--			let cartNoArr = []--%>
    <%--			$(".checkProd").each(function(){--%>
    <%--				if($(this).prop("checked") == true){--%>
	<%--    				cartNoArr.push($(this).parent().find("input[name='cartNo']").val());--%>
    <%--				}--%>
    <%--			});--%>
    <%--			console.log(cartNoArr);--%>
    <%--			let cartNoStr = JSON.stringify(cartNoArr);--%>
    <%--			--%>
    <%--			let of = $("#orderForm");--%>
    <%--			of.find("input[name='cartNoStr']").val(cartNoStr);--%>
    <%--			--%>
    <%--			of.submit();--%>
    <%--		}); */--%>
    <%--		--%>
    		$("#orderBtn").click(function(){
    			let prodNo = $("#prodNoP").html();
    			let prodCnt = $("#prodCntP").val();

    			let cartNoArr = []
    			$(".cartNo").each(function(){
    				cartNoArr.push($(this).val());
    			});
    			console.log(cartNoArr);
    			console.log(cartNoArr[0]);

				 let cartNoStr = JSON.stringify(cartNoArr);

    			// alert("버튼클릭");
    			let order_itemName = $($(".cartProd").children()[0]).find("#prodNameP").html();
    			// let order_quantity = $($(".cartProd").children()[0]).find("#prodNameP").html();
    			console.log("order_itemName=", order_itemName);

    			let order_total_amount = Number($("#prodPriceSumFinal").html().replace(",",""));
    			console.log("order_total_amount= ", order_total_amount);

    			let memMileage = Number($("#mileageInput").val());
    			let memNo = "00001";

    			if(cartNoArr[0] == ""){
    				$.ajax({
	    				  type : 'POST'
	    				, url : "<c:url value='/kakaoPay/readyD'/>"
	    				, data : {
	    					  item_name : order_itemName
	    					, quantity : "1"
	    					, total_amount : order_total_amount
	    					, tax_free_amount : "0"
	    					, prodNo : prodNo
	    					, prodCnt : prodCnt
	    					, memMileage: memMileage
	    					, memNo : memNo
	    				},
	    				success : function(res){
	    					console.log("res=", res);
	    					location.href = res.next_redirect_pc_url;

	
	    				}
	    			});
    			}else{
	    			$.ajax({
	    				  type : 'POST'
	    				, url : "<c:url value='/kakaoPay/ready'/>"
	    				, data : {
	    					  item_name : order_itemName
	    					, quantity : "1"
	    					, total_amount : order_total_amount
	    					, tax_free_amount : "0"
	    					, cartNoStr : cartNoStr
	    					, memMileage: memMileage
	    					, memNo : memNo
	    				},
	    				success : function(res){
	    					console.log("res=", res);
	    					location.href = res.next_redirect_pc_url;

	
	    				}
	    			});
    			}
    		});

    <%--		$("#mileageBtn").click(function(){--%>
    <%--			let input = $("#mileageInput");--%>
    <%--			let inputNum = input.val();--%>
    <%--			let price = Number($("#prodPriceSum").html().replace(",", ""));--%>
    <%--			--%>
    <%--			let memMileage = $("#memMileage");--%>
    <%--			--%>
    <%--			console.log("memMileage:", memMileage.html());--%>
    <%--			--%>
    <%--			if(memMileage.html() < Number(inputNum)){--%>
    <%--				alert("보유 마일리지가 부족합니다.");	--%>
    <%--				input.val(0);--%>
    <%--				return;--%>
    <%--			}else if(price < Number(inputNum)){--%>
    <%--				alert("상품 가격보다 사용 마일리지가 클 수 없습니다.");--%>
    <%--				input.val(0);--%>
    <%--				return;--%>
    <%--			}--%>
    <%--			memMileage.html("${member.memMileage}"-Number(inputNum));--%>
	<%--			    			--%>
    <%--			console.log(Number(inputNum).toLocaleString());--%>
    <%--			$("#priceDiscount").html("-"+Number(inputNum).toLocaleString());--%>
    <%--			--%>
    <%--			console.log("price:", price);--%>
    <%--			console.log("(price-Number(inputNum)).toLocaleString()", (price-Number(inputNum)).toLocaleString());--%>
    <%--			$("#prodPriceSumFinal").html((price-Number(inputNum)).toLocaleString());--%>
    <%--			--%>
    <%--		});--%>
    <%--	});--%>
    </script>
</body>
</html>