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

	});//--DOMContentLoaded

	function reloadPage(input) {
		// 변경된 날짜 값을 가져옵니다.
		var selectedDate = input.value;

		// 입력된 날짜를 '-'로 분리하여 배열로 만듭니다.
		var parts = selectedDate.split("-");
		// 분리된 배열의 각 요소를 합쳐서 'yyyyMMdd' 형식의 문자열로 만듭니다.
		var yyyyMMdd = parts[0] + parts[1] + parts[2];
		// 문자열을 정수로 변환하여 반환합니다.

		// URL에 변경된 날짜를 쿼리 매개변수로 추가하여 새로고침합니다.
		var url = window.location.href.split('?')[0] + '?calID=' + yyyyMMdd;
		window.location.href = url;
	}

	// 페이지가 로드될 때 URL에서 날짜를 가져와 input 요소에 설정합니다.
	window.onload = function() {
		var urlParams = new URLSearchParams(window.location.search);
		var selectedDate = urlParams.get('calID');
		if (selectedDate) {
			var formattedDate = selectedDate.substring(0, 4) + "-"
					+ selectedDate.substring(4, 6) + "-"
					+ selectedDate.substring(6);
			console.log(formattedDate);
			if (selectedDate) {
				document.getElementById('calID').value = formattedDate;
			}
		}
	};

	// 주어진 정수형 calID를 "YYYY-MM-DD" 형식인 "2024-03-04"로 변환하는 함수
	function formatDate(calID) {
		// 정수형 calID를 문자열로 변환하고, 길이가 8이 되도록 0으로 채웁니다.
		var calIDString = calID.toString().padStart(8, '0');

		// 연도, 월, 일을 추출합니다.
		var year = calIDString.substr(0, 4);
		var month = calIDString.substr(4, 2);
		var day = calIDString.substr(6, 2);

		// 변환된 날짜 문자열을 반환합니다.
		return year + '-' + month + '-' + day;
	}
</script>

<style>
/* 테이블과 관련된 스타일 */
.table th, .table td {
	padding: 0.5rem; /* 셀 내부의 padding을 조절합니다 */
}

/* 선택적으로 테이블의 너비를 조절합니다 */
.table-responsive {
	margin: 0 auto; /* 상하 마진은 0, 좌우 마진은 자동으로 설정 */
}

/* 선택적으로 테이블 행의 높이를 조절합니다 */
.table tr {
	height: auto; /* 필요에 따라 조절 */
}
</style>
</head>
<body>

	<input type="hidden" id="sessionEmail"
		value="${sessionScope.user.email}" />

	<div class="container">
		<!-- 제목 -->
		<div class="row">
			<div class="col-lg-12">
				<h2 class="page-header" style="text-align: center;">출석 현황</h2>
			</div>
		</div>
		<br> <br>
		<div>
			<div class="container col-md-6">
				<table class="table">
					<tbody>
						<tr>
							<td class="form-label">훈련과정명</td>
							<td><input type="text" class="form-control ppl_input"
								readonly="readonly" name="courseName" id="courseName"
								value="${course.courseName}_${course.numberOfTimes}회차" size="20"
								maxlength="30"></td>
						</tr>
						<tr>
							<td class="form-label">훈련 기관명</td>
							<td><input type="text" class="form-control"
								name="academyName" id="academyName" size="20"
								value="${course.academyName}" maxlength="21" readonly></td>
						</tr>
						<tr>
							<td class="form-label">훈련기간</td>
							<td><input type="text" class="form-control" name="period"
								id="period" value="${course.startDate} ~ ${course.endDate}"
								readonly="readonly" size="20" maxlength="30"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="container-fluid testimonial py-2">
			<!-- table -->
			<table id="attendanceTable" class="table table-responsive">
				<thead>
					<tr>
						<th scope="col" class="text-center col-lg-2  col-sm-2">순번</th>
						<th scope="col" class="text-center col-lg-2  col-sm-2">날짜</th>
						<th scope="col" class="text-center col-lg-2  col-sm-2">출석여부</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<%-- 조회데이터가 있는 경우:jsp comment(html에 노출 안됨) --%>
						<c:when test="${not empty attendances }">
							<c:forEach var="vo" items="${attendances}" varStatus="loop">
								<tr>
									<td class="text-center">${loop.index + 1}</td>
									<td class="text-center"><input type="hidden"
										id="calID${loop.index}" value="${vo.calID}"> <script>
											// JavaScript를 사용하여 calID 값을 원하는 형식으로 변환
											var calID = document
													.getElementById('calID${loop.index}').value;
											var formattedDate = calID.replace(
													/(\d{4})(\d{2})(\d{2})/,
													'$1-$2-$3');
											document.write(formattedDate);
										</script></td>
									<td class="text-center"><c:forEach var="attendStatus"
											items="${attendStatusList}">
											<c:if test="${attendStatus.detCode eq vo.attendStatus}">
			                            ${attendStatus.detName}
			                        </c:if>
										</c:forEach></td>
								</tr>
							</c:forEach>
						</c:when>
						<%-- 조회데이터가 없는 경우:jsp comment(html에 노출 않됨) --%>
						<c:otherwise>
							<tr>
								<td colspan="99" class="text-center">훈련 과정이 현재 진행 중이 아닙니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<!--// table -------------------------------------------------------------->
			<br> <br>
		</div>
	</div>
	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
</body>
</html>