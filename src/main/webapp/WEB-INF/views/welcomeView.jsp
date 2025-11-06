<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>ACompany Welcome</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">
    
    <%@ include file="/WEB-INF/include/top.jsp" %>
    
	<script src="https://cdn.jsdelivr.net/npm/chart.js@4.3.3/dist/chart.umd.min.js"></script>
	
	<style type="text/css">
		.chartRank {
			width: 100%; 
			height: 398px;
		}
	</style>
	
</head>

<body>

<script type="text/javascript">
if("${login.memNo }" == null || "${login.memNo}" == ''){
	location.href = "${pageContext.request.contextPath }/startView?msg=none";
}

	  $(document).ready(function () {
	    fn_getLikeRank();
	    fn_getCarpoolRank();
	    fn_getShareRank();
	    fn_getSalesRank();
	  });
	  
	  Chart.defaults.font.size = 18;
	  
	  /* 영업실적 랭크 */
	  function fn_getSalesRank() {
			let saleCnt = [];
			let memNo = [];
			let colors = [];
			let borderColor = [];
			
			$.ajax({
				url: "<c:url value='/saleChart'/>",
				type: "GET",
				success: function (result) {
					console.log(result);
					for (let i = 0; i < result.length; i++) {
						memNo.push(result[i].memName);
						saleCnt.push(result[i].saleCnt);
						colors.push(fn_random_color() + ',0.3)');
						borderColor.push(colors[i].replace(",0.3)", ",1)"));
						}
					console.log("saleCnt", saleCnt);
					console.log("memNo", memNo);
					
					new Chart(document.getElementById("saleChart"), {
						type: "bar",
						data: {
							labels: memNo, // memNo가 레이블로 사용됩니다.
							datasets: [{
								data: saleCnt, // shareCnt가 데이터로 사용됩니다.
								label: "판매 횟수",
								backgroundColor: colors,
								borderColor : borderColor,
								borderWidth: 2,
								fill: false,
							}],
						},
						options:{
							plugins:{
								legend: {
									display: false
								},
							},
						},
					});
				},
				error: function () {
					// alert("실패");
				},
			}); // ajax
			
		}
	  
	  
	  // 나눔 Rank
	  function fn_getShareRank() {
			let shareCnt = [];
			let memNo = [];
			let colors = [];
			let borderColor = [];
			
			$.ajax({
				url: "<c:url value='/shareChart'/>",
				type: "GET",
				success: function (result) {
					console.log(result);
					for (let i = 0; i < result.length; i++) {
						memNo.push(result[i].memName);
						shareCnt.push(result[i].shCnt);
						colors.push(fn_random_color() + ',0.3)');
						borderColor.push(colors[i].replace(",0.3)", ",1)"));
						}
					console.log("shareCnt", shareCnt);
					console.log("memNo", memNo);
					
					new Chart(document.getElementById("shareChart"), {
						type: "bar",
						data: {
							labels: memNo, // memNo가 레이블로 사용됩니다.
							datasets: [{
								data: shareCnt, // shareCnt가 데이터로 사용됩니다.
								label: "나눔 횟수",
								backgroundColor: colors,
								borderColor : borderColor,
								borderWidth: 2,
								fill: false,
							}],
						},
						options:{
							plugins:{
								legend: {
									display: false
								},
							},
						},
					});
				},
				error: function () {
					// alert("실패");
				},
			}); // ajax
			
		}
		
		function fn_getCarpoolRank() {
			let carPoolCnt = [];
			let memNo = [];
			let colors = [];
			let borderColor = [];
			
			$.ajax({
				url: "<c:url value='/carPoolChart'/>",
				type: "GET",
				success: function (result) {
					console.log(result);
					for (let i = 0; i < result.length; i++) {
						memNo.push(result[i].memName);
						carPoolCnt.push(result[i].cpCnt);
						colors.push(fn_random_color() + ',0.3)');
						borderColor.push(colors[i].replace(",0.3)", ",1)"));
						}
					console.log("carPoolCnt", carPoolCnt);
					console.log("memNo", memNo);
					
					new Chart(document.getElementById("carPoolChart"), {
						type: "bar",
						data: {
							labels: memNo, // memNo가 레이블로 사용됩니다.
							datasets: [{
								data: carPoolCnt, // carPoolCnt가 데이터로 사용됩니다.
								label: "8월 카풀왕",
								backgroundColor: colors,
								borderColor : borderColor,
								borderWidth: 2,
								fill: false,
								},
								],
						},
						options:{
							plugins:{
								legend: {
									display: false
								},
							},
						},
					});
				},
				error: function () {
					// alert("실패");
				},
			}); // ajax
		} // fn_getLikeRank()
		
	// 소통 Rank
	  function fn_getLikeRank() {
	    let likeCnt = [];
	    let memNo = [];
	    let colors = [];
	    let borderColor = [];
	
	    $.ajax({
	      url: "<c:url value='/likeChart'/>",
	      type: "GET",
	      success: function (result) {
	        console.log(result);
	        for (let i = 0; i < result.length; i++) {
	          memNo.push(result[i].memName);
	          likeCnt.push(result[i].boardLike);
	          colors.push(fn_random_color() + ',0.3)');
	          borderColor.push(colors[i].replace(",0.3)", ",1)"));
	        }
	        console.log("likeCnt", likeCnt);
	        console.log("memNo", memNo);
	
	        new Chart(document.getElementById("likeChart"), {
	          type: "bar",
	          data: {
	            labels: memNo, // memNo가 레이블로 사용됩니다.
	            datasets: [{
	                data: likeCnt, // likeCnt가 데이터로 사용됩니다.
	                label: memNo,
	                backgroundColor: colors,
	                borderColor : borderColor,
	                borderWidth: 2,
	                fill: false,
	              },
	            ],
	          },
				options:{
					plugins:{
						legend: {
							display: false
						},
					},
				},
	        });
	      },
	      error: function () {
	      },
	    }); 
	  } // fn_getLikeRank()
	  
		function fn_random_color(){
		  let R = Math.floor(Math.random() * (255 + 1));
		  let G = Math.floor(Math.random() * (255 + 1));
		  let B = Math.floor(Math.random() * (255 + 1));
		  let str = 'rgba('+R+','+G+','+B+'';
		  return str;
		}
</script>

    <!-- Carousel Start -->
    <div class="container-fluid p-0 wow fadeIn" data-wow-delay="0.1s">
        <div id="header-carousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="w-100" src="img/finance.jpg" alt="Image" style="width: 1200px; height: 1000px">
                    <div class="carousel-caption" style="bottom: 25rem;">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <h1 class="display-1 text-white mb-5 animated slideInDown">Innovating Together, Always</h1>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="w-100" src="img/macbook.jpg" alt="Image" style="width: 1200px; height: 1000px">
                    <div class="carousel-caption" style="bottom: 25rem;">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-7">
                                    <h1 class="display-1 text-white mb-5 animated slideInDown">Where Vision Meets Achievement</h1>
                                    <a id="scrollLink" href="#scroll-target" class="btn btn-primary py-sm-3 px-sm-4">Explore More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#header-carousel"
                data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#header-carousel"
                data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
    <!-- Carousel End -->

    
<!-- Project Start -->
    <div id="scroll-target" class="container-xxl project py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <h4 class="section-title">Our Projects</h4>
                <h1 class="display-5 mb-4">ACompany Rank</h1>
            </div>
            <div class="row g-4 wow fadeInUp" data-wow-delay="0.3s">
                <div class="col-lg-3">
                    <div class="nav nav-pills d-flex justify-content-between w-100 h-100 me-4">
                        <button class="nav-link w-100 d-flex align-items-center text-start p-4 mb-4 active" data-bs-toggle="pill" data-bs-target="#tab-pane-1" type="button">
                            <h3 class="m-0">01. 소통</h3>
                        </button>
                        <button class="nav-link w-100 d-flex align-items-center text-start p-4 mb-4" data-bs-toggle="pill" data-bs-target="#tab-pane-2" type="button">
                            <h3 class="m-0">02. 카풀</h3>
                        </button>
                        <button class="nav-link w-100 d-flex align-items-center text-start p-4 mb-4" data-bs-toggle="pill" data-bs-target="#tab-pane-3" type="button">
                            <h3 class="m-0">03. 나눔</h3>
                        </button>
                        <button class="nav-link w-100 d-flex align-items-center text-start p-4 mb-0" data-bs-toggle="pill" data-bs-target="#tab-pane-4" type="button">
                            <h3 class="m-0">04. 영업</h3>
                        </button>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="tab-content w-100">
                        <div class="tab-pane fade show active" id="tab-pane-1">
                        	<h5 style="text-align: center;">이달의 게시판(게시글) 좋아요</h5>
							<canvas class="chartRank" id="likeChart"></canvas>
                        </div>
                        <div class="tab-pane fade" id="tab-pane-2">
                        	<h5 style="text-align: center;">이달의 카풀</h5>
							<canvas class="chartRank" id="carPoolChart"></canvas>
                        </div>
                        <div class="tab-pane fade" id="tab-pane-3">
                        	<h5 style="text-align: center;">이달의 나눔</h5>
							<canvas class="chartRank" id="shareChart"></canvas>
                        </div>
                        <div class="tab-pane fade" id="tab-pane-4">
                        	<h5 style="text-align: center;">이달의 영업실적</h5>
							<canvas class="chartRank" id="saleChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Project End -->


    <!-- Team Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <h4 class="section-title">Team B : THE Company</h4>
                <h1 class="display-5 mb-4">Introducing our Team Members</h1>
            </div>
            <div class="row g-0 team-items">
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="team-item position-relative">
                        <div class="position-relative">
                        	<c:if test="${likeRanker.atchNo != 0 }">
                            <img class="img-fluid" src="<c:url value='/image/${likeRanker.atchNo } '/>" alt="">
                            </c:if>
                        	<c:if test="${likeRanker.atchNo == 0 }">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/base_img.png" alt="기본프로필" />
                            </c:if>
                        </div>
                        <div class="bg-light text-center p-4">
                            <h3 class="mt-2">${likeRanker.memName }</h3>
                            <span class="text-primary">소통 우수사원</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                    <div class="team-item position-relative">
                        <div class="position-relative">
                        	<c:if test="${carpoolRanker.atchNo != 0 }">
                            <img class="img-fluid" src="<c:url value='/image/${carpoolRanker.atchNo } '/>" alt="">
                            </c:if>
                        	<c:if test="${carpoolRanker.atchNo == 0 }">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/base_img.png" alt="기본프로필" />
                            </c:if>
                        </div>
                        <div class="bg-light text-center p-4">
                            <h3 class="mt-2">${carpoolRanker.memName }</h3>
                            <span class="text-primary">카풀 우수사원</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                    <div class="team-item position-relative">
                        <div class="position-relative">
                        	<c:if test="${shareRanker.atchNo != 0 }">
                            <img class="img-fluid" src="<c:url value='/image/${shareRanker.atchNo } '/>" alt="">
                            </c:if>
                        	<c:if test="${shareRanker.atchNo == 0 }">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/base_img.png" alt="기본프로필" />
                            </c:if>
                        </div>
                        <div class="bg-light text-center p-4">
                            <h3 class="mt-2">${shareRanker.memName }</h3>
                            <span class="text-primary">나눔 우수사원</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.7s">
                    <div class="team-item position-relative">
                        <div class="position-relative">
                        	<c:if test="${saleRanker.atchNo != 0 }">
                            <img class="img-fluid" src="<c:url value='/image/${saleRanker.atchNo } '/>" alt="">
                            </c:if>
                        	<c:if test="${saleRanker.atchNo == 0 }">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/base_img.png" alt="기본프로필" />
                            </c:if>
                        </div>
                        <div class="bg-light text-center p-4">
                            <h3 class="mt-2">${saleRanker.memName }</h3>
                            <span class="text-primary">영업 우수사원</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Team End -->

    <!-- Footer Start -->
    <div class="container-fluid bg-dark text-light footer mt-5 py-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <h4 class="text-white mb-4">Our Office</h4>
                    <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                    <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                    <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                    <div class="d-flex pt-2">
                        <a class="btn btn-square btn-outline-light rounded-circle me-2" href=""><i class="fab fa-twitter"></i></a>
                        <a class="btn btn-square btn-outline-light rounded-circle me-2" href=""><i class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-square btn-outline-light rounded-circle me-2" href=""><i class="fab fa-youtube"></i></a>
                        <a class="btn btn-square btn-outline-light rounded-circle me-2" href=""><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h4 class="text-white mb-4">Services</h4>
                    <a class="btn btn-link" href="">Landscaping</a>
                    <a class="btn btn-link" href="">Pruning plants</a>
                    <a class="btn btn-link" href="">Urban Gardening</a>
                    <a class="btn btn-link" href="">Garden Maintenance</a>
                    <a class="btn btn-link" href="">Green Technology</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h4 class="text-white mb-4">Quick Links</h4>
                    <a class="btn btn-link" href="">About Us</a>
                    <a class="btn btn-link" href="">Contact Us</a>
                    <a class="btn btn-link" href="">Our Services</a>
                    <a class="btn btn-link" href="">Terms & Condition</a>
                    <a class="btn btn-link" href="">Support</a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h4 class="text-white mb-4">Newsletter</h4>
                    <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                    <div class="position-relative w-100">
                        <input class="form-control bg-light border-light w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                        <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->


    <!-- Copyright Start -->
    <div class="container-fluid copyright py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    &copy; <a class="border-bottom" href="#">Your Site Name</a>, All Right Reserved.
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                    Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a> Distributed By <a href="https://themewagon.com">ThemeWagon</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Copyright End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>
    <script src="lib/parallax/parallax.min.js"></script>
    <script src="lib/isotope/isotope.pkgd.min.js"></script>
    <script src="lib/lightbox/js/lightbox.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    <script type="text/javascript">
	    document.getElementById('scrollLink').addEventListener('click', function(event) {
	        event.preventDefault(); // 기본 링크 동작 방지
	
	        var targetElement = document.getElementById('scroll-target');
	        var targetPosition = targetElement.offsetTop - 80; // 목표 위치보다 200px 위로
	
	        window.scrollTo({
	            top: targetPosition,
	            behavior: 'smooth' // 스무스한 스크롤 적용
	        });
	    });
    </script>
    
</body>

</html>
