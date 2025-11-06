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
    <style type="text/css">
    	.partDiv{
    		height: 200px;
    		vertical-align: middle;
    	}
    	.partDivB{
    		border-bottom: 0.5px solid lightgray;
    	}
    	#logTable thead tr {
    		border : 0.5px solid lightgray;
    		background-color: var(--light);
    	}
    	#logTable thead tr th {
    		border : 0.5px solid lightgray;
    	}
    	#logTable tbody tr td {
    		border : 0.5px solid lightgray;
    		color : black;
    	}
    	.dateSelBtn{
    		margin:0;
    		border: 0.3px solid lightgray;
    		background-color: var(--light);
    	}
    </style>
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
                    <li class="breadcrumb-item text-primary active" aria-current="page">Order Log</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- Feature Start -->
    <div class="container-fluid py-5">
        <div class="container">
	        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
	                <h4 class="section-title">Order Log</h4>
	                <h1 class="display-5 mb-4">주문 내역</h1>
	        </div>
	        <div class="row g-4 wow fadeInUp" style="position:relative;" data-wow-delay="0.3s">
		        <div class="col-lg-12">
		        	<div id="searchBar" style="padding-left:0px; padding-right:0px; color:black; font-size:20px; margin-bottom: 10px;">
			        	<form name="search" action="${pageContext.request.contextPath }/mileageShopOrderLogView" method="get">
			        		<input type="hidden" name="curPage" value="${searchVO.curPage}"> 
							<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage}">
							&nbsp;&nbsp;
							주문 처리상태: <select name="searchState" style="width:200px">
								<option value="">전체 주문처리상태</option>
								<option value="N" ${searchVO.searchState eq 'N' ? "selected='selected'" : "" }>입금전</option>
								<option value="P" ${searchVO.searchState eq 'P' ? "selected='selected'" : "" }>배송준비중</option>
								<option value="D" ${searchVO.searchState eq 'D' ? "selected='selected'" : "" }>배송중</option>
								<option value="S" ${searchVO.searchState eq 'S' ? "selected='selected'" : "" }>배송완료</option>
							</select>
							&nbsp;&nbsp;&nbsp;&nbsp;
							주문 날짜: <input type="date" id="date1" name="startDate" value="${searchVO.startDate }"> ~ <input type="date" id="date2" name="endDate" value="${searchVO.endDate }">
							&nbsp;&nbsp;
							<button class="dateSelBtn" type="button"data-month="0" data-date="0">오늘</button>
							<button class="dateSelBtn" type="button" data-month="0" data-date="7">1주일</button>
							<button class="dateSelBtn" type="button" data-month="1" data-date="0">1개월</button>
							<button class="dateSelBtn" type="button" data-month="3" data-date="0">3개월</button>
							<button class="" id="logSearchResetBtn" type="button" style="width:100px; float: right; margin-right: 15px; font-size:18px">초기화</button>
							<button class="" id="logSearchBtn" type="button" style="width:60px; float: right; margin-right: 15px; font-size:18px">조회</button>
			        	</form>
		        	</div>
			        <table id="logTable" style="background-color: white; border: 1px solid black; padding: 15px 15px 15px 15px; text-align: center">
				        <colgroup>
						    <col width="200px" />
						    <col width="600px" />
						    <col width="100px" />
						    <col width="150px" />
						    <col width="150px" />
						    <col width="150px" />
						  </colgroup>
						  <thead>
						    <tr>
						      <th>주문일자</th>
						      <th>상품정보</th>
						      <th>수량</th>
						      <th>구매금액</th>
						      <th>할인</th>
						      <th>주문처리상태</th>
						    </tr>
						  </thead>
						  <tbody>
	           		  	<c:forEach items="${orderLogList }" var="orderLog" >
								    <tr class="orderLog" style="border-bottom: 0.5px solid black">
								      <td>${orderLog.orderDate.split(" ")[0] }<br>
								       	<p style="color:gray">[${orderLog.orderNo }]</p>
								      </td>
								      
										      <td>
										      <c:forEach items="${orderDetailList }" var="orderDetail">
											      	<c:if test="${orderLog.orderNo eq orderDetail.orderNo }">
										      			<div class="partDiv partDivB">
													      	<div style="width: 30%; display: inline-block;">
													      	<br>
													      		<img alt="" src="${orderDetail.prodImgUrl }">
													      	</div>
													      	<div style="width: 65%; display: inline-block;">
													      	<br>
													      		<p style="color:var(--primary)">${orderDetail.prodNo }</p>
													      		${orderDetail.prodName }
													      	</div>
												      	</div>
									      			</c:if>
								      			</c:forEach>
										      </td>
										      <td>
										      <c:forEach items="${orderDetailList }" var="orderDetail">
											      <c:if test="${orderLog.orderNo eq orderDetail.orderNo }">
											   		   <div class="partDiv partDivB"><br><br><br><p>${orderDetail.prodCnt }</p></div>
											      </c:if>
											    </c:forEach>
											   </td>
										      <td>
										      <c:forEach items="${orderDetailList }" var="orderDetail">
										      		<c:if test="${orderLog.orderNo eq orderDetail.orderNo }">
										 			     <div class="partDiv partDivB"><br><br><br><p style="display: inline"><fmt:formatNumber value="${orderDetail.prodCnt * orderDetail.prodPrice }" pattern="#,###,###"/></p></div>
										      		</c:if>
										      	</c:forEach>
										      </td>
								      <td>${orderLog.disMileage }</td>
								      <td>
								      <c:if test="${orderLog.orderState eq 'N'}">입금전</c:if>
								      <c:if test="${orderLog.orderState eq 'P'}">배송준비중</c:if>
								      <c:if test="${orderLog.orderState eq 'D'}">배송중</c:if>
								      <c:if test="${orderLog.orderState eq 'S'}">배송완료</c:if>
								      </td>
								    </tr>
							  </c:forEach>
						  </tbody>
					</table>
					<!-- Paging -->
					<%@include file="/WEB-INF/include/paging.jsp" %>
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
    		$(".orderLog").each(function(){
    			let arr = [1, 2, 3];
    			for(let index of arr){
	    			console.log($($(this).children()[index]).find(".partDiv:last"));
	    			$($(this).children()[index]).find("div.partDiv:last").removeClass("partDivB");
    			}
    		});
    		
    		let sf =$("form[name='search']");
    		let curPage= sf.find("input[name='curPage']");
    		let rowSizePerPage = sf.find("input[name='rowSizePerPage']");
    		let startDate= sf.find("input[name='startDate']");
    		let endDate= sf.find("input[name='endDate']");
    		let searchState= sf.find("select[name='searchState']");

    		$('ul.pagination li a').click(function(e) {
    			e.preventDefault();

    			console.log($(e.target).data("curpage"));  
    			
    			curPage.val($(e.target).data("curpage")); 
    			rowSizePerPage.val($(this).data("rowsizeperpage")); 
    			startDate.val("${searchVO.startDate}");
    			endDate.val("${searchVO.endDate}");
    			searchState.val("${searchVO.searchState}");
    			
    			sf.submit();
    		});
    		
    		$("#logSearchBtn").click(function(){
    			curPage.val(1); 
				
    			sf.submit();
    		});
    		
    		$("#logSearchResetBtn").click(function(){
    			curPage.val(1); 
    			startDate.val("");
    			endDate.val("");
    			searchState.val("");
    			
    			sf.submit();
    		});
    		
    		$(".dateSelBtn").click(function(){
    			
    			let month = Number($(this).data("month"));
    			let date = Number($(this).data("date"));
    			
    			console.log("month:", month);
    			console.log("date:", date);
    			
    			curPage.val(1); 
    			searchState.val("${searchVO.searchState}");
    			
    			let today = new Date();
    			
    			let todayStr = today.getFullYear() + "-" + String(today.getMonth()+1).padStart(2, '0') + "-" + String(today.getDate()).padStart(2, '0');
    			console.log("todayDate:", startDate.val());
    			console.log("todayStr:", todayStr);
    			
    			endDate.val(todayStr);
    			console.log("endDate:", endDate.val());
    			
    			today.setHours(0);
    			today.setMinutes(0);
    			today.setSeconds(0);
    			
    			today.setMonth(today.getMonth()-month);
    			today.setDate(today.getDate()-date);
    			let startDayStr = today.getFullYear() + "-" + String(today.getMonth()+1).padStart(2, '0') + "-" + String(today.getDate()).padStart(2, '0');
    			startDate.val(startDayStr);
    			console.log("startDate:", startDate.val());
    			
    			console.log(today);
    			console.log(today.getFullYear());
    			console.log(today.getMonth()+1);
    			console.log(today.getDate());
    			console.log(today.getHours());
    			console.log(today.getMinutes());
    			console.log(today.getSeconds());
    			
    		   sf.submit();
    		});
    	});
    </script>
</body>
</html>