<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
</head>

<script type="text/javascript">
	if("${login.memNo }" == null || "${login.memNo}" == ''){
		location.href = "${pageContext.request.contextPath }/startView?msg=none";
	}
	
	$(function(){
		let loginCheck = "${login.memNo }";
		console.log("loginCheck:",loginCheck);
		
		
		
		$(".category-M").each(function(){
			if($(this).data("catecode") == "${searchVO.searchCategory}"){
				$(this).addClass("cate-focus");
			}
		});
		
		$(".category-L").on("click", function(){
			let category = $(this).data("catecode");
			location.href= "${pageContext.request.contextPath }/mileageShopView?SearchCategory="+category;
		});
		
		$(".category-M").on("click", function(){
			let category = $(this).data("catecode");
			location.href= "${pageContext.request.contextPath }/mileageShopView?SearchCategory="+category;
		});
		
		let sf =$("form[name='search']");
		let curPage= sf.find("input[name='curPage']");
		let rowSizePerPage = sf.find("input[name='rowSizePerPage']");

		$('ul.pagination li a').click(function(e) {
			e.preventDefault();

			console.log($(this).data("curpage"));  
			curPage.val($(this).data("curpage")); 
			rowSizePerPage.val($(this).data("rowsizeperpage")); 
			
			sf.submit();
		});
		
		$("#productSearchBtn").on("click",function(){
			curPage = 1;
			
			sf.submit();
		});
		
		$(".prod_list").on("click", function(){
			let df = $("#detailForm");
			let prodNo = $(this).data("prodno");
			
			df.find("input[name=prodNo]").val(prodNo);
			df.submit();
		});
	});
</script>

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
                    <li class="breadcrumb-item text-primary active" aria-current="page">Mileage Shop</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- Team Start -->
    <div class="container-xxl py-5" style="max-width: 1800px; min-height: 1400px;">
	    <div class="row">
	        <div class="col-lg-3 col-md-4" style="position: relative; right: 0px; width: 350px">
	    		  <div id="category_div" class="w-100" style="padding : 5px; background-color: white; border:0.5px solid lightgray;  position: relative; top: 200px">
	           	  	<div class="categoryDiv-header">CATEGORY</div>
	           	  	<c:forEach items="${categoryLList }" var="categoryL" varStatus="i" begin="1" end="1" step="1">
	           	  		<div id="categoryDiv-list-L" class="card-body-div d-flex justify-content-center" style="margin-top:5px;margin-bottom:0;">
								<div class="category-L d-flex justify-content-center" data-cateCode="${categoryL.cateCode }">
									<p class="category-L-P" style="margin:0 auto; text-align: center;">${categoryL.cateName }</p>
								</div>
							</div>
							<div id="categoryDiv-list-M" class="card-body-div justify-content-center" style="margin-top:15px;margin-bottom:0;">
								<c:forEach items="${categoryMList }" var="categoryM">
									<c:if test="${categoryM.parentCode == categoryL.cateCode }">
											<div class="category-M d-flex justify-content-center" data-cateCode="${categoryM.cateCode }">
												<p class="category-M-P" style="margin:0 auto; text-align: center">${categoryM.cateName }</p>
											</div>
									</c:if>
								</c:forEach>
							</div>
	           	  	</c:forEach>
	            	</div>
	        </div>
	        <div class="col-lg-8 col-md-8" style="position: relative; left: 50px">
	            <!-- Your existing content goes here -->
			         <div class="container">
			            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
			                <h4 class="section-title">Mileage Shop</h4>
			                <h1 class="display-5 mb-4">사원 마일리지로 할인 받아 다양한 상품을 구매해보세요.</h1>
			            </div>
			            
			            <!-- -------------------------------------------Search Bar -------------------------------------- -->
			            <div id="searchBar" style="height:50px; padding-top:10px; color:black; font-size:20px; margin-bottom: 30px; text-align: right; background-color: var(--light)">
				        	<form name="search" action="${pageContext.request.contextPath }/mileageShopView" method="get">
					        	<input type="hidden" name="curPage" value="${searchVO.curPage}"> 
								<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage}">
								<input type="hidden" name="searchCategory" value="${searchVO.searchCategory}">
								
				        		<p style="float:left; margin-left: 20px">총 <span style="color:var(--primary)">${totalRowCount }</span>개의 상품이 있습니다.</p>
								정렬: <select name="searchOrder">
									<option value="">--선택--</option>
									<option value="B" ${searchVO.searchOrder eq 'B' ? "selected='selected'" : "" }>베스트상품순</option>
									<option value="H" ${searchVO.searchOrder eq 'H' ? "selected='selected'" : "" }>높은가격순</option>
									<option value="L" ${searchVO.searchOrder eq 'L' ? "selected='selected'" : "" }>낮은가격순</option>
								</select>
								&nbsp;&nbsp;
								검색어: <input type="text" style="width:130px" name="searchWord" value="${searchVO.searchWord }">
								&nbsp;&nbsp;
								<button id="productSearchBtn" type="button" style="width:60px">검색</button>
				        	</form>
		        		</div>
			            
			       <!-- -------------------------------------------Mileage Products -------------------------------------- -->
			            <div class="row g-0 team-items">
				       <form id="detailForm" action="${pageContext.request.contextPath }/mileageShopDetailView" style="display:none;">
				       	<input type="hidden" name="prodNo">
				       </form>
		            	<c:forEach items="${prodList }" var="prod">
			                <div class="col-lg-3 col-md-6 wow fadeInUp prod_list" data-wow-delay="0.1s" data-prodNo="${prod.prodNo }">
			                    <div class="team-item position-relative" style="height: 395px">
			                        <div class="position-relative">
			                            <img class="img-fluid" src="${prod.prodImgUrl }" alt="" style="width: 250px; height: 200px">
			                            <!-- <div class="team-social text-center">
			                                <a class="btn btn-square" href=""><i class="fab fa-facebook-f"></i></a>
			                                <a class="btn btn-square" href=""><i class="fab fa-twitter"></i></a>
			                                <a class="btn btn-square" href=""><i class="fab fa-instagram"></i></a>
			                            </div> -->
			                        </div>
			                        <div class="bg-light text-center p-4" style="height: 170px">
			                            <h3 class="mt-2 prodName">${prod.prodName }</h3>
			                            단위: <span class="text-primary">${prod.prodUnit }</span><br>
			                            가격: <span class="text-primary"><fmt:formatNumber value="${prod.prodPrice }" pattern="#,###,###"/></span>
			                        </div>
			                    </div>
			                </div>
		                </c:forEach>
		            </div>
		            <!-- Paging -->
		            <div class="wow fadeInUp" data-wow-delay="0.1s">
						<%@include file="/WEB-INF/include/paging.jsp" %>
		            </div>
		        </div>
	            <div class="container">
	                <!-- Rest of your content -->
	            </div>
	        </div>
	    </div>
	    
        
    </div>
    <!-- Team End -->
        

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
</body>

</html>