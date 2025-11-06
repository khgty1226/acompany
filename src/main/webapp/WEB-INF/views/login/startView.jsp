<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko" class=" js  no-overflowscrolling"><head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=0,maximum-scale=10,user-scalable=yes">
<meta name="HandheldFriendly" content="true">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
<title>ACompany</title>
<link rel="stylesheet" href="http://www.saysoft.co.kr/theme/cookie/css/mobile.css?ver=191202">
<link rel="stylesheet" href="http://www.saysoft.co.kr/theme/cookie/mobile/skin/latest/banner/style.css?ver=191202">
<link rel="stylesheet" href="http://www.saysoft.co.kr/theme/cookie/mobile/skin/latest/service/style.css?ver=191202">
<link rel="stylesheet" href="http://www.saysoft.co.kr/theme/cookie/mobile/skin/latest/basic/style.css?ver=191202">
<!--[if lte IE 8]>
<script src="http://www.saysoft.co.kr/js/html5.js"></script>
<![endif]-->
<script>
// 자바스크립트에서 사용하는 전역변수 선언
var g5_url       = "http://www.saysoft.co.kr";
var g5_bbs_url   = "http://www.saysoft.co.kr/bbs";
var g5_is_member = "";
var g5_is_admin  = "";
var g5_is_mobile = "1";
var g5_bo_table  = "";
var g5_sca       = "";
var g5_editor    = "";
var g5_cookie_domain = "";
</script>
<script src="http://www.saysoft.co.kr/js/jquery-1.8.3.min.js"></script>
<script src="http://www.saysoft.co.kr/js/jquery.menu.js?ver=191202"></script>
<script src="http://www.saysoft.co.kr/js/common.js?ver=191202"></script>
<script src="http://www.saysoft.co.kr/js/wrest.js?ver=191202"></script>
<script src="http://www.saysoft.co.kr/js/placeholders.min.js"></script>
<script src="http://www.saysoft.co.kr/theme/cookie/js/theme_common.js"></script>
<script src="http://www.saysoft.co.kr/theme/cookie/js/wow.min.js"></script>
<script>
new WOW().init();
</script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer">
<link rel="stylesheet" href="http://www.saysoft.co.kr/theme/cookie/css/font.css"><script src="http://www.saysoft.co.kr/js/modernizr.custom.70111.js"></script>
<script src="http://www.saysoft.co.kr/js/jquery.bxslider.js?ver=191202"></script>

<style type="text/css">

#hd { height: 85.72px; }
#logo {     
	width: 239.75px;
    height: 100%;
    padding: 10px;
    margin-right: 16px;}
#hd_wrapper { height: 100%;}

</style>

</head>
<body class="">

<header id="hd" class="">
    <h1 id="hd_h1">ACompany</h1>

    <div class="to_content"><a href="#container">본문 바로가기</a></div>

    
<!-- 팝업레이어 시작 { -->
<div id="hd_pop">
    <h2>팝업레이어 알림</h2>

<span class="sound_only">팝업레이어 알림이 없습니다.</span></div>

<script>
$(function() {
    $(".hd_pops_reject").click(function() {
        var id = $(this).attr('class').split(' ');
        var ck_name = id[1];
        var exp_time = parseInt(id[2]);
        $("#"+id[1]).css("display", "none");
        set_cookie(ck_name, 1, exp_time, g5_cookie_domain);
    });
    $('.hd_pops_close').click(function() {
        var idb = $(this).attr('class').split(' ');
        $('#'+idb[1]).css('display','none');
    });
    
    let msg = $("#msg").val();
    if("${msg }" == "none"){
    	alert("회원만 이용 가능합니다. 사원이실 경우 로그인 후 이용해주세요.");
    }
});
</script>
<!-- } 팝업레이어 끝 -->

	<input id="msg" type="hidden" value="${msg }">
    <div id="hd_wrapper">

        <div id="logo">
            <a href="" style=""><img src="img/Acompany.png" style="width: 250px; height: 64px; margin: 0 16px 0 0;"alt="ACompany" title="">
            </a>
        </div>
        <button type="button" id="gnb_open"><i class="fa fa-bars"></i><span class="sound_only"> 메뉴열기</span></button>

        <div id="gnb" class="pc_view">
            <ul id="gnb_1dul">
                            <li class="gnb_1dli">
                    <a href="<c:url value="/joinView" />" target="_self" class="gnb_1da">회원가입</a>
                </li>
                            <li class="gnb_1dli">
                    <a href="<c:url value="/loginView" />" target="_self" class="gnb_1da">&nbsp;&nbsp;로그인</a>
                </li>
                        </ul>

        </div>

        <div id="gnb2">
        <div class="btn_home">
            <a href=""><img src="img/Acompany.png" alt="ACompany"></a>
        </div>
            <button type="button" class="btn_close"><i class="fa fa-times"></i></button>
            <ul class="gnb_tnb">
                                <li><a href="<c:url value="/joinView" />">회원가입</a></li>
                <li><a href="<c:url value="/loginView" />">로그인</a></li>
                
            </ul>
            <ul id="gnb2_1dul">
                            <li class="gnb2_1dli">
                    <a href="" target="_self" class="gnb2_1da">회사소개</a>
                    <button type="button" class="btn_gnb_op">하위분류</button><ul class="gnb2_2dul">
                        <li class="gnb2_2dli"><a href="" target="_self" class="gnb2_2da"><span></span>ACompany</a></li>
                                            <li class="gnb2_2dli"><a href="" target="_self" class="gnb2_2da"><span></span>조직도</a></li>
                                            <li class="gnb2_2dli"><a href="" target="_self" class="gnb2_2da"><span></span>오시는길</a></li>
                    </ul>
                </li>
                        </ul>

        </div>   
        <div class="mask"></div>  
        <script>
        $(function () {
            //폰트 크기 조정 위치 지정
            var font_resize_class = get_cookie("ck_font_resize_add_class");
            if( font_resize_class == 'ts_up' ){
                $("#text_size button").removeClass("select");
                $("#size_def").addClass("select");
            } else if (font_resize_class == 'ts_up2') {
                $("#text_size button").removeClass("select");
                $("#size_up").addClass("select");
            }

            $(".hd_opener").on("click", function() {
                var $this = $(this);
                var $hd_layer = $this.next(".hd_div");

                if($hd_layer.is(":visible")) {
                    $hd_layer.hide();
                    $this.find("span").text("열기");
                } else {
                    var $hd_layer2 = $(".hd_div:visible");
                    $hd_layer2.prev(".hd_opener").find("span").text("열기");
                    $hd_layer2.hide();

                    $hd_layer.show();
                    $this.find("span").text("닫기");
                }
            });


            $(".btn_gnb_op").click(function(){
                $(this).toggleClass("btn_gnb_cl").next(".gnb2_2dul").slideToggle(300);
                
            });

            $(".hd_closer").on("click", function() {
                var idx = $(".hd_closer").index($(this));
                $(".hd_div:visible").hide();
                $(".hd_opener:eq("+idx+")").find("span").text("열기");
            });

            $("#hd_sch .btn_close").on("click", function() {
                $("#hd_sch").hide();
            });

            
            $("#gnb_open").on("click", function() {
                $("#gnb2").addClass("active");
                $(".mask").addClass("active");
                $("html").addClass("active");
                
            });

            $("#gnb2 .btn_close").on("click", function() {
                $("#gnb2").removeClass("active");
                $(".mask").removeClass("active");
                $("html").removeClass("active");
            });
            $(".mask").on("click", function() {
                $("#gnb2").removeClass("active");
                $(".mask").removeClass("active");
                $("html").removeClass("active");
            });

 
        });

        //상단고정
        if( $("#hd").length ){
            var jbOffset = $("#hd").offset();
            $( window ).scroll( function() {
                if ( $( document ).scrollTop() > jbOffset.top ) {
                    $( 'body' ).addClass( 'fixed' );
                }
                else {
                    $( 'body' ).removeClass( 'fixed' );
                }
            });
        }
        </script>
        
    </div>
   
</header>



<div id="wrapper">

    <div id="container">
    
<!-- 배너 최신글 -->

<!-- 배너 최신글 시작 { -->
<div class="lt_bn">
    <div class="bx-wrapper" style="max-width: 100%;"><div class="bx-viewport" style="width: 100%; overflow: hidden; position: relative; height: 968px;"><ul style="width: 515%; position: relative; transition-duration: 0s; transform: translate3d(-1905px, 0px, 0px);">
            <li class="list_0" style="background-image: url(&quot;http://www.saysoft.co.kr/data/file/banner/3232261318_pJamhrvO_511c0c11d928df6af4db750ffcdcba24365d69f3.jpg&quot;); float: left; list-style: none; position: relative; width: 1905px;">
            <div class="bg"></div>
            <div class="bn_txt active-slide test">
                <div class="txt_wr">
                        <div class="bn_tit">Department of System Integration</div>
                        <div class="bn_detail pc_view"> - 우리 미래에 필요한 기술 -
<br>창조적 장인 정신을 기반으로한 꾸준한 혁신 활동은 오늘도 최초와 최고의 제품을 고객에게 전하고 있습니다.</div>

                        
                </div>
            </div>
        </li>
            <li class="list_1" style="background-image: url(&quot;http://www.saysoft.co.kr/data/file/banner/1938406516_zVtomYvx_a1378c2103914b01522b69d579304924d010dd3e.jpg&quot;); float: left; list-style: none; position: relative; width: 1905px;">
            <div class="bg"></div>
            <div class="bn_txt">
                <div class="txt_wr">
                        <div class="bn_tit">Solution Business Division</div>
                        <div class="bn_detail pc_view"> 자율ㆍ책임ㆍ융합ㆍ창의의 경영이념 아래 시스템ㆍ솔루션ㆍ연구개발사업등
<br>풍부한 경험과 최고의 기술력으로 고객 가치를 실현하고 있습니다.</div>

                        
                </div>
            </div>
        </li>
            <li class="list_2" style="background-image: url(&quot;http://www.saysoft.co.kr/data/file/banner/1938406516_Qd0lepYO_c4a53dbb6971c0fab69b5ee8922fa7ee1ea8c3f6.jpg&quot;); float: left; list-style: none; position: relative; width: 1905px;">
            <div class="bg"></div>
            <div class="bn_txt">
                <div class="txt_wr">
                        <div class="bn_tit">R&amp;D and Innovation</div>
                        <div class="bn_detail pc_view"> 고객의 한결같은 성원과 기대에 부응하기 위해 신속하고 정확한 고객지원으로 성실과 최선을 다하겠습니다.</div>

                        
                </div>
            </div>
        </li>
            <li class="list_0 bx-clone" style="background-image: url(&quot;http://www.saysoft.co.kr/data/file/banner/3232261318_pJamhrvO_511c0c11d928df6af4db750ffcdcba24365d69f3.jpg&quot;); float: left; list-style: none; position: relative; width: 1905px;">
            <div class="bg"></div>
            <div class="bn_txt">
                <div class="txt_wr">
                        <div class="bn_tit">Department of System Integration</div>
                        <div class="bn_detail pc_view"> - 우리 미래에 필요한 기술 -
<br>창조적 장인 정신을 기반으로한 꾸준한 혁신 활동은 오늘도 최초와 최고의 제품을 고객에게 전하고 있습니다.</div>

                        
                </div>
            </div>
        </li></ul></div><div class="bx-controls"></div></div>
    
    <div id="bx_pager">
                <a data-slide-index="0" href="" class="">01<span></span></a>
                <a data-slide-index="1" href="" class="">02<span></span></a>
                <a data-slide-index="2" href="" class="">03<span></span></a>
        
            </div>

    <button type="button" class="btn_bottom">아래로</button>
</div>


<script>
$('.lt_bn ul').show().bxSlider({

    pagerCustom: '#bx_pager',
    controls:false,
    auto:true,
    pause: 8000,
    speed: 800,

     onSliderLoad: function () {
        $('.lt_bn .bn_txt').eq(1).addClass('active-slide');
        $(".bn_txt.active-slide").addClass("test");
    },
    onSlideAfter: function (currentSlideNumber, totalSlideQty, currentSlideHtmlObject) {
        console.log(currentSlideHtmlObject);
        $('.active-slide').removeClass('active-slide');
        $('.lt_bn .bn_txt').eq(currentSlideHtmlObject + 1).addClass('active-slide');
        $(".bn_txt.active-slide").addClass("test");

    },
    onSlideBefore: function () {
        $(".bn_txt.active-slide").removeClass("test");
        $(".one.bn_txt.active-slide").removeAttr('style');

    }
});

 function parallax(){
    var scrolled = $(window).scrollTop();
    $('.lt_bn ul li').css('background-position',"0 "+  (scrolled * 1 ) + 'px');
}
$(window).scroll(function(){
    parallax();
});


jQuery(document).ready(function($) {
    $(".btn_bottom").on("click", function() {           
        var position=$('#index').offset(); // 위치값
        $('html,body').animate({scrollTop:position.top},400); // 이동
    });
});
</script>

<!-- } 배너 최신글 끝 --><div id="index">


<!-- 갤러리 최신글 -->
<div class="lt_service_wrap">
	<div class="lt_service">
	
	<div class="category">비즈니스</div>
	<h2 class="title">꾸준한 혁신활동으로<br>최고의 기술을 보여드리겠습니다</h2>
		<ul>
			<li>
				<a>
				<div class="lt_img">
					<img src="http://www.saysoft.co.kr/data/file/solution/thumb-3232261203_tKpF1n0J_a95b9c423e7d363fe8f947889c1577c87b894351_310x310.jpg" alt="">
				</div>
				<div class="lt_txt_wr">
					<div class="lt_tit">카풀 시스템</div>
					<div class="lt_detail"> &nbsp;당진시 온라인 주민참여 플랫폼'손 끝으로 만나는 우리마을' 앱 구축◈ 온라인 주민참여 플랫폼이란?&nbsp;- 온라인 주민참여 플랫폼은 주민이 직접 의제를 제안하고 토론…</div>
				</div>
				</a>
			</li>
			<li>
				<a>
					<div class="lt_img">
						<img src="http://www.saysoft.co.kr/data/editor/2203/thumb-1a889adfc3155d84d91551c9a2b13ef2_1646380964_8333_310x310.png" alt="" title="">
					</div>
					<div class="lt_txt_wr">
						<div class="lt_tit">채팅 / 커뮤니티</div>
						<div class="lt_detail"> &nbsp;정책현황판</div>
					</div>
				</a>
			</li>
			<li>
				<a>
					<div class="lt_img">
						<img src="http://www.saysoft.co.kr/data/editor/2203/thumb-1a889adfc3155d84d91551c9a2b13ef2_1646379433_4293_310x310.png" alt="" title="">
					</div>
					<div class="lt_txt_wr">
						<div class="lt_tit">마일리지 샵</div>
						<div class="lt_detail"> &nbsp;정책 포털 시스템업무지원 시스템 도입으로『업무 편의 증대 및 정보공개 기반마련 및 공공기관의 업무지원시스템 요구사항에 대한 지속적인 운영유지보수』체계를 확립합니다.&amp;nb…</div>
					</div>
				</a>
			</li>
		</ul>
	</div>
</div>



<!-- a메뉴 최신글 -->

<link rel="stylesheet" href="http://www.saysoft.co.kr/theme/cookie/mobile/skin/latest/basic/dist/css/swiper.min.css">
<script src="http://www.saysoft.co.kr/theme/cookie/mobile/skin/latest/basic/dist/js/swiper.min.js"></script>


<div class="lt_news_wrap">
    <div class="lt_news_bg"></div>

<div class="lt_news">
<div class="category">공지사항</div>
<h2 class="title">ACompany의<br>새로운 소식을 전해드립니다</h2>

<div class="swiper-container swiper1 swiper-container-horizontal">
    <div class="swiper-wrapper" style="transform: translate3d(-2550px, 0px, 0px); transition-duration: 0ms;"><div class="swiper-slide swiper-slide-duplicate" style="cursor: pointer; width: 410px; margin-right: 15px;" data-swiper-slide-index="0">
            
            
            <div class="sw_tit">
                전남, 블록체인 기반 친환경 농산물 유통 플랫폼 구축 (LG CNS + 세이정보기술)            </div>
            <div class="sw_date">
                 <!-- 　
                                    　
                 -->
                2020-05-04　
                                
                            </div>                                
        </div><div class="swiper-slide swiper-slide-duplicate" style="cursor: pointer; width: 410px; margin-right: 15px;" data-swiper-slide-index="1">
            
            
            <div class="sw_tit">
                [대기업 X 블록체인]⑥LG CNS '경험과 기술력으로 블록체인 생태계 선도한다'            </div>
            <div class="sw_date">
                 <!-- 　
                                    　
                 -->
                2020-05-04　
                                
                            </div>                                
        </div><div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-prev" style="cursor: pointer; width: 410px; margin-right: 15px;" data-swiper-slide-index="2">
            
            
            <div class="sw_tit">
                “먹거리 안전, 블록체인으로 책임진다”… LG CNS, 세이정보기술과 맞손            </div>
            <div class="sw_date">
                 <!-- 　
                                    　
                 -->
                2020-05-04　
                                
                            </div>                                
        </div>

        <style>
</style>

        <div class="swiper-slide swiper-slide-duplicate-active" style="cursor: pointer; width: 410px; margin-right: 15px;" data-swiper-slide-index="0">
            
            
            <div class="sw_tit">
                전남, 블록체인 기반 친환경 농산물 유통 플랫폼 구축 (LG CNS + 세이정보기술)            </div>
            <div class="sw_date">
                 <!-- 　
                                    　
                 -->
                2020-05-04　
                                
                            </div>                                
        </div>

        <style>
</style>

        <div class="swiper-slide swiper-slide-duplicate-next" style="cursor: pointer; width: 410px; margin-right: 15px;" data-swiper-slide-index="1">
            
            
            <div class="sw_tit">
                [대기업 X 블록체인]⑥LG CNS '경험과 기술력으로 블록체인 생태계 선도한다'            </div>
            <div class="sw_date">
                 <!-- 　
                                    　
                 -->
                2020-05-04　
                                
                            </div>                                
        </div>

        <style>
</style>

        <div class="swiper-slide swiper-slide-prev" style="cursor: pointer; width: 410px; margin-right: 15px;" data-swiper-slide-index="2">
            
            
            <div class="sw_tit">
                “먹거리 안전, 블록체인으로 책임진다”… LG CNS, 세이정보기술과 맞손            </div>
            <div class="sw_date">
                 <!-- 　
                                    　
                 -->
                2020-05-04　
                                
                            </div>                                
        </div>

                

    <div class="swiper-slide swiper-slide-duplicate swiper-slide-active" style="cursor: pointer; width: 410px; margin-right: 15px;" data-swiper-slide-index="0">
            
            
            <div class="sw_tit">
                전남, 블록체인 기반 친환경 농산물 유통 플랫폼 구축 (LG CNS + 세이정보기술)            </div>
            <div class="sw_date">
                 <!-- 　
                                    　
                 -->
                2020-05-04　
                                
                            </div>                                
        </div><div class="swiper-slide swiper-slide-duplicate swiper-slide-next" style="cursor: pointer; width: 410px; margin-right: 15px;" data-swiper-slide-index="1">
            
            
            <div class="sw_tit">
                [대기업 X 블록체인]⑥LG CNS '경험과 기술력으로 블록체인 생태계 선도한다'            </div>
            <div class="sw_date">
                 <!-- 　
                                    　
                 -->
                2020-05-04　
                                
                            </div>                                
        </div><div class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-prev" style="cursor: pointer; width: 410px; margin-right: 15px;" data-swiper-slide-index="2">
            
            
            <div class="sw_tit">
                “먹거리 안전, 블록체인으로 책임진다”… LG CNS, 세이정보기술과 맞손            </div>
            <div class="sw_date">
                 <!-- 　
                                    　
                 -->
                2020-05-04　
                                
                            </div>                                
        </div></div>
    <!-- 페이징 -->
    <div class="swiper-pagination swiper-pagination1"></div>
    
    <!-- 좌우버튼 활성화시 주석해제 {
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
    } -->
    
</div>

</div>
</div>

<script>
    var swiper1 = new Swiper('.swiper1', {
        // pagination: '.swiper-pagination1',
        slidesPerView: 3,
        loop: true, 
        autoplay: 6000,
        autoplayDisableOnInteraction: false,
        
        spaceBetween: 15,

        breakpoints: {

    960: {
        slidesPerView: 2,
        spaceBetween: 20,
    },

    630:{
        slidesPerView: 1,
    }
  }
    });
    
</script>


</div>
    </div>
</div>

<div id="ft">	
<div class="ft_info">
    <div id="ft_wr">      
        <div id="ft_contact">
            <strong>042 - 719 - 8850</strong>
            <p>평일 : 09:00 - 17:40<br>(점심시간 12:50 - 13:50 / 주말, 공휴일 휴무)</p>
        </div>
        <div id="ft_company">
            <ul>
                <li class="ft_company1"><i class="fa fa-building"></i> 회사명 : ㈜TheCompany</li>
                <li class="ft_company2"> 대표 : 김현곤</li>
			</ul>
            <ul>
				<li class="ft_company2"><i class="fa fa-map-marker"></i> &nbsp;본사 : 대전 중구 계룡로 825 희영빌딩(2층)</li>
			</ul>
            <ul>
				<li class="ft_company5"><i class="fa fa-phone"></i> 전화 : 042-719-8850</li>
                <li class="ft_company2"><i class="fa fa-print"></i> 팩스 : 0505-719-8850</li>
			</ul>
        </div>
	</div>	
	
	<div class="ft_wr">
		<div id="ft_copy">Copyright © <b>Since 2023 SAYSOFT,</b> All rights reserved.</div>
    </div>
    <button type="button" id="top_btn"><i class="fa fa-arrow-up" aria-hidden="true"></i><span class="sound_only">상단으로</span></button>
    			
			    </div>
	
</div>



<script>
jQuery(function($) {

    $( document ).ready( function() {

        // 폰트 리사이즈 쿠키있으면 실행
        font_resize("container", get_cookie("ck_font_resize_rmv_class"), get_cookie("ck_font_resize_add_class"));
        
 
        if ($('#top_btn').length) {
            var scrollTrigger = 100, // px
                backToTop = function () {
                    var scrollTop = $(body).scrollTop();
                    if (scrollTop > scrollTrigger) {
                        $('#top_btn').addClass('show');
                    } else {
                        $('#top_btn').removeClass('show');
                    }
                };
            backToTop();
            $(boody).on('scroll', function () {
                backToTop();
            });
            $('#top_btn').on('click', function (e) {
                e.preventDefault();
                $('body').animate({
                    scrollTop: 0
                }, 700);
            });
        }
    });
});
</script>



<!-- ie6,7에서 사이드뷰가 게시판 목록에서 아래 사이드뷰에 가려지는 현상 수정 -->
<!--[if lte IE 7]>
<script>
$(function() {
    var $sv_use = $(".sv_use");
    var count = $sv_use.length;

    $sv_use.each(function() {
        $(this).css("z-index", count);
        $(this).css("position", "relative");
        count = count - 1;
    });
});
</script>
<![endif]-->



</body></html>