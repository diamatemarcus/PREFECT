<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.board.domain.BoardVO"%>
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
	document.addEventListener("DOMContentLoaded", function() {
		console.log("DOMContentLoaded");

		const moveToRegBTN = document.querySelector("#moveToReg");
		const doRetrieveBTN = document.querySelector("#doRetrieve");//목록 버튼
		const searchDivSelect = document.querySelector("#searchDiv");//id 등록 버튼
		const boardForm = document.querySelector("#boardForm");
		const searchWordTxt = document.querySelector("#searchWord");
		const rows = document.querySelectorAll("#boardTable>tbody>tr");

		rows.forEach(function(row) {
			row.addEventListener('click', function(e) {
				let cells = row.getElementsByTagName("td");
				const seq = cells[5].innerText;
				console.log('seq:' + seq);

				const div = document.querySelector("#div").value;
				console.log('div:' + div);

				window.location.href = "${CP}/board/doSelectOne.do?seq=" + seq
						+ "&div=" + div;
			});
		});

		// 등록 이동 이벤트
		moveToRegBTN.addEventListener("click", function(e) {
			console.log("moveToRegBTN click");

			const regId = '${sessionScope.user.email}';
			const userRole = '${sessionScope.user.role}';
			const div = document.querySelector("#div").value;

			if (eUtil.isEmpty(regId) == true) {
				Swal.fire("로그인 후 작성 가능합니다.", "","info");
				return;
			}
			
			if (userRole == "30" && div == "10") {
				Swal.fire("관리자만 글쓰기 가능합니다.", "","info");
				return;
			}

			window.location.href = "${CP}/board/moveToReg.do?div=" + div;

		});

		searchWordTxt.addEventListener("keyup", function(e) {
			console.log("keyup:" + e.keyCode);
			if (13 == e.keyCode) {//
				doRetrieve(1);
			}
			//enter event:
		});

		//form submit방지
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
			boardForm.action = "/ehr/board/doRetrieve.do";
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

	});//--DOMContentLoaded

	function pageDoRerive(url, pageNo) {
		console.log("url:" + url);
		console.log("pageNo:" + pageNo);

		let boardForm = document.boardForm;
		boardForm.pageNo.value = pageNo;
		boardForm.action = url;
		boardForm.submit();
	}
</script>
<style>


/* 테이블과 관련된 스타일 */
.table th, .table td {
	padding: 0.5rem; /* 셀 내부의 padding을 조절합니다 */
}

/* 선택적으로 테이블의 너비를 조절합니다 */
.table-responsive {
	margin: -46px auto; /* 상하 마진은 0, 좌우 마진은 자동으로 설정 */
}

/* 선택적으로 테이블 행의 높이를 조절합니다 */
.table tr {
	height: auto; /* 필요에 따라 조절 */
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


.pagination-container {
	margin-top: -5px; /* 페이징의 상단 간격을 줄입니다. */
}
</style>
</head>
<body>
	<!-- Spinner Start -->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>
	<!-- Spinner End -->


	<div class="container">
		<!-- 제목 -->
		<div class="row">
			<div class="col-lg-12">
				<h2 class="page-header" style="text-align: center;">${title}</h2>
			</div>
		</div>
		<br> <br>
		<!--// 제목 ----------------------------------------------------------------->



		<!-- table -->
		<table class="table table-responsive" id="boardTable">
			<thead>
				<tr>
					<th scope="col" class="text-center col-lg-1  col-sm-1">NO</th>
					<th scope="col" class="text-center col-lg-5  col-sm-6">제목</th>
					<th scope="col" class="text-center col-lg-2  col-sm-1">등록일</th>
					<th scope="col" class="text-center col-lg-2  ">등록자</th>
					<th scope="col" class="text-center col-lg-1  ">조회수</th>
					<th scope="col" class="text-center" style="display: none;">SEQ</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
				    <c:when test="${ not empty list }">
						<!-- 반복문 -->
						<c:forEach var="vo" items="${list}" varStatus="status">
							<tr>
								<td class="text-center col-lg-1  col-sm-1"><c:out value="${vo.no}" escapeXml="true"/>
								<!-- 제목과 댓글 수(0이 아닌 경우에만) 표시 -->
								<td class="text-left col-lg-5 col-sm-8">
                                    <c:out value="${vo.title}" escapeXml="true"/>
									<!-- 댓글 수가 0이 아닐 때만 표시 -->
									<c:if test="${vo.replyCnt > 0}">
									    <!-- 배경색 없이 빨간색 글씨로 댓글 수 표시 -->
									    <span style="color: red; font-size: 12px;">${vo.replyCnt}</span>
									</c:if>
								</td>
								<td class="text-center col-lg-2 col-sm-1"><c:out value="${vo.modDt}" escapeXml="true"/></td>
								
								<!-- 등록자 이름을 한 번만 출력하기 위한 변수 선언 -->
								<c:set var="printedName" value="false" />
								
								<!-- 사용자 목록을 순회하면서 조건을 확인 -->
								<c:forEach items="${users}" var="user">
									<c:if test="${vo.modId eq user.email and not printedName}">
										
										<!-- 조건을 만족하는 경우에만 사용자 이름을 출력하고, printedName을 true로 설정 -->
										<td class="text-center col-lg-2">${user.name}</td>
										<c:set var="printedName" value="true" />
									</c:if>
								</c:forEach>
							
							<!-- 사용자 이름이 출력되지 않은 경우 빈 칸 출력 -->
							<c:if test="${not printedName}">
							    <td class="text-center col-lg-2">-</td>
							</c:if>
							
								<td class="text-center col-lg-1"><c:out value="${vo.readCnt}" /></td>
								<td style="display: none;"><c:out value="${vo.seq}" /></td>
							</tr>              
						</c:forEach>
						<!--// 반복문 -->      
				    </c:when>
				    <c:otherwise>
						<tr>
                            <td colspan="99" class="text-center">조회된 데이터가 없습니다..</td>
						</tr>              
				    </c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<!--// table -------------------------------------------------------------->

		<div class="button-container">
			<input type="button" value="글쓰기" class="button" id="moveToReg">
		</div>

		<!-- 페이징 : 함수로 페이징 처리 
         총글수, 페이지 번호, 페이지 사이즈, bottomCount, url,자바스크립트 함수
    -->
	   <div class="pagination-container">
			<div class="container-fluid">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<div class="pagination d-flex justify-content-center">
								<nav>${pageHtml}</nav>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--// 페이징 ---------------------------------------------------------------->

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
				</div>
			</div>

		</form>
		<br> <br>
		<!--// 검색 ----------------------------------------------------------------->

	</div>
	<br>
	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

</body>
</html>