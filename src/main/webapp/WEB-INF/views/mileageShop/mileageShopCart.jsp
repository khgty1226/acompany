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
	<input id="msg" type="hidden" value="${msg }">
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
                    <li class="breadcrumb-item text-primary active" aria-current="page">Cart</li>
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
			                <h4 class="section-title">Shopping Cart</h4>
			                <h1 class="display-5 mb-4">장바구니</h1>
	            </div>
            </div>
            <div class="row g-5" style="width: 1500px">
            	  <div class="col-lg-9">
            	  	<table id="cartTable" style="border:1px solid black">
            	  		<colgroup>
            	  			<col width="50px"/>
            	  			<col width="550px"/>
            	  			<col width="100px"/>
            	  			<col width="140px"/>
            	  			<col width="50px"/>
            	  			<col width="140px"/>
            	  		</colgroup>
            	  		<thead style="text-align: center; background-color: var(--light)">
            	  			<tr>
            	  				<th style="padding-top: 5px"><input id="checkAll" style="zoom: 1.3" type="checkbox"></th>
            	  				<th>상품정보</th>
            	  				<th>단위</th>
            	  				<th>단가</th>
            	  				<th>수량</th>
            	  				<th>합계</th>
            	  			</tr>
            	  		</thead>
            	  		<tbody style="color : #333">
            	  			<c:forEach items="${prodList }" var="prod">
            	  				<tr class="cartProd">
            	  					<td style="text-align: center"><input class="checkProd" style="zoom: 1.3" type="checkbox">
	   	  								<input type="hidden" class="cartNo" name="cartNo" value="${prod.cartNo }">
            	  					</td>
            	  					<td>
            	  						<div class="row">
            	  							<div class="col-4">
            	  								<img alt="" style="border: 1px solid #eee" src="${prod.prodImgUrl }">
            	  							</div>
            	  							<div class="col-8">
            	  								<p style="color : var(--primary)">${prod.prodNo }</p>
            	  								<p>${prod.prodName }</p>
            	  							</div>
            	  						</div>
            	  					</td>
            	  					<td style="text-align: center">${prod.prodUnit }</td>
            	  					<td style="text-align: center"><fmt:formatNumber value="${prod.prodPrice }" pattern="#,###,###"/></td>
            	  					<td><input type="number" name="prodCnt" style="width: 70px; text-align: center" value="${prod.prodCnt }"><button type="button" class="changeCnt" style="font-size: 14px;">수량변경</button></td>
            	  					<td style="text-align: center"><fmt:formatNumber value="${prod.prodPrice * prod.prodCnt }" pattern="#,###,###"/></td>
            	  				</tr>
            	  			</c:forEach>
            	  		</tbody>
            	  	</table>
            	  	<form id="deleteForm" action="${pageContext.request.contextPath }/mileageShopDeleteDo">
          				<input type="hidden" name="cartNoStr" value="">
          			</form>
            	  	<button type="button" id="deleteSelBtn" class="btn btn-outline-secondary" style="margin-top:5px">선택삭제</button>
                </div>
                <div class="col-lg-3" style="border: 0.5px solid gray; padding-top: 5px; min-height: 400px">
                    <div class="categoryDiv-header">Order Info</div>
                    <div class="row g-4" style="margin-top:10px">
                        <div class="col-12" style="border-bottom: 0.5px solid lightgray">
                            <div class="d-flex align-items-start">
	                             <div class="col-4" style="padding-left:23px">
                                    <p style="font-size:1.4rem">상품금액</p>
                                </div>
                                <div class="col-8" style="height: 100%">
                                	<div style="width: 500px; height: 40px; float: right;  text-align:right;">
                                		<p id="prodPriceSum" class="price-p"></p>
                                		<p class="price-p">원</p>
                                	</div>
                                </div>
                            </div>
                        </div>
                        <%-- <div class="col-12" style="border-bottom: 0.5px solid lightgray">
                            <div class="d-flex align-items-start">
	                             <div class="col-4" style="padding-left:23px">
                                    <p style="font-size:1.4rem">배송비</p>
                                </div>
                                <div class="col-8" style="height: 100%">
                                	<div style="width: 500px; height: 40px; float: right;  text-align:right;">
                                		<p class="price-p"><fmt:formatNumber value="${product.prodPrice }" pattern="#,###,###"/></p>
                                		<p class="price-p">원</p>
                                	</div>
                                </div>
                            </div>
                        </div> --%>
                        <div class="col-12" style="border-bottom: 0.5px solid lightgray">
                            <div class="d-flex align-items-start">
	                            <div class="col-4" style="padding-left:23px">
                                    <p style="font-size:1.4rem">합계</p>
                                </div>
                                <div class="col-8" style="height: 100%">
                                	<div style="width: 500px; height: 40px; float: right;  text-align:right;">
                                		<p id="prodPriceSumFinal"  class="total-price-p"><fmt:formatNumber value="${product.prodPrice }" pattern="#,###,###"/></p>
                                		<p class="total-price-p">원</p>
                                	</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-12">
                            <div class="d-flex align-items-start">
	                                <div class="col-12" style="height: 100%">
	                                	<div style="width: 100%; height: 110px;">
	                                			<form id="orderForm" action="${pageContext.request.contextPath }/mileageShopOrderView">
	                                				<input type="hidden" name="cartNoStr" value="">
	                                			</form>
						                       <button id="orderAllBtn" type="button" class="btn btn-outline-primary">전체상품 주문하기</button><br>
						                       <button id="orderSelBtn" type="button" class="btn btn-outline-primary">선택상품 주문하기</button>
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
	if("${login.memNo }" == null || "${login.memNo}" == ''){
		location.href = "${pageContext.request.contextPath }/startView?msg=none";
	}
    	$(function(){
    		
   			let msg = $("#msg").val();
   			
   			if(msg == "oFail"){
   				alert("결제에 실패했습니다. 전산실에 문의해주세요. 010-7358-4002");
   			}else if (msg == "oSuccess"){
   				alert("상품이 결제되었습니다.");
   			}else if (msg == "dFail"){
   				alert("항목 삭제에 실패했습니다. 전산실에 문의해주세요. 010-7358-4002");
   			}else if (msg == "dSuccess"){
   			}
    		
    		$("#checkAll").click(function(){
    			if($(this).prop("checked") == true){
	    			$(".checkProd").prop("checked", true);
    			}else{
	    			$(".checkProd").prop("checked", false);
    			}
    		});
    		
    		$(".changeCnt").click(function(){
    			let cartNo = $($(this).parent().parent().children()[0]).find("input[name='cartNo']").val();
    			console.log(cartNo);
    			
    			let prodCnt = $(this).parent().find("input[name='prodCnt']").val();
    			console.log(prodCnt);
    			if(prodCnt < 1){
    				alert("구매 수량은 1개 이상 선택 가능합니다. 다시 선택해주세요.")
    				location.reload();
    				return;
    			}
    			
    			$.ajax({
    				url: "${pageContext.request.contextPath }/changeCartProdCnt"
    				, type: "post"
    				, data: {
    					cartNo : cartNo
    					, prodCnt: prodCnt
    				}
    				, success: function(result){
    					if(result){
	    					location.href = "${pageContext.request.contextPath }/mileageShopCartView";
    					}else{
	    					alert("수량 변경에 실패했습니다. 전산실에 문의해주세요.");
    					}
    				}
    				, error: function(){
    					alert("서버와의 연결에 실패했습니다. 전산실에 문의해주세요.");
    				}
    			});
    		});
    		
    		let prodPriceSum = 0;
    		$(".cartProd").each(function(){
    			let prodTotalPrice = Number($($(this).children()[5]).html().replace(",", ""));
    			prodPriceSum += prodTotalPrice;
    		});
    		
    		$("#prodPriceSum").html(prodPriceSum.toLocaleString());
    		$("#prodPriceSumFinal").html($("#prodPriceSum").html());
    		
    		$("#orderAllBtn").click(function(){
    			let cartNoArr = []
    			$(".cartNo").each(function(){
    				cartNoArr.push($(this).val());
    			});
    			console.log(cartNoArr);
    			if(cartNoArr.length == 0){
    				alert("구매하실 항목이 없습니다.");
    				return;
    			}
    			let cartNoStr = JSON.stringify(cartNoArr);
    			
    			let of = $("#orderForm");
    			of.find("input[name='cartNoStr']").val(cartNoStr);
    			
    			of.submit();
    		});
    		
    		$("#orderSelBtn").click(function(){
    			let cartNoArr = []
    			$(".checkProd").each(function(){
    				if($(this).prop("checked") == true){
	    				cartNoArr.push($(this).parent().find("input[name='cartNo']").val());
    				}
    			});
    			console.log(cartNoArr.length);
    			if(cartNoArr.length == 0){
    				alert("구매하실 항목을 선택해주세요.")
    				return;
    			}
    			let cartNoStr = JSON.stringify(cartNoArr);
    			
    			let of = $("#orderForm");
    			of.find("input[name='cartNoStr']").val(cartNoStr);
    			
    			of.submit();
    		});
    		
    		$("#deleteSelBtn").click(function(){
    			let cartNoArr = []
    			$(".checkProd").each(function(){
    				if($(this).prop("checked") == true){
	    				cartNoArr.push($(this).parent().find("input[name='cartNo']").val());
    				}
    			});
    			console.log(cartNoArr.length);
    			if(cartNoArr.length == 0){
    				alert("삭제하실 항목을 선택해주세요.")
    				return;
    			}
    			let cartNoStr = JSON.stringify(cartNoArr);
    			
    			let df = $("#deleteForm");
    			df.find("input[name='cartNoStr']").val(cartNoStr);
    			
    			df.submit();
    		});
    	});
    </script>
</body>
</html>