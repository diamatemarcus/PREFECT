<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.course.domain.CourseVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<link href="${CP}/resources/css/layout.css" rel="stylesheet"
	type="text/css">
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<script>
	/* document.addEventListener("DOMContentLoaded", function() {
		console.log("DOMContentLoaded");

		const boardForm = document.querySelector("#boardForm");
		const doRetrieveBTN = document.querySelector("#doRetrieve");
		const searchWordTxt = document.querySelector("#searchWord");
		const searchDivSelect = document.querySelector("#searchDiv");//id 등록 버튼
		const moveToRegBTN = document.querySelector("#moveToReg");

		// 등록 이동 이벤트
		/* moveToRegBTN.addEventListener("click", function(e) {
			console.log("moveToRegBTN click");

			window.location.href = "${CP}/course/moveToReg.do";
		}); */

		/* searchWordTxt.addEventListener("keyup", function(e) {
			console.log("keyup:" + e.keyCode);
			if (13 == e.keyCode) {//
				doRetrieve(1);
			}
			//enter event:
		}); */

		/* //form submit방지
		boardForm.addEventListener("submit", function(e) {
			console.log(e.target)
			e.preventDefault();//submit 실행방지

		});

		//목록버튼 이벤트 감지
		doRetrieveBTN.addEventListener("click", function(e) {
			console.log("doRetrieve click");
			doRetrieve(1);
		});

		function doRetrieve(pageNo) {
			console.log("doRetrieve pageNO:" + pageNo);

			let boardForm = document.boardForm;
			boardForm.pageNo.value = pageNo;
			boardForm.action = "/ehr/course/doRetrieveAllCourses.do";
			console.log("doRetrieve pageNO:" + boardForm.pageNo.value);
			boardForm.submit();
		}

		//검색조건 변경!:change Event처리 
		searchDivSelect.addEventListener("change", function(e) {
			console.log("change:" + e.target.value);

			let chValue = e.target.value;
			if ("" == chValue) { //전체

				//input text처리
				let searchWordTxt = document.querySelector("#searchWord");
				searchWordTxt.value = "";

				//select값 설정
				let pageSizeSelect = document.querySelector("#pageSize");
				pageSizeSelect.value = "10";
			}
		});
		

	});//--DOMContentLoaded */
	
	function moveToInfo() {
        window.location.href = "/ehr/attendance/moveToCourseInfo.do";
    }
</script>
<style>
.my-custom-row {
	display: flex;
	flex-wrap: wrap;
	margin: -85px -87px 0px -212px;
}

.button-container {
	margin-bottom: 10px; /* 글쓰기 버튼과 페이징 사이의 간격을 줄입니다. */
}

.button {
	width: auto;
	padding: 7px 20px;
	border: none;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 17px;
	cursor: pointer;
	border-radius: 8px;
	background-color: #3986ff;
	color: white;
}
</style>
</head>
<body>

	<!-- Spinner Start -->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>
	<!-- Title -->


	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h2 class="page-header" style="text-align: center;">${ courseList[0].academyName }
					: 코스 조회</h2>
			</div>
		</div>
		<br> <br> <input type="hidden" id="sessionEmail"
			value="${sessionScope.user.email}" />

		<%--<div class="my-custom-row">
			<div class="container col-md-12">

				<!-- 검색 -->
				 <form action="#" method="get" id="boardForm" name="boardForm">
	            <input type="hidden" name="div" id="div" value="${paramVO.getDiv() }" />
	            <input type="hidden" name="pageNo" id="pageNo" />
	            <div class="row g-1 justify-content-end ">
	                <label for="searchDiv" class="col-auto col-form-label">검색조건</label>
	                <div class="col-auto">
	                    <select class="form-select pcwk_select" id="searchDiv"
	                        name="searchDiv">
	                        <option value="">전체</option>
	                        <c:forEach var="vo" items="${boardSearch }">
	                            <option value="<c:out value='${vo.detCode}'/>"
	                                <c:if test="${vo.detCode == paramVO.searchDiv }">selected</c:if>><c:out
	                                    value="${vo.detName}" /></option>
	                        </c:forEach>
	                    </select>
	                </div>
	                <div class="col-auto">
	                    <input type="text" class="form-control" id="searchWord"
	                        name="searchWord" maxlength="100" placeholder="검색어를 입력 하세요"
	                        value="${paramVO.searchWord}">
	                </div>
	                <div class="col-auto">
	                    <select class="form-select" id="pageSize" name="pageSize">
	                        <c:forEach var="vo" items="${pageSize }">
	                            <option value="<c:out value='${vo.detCode }' />"
	                                <c:if test="${vo.detCode == paramVO.pageSize }">selected</c:if>><c:out
	                                    value='${vo.detName}' /></option>
	                        </c:forEach>
	                    </select>
	                </div>
	                <div class="col-auto ">
	                    <!-- 열의 너비를 내용에 따라 자동으로 설정 -->
	                    <input type="button" value="검색" class="button" id="doRetrieve">
	                    <input type="button" value="코스 등록" class="button" id="moveToReg">
	                </div>
	            </div>
	
	        </form> --%>
		<!--// 검색 ----------------------------------------------------------------->



		<!-- Courses List -->
		<table class="table">
			<thead>
				<tr>
					<th scope="col" class="text-center col-lg-1">NO</th>
					<th scope="col" class="text-center col-lg-3">코스 이름</th>
					<th scope="col" class="text-center col-lg-3">회차</th>
					<th scope="col" class="text-center col-lg-5">코스 설명</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty courseList}">
						<!-- 반복문 -->
						<c:forEach var="course" items="${courseList}" varStatus="status">
							<tr>
								<td class="text-center">${status.count}</td>
								<td class="text-center">${course.courseName}</td>
								<td class="text-center">${course.numberOfTimes}회차</td>
								<td class="text-center">${course.courseInfo}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4" class="text-center">등록된 코스가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<br><br>
		<div class="button-container">
			<input type="button" value="내 과정 정보" class="button" onclick="moveToInfo()">
		</div>
	</div>


	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

</body>
</html>
