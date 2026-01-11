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
                <li class="breadcrumb-item text-primary active" aria-current="page">Mileage Shop</li>
            </ol>
        </nav>
    </div>
</div>
<!-- Page Header End -->


<!-- Feature Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row g-5" style="width: 1500px">
            <div class="col-lg-5">
                <div class="product-img">
                    <img src="${product.prodImgUrl }" alt="">
                </div>
            </div>
            <div class="col-lg-7">
                <h4 class="section-title">${product.parentCateName } / ${product.cateName }</h4>
                <h1 class="display-5 mb-4">${product.prodName }</h1>
                <div class="row g-4">
                    <div class="col-3" style="padding-top: 10px">관리코드:${product.prodNo }</div>
                    <div class="col-3" style="padding-top: 10px">단위: ${product.prodUnit }</div>
                    <div class="col-6" style="text-align:right;"><p id="prodPrice" style="font-size:2rem; font-weight: bold; color: black; display: inline"><fmt:formatNumber value="${product.prodPrice }" pattern="#,###,###"/></p>
                        <p style="font-size:2rem; font-weight: bold; color: black; display: inline">원</p>
                    </div>
                </div>
                <div class="row g-4" style="margin-top:10px">
                    <div class="col-12" style="border-bottom: 0.5px solid lightgray">
                        <div class="d-flex align-items-start row">
                            <!--                                 <img class="flex-shrink-0" src="img/icons/icon-2.png" alt="Icon"-->
                            <div class="col-4" style="padding-left:35px">
                                <p style="font-size:1.6rem">주문수량</p>
                            </div>
                            <div class="col-8" style="height: 100%">
                                <div style="width: 130px; height: 40px; float: right;">
                                    <div style="border: 0.5px solid lightgray; width: 40px; height: 40px; display: inline-block;">
                                        <button id="cntMinusBtn" style="width: 100%; height: 100%; background-color: white">-</button>
                                    </div>
                                    <div style="width: 38px; height: 40px; display: inline-block; text-align: center"><p id="prodCnt" style="font-size:1.6rem; color: black">1</p></div>
                                    <div style="border: 0.5px solid lightgray; width: 40px; height: 40px; display: inline-block;">
                                        <button id="cntPlusBtn" style="width: 100%; height: 100%; background-color: white">+</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12" style="border-bottom: 0.5px solid lightgray">
                        <div class="d-flex align-items-start">
                            <!--                                 <img class="flex-shrink-0" src="img/icons/icon-3.png" alt="Icon">
                             -->                            <div class="col-4" style="padding-left:23px">
                            <p style="font-size:1.6rem">총 상품금액</p>
                        </div>
                            <div class="col-8" style="height: 100%">
                                <div style="width: 500px; height: 40px; float: right;  text-align:right;">
                                    <p style="font-size:2rem; color: var(--primary); font-weight: bold; display: inline">총 </p>
                                    <p id="prodTotalPrice" style="font-size:2rem; color: var(--primary); font-weight: bold; display: inline;"><fmt:formatNumber value="${product.prodPrice }" pattern="#,###,###"/></p>
                                    <p style="font-size:2rem; color: var(--primary); font-weight: bold; display: inline">원</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="d-flex align-items-start">
                            <!--                                 <img class="flex-shrink-0" src="img/icons/icon-4.png" alt="Icon">
                             -->                                <div class="col-4" style="padding-left:35px">
                        </div>
                            <div class="col-8" style="height: 100%">
                                <div style="width: 500px; height: 40px; float: right;  text-align:right;">
                                    <form id="prodForm" action="${pageContext.request.contextPath }/mileageShopOrderView" style="display:none;">
                                        <input type="hidden" name="prodNo" value="${product.prodNo }">
                                        <input type="hidden" name="prodCnt">
                                    </form>
                                    <button id="cartBtn" type="button" class="btn btn-outline-primary prodDetailBtn">장바구니</button>
                                    <button id="orderDirBtn" type="button" class="btn btn-outline-primary prodDetailBtn">구매하기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="row g-5" style="width: 1500px">
            <div class="col-12" style="text-align: center; padding-top: 20px; margin-top:200px; background-color: var(--light)">
                <h1 class="display-5 mb-4">상세정보</h1>
            </div>
            <div class="col-2"></div>
            <div class="col-8" style="text-align: center">
                <img alt="" src="${product.prodContentUrl }">
            </div>
            <div class="col-2"></div>
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
        $("#cntMinusBtn").on("click", function(){
            let prodCnt = $("#prodCnt").html()-1;
            if(prodCnt > 0){
                $("#prodCnt").html(prodCnt);

                let prodPrice = Number($("#prodPrice").html().replace(",", ""));
                let prodTotalPrice = prodCnt * prodPrice;
                $("#prodTotalPrice").html(prodTotalPrice.toLocaleString());

            }
        });
        $("#cntPlusBtn").on("click", function(){
            let prodCnt = $("#prodCnt").html()-0+1;
            $("#prodCnt").html(prodCnt);

            let prodPrice = Number($("#prodPrice").html().replace(",", ""));
            let prodTotalPrice = prodCnt * prodPrice;
            $("#prodTotalPrice").html(prodTotalPrice.toLocaleString());
        });

        $("#cartBtn").on("click",function(){
            let prodNo = "${product.prodNo}";
            let prodCnt = Number($("#prodCnt").html());

            console.log(prodCnt);

            $.ajax({
                url: "${pageContext.request.contextPath }/mileageShopCartDo"
                , type: "post"
                , data: {
                    prodNo : prodNo
                    , prodCnt : prodCnt
                }
                ,success: function(result){
                    console.log(result);
                    if(result == "fail"){
                        alert("장바구니 추가에 실패했습니다. 전산실에 문의해주세요.");
                    }else if(result == "duplicate"){
                        let check = confirm("상품이 이미 장바구니에 있습니다. 장바구니로 이동하시겠습니까?");
                        if(!check){
                            return;
                        }else{
                            location.href = "${pageContext.request.contextPath }/mileageShopCartView";
                        }
                    }else if (result == "success"){
                        let check = confirm("상품을 장바구니에 추가했습니다. 장바구니로 이동하시겠습니까?");
                        if(!check){
                            return;
                        }else{
                            location.href = "${pageContext.request.contextPath }/mileageShopCartView";
                        }
                    }
                }
                , error: function(){
                    alert("서버와의 연결에 실패했습니다. 전산실에 문의해주세요.");
                }
            });
        });

        $("#orderDirBtn").click(function(){
            let pf = $("#prodForm");
            pf.find("input[name='prodCnt']").val($("#prodCnt").html());
            console.log("cnt:", pf.find("input[name='prodCnt']").val());

            pf.submit();
        });
    });
</script>
</body>
</html>