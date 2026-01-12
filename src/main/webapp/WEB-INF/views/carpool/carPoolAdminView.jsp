<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>ACompany CarPool</title>
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
    
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    
</head>
<script>
if("${login.memNo }" == null || "${login.memNo}" == ''){
	location.href = "${pageContext.request.contextPath }/startView?msg=none";
}

	$(function(){
		let check = $("#check").val();
		
		if(check == 'delete'){
			alert("카풀을 삭제했습니다.");
		}else if(check == 'dfail'){
			alert("카풀 삭제에 실패했습니다. 전산실에 문의해주세요. 010-7358-4002");
		}
		
		
		
	});
</script>
<body>
	<input type="hidden" id="check" value="${msg }">

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
            <h1 class="display-1 text-white animated slideInDown">CarPool</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb text-uppercase mb-0">
                    <li class="breadcrumb-item"><a class="text-white" href="#">CarPool</a></li>
                    <li class="breadcrumb-item text-primary active" aria-current="page">카풀 관리</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- Project Start -->
    <div class="container-xxl project py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <h4 class="section-title">Car Pool Management</h4>
                <h1 class="display-5 mb-4">가까운 거리의 사원들과 함께 출/퇴근 해보세요.</h1>
                <div>
                </div>
            </div>
            <div class="row g-4 wow fadeInUp" style="position:relative; height: 800px" data-wow-delay="0.3s">
            
            <div id="map" style="width:100%; height:550px; position:absolute; z-index:1"></div>
            <div class="col-lg-3" style="padding-left: 0; position:relative; left:15px; top:15px; z-index:2">
	            	<div class="w-100" style="padding : 5px; background-color: white; border:0.5px solid lightgray; border-bottom:none; opacity: 0.8">
	           	  	<div class="carPoolList-header">LIST</div>
						<div id="carPoolGoOutDiv" class="card-body-div d-flex justify-content-center" style="margin-top:5px;margin-bottom:0;">
							 	 <button type="button" id="carPoolGoBtn" class="btn btn-primary mybtn goOutBtn" disabled>출근</button>
							 	 <button type="button" id="carPoolOutBtn" class="btn btn-outline-primary mybtn goOutBtn">퇴근</button>
						</div>
	           	  	<div class="carPoolList-search">
							 주소: &nbsp;&nbsp;<input id="carPoolSearchWord" type="text" placeholder="">&nbsp;<button id="carPoolSearchBtn" style="margin-left:5px" type="button">검색</button>
						</div>
	            	</div>
                 	<input type="hidden" id="cpPassDriver" name="cpPassDriver" value="P">
                <div class="w-100" id="carPoolList" style="">
                   	<c:forEach items="${carPoolList }" var="carPool"> <!-- 5개의 카풀 -->
			                   <div class="carPool" data-cpNo="${carPool.cpNo }" data-lat="${carPool.cpLocLat }" data-lng="${carPool.cpLocLng }" data-goOut="${carPool.cpGoOut }" data-cpLoc="${carPool.cpLoc }" data-cpRoadLoc="${carPool.cpRoadLoc }">
			                   	<h3 id="cpMemNo" style="display:none;">${carPool.memNo }</h3>
			                   	<h3>${fn:substring(carPool.cpRunDate, 0, 16)}</h3>
			                   		주소 : <p id="cpLoc" style="display:inline">${carPool.cpLoc }</p><br>
			                   		인원 : <p id="cpPass" style="display:inline">${carPool.cpTakePass }</p>/<p id="cpTotalPass" style="display:inline">${carPool.cpTotalPass }</p>
			                   </div>
                   	</c:forEach>
                </div>
            </div>
            <div class="col-lg-6">
            </div>
			  <div class="col-lg-3" style="position:relative; top:15px; right:15px; z-index:2;">
	                  <div class="tab-content w-100">
	                      <div class="tab-pane fade show active">
	                          <div class="row g-4">
	                              <div class="col-md-12 card border-info" style="height:520px;">
										  <div class="card-header">CAR POOL</div>
										  <div id="carPoolGoOutDiv" class="d-flex justify-content-center" style="margin-top:8px;margin-bottom:13px;">
											 	 <button type="button" id="carPoolGoBtn" class="btn btn-primary mybtn goOutBtn" disabled>출근</button>
											 	 <button type="button" id="carPoolOutBtn" class="btn btn-outline-primary mybtn goOutBtn" disabled>퇴근</button>
									      </div>
										  <div class="card-body" style="height: 100%; padding-top:0px">
											  <div class="card-body-div hidden-form">
											    <h5 class="card-title">카풀 번호 : </h5>
											    <form id="applyForm" method="post" action="">
											    	<input type="text" class="card-text" id="cpNo" name="cpNo" value="" readonly><br>
											    	<input type="hidden" id="cpDriver" name="driver" value="">
											    	<input type="hidden" name=location value="">
											    </form>
											  </div>
											  <div class="card-body-div" style="margin-bottom:0px">
											    <h5 class="card-title">날짜 : </h5>
											    <p class="card-text" id="cpRunDate"></p><br>
											  </div>
											  <div id="cpArrTimeDiv" style="color:gray">( 거리/도착시간 : <input id="cpDistance" name="cpDistance" class="card-input" value="" style="color:gray" readonly> / <input class="card-input" id="cpArrTime" name="cpArrTime" type="time" style="color:gray" readonly>)</div>
											  <div class="card-body-div" style="margin-top:10px; margin-bottom:0px">
											    <h5 class="card-title">장소 : </h5>
											    <p class="card-text" id="cpLocInfo"></p><br>
											  </div>
											  <div id="cpLocDiv" style="color:gray">( 도로명 : <input class="card-input" id="cpRoadLoc" name="cpRoadLoc" style="background-color: white; color: gray" value="" readonly> )</div>
											  <div class="card-body-div" style="margin-top:10px">
											    <h5 class="card-title">차량 : </h5>
											    <p class="card-text" id="carNo"></p><br>
											    ( <p class="card-text" id="carColor"></p> / <p class="card-text" id="carModel"></p> )<br>
											  </div>
											  <div class="card-body-div">
											    <h5 class="card-title">인원 </h5>( <p class="card-text" id="cpTakePass"></p> / <p class="card-text" id="cpTotalPassInfo"></p> )<br>
											    <div class="pass-container container" id="passContainer">
											    	<!-- 카풀 탑승자 목록 출력 위치 -->
											    </div>
											  </div>
											  <div id="carPoolBtnDiv" class="card-body-div d-flex justify-content-center" style="margin-top:15px;margin-bottom:0;">
											 	 <button type="button" id="carPoolApplyBtn" class="btn btn-outline-primary mybtn">신청하기</button>
											 	 <button type="button" style="display:none;" id="carPoolCancelBtn" class="btn btn-outline-primary mybtn">취소하기</button>
											 	 <button type="button" style="display:none;" id="carPoolDeleteBtn" class="btn btn-outline-primary mybtn">삭제하기</button>
											 	 <div id="carPoolNotice" style="display:none;">신청 마감되었습니다.</div>
											  </div>
										  </div>
										</div>
	                          </div>
	                      </div>
	                  </div>
	          </div>
        </div>
        <div class="container">
	        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
	                <h4 class="section-title">Car Pool Log</h4>
	                <h1 class="display-5 mb-4">카풀 운행 기록</h1>
	        </div>
	        <div class="row g-4 wow fadeInUp" style="position:relative;" data-wow-delay="0.3s">
		        <div class="col-lg-12">
		        	<form id="cpStateChangeForm" action="" method="post" style="display:none">
		        		<input type="text" name="cpNo">
		        		<input type="text" name="cpState">
		        		<input type="text" name="memNo">
		        	</form>
		        	<div id="searchBar" style="padding-left:0px; padding-right:0px; color:black; font-size:20px; margin-bottom: 10px">
			        	<form name="search" action="${pageContext.request.contextPath }/carPoolAdminView" method="get">
			        		<input type="hidden" name="curPage" value="${searchVO.curPage}"> 
							<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage}">
							날짜: <input type="date" id="date1" name="startDate" value="${searchVO.startDate }"> ~ <input type="date" id="date2" name="endDate" value="${searchVO.endDate }">
							&nbsp;&nbsp;
							출/퇴근: <select name="cpGoOut">
								<option value="">--선택--</option>
								<option value="G" ${searchVO.cpGoOut eq 'G' ? "selected='selected'" : "" }>출근</option>
								<option value="O" ${searchVO.cpGoOut eq 'O' ? "selected='selected'" : "" }>퇴근</option>
							</select>
							&nbsp;&nbsp;
							운행상태: <select name="cpState">
								<option value="">--선택--</option>
								<option value="P" ${searchVO.cpState eq 'P' ? "selected='selected'" : "" }>운행중</option>
								<option value="C" ${searchVO.cpState eq 'C' ? "selected='selected'" : "" }>완료대기</option>
								<option value="S" ${searchVO.cpState eq 'S' ? "selected='selected'" : "" }>운행완료</option>
								<option value="F" ${searchVO.cpState eq 'F' ? "selected='selected'" : "" }>운행실패</option>
							</select>
							&nbsp;&nbsp;
							검색항목: <select name="searchCategory">
									<option value="">--선택--</option>
									<option value="L" ${searchVO.searchCategory eq 'L' ? "selected='selected'" : "" }>출발/도착지</option>
									<option value="D" ${searchVO.searchCategory eq 'D' ? "selected='selected'" : "" }>운전자</option>
									<option value="N" ${searchVO.searchCategory eq 'N' ? "selected='selected'" : "" }>차량번호</option>
							</select>
							&nbsp;&nbsp;
							검색어: <input type="text" style="width:130px" name="searchWord" value="${searchVO.searchWord }">
							&nbsp;&nbsp;
							<button id="carPoolLogSearchBtn" type="button" style="width:60px">검색</button>
			        	</form>
		        	</div>
			        <table style="background-color: var(--light); border: 1px solid black; padding: 15px 15px 15px 15px; text-align: center">
				        <colgroup>
						    <col width="150px" />
						    <col width="170px" />
						    <col width="170px" />
						    <col width="120px" />
						    <col width="220px" />
						    <col width="120px" />
						    <col width="170px" />
						    <col width="120px" />
						    <col width="150px" />
						  </colgroup>
						  <thead>
						    <tr>
						      <th>등록일</th>
						      <th>운행일</th>
						      <th>카풀 넘버</th>
						      <th>출/퇴근</th>
						      <th>출발/도착지</th>
						      <th>운전자</th>
						      <th>차량번호</th>
						      <th>상세보기</th>
						      <th>상태</th>
						    </tr>
						  </thead>
						  <tbody>
							  <c:forEach items="${carPoolLogList }" var="carPool" >
								    <tr>
								      <td>${carPool.cpRegDate }</td>
								      <td>${carPool.cpRunDate } ${carPool.cpRunTime }</td>
								      <td class="logCpNo">${carPool.cpNo }</td>
								      <td>
											<c:choose>
												<c:when test="${carPool.cpGoOut eq 'G' }">
													출근
												</c:when>
												<c:when test="${carPool.cpGoOut eq 'O' }">
													퇴근
												</c:when>
											</c:choose>
											<%-- ${carPool.cpRNum } --%>
									   </td>
								      <td>${carPool.cpLoc }</td>
								      <td>${carPool.driver }</td>
								      <td>${carPool.carNo }</td>
								      <td><button type="button" class="btn btn-outline-primary carPoolDetailBtn" data-cpNo="${carPool.cpNo }" data-bs-toggle="modal" data-bs-target="#exampleModal">상세보기</button></td>
								      <td>
								      		<c:choose>
								      			<c:when test="${carPool.cpState eq 'P' }">
											      	운행중
								      			</c:when>
								      			<c:when test="${carPool.cpState eq 'C' }">
							      					완료대기
								      			</c:when>
								      			<c:when test="${carPool.cpState eq 'S' }">
								      				운행완료
								      			</c:when>
								      			<c:when test="${carPool.cpState eq 'F' }">
								      				운행실패
								      			</c:when>
								      		</c:choose>
								      		
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
    </div>
    <!-- Project End -->
        

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
    
    <!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">CarPool Detail</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <div class="col-md-12 card border-info" style="height:520px;">
										  <div class="card-header">CAR POOL</div>
										  <div id="carPoolGoOutDivModal" class="d-flex justify-content-center" style="margin-top:8px;margin-bottom:13px;">
											 	 <button type="button" id="carPoolGoBtnModal" class="btn btn-primary mybtn goOutBtn" disabled>출근</button>
											 	 <button type="button" id="carPoolOutBtnModal" class="btn btn-outline-primary mybtn goOutBtn" disabled>퇴근</button>
									      </div>
										  <div class="card-body" style="height: 100%; padding-top:0px">
											  <div class="card-body-div hidden-form">
											    <h5 class="card-title">카풀 번호 : </h5>
											    <form id="applyFormModal" method="post" action="">
											    	<input type="text" class="card-text" id="cpNoModal" name="cpNo" value="" readonly><br>
											    </form>
											  </div>
											  <div class="card-body-div" style="margin-bottom:0px">
											    <h5 class="card-title">날짜 : </h5>
											    <p class="card-text" id="cpRunDateModal"></p><br>
											  </div>
											  <div id="cpArrTimeDivModal" style="color:gray">( 거리/도착시간 : <input id="cpDistanceModal" name="cpDistance" class="card-input" value="" style="color:gray" readonly> / <input class="card-input" id="cpArrTimeModal" name="cpArrTime" type="time" style="color:gray" readonly>)</div>
											  <div class="card-body-div" style="margin-top:10px; margin-bottom:0px">
											    <h5 class="card-title">장소 : </h5>
											    <p class="card-text" id="cpLocInfoModal"></p><br>
											  </div>
											  <div id="cpLocDivModal" style="color:gray">( 도로명 : <input class="card-input" id="cpRoadLocModal" name="cpRoadLoc" style="background-color: white; color: gray" value="" readonly> )</div>
											  <div class="card-body-div" style="margin-top:10px">
											    <h5 class="card-title">차량 : </h5>
											    <p class="card-text" id="carNoModal"></p><br>
											    ( <p class="card-text" id="carColorModal"></p> / <p class="card-text" id="carModelModal"></p> )<br>
											  </div>
											  <div class="card-body-div">
											    <h5 class="card-title">인원 </h5>( <p class="card-text" id="cpTakePassModal"></p> / <p class="card-text" id="cpTotalPassInfoModal"></p> )<br>
											    <div class="pass-container container" id="passContainerModal">
											    	<!-- 카풀 탑승자 목록 출력 위치 -->
											    </div>
											  </div>
											  <div id="carPoolBtnDivModal" class="card-body-div d-flex justify-content-center" style="margin-top:15px;margin-bottom:0;">
											 	<!--  <button type="button" id="carPoolApplyBtn" class="btn btn-outline-primary mybtn">신청하기</button>
											 	 <button type="button" style="display:none;" id="carPoolCancelBtn" class="btn btn-outline-primary mybtn">취소하기</button>
											 	 <button type="button" style="display:none;" id="carPoolDeleteBtn" class="btn btn-outline-primary mybtn">삭제하기</button>
											 	 <div id="carPoolNotice" style="display:none;">신청 마감되었습니다.</div> -->
											  </div>
										  </div>
										</div>
	      </div>
	      <div class="modal-footer">
	        <!-- <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button> -->
	      </div>
	    </div>
	  </div>
	</div>


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
    
    <!-- JavaScript CarPool -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=43b97ae5d04bed8b63d4d8471ecc1c27&libraries=services"></script>
	
	<!-- 지도 컨트롤에 대한 부분 -->
	<script>
	$(function(){
		
		let carPoolElements = $("#carPoolList").find(".carPool");
		if(carPoolElements.length <= 0){
			console.log("null");
			$("#carPoolList").html("<p id='empty' style='color:gray; text-align: center; margin-top: 50%;'>등록된 차량이 없습니다.</p>");
		}

		var address = "${member.memAdd}"; // 로그인한 회원의 주소 가져오기  (초기 지도 세팅)
		var company = "대전광역시 중구 계룡로 825";

		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		console.log("map :",map);
	
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		let bounds = new kakao.maps.LatLngBounds();
 		
		var markerG = new kakao.maps.Marker;
		var markerC = new kakao.maps.Marker;
		// 주소로 회원의 집 좌표를 검색합니다
		geocoder.addressSearch(address, function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				 console.log("coords:",coords);
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        markerG.setMap(map);
		        markerG.setPosition(coords);
 				 console.log("markerG:",markerG.getPosition());
		        bounds.extend(markerG.getPosition());
 				 console.log("bounds:",bounds);
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">회원의 집</div>'
		        });
		        infowindow.open(map, markerG);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		        
		       
		     	// 마커에 클릭이벤트를 등록합니다
		        kakao.maps.event.addListener(markerG, 'click', function() {
		              // 마커 위에 인포윈도우를 표시합니다
		              map.panTo(markerG.getPosition());
		        });
  				
				map.setBounds(bounds);
		    } 
		});   
		
		
        let coordsC = new kakao.maps.LatLng("36.32662677028527","127.40775961305604");
        // 결과값으로 받은 위치를 마커로 표시합니다
        markerC.setMap(map);
        markerC.setPosition(coordsC);

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">회사</div>'
        });
        infowindow.open(map, markerC);
        
     	// 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(markerC, 'click', function() {
              // 마커 위에 인포윈도우를 표시합니다
              map.panTo(markerC.getPosition());
        });


	        
		
		var markers= [];
		
		function removeMarker() {
    	    for ( var i = 0; i < markers.length; i++ ) {
    	        markers[i].setMap(null);
    	    }   
    	    markers = [];
    	}
		
		// "마커 보이기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에 표시하는 함수입니다
		function showMarkers() {
		    setMarkers(map)    
		}

		// "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
		function hideMarkers() {
		    setMarkers(null);    
		}
		
		
		function fn_mark(){
			// CarPool 목록의 위치를 마커 표시
			
			 let loc = $(this).children("#cpLoc").html();
			 let lat = $(this).data('lat');
			 let lng = $(this).data('lng');

			
		    var imageSrc = '${pageContext.request.contextPath}/img/carmarker.png', // 마커이미지의 주소입니다    
		     imageSize = new kakao.maps.Size(40, 45), // 마커이미지의 크기입니다
		     imageOption = {offset: new kakao.maps.Point(20, 45)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		      
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			 var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		
	        var coords = new kakao.maps.LatLng(lat, lng);
	         // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	            image: markerImage
	        });
	       markers.push(marker);
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	     //    var infowindow = new kakao.maps.InfoWindow({
	      //     content: '<div style="width:150px;text-align:center;padding:6px 0;">'+loc+'</div>'
	       // });
	       // infowindow.open(map, marker); 
	        
	     // 마커에 클릭이벤트를 등록합니다
	        kakao.maps.event.addListener(marker, 'click', function() {
	              // 마커 위에 인포윈도우를 표시합니다
	              $("#carPoolList").children()[markers.indexOf(marker)].click();
	              map.panTo(marker.getPosition());
	        });
	     
	        /* GoOut 마커 숨기기*/
	     	if($(this).data('goout') != 'G'){
	     		let arr = $(this).parent().children();
	     		$(this).hide();
				markers[arr.index($(this))].setMap(null);
	     	}
	     	
		}
		
		if(carPoolElements.length > 0){
			$("#carPoolList").children().each(fn_mark);
		}
		

		function searchAddrFromCoords(coords, callback) {
		    // 좌표로 행정동 주소 정보를 요청합니다
		    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
		}
	
		function searchDetailAddrFromCoords(coords, callback) {
		    // 좌표로 법정동 상세 주소 정보를 요청합니다
		    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}
    	
		let goBtn = $("#carPoolGoBtn");
		let outBtn = $("#carPoolOutBtn");
		
    	function fn_carPoolClick(){
    	
	    	let arr = $(this).parent().children();
			map.panTo(markers[arr.index($(this))].getPosition());
			
			$(this).parent().children(".carPool-active").children(".text-active").removeClass('text-active');
			$(this).parent().children(".carPool-active").removeClass('carPool-active');
			$(this).addClass('carPool-active');
			$(this).children("h3").addClass('text-active');
			$(this).children("p").addClass('text-active');
			
			let cpNo = $(this).data("cpno");
			
			
			$.ajax({
				url:'${pageContext.request.contextPath }/carPoolDetail'
				, method: "POST"
				, data: {
					cpNo: cpNo
				}
				, success:function(carPool){
					
					
					
					$("#cpNo").val(carPool.cpNo);
					$("#cpRunDate").html(carPool.cpRunDate);
					$("#cpArrTime").val(carPool.cpArrTime);
					$("#cpLocInfo").html(carPool.cpLoc);
					$("#cpRoadLoc").val(carPool.cpRoadLoc);
					$("#carNo").html(carPool.carNo);
					$("#carColor").html(carPool.carVO.carColor);
					$("#carModel").html(carPool.carVO.carModel);
					$("#cpTakePass").html(carPool.cpTakePass);
					$("#cpTotalPassInfo").html(carPool.cpTotalPass);
					$("#cpDistance").val(carPool.cpDistance + " km");
					$("#passContainer").html("");
					$("#cpDriver").val(carPool.memNo);
					
					
					for(var i = 0 ; i < carPool.passList.length; i++){
						if(carPool.passList[i].memNo == carPool.memNo){
							var passDiv= '<div class="pass-div row driver">'
					    		+	'<div style="padding-left:5px; padding-top:5px" class="pass-img col-3"><img style="width:50px; height:50px;" alt="" src="${pageContext.request.contextPath }/img/base_img.png"></div>'
						    	+	'<div class="pass-text col-9" style="padding-top:4px">'
						    	+	'<p style="font-size:15px; display:inline-block; margin-bottom:3px">'+ carPool.passList[i].memTeam + "  " + carPool.passList[i].memName + '&nbsp;&nbsp;' + "(" + carPool.passList[i].memAge + "/" + "남" + ")</p><br>"
						    	+		carPool.passList[i].memPhone
						    	+	'</div>'
					    		+'</div>';
								$("#passContainer").html(passDiv + $("#passContainer").html());
						}else{
							var passDiv= '<div class="pass-div row">'
					    		+	'<div style="padding-left:5px; padding-top:5px" class="pass-img col-3"><img style="width:50px; height:50px;" alt="" src="${pageContext.request.contextPath }/img/base_img.png"></div>'
						    	+	'<div class="pass-text col-9" style="padding-top:4px">'
						    	+	'<p style="font-size:15px; display:inline-block; margin-bottom:3px;">'+ carPool.passList[i].memTeam + "  " + carPool.passList[i].memName + '&nbsp;&nbsp;' + "(" + carPool.passList[i].memAge + "/" + "남" + ")</p><br>"
						    	+		carPool.passList[i].memPhone
						    	+	'</div>'
					    		+'</div>';
								$("#passContainer").html($("#passContainer").html()+passDiv);
						}	
					};
					
					$("#carPoolBtnDiv").children().hide();
					$("#carPoolApplyBtn").show();
					
					if(carPool.cpTotalPass <= carPool.cpTakePass){
						$("#carPoolBtnDiv").children().hide();
						$("#carPoolNotice").show();	
					}
					
					$("#carPoolBtnDiv").children().hide();
					$("#carPoolDeleteBtn").show();
					
					if(carPool.cpGoOut == "G"){
						console.log("cpGoOut:", carPool.cpGoOut)
						goBtn.removeClass("btn-outline-primary");
						goBtn.addClass("btn-primary");
						
						outBtn.removeClass("btn-primary");
						outBtn.addClass("btn-outline-primary");
					}else{
						console.log("cpGoOut:", carPool.cpGoOut)
						outBtn.removeClass("btn-outline-primary");
						outBtn.addClass("btn-primary");
			
						goBtn.removeClass("btn-primary");
						goBtn.addClass("btn-outline-primary");
					}
					
					
				}
				, error: function(error){
					alert("카풀 정보를 불러올 수 없습니다. 전산실에 문의해주세요. 010-7358-4002");
				}
			});
    	}
    	if(carPoolElements.length > 0){
	    	$(".carPool").on("click", fn_carPoolClick);
		}
		
		$("#carPoolApplyBtn").on('click', function(){
			var cpNo = $("#cpNo").val();
			if(cpNo == null || cpNo ==""){
				alert("카풀을 선택해주세요.");
				return;
			}
			
			if (!confirm("카풀을 신청하시겠습니까?")) {
		        // 취소(아니오) 버튼 클릭 시 이벤트
		        return;
		    } else {
		        // 확인(예) 버튼 클릭 시 이벤트
				let applyForm = $("#applyForm");
				applyForm.attr("action", "${pageContext.request.contextPath }/carPoolApply");
				applyForm.submit();
		    }
		});
		
		$("#carPoolCancelBtn").on('click', function(){
			
			if (!confirm("해당 카풀을 취소하시겠습니까?")) {
		        // 취소(아니오) 버튼 클릭 시 이벤트
		        return;
		    } else {
		        // 확인(예) 버튼 클릭 시 이벤트
				let applyForm = $("#applyForm");
		       let location = applyForm.find("input[name='location']");
		       location.val("my");
				applyForm.attr("action", "${pageContext.request.contextPath }/carPoolCancel");
				applyForm.submit();
		    }
			
		});
		
		$("#carPoolDeleteBtn").on('click', function(){
			if (!confirm("해당 카풀을 삭제하시겠습니까?")) {
		        // 취소(아니오) 버튼 클릭 시 이벤트
		        return;
		    } else {
		        // 확인(예) 버튼 클릭 시 이벤트
				let applyForm = $("#applyForm");
		       let location = applyForm.find("input[name='location']");
		       location.val("my");
				applyForm.attr("action", "${pageContext.request.contextPath }/carPoolDeleteAdmin");
				applyForm.submit();
		    }
		});
		
		
		function fn_myApply(){
			
			$.ajax({
				url: "${pageContext.request.contextPath }/getMyApplyList"
				, type: "post"
				, data: {
					memNo: "${login.memNo}"
				}
				, success: function(myApplyList){
					var carPoolList = $(".carPool");
					console.log(myApplyList);
					console.log(carPoolList);
					
					
					for(let i = 0 ; i < myApplyList.length; i++){
						for(let j = 0 ; j < carPoolList.length; j++){
							if(carPoolList[j].dataset.cpno == myApplyList[i]){
								console.log("myApply carPool:", carPoolList[j]);
								carPoolList[j].classList.add("myApply");
							}
						}
					}
				}
				, error: function(error){
					alert("에러");
				}
			});
		}
		
		fn_myApply();

		$("#carPoolSearchWord").on('keyup', function(key){
			if(key.keyCode === 13){
				$("#carPoolSearchBtn").click();
			}
		})

		$("#carPoolSearchBtn").on('click', function(){
			
			let word = $("#carPoolSearchWord").val();
			let cpPassDriver = $("#cpPassDriver").val();
			console.log("cpPassDriver:", cpPassDriver);
			
			let listDiv = $("#carPoolList");
			let carPoolList = $("#carPoolList").children().toArray();
			
			if(cpPassDriver == "P"){
				for(let i = 0 ; i < carPoolList.length; i++){
					if($(carPoolList[i]).find("#cpMemNo").html() != "${member.memNo}"){
						if(($(carPoolList[i]).data('cploc').indexOf(word) != -1) || ($(carPoolList[i]).data('cproadloc').indexOf(word) != -1)){
							$(carPoolList[i]).show();
							markers[i].setMap(map);
						}else{
							$(carPoolList[i]).hide();
							markers[i].setMap(null);
						}
					}
				}
			}else{
				for(let i = 0 ; i < carPoolList.length; i++){
					if($(carPoolList[i]).find("#cpMemNo").html() == "${member.memNo}"){
						if(($(carPoolList[i]).data('cploc').indexOf(word) != -1) || ($(carPoolList[i]).data('cproadloc').indexOf(word) != -1)){
							$(carPoolList[i]).show();
							markers[i].setMap(map);
						}else{
							$(carPoolList[i]).hide();
							markers[i].setMap(null);
						}
					}
				}
			}
			
			/*
			$.ajax({
				url: "${pageContext.request.contextPath }/carPoolSearch"
				, type : "get"
				, data : {
					word : word
					, cpGoOut : cpGoOut
				}
				, success : function(carPoolList){
					let listDiv = $("#carPoolList");
					listDiv.empty();
					
					for(let i = 0 ; i < carPoolList.length; i++){
						
						let listEl = '<div class="carPool" data-cpNo="'+ carPoolList[i].cpNo +'" data-lat="'+ carPoolList[i].cpLocLat +'" data-lng="'+ carPoolList[i].cpLocLng +'">'
		                   	+ '<h3 id="cpMemNo">'+ carPoolList[i].memNo +'</h3>' 
	                   			+ '주소 : <p id="cpLoc" style="display:inline">'+ carPoolList[i].cpLoc +'</p><br>'
	                   			+ '인원 : <p id="cpPass" style="display:inline">'+ carPoolList[i].cpTakePass +'</p>/<p id="cpTotalPass" style="display:inline">'+ carPoolList[i].cpTotalPass +'</p>'
	                   		+ '</div>';
	                    
						listDiv.html(listDiv.html() + listEl);
					}
					
			    	$(".carPool").on("click", fn_carPoolClick);
			    	removeMarker();
					markers = [];
					
					$("#carPoolList").children().each(fn_mark);
					fn_myApply();
			    	
					
				}, error : function(){
					alert("실패");
				}
			});
			*/
			
			carPoolElements = $("#carPoolList").find(".carPool");
			if(carPoolElements.length <= 0){
				$("#carPoolList").html("<p id='empty' style='color:gray; text-align: center; margin-top: 50%;'>등록된 차량이 없습니다.</p>");
			}
		});
		

		$("#carPoolGoBtn").on('click', function(){
			let bounds = new kakao.maps.LatLngBounds();
			
			goBtn.removeClass("btn-outline-primary");
			goBtn.addClass("btn-primary");
			
			outBtn.removeClass("btn-primary");
			outBtn.addClass("btn-outline-primary");
			
			goBtn.attr('disabled', true);
			outBtn.attr('disabled', false);
			
			$("#cpGoOut").val("G");
			console.log($("#cpGoOut").val());
			
     		let arr = $("#carPoolList").children();
			
			/* GoOut 마커 숨기기*/
			$("#carPoolList").children().each(function(){
				if($(this).data('goout') == 'G'){
					$(this).show();
					markers[arr.index($(this))].setMap(map);
					bounds.extend(markers[arr.index($(this))].getPosition());
				}else{
		     		$(this).hide();
					markers[arr.index($(this))].setMap(null);
		     	}
			});
			
			bounds.extend(markerG.getPosition());
			map.setBounds(bounds);
			
		});
		
	$("#carPoolOutBtn").on('click', function(){
			let bounds = new kakao.maps.LatLngBounds();
			
			outBtn.removeClass("btn-outline-primary");
			outBtn.addClass("btn-primary");

			goBtn.removeClass("btn-primary");
			goBtn.addClass("btn-outline-primary");
			
			outBtn.attr('disabled', true);
			goBtn.attr('disabled', false);
			
			$("#cpGoOut").val("O");
			
			let arr = $("#carPoolList").children();
			
			/* GoOut 마커 숨기기*/
			console.log($("#carPoolList").children());
			$("#carPoolList").children().each(function(){
				if($(this).data('goout') == 'O'){
					$(this).show();
					markers[arr.index($(this))].setMap(map);
					bounds.extend(markers[arr.index($(this))].getPosition());
				}else{
		     		$(this).hide();
					markers[arr.index($(this))].setMap(null);
		     	}
			});
			bounds.extend(markerC.getPosition());
			map.setBounds(bounds);
	});
		
		
	$(".cpStateChangeBtn").on("click", function(){

		let cpState = $(this).parent().children('select').val();
		if(cpState == 'P'){
			alert("'운행완료' 혹은 '운행실패'를 선택해주세요.");
			return;
		}
		let memNo = "${member.memNo}";
		let cpNo = $(this	).parent().parent().children('.logCpNo').html();
		console.log("select val:", cpState);
		console.log("cpNo:", cpNo);
		console.log("memNo:", memNo);
		
		let form = $("#cpStateChangeForm");
		form.find("input[name='cpNo']").val(cpNo);
		form.find("input[name='cpState']").val(cpState);
		form.find("input[name='memNo']").val(memNo);
 		form.attr("action", "${pageContext.request.contextPath }/carPoolStateChange");
		form.submit();

	});
	
	$(".cpStateChangePassBtn").on("click", function(){

		let cpState = $(this).parent().children('select').val();
		if(cpState == 'P'){
			alert("'운행완료' 혹은 '운행실패'를 선택해주세요.");
			return;
		}

		let cpNo = $(this	).parent().parent().children('.logCpNo').html();
		let memNo = "${member.memNo}";
		
		console.log("select val:", cpState);
		console.log("cpNo:", cpNo);
		console.log("memNo:", memNo);
		
		let form = $("#cpStateChangeForm");
		form.find("input[name='cpNo']").val(cpNo);
		form.find("input[name='cpState']").val(cpState);
		form.find("input[name='memNo']").val(memNo);
 		form.attr("action", "${pageContext.request.contextPath }/carPoolStateChangePass");
		form.submit();

	});
	
	/*                                             Paging                                            */
	
	let sf =$("form[name='search']");
	let curPage= sf.find("input[name='curPage']");
	let rowSizePerPage = sf.find("input[name='rowSizePerPage']");
	let startDate= sf.find("input[name='startDate']");
	let endDate= sf.find("input[name='endDate']");
	let cpGoOut= sf.find("input[name='cpGoOut']");
	let cpState= sf.find("input[name='cpState']");
	let searchCategory= sf.find("input[name='searchCategory']");
	let searchWord= sf.find("input[name='searchWord']");

	$('ul.pagination li a').click(function(e) {
		e.preventDefault();

		console.log($(e.target).data("curpage"));  
		
		curPage.val($(e.target).data("curpage")); 
		rowSizePerPage.val($(this).data("rowsizeperpage")); 
		startDate.val("${searchVO.startDate}");
		endDate.val("${searchVO.endDate}");
		cpGoOut.val("${searchVO.cpGoOut}");
		cpState.val("${searchVO.cpState}");
		searchCategory.val("${searchVO.searchCategory}");
		searchWord.val("${searchVO.searchWord}");
		
		sf.submit();
	});
	
	$("#carPoolLogSearchBtn").on("click",function(){
		curPage = 1;
		
		sf.submit();
	});

	let goBtnModal = $("#carPoolGoBtnModal");
	let outBtnModal = $("#carPoolOutBtnModal");
	
	function fn_carPoolDetailClick(){
    	
    	//let arr = $(this).parent().children();
		//map.panTo(markers[arr.index($(this))].getPosition());
		
		//$(this).parent().children(".carPool-active").children(".text-active").removeClass('text-active');
		//$(this).parent().children(".carPool-active").removeClass('carPool-active');
		//$(this).addClass('carPool-active');
		//$(this).children("h3").addClass('text-active');
		//$(this).children("p").addClass('text-active');
		
		let cpNo = $(this).data("cpno");
		
		
		$.ajax({
			url:'${pageContext.request.contextPath }/carPoolModal'
			, method: "POST"
			, data: {
				cpNo: cpNo
			}
			, success:function(carPool){
				
				
				
				$("#cpNoModal").val(carPool.cpNo);
				$("#cpRunDateModal").html(carPool.cpRunDate);
				$("#cpArrTimeModal").val(carPool.cpArrTime);
				$("#cpLocInfoModal").html(carPool.cpLoc);
				$("#cpRoadLocModal").val(carPool.cpRoadLoc);
				$("#carNoModal").html(carPool.carNo);
				$("#carColorModal").html(carPool.carVO.carColor);
				$("#carModelModal").html(carPool.carVO.carModel);
				$("#cpTakePassModal").html(carPool.cpTakePass);
				$("#cpTotalPassInfoModal").html(carPool.cpTotalPass);
				$("#cpDistanceModal").val(carPool.cpDistance + " km");
				$("#passContainerModal").html("");
				
				
				for(var i = 0 ; i < carPool.passList.length; i++){
					if(carPool.passList[i].memNo == carPool.memNo){
						var passDiv= '<div class="pass-div row driver">'
				    		+	'<div style="padding-left:23px; padding-top:5px" class="pass-img col-3"><img style="width:50px; height:50px;" alt="" src="${pageContext.request.contextPath }/img/base_img.png"></div>'
					    	+	'<div class="pass-text col-9" style="padding-top:4px">'
					    	+	'<p style="font-size:15px; display:inline-block; margin-bottom:3px">'+ carPool.passList[i].memTeam + "  " + carPool.passList[i].memName + '&nbsp;&nbsp;' + "(" + carPool.passList[i].memAge + "/" + (carPool.passList[i].memGender === "M" ? "남" : "여") + ")</p><br>"
					    	+		carPool.passList[i].memPhone
					    	+	'</div>'
				    		+'</div>';
							$("#passContainerModal").html(passDiv + $("#passContainerModal").html());
					}else{
						var passDiv= '<div class="pass-div row">'
				    		+	'<div style="padding-left:23px; padding-top:5px" class="pass-img col-3"><img style="width:50px; height:50px;" alt="" src="${pageContext.request.contextPath }/img/base_img.png"></div>'
					    	+	'<div class="pass-text col-9" style="padding-top:4px">'
					    	+	'<p style="font-size:15px; display:inline-block; margin-bottom:3px;">'+ carPool.passList[i].memTeam + "  " + carPool.passList[i].memName + '&nbsp;&nbsp;' + "(" + carPool.passList[i].memAge + "/" + (carPool.passList[i].memGender === "M" ? "남" : "여") + ")</p><br>"
					    	+		carPool.passList[i].memPhone
					    	+	'</div>'
				    		+'</div>';
							$("#passContainerModal").html($("#passContainerModal").html()+passDiv);
					}	
				};
				
				//$("#carPoolBtnDiv").children().hide();
				//$("#carPoolApplyBtn").show();
				
				//if(carPool.cpTotalPass <= carPool.cpTakePass){
				//	$("#carPoolBtnDiv").children().hide();
				//	$("#carPoolNotice").show();	
				//}
				
				/* for(let i = 0 ; i < carPool.passList.length; i++){
					if(carPool.passList[i].memNo == "${login.memNo}"){
						$("#carPoolBtnDiv").children().hide();
						$("#carPoolCancelBtn").show();
						
						
						if(carPool.memNo == "${login.memNo}"){
							$("#carPoolBtnDiv").children().hide();
							$("#carPoolDeleteBtn").show();
						}
					}
				} */
				
				if(carPool.cpGoOut == "G"){
					console.log("cpGoOutModal:", carPool.cpGoOut)
					goBtnModal.removeClass("btn-outline-primary");
					goBtnModal.addClass("btn-primary");
					
					outBtnModal.removeClass("btn-primary");
					outBtnModal.addClass("btn-outline-primary");
				}else{
					console.log("cpGoOutModal:", carPool.cpGoOut)
					outBtnModal.removeClass("btn-outline-primary");
					outBtnModal.addClass("btn-primary");
		
					goBtnModal.removeClass("btn-primary");
					goBtnModal.addClass("btn-outline-primary");
				}
				
				
			}
			, error: function(error){
				alert("카풀 정보를 불러올 수 없습니다. 전산실에 문의해주세요. 010-7358-4002");
			}
		});
	}
	
	$(".carPoolDetailBtn").on("click", fn_carPoolDetailClick);

	
	});
	</script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    
</body>

</html>