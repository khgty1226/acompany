<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<style>
	 .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap; color:black;}
	 .title {font-weight:bold;display:block;}
	 .card-body-div{margin-bottom:20px !important;}
</style>
<script>
if("${login.memNo }" == null || "${login.memNo}" == ''){
	location.href = "${pageContext.request.contextPath }/startView?msg=none";
}

	$(function(){
		let check = $("#check").val();
		if(check == 'create'){
			alert("카풀이 등록되었습니다.");
		}else if(check == 'cfail'){
			alert("카풀 등록에 실패했습니다. 전산실에 문의해주세요. 010-7358-4002");
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
                    <li class="breadcrumb-item text-primary active" aria-current="page">조회/신청</li>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->


    <!-- Project Start -->
    <div class="container-xxl project py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <h4 class="section-title">Car Pool</h4>
                <h1 class="display-5 mb-4">가까운 거리의 사원들과 함께 출/퇴근 해보세요.</h1>
                <div>
						<button type="button" style="width: 200px" onclick="location.href='${pageContext.request.contextPath }/carPoolView'" class="btn btn-primary mybtn">카풀 목록</button>
						<button type="button" style="width: 200px" onclick="location.href='${pageContext.request.contextPath }/myCarPoolView'" class="btn btn-primary mybtn">나의 카풀</button>
                </div>
            </div>
            <div class="row g-4 wow fadeInUp" style="position:relative" data-wow-delay="0.3s">
            
            <div id="map" style="width:100%; height:500px; position:absolute; z-index:1"></div>
            <div class="col-lg-3" style="padding-left: 0; position:relative; left:15px; top:15px; z-index:-2">
	            <%-- <div class="w-100" style="padding : 5px; background-color: white; border:0.5px solid lightgray; border-bottom:none; opacity: 0.8">
	           	  	<div class="carPoolList-header">LIST</div>
	           	  	<div class="carPoolList-search">
							 주소: &nbsp;&nbsp;<input id="carPoolSearchWord" type="text" placeholder="">&nbsp;<button id="carPoolSearchBtn" style="margin-left:5px" type="button">검색</button>
						</div>
	            	</div>
                <div class="w-100" id="carPoolList" style="">
                   	<c:forEach items="${carPoolList }" var="carPool"> <!-- 5개의 카풀 -->
			                   <div class="carPool" data-cpNo="${carPool.cpNo }" data-lat="${carPool.cpLocLat }" data-lng="${carPool.cpLocLng }">
			                   	<h3 id="cpMemNo">${carPool.memNo }</h3>
			                   		주소 : <p name="cpLoc" style="display:inline">${carPool.cpLoc }</p><br>
			                   		인원 : <p name="cpPass" style="display:inline">${carPool.cpTakePass }</p>/<p name="cpTotalPass" style="display:inline">${carPool.cpTotalPass }</p>
			                   </div>
                   	</c:forEach>
                </div> --%>
            </div>
            <div class="col-lg-6">
            </div>
			  <div class="col-lg-3" style="position:relative; top:15px; right:15px; z-index:2; hei">
	                  <div class="tab-content w-100">
	                      <div class="tab-pane fade show active">
	                          <div class="row g-4">
	                              <div class="col-md-12 card border-info">
	                              <form id="carPoolCreateForm" action="${pageContext.request.contextPath }/carPoolCreate">
	                              	<input type="hidden" name="memNo" value="${member.memNo }">
	                              	<input type="hidden" id="cpGoOut" name="cpGoOut" value="G">
										  <div class="card-header">CAR POOL</div>
										  <div id="carPoolGoOutDiv" class="d-flex justify-content-center" style="margin-top:8px;margin-bottom:13px;">
											 	 <button type="button" id="carPoolGoBtn" class="btn btn-primary mybtn goOutBtn" disabled>출근</button>
											 	 <button type="button" id="carPoolOutBtn" class="btn btn-outline-primary mybtn goOutBtn">퇴근</button>
									      </div>
										  <div class="card-body" style="height: 100%; padding-top: 0px">
											  <div class="card-body-div">
											    <h5 class="card-title-input">날짜 : </h5>
											    <input class="card-input" id="cpRunDate" name="cpRunDate" style="width: 210px" type="date"><br>
											    <h5 class="card-title-input"></h5>
											    <input class="card-input" id="cpRunTime" name="cpRunTime" type="time"><br>
											    <div id="cpArrTimeDiv">( 거리/도착시간 : <input id="cpDistance" name="cpDistance" class="card-input" value="" readonly> / <input class="card-input" id="cpArrTime" name="cpArrTime" type="time" readonly>)</div>
											  </div>
											  <div class="card-body-div">
											    <h5 class="card-title-input">장소 : </h5>&nbsp;&nbsp;
											    <input class="card-input" id="cpLoc" name="cpLoc" value="" readonly><br>
											    <div id="cpLocDiv">( 도로명 : <input class="card-input" id="cpRoadLoc" name="cpRoadLoc" value="" readonly> )</div>
											    <input type="hidden" id="cpLocLat" name="cpLocLat" value="">
											    <input type="hidden" id="cpLocLng" name="cpLocLng" value="">
											  </div>
											  <div class="card-body-div">
											    <h5 class="card-title-input">차량 : </h5>&nbsp;&nbsp;
											    <select id="carNo" name="carNo" style="width:203px; text-align:center; border:none; background-color: var(--light)">
											    	<option value="" selected>차량을 선택해주세요.</option>
											    	<c:forEach items="${member.carList }" var="car">
												    	<option value="${car.carNo }">${car.carNo }</option>
											    	</c:forEach>
											    </select><br>
											    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											    <div id="carInfo" style="display:inline;"></div>
											  </div>
											  <div class="card-body-div">
											    <h5 class="card-title-input">인원 :</h5>&nbsp;&nbsp;
											    <select id="cpTotalPass" name="cpTotalPass" style="width:203px; text-align:center; border:none; background-color: var(--light)">
											    	<option value="" selected>인원 수를 선택해주세요.</option>
											    	<option value="2">2명</option>
											    	<option value="3">3명</option>
											    	<option value="4">4명</option>
											    	<option value="5">5명</option>
											    	<option value="6">6명</option>
											    	<option value="7">7명</option>
											    </select>
											    <br>
											  </div>
											  <div id="carPoolBtnDiv" class="card-body-div d-flex justify-content-center" style="margin-top:20px;margin-bottom:0;">
											 	 <button type="button" id="carPoolCreateBtn" class="btn btn-outline-primary mybtn">등록하기</button>
											 	 <button type="button" style="display:none;" id="carPoolCancelBtn" class="btn btn-outline-primary mybtn">취소하기</button>
											 	 <button type="button" style="display:none;" id="carPoolDeleteBtn" class="btn btn-outline-primary mybtn">삭제하기</button>
											 	 <div id="carPoolNotice" style="display:none;">신청 마감되었습니다.</div>
											  </div>
										  </div>
										  </form>
										</div>
	                          </div>
	                      </div>
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
		
		var address = "${member.memAdd}"; // 로그인한 회원의 주소 가져오기  (초기 지도 세팅)
		var company = "대전광역시 중구 계룡로 825";
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
	
		var markerD = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		    infowindowD = new kakao.maps.InfoWindow({zindex:1}), // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
		    infowindowC = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
		    
		var markerC = new kakao.maps.Marker(); // 클릭한 위치를 표시할 마커입니다
	
	    geocoder.addressSearch(address, function(result, status) {
			
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x); // y 위도 Lat. x 경도 Lng
				 console.log(coords);

				 // 결과값으로 받은 위치를 마커로 표시합니다
		        markerD.setMap(map);
		        markerD.setPosition(coords);
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
	           var content = '<div style="width:150px;text-align:center;padding:6px 0;">회원의 집</div>';
	            infowindowD.setContent(content);
		        infowindowD.open(map, markerD);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		        
		        searchDetailAddrFromCoords(coords, function(result, status) {
			        if (status === kakao.maps.services.Status.OK) {
						$("#cpLoc").val(result[0].address.address_name);			          
						$("#cpRoadLoc").val(result[0].road_address.address_name);			          
			        }   
			    });
		        
		        $("#cpLocLat").val(result[0].y);
		        $("#cpLocLng").val(result[0].x);
		    } 
		});   
		    
		 /* var markers = [];
		    
	    function fn_mark(){
			// CarPool 목록의 위치를 마커 표시
			
			 let loc = $(this).children("#cpLoc").html();
			 let lat = $(this).data('lat');
			 let lng = $(this).data('lng');

			console.log($(this).data('cpno'));
			
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
		}
		
		$("#carPoolList").children().each(fn_mark);
		
		
    	
    	function fn_carPoolClick(){
    	
	    	var arr = $(this).parent().children();
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
					$("#cpLocInfo").html(carPool.cpLoc);
					$("#carNo").html(carPool.carNo);
					$("#carColor").html(carPool.carVO.carColor);
					$("#carModel").html(carPool.carVO.carModel);
					$("#cpTakePass").html(carPool.cpTakePass);
					$("#cpTotalPassInfo").html(carPool.cpTotalPass);
					$("#passContainer").html("");
					
					
					for(var i = 0 ; i < carPool.passList.length; i++){
						if(carPool.passList[i].memNo == carPool.memNo){
							var passDiv= '<div class="pass-div row driver">'
					    		+	'<div class="pass-img col-3"></div>'
						    	+	'<div class="pass-text col-9">'
						    	+		carPool.passList[i].memName + '&nbsp;&nbsp;' + "(" + carPool.passList[i].memAge + "/" + "남" + ")"
						    	+	'</div>'
					    		+'</div>';
								$("#passContainer").html(passDiv + $("#passContainer").html());
						}else{
							var passDiv= '<div class="pass-div row">'
					    		+	'<div class="pass-img col-3"></div>'
						    	+	'<div class="pass-text col-9">'
						    	+		carPool.passList[i].memName + '&nbsp;&nbsp;' + "(" + carPool.passList[i].memAge + "/" + "남" + ")"
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
					
					for(let i = 0 ; i < carPool.passList.length; i++){
						if(carPool.passList[i].memNo == "${login.memNo}"){
							$("#carPoolBtnDiv").children().hide();
							$("#carPoolCancelBtn").show();
							
							
							if(carPool.memNo == "${login.memNo}"){
								$("#carPoolBtnDiv").children().hide();
								$("#carPoolDeleteBtn").show();
							}
						}
					}
					
				}
				, error: function(error){
					alert("카풀 정보를 불러올 수 없습니다. 전산실에 문의해주세요. 010-7358-4002");
				}
			});
    	}
    	
    	$(".carPool").on("click", fn_carPoolClick); */
	
		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		        	
		            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
		            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
		            
		            content = '<div class="bAddr">' +
		                            '<span class="title">법정동 주소정보</span>' + 
		                            detailAddr + 
		                        '</div>';
	
		            if($("#cpGoOut").val() == "G"){
		            	
			            // 마커를 클릭한 위치에 표시합니다 
			            markerD.setPosition(mouseEvent.latLng);
			            markerD.setMap(map);
		
			            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			            infowindowD.setContent(content);
			            infowindowD.open(map, markerD);
		            }else{
		            	// 마커를 클릭한 위치에 표시합니다 
			            markerC.setPosition(mouseEvent.latLng);
			            markerC.setMap(map);
		
			            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			            infowindowC.setContent(content);
			            infowindowC.open(map, markerC);
			            	
		            }
		            
		            $("#cpLoc").val(result[0].address.address_name);			          
			        if(result[0].road_address == null){
			        	$("#cpRoadLoc").val("");
			        }else{
				        $("#cpRoadLoc").val(result[0].road_address.address_name);
			        }
			        $("#cpLocLat").val(mouseEvent.latLng.Ma);
			        $("#cpLocLng").val(mouseEvent.latLng.La);
					
			        if($("#cpRunTime").val() != ""){
			        	
				        fn_arrTimeCompute(mouseEvent.latLng.Ma, mouseEvent.latLng.La);
			        }
		        }   
		    });
		});
		
		function fn_arrTimeCompute(lat, lng){
			$.ajax({
	            url:"https://apis-navi.kakaomobility.com/v1/directions"
	            , type : "GET"
	            , contentType : "application/json"
	            , headers:{
	                "Authorization" : "KakaoAK 77496d3a91483d37aaab3f61c677c676"
	            }
	            , data: {
	                "origin": lng + "," + lat
	                , "destination":"127.40775961305604,36.32662677028527"  // 희영빌딩 (회사)
	            }
	            , success: function(response){
	                console.log(response);
	                let distance = Math.round(response['routes'][0].sections[0].distance/1000*10)/10;
	                let duration = Math.round(response['routes'][0].sections[0].duration/60);
	                console.log("거리 :", distance);
	                console.log("시간 :", duration);
	                
	                let runTime = $("#cpRunTime").val();
	                let hour = parseInt(runTime.split(":")[0]);
	                let minute = parseInt(runTime.split(":")[1]);
	                
	                let arrHour = hour;
	                let arrMinute = minute + duration;
	
	                if(arrMinute > 59){
		                	arrMinute = arrMinute - 60;
		                	arrHour = arrHour + 1;
		                	if(arrHour > 23){
		                		arrHour = arrHour - 24;
		                	}
	                	}
	                	
	                if(arrHour < 10){
	                		arrHour = "0" +arrHour;
	                	}
	                if(arrMinute < 10){
	                		arrMinute = "0" + arrMinute;
	               	 }
	                	$("#cpArrTime").val(arrHour+":"+arrMinute);
	                	$("#cpDistance").val(distance+" km");
	                	
	                
	            }, error: function(){
	                alert("error");
	            }
	        });
		}
		
		$("#cpRunDate").on("change", function(){
			let cpRunDate = new Date($("#cpRunDate").val());
			console.log(cpRunDate);
			let today = new Date();
			today.setHours(8);
			today.setMinutes(59);
			today.setSeconds(59);
			console.log(today);
			
			if(today > cpRunDate){
				alert("운행일은 현재 날짜 이후로 선택해주세요."); // 당일부터 가능
				$("#cpRunDate").val("");
				return;
			}
			
		});
		
		$("#cpRunTime").on("change", function(){
			
			let cpRunDate = new Date($("#cpRunDate").val());
			console.log(cpRunDate);
			let todayDate = new Date();
			
			if(cpRunDate <= todayDate){
			
				let cpRunTime = $("#cpRunTime").val();
				let date = new Date();
				date.setHours(parseInt(cpRunTime.split(":")[0]));
				date.setMinutes(parseInt(cpRunTime.split(":")[1]));
				console.log("date:", date);
				
				let today = new Date();
				today.setSeconds(0);
				console.log(today); // 현재 시간
				
				if(today > date){
					alert("운행 시간은 현재 시간 이후로 선택해주세요.");
					$("#cpRunTime").val("");
					return;
				}
			}
				
				let markerLatLng = markerD.getPosition();
				
				fn_arrTimeCompute(markerLatLng.Ma, markerLatLng.La);
			
		});
	
	
		function searchAddrFromCoords(coords, callback) {
		    // 좌표로 행정동 주소 정보를 요청합니다
		    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
		}
	
		function searchDetailAddrFromCoords(coords, callback) {
		    // 좌표로 법정동 상세 주소 정보를 요청합니다
		    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}
		
		$("#carNo").change(function(e){
			let carNo = $(this).val();
			$.ajax({
				url: "${pageContext.request.contextPath }/carPoolCarInfo"
				, type: "get"
				, data: {
					carNo : carNo
				}
				, success: function(car){
					console.log(carNo);
					if(carNo != ""){
						let carStr = '( <p class="card-text" id="carColor">'+car.carColor+'</p> / <p class="card-text" id="carModel">'+car.carModel+'</p> )';
						$("#carInfo").html(carStr);
					}else{
						$("#carInfo").html("");
					}
				}
				, error: function(){
					alert("차량 정보를 불러오지 못 했습니다.");
				}
			});
		});
		
		$("#carPoolCreateBtn").on("click", function(){
			let form = $("#carPoolCreateForm");
			
			let cpRunDate = $("#cpRunDate");
			let cpRunTime = $("#cpRunTime");
			let cpLoc = $("#cpLoc");
			let carNo = $("#carNo");
			let cpTotalPass = $("#cpTotalPass");

			if(cpRunDate.val() == ""){
				alert("운행 날짜를 선택해주세요.");
				cpRunDate.click();
				return;
			}else if(cpRunTime.val() == ""){
				alert("운행 시간을 선택해주세요.");
				cpRunTime.click();
				return;
			}else if(cpLoc.val() == ""){
				alert("출발지를 선택해주세요.");
				cpLoc.click();
				return;
			}else if(carNo.val() == ""){
				alert("차량을 선택해주세요.");
				carNo.click();
				return;
			}else if(cpTotalPass.val() == ""){
				alert("탑승 인원을 선택해주세요.");
				cpTotalPass.click();
				return;
			}
			
			
			
			form.submit();
		});
		
			
		let goBtn = $("#carPoolGoBtn");
		let outBtn = $("#carPoolOutBtn");

		$("#carPoolGoBtn").on('click', function(){
				markerC.setMap(null);
				infowindowC.close();
				
				goBtn.removeClass("btn-outline-primary");
				goBtn.addClass("btn-primary");
				
				outBtn.removeClass("btn-primary");
				outBtn.addClass("btn-outline-primary");
				
				goBtn.attr('disabled', true);
				outBtn.attr('disabled', false);
				
				$("#cpGoOut").val("G");
				console.log($("#cpGoOut").val());
				
				 geocoder.addressSearch(address, function(result, status) {
						
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x); // y 위도 Lat. x 경도 Lng
					 console.log(coords);
			        
					 searchDetailAddrFromCoords(coords, function(result, status) {
					        if (status === kakao.maps.services.Status.OK) {
								$("#cpLoc").val(result[0].address.address_name);			          
								$("#cpRoadLoc").val(result[0].road_address.address_name);			          
					        }   
					    });

					 // 결과값으로 받은 위치를 마커로 표시합니다
			        markerD.setMap(map);
			        markerD.setPosition(coords);
			
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
		           var content = '<div style="width:150px;text-align:center;padding:6px 0;">회원의 집</div>';
		            infowindowD.setContent(content);
			        infowindowD.open(map, markerD);
			
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			        
			    } 
					});   
			});
			
		$("#carPoolOutBtn").on('click', function(){
				
				outBtn.removeClass("btn-outline-primary");
				outBtn.addClass("btn-primary");
	
				goBtn.removeClass("btn-primary");
				goBtn.addClass("btn-outline-primary");
				
				outBtn.attr('disabled', true);
				goBtn.attr('disabled', false);
				
				$("#cpGoOut").val("O");
				console.log($("#cpGoOut").val());
				
				 geocoder.addressSearch(company, function(result, status) {
						
					    // 정상적으로 검색이 완료됐으면 
					     if (status === kakao.maps.services.Status.OK) {
					
					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x); // y 위도 Lat. x 경도 Lng
							 console.log(coords);
					        
							 searchDetailAddrFromCoords(coords, function(result, status) {
							        if (status === kakao.maps.services.Status.OK) {
										$("#cpLoc").val(result[0].address.address_name);			          
										$("#cpRoadLoc").val(result[0].road_address.address_name);			          
							        }   
							    });

							 // 결과값으로 받은 위치를 마커로 표시합니다
					        markerD.setMap(map);
					        markerD.setPosition(coords);
					
					        // 인포윈도우로 장소에 대한 설명을 표시합니다
				           var content = '<div style="width:150px;text-align:center;padding:6px 0;">회사</div>';
				            infowindowD.setContent(content);
					        infowindowD.open(map, markerD);
					
					        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					        map.setCenter(coords);
					        
					    } 
					});   
		});
	});
	
	</script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    
</body>

</html>