<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.searchBtn {
	border: none;
	width: 61px;
	font-weight: 500;
	color: #FFF;
	background: #0077b5;
}
</style>
<script>
$(document).ready(function(){
	
	$("#check_all").click(function(){
		if($(this).prop("checked")){
			$("input[name='check_list']").prop("checked", true);
		}else{
			$("input[name='check_list']").prop("checked", false);
		}
	});
	
	$("#id_searchDept").change(function(){
		let deptVal = $(this).val();
		// console.log(deptVal);
		
		$(".teams").each(function(){
			if($(this).data("deptcode") == deptVal){
				$(this).show();
			}else{
				$(this).hide();
			}
		});
	});
	
	let parentKey = $("select[name=searchDept]").val();
	$(".teams").each(function(){
		// console.log("parentKey : ", parentKey);
		// console.log("this value : ", $(this).data("deptcode"));
		
		let deptVal = $(this).data("deptcode");
		
		if(parentKey != deptVal){
			$(this).hide();
		}
	});
	
	$(".memTeams").each(function(){
		// console.log("parentKey : ", parentKey);
		// console.log("this value : ", $(this).data("deptcode"));
		
		let memParentKey = $(this).parent().parent().parent().children("td[name='mem_dept_td']").children().val();
		let deptVal = $(this).data("deptcode");
		console.log("memParentKey:", memParentKey);
		
		if(memParentKey != deptVal){
			$(this).hide();
		}
	}); 
	
	$(".id_memberDept").change(function(){
		let memDeptVal = $(this).val();
		// console.log(memDeptVal);
		
		console.log($(this).parent().parent().children("td[name='mem_team_td']").children().children());
		let memTeams = $(this).parent().parent().children("td[name='mem_team_td']").children().children();
		
		memTeams.each(function(){
			
			// console.log("this value : ", $(this).data("deptcode"));
			
			if($(this).data("deptcode") == memDeptVal){
				$(this).show();
			}else{
				$(this).hide();
			}
		});
		$(this).parent().parent().children("td[name='mem_team_td']").find(".memTeams").removeAttr("selected");
		$(this).parent().parent().children("td[name='mem_team_td']").find(".memTeams[data-deptCode='" + memDeptVal + "']").prop("selected", true);
	});
});

$(function(){

	$('#id_rowSizePerPage').change(function() {
		sf.find("input[name='curPage']").val(1);
		sf.find("input[name='rowSizePerPage']").val($(this).val());
		sf.submit();
	});

	let sf = $("form[name='search']");
	let curPage= sf.find("input[name='curPage']");
	let rowSizePerPage = sf.find("input[name='rowSizePerPage']");
	$('ul.pagination li a').click(function(e) {
		e.preventDefault();

		console.log($(e.target).data("curpage"));  
		
		curPage.val($(e.target).data("curpage")); 
		rowSizePerPage.val($(this).data("rowsizeperpage")); 
		sf.submit();
	});


	sf.find("button[type=submit]").click(function(e) {
		e.preventDefault();
		curPage.val(1);
		rowSizePerPage.val(10);
		sf.submit();
	});

	$('#id_btn_reset').click(function() {
		sf.find("select[name='searchType'] option:eq(0)").attr("selected", "selected");	
		sf.find("select[name='searchCategory'] option:eq(0)").prop("selected", "selected");	
		sf.find("input[name='searchWord']").val("");
		sf.find("select[name='searchDept']").val("");
		sf.find("select[name='searchTeam']").val("");
		sf.find("input[name='curPage']").val(1);
		sf.find("input[name='rowSizePerPage']").val(10);
		sf.submit();
	});
});

//멤버 삭제 처리
function fn_delete(){
	let result = confirm("삭제를 진행하시겠습니까?");
	if(result){
		let cl = $("input:checkbox[name='check_list']:checked");
		console.log("cl", cl);
		
		if(cl.length == 0){
			alert("선택된 회원이 없습니다. 삭제하고자 하는 회원에 체크를 한 후 진행해 주세요.");
			return;
		}
		
		let multiId = [];
		
		cl.each(function(){
			console.log("$(this).val() : ", $(this).val());
			
			multiId.push($(this).val());
		});

		console.log("multiId", multiId);
		console.log(JSON.stringify(multiId));
		$("form[name='memMultiDelete']").find("input[name='memMultiId']").val(JSON.stringify(multiId));
		$("form[name='memMultiDelete']").submit();
	}
}

// 멤버 수정 처리
function fn_submit(){
	let result = confirm("권한(부서/팀)을 수정하시겠습니까?");
	if(result){
		let f= $("form[name='listForm']");
		f.submit();
	}
}
</script>
<!-- Spinner Start -->
<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-border position-relative text-primary" style="width: 6rem; height: 6rem;" role="status"></div>
    <img class="position-absolute top-50 start-50 translate-middle" src="img/icons/icon-1.png" alt="Icon">
</div>
<!-- Spinner End -->

<!-- Page Header Start -->
<div class="container-fluid page-header py-5 mb-5 wow fadeIn" data-wow-delay="0.1s">
    <div class="container py-5">
        <h1 class="display-1 text-white animated slideInDown">MEMBERS</h1>
        <nav aria-label="breadcrumb animated slideInDown">
            <ol class="breadcrumb text-uppercase mb-0">
                <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
                <li class="breadcrumb-item text-primary active" aria-current="page">MEMBERS</li>
            </ol>
        </nav>
    </div>
</div>
<!-- Page Header End -->

<!-- Team Start -->
<div class="container-xxl">
	<div class="container" style="">
		<div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
		    <h4 class="section-title">MEMBERS</h4>
		    <h1 class="display-5 mb-4">회원목록</h1>
		</div>
	</div>
</div>
<!-- Team End -->

<!-- 회원 리스트 폼 -->
<section class="page-section mt-5" id="contact" >

	<div class="container col-7">
		<!-- Contact Section Heading-->
		
		<!-- 카테고리별 검색 창 -->
		<div class="div_search">
			<div class="div_div_search row">
				<div class="rowSizePerPage col-12" style="display: flex; justify-content: center;">
					<form name="search">
						<input type="hidden" name="curPage" value="${searchVO.curPage}"> 
						<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage}">
						<div class="searchForm" style="height:35px; font-size:16px;">
							<label for="id_searchType">검색</label>
							&nbsp;&nbsp;
							<select id="id_searchType" name="searchType">
								<option value="ID" ${searchVO.searchType eq "ID" ? "selected='selected'" : ""}>사원번호</option>
								<option value="NM" ${searchVO.searchType eq "NM" ? "selected='selected'" : ""}>이름</option>
								<option value="HP" ${searchVO.searchType eq "HP" ? "selected='selected'" : ""}>전화번호</option>
							</select>
							<input type="text" name="searchWord" style="border:solid 1px;" value="${searchVO.searchWord }" placeholder="검색어">
							&nbsp;&nbsp;&nbsp;&nbsp;
							
							<label for="id_searchDept">부서</label>
							&nbsp;&nbsp;
							<select id="id_searchDept" name="searchDept">
								<option value="">전체</option>
								<c:forEach items="${deptList}" var="deptCode">
									<option value="${deptCode.commCd}" ${searchVO.searchDept eq deptCode.commCd ? "selected='selected'" : "" }>${deptCode.commNm}</option>
								</c:forEach>
							</select>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<label for="id_searchTeam">팀</label>
							&nbsp;&nbsp;
							
							<select id="id_searchTeam" name="searchTeam">
								<option value="">전체</option>
								<c:forEach items="${teamList}" var="teamCode">
									<option class="teams" value="${teamCode.commCd}" ${searchVO.searchTeam eq teamCode.commCd ? "selected='selected'" : ""} data-deptCode="${teamCode.commParent }">${teamCode.commNm}</option>
								</c:forEach>
							</select>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button class="searchBtn" type="submit">검 색</button>
							<button class="searchBtn" type="button" id="id_btn_reset" >초기화</button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;전체 ${searchVO.totalRowCount } 건 조회&nbsp;
							<select id="id_rowSizePerPage" name="rowSizePerPage">
								<c:forEach begin="10" end="50" step="10" var="i">
									<option value="${i }" ${searchVO.rowSizePerPage eq i ? "selected='selected'" : "" }>${i }</option>
								</c:forEach>
							</select>
						</div>
					</form>
				</div>
			</div>
		</div>
		
		