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
		// 페이지가 로드될 때 실행되는 코드
		var searchDiv = '${param.subjectCode}'; // URL 파라미터에서 searchDiv 값 가져오기
		console.log(searchDiv);
		var selectBox = document.getElementById("searchDiv");
		if (searchDiv) {
			// searchDiv 값이 존재하는 경우 해당 값을 가진 옵션을 선택합니다.
			for (var i = 0; i < selectBox.options.length; i++) {
				if (selectBox.options[i].value === searchDiv) {
					selectBox.options[i].selected = true;
					break;
				}
			}
		}
		console.log(selectBox.value); // 선택된 옵션의 값을 출력합니다.

	});//--DOMContentLoaded

	function doRetrieve() {
		var searchDiv = document.getElementById("searchDiv").value;

		// 새 URL로 이동
		window.location.href = "${CP}/subject/moveToScoreReg.do?subjectCode="
				+ searchDiv;

	}

	function doSave() {
		// 모든 훈련생의 출석 상태를 저장하기 위해 테이블 내의 모든 select 요소를 찾습니다.

		// 등록 횟수를 저장하는 변수
		var count = 0;

		//hidden input session 요소의 값을 가져옵니다.
		var sessionEmail = document.getElementById('sessionEmail').value;
		console.log("Session Email:", sessionEmail);

		var saveButton = document.getElementById('doSave');
		var selectElements = document
				.querySelectorAll('#subjectScoreTable input[id="score"]');
		var traineeEmails = document
				.querySelectorAll('#subjectScoreTable input[id="traineeEmail"]');
		var courseCode = document.getElementById('courseCode').value;
		var subjectCode = '${param.subjectCode}'; // URL 파라미터에서 searchDiv 값 가져오기

		//confirm
		if (confirm("저장 하시겠습니까?") == false)
			return;

		// 각 select 요소의 값을 가져와서 서버로 전송할 데이터로 만듭니다.
		var attendData = [];
		selectElements.forEach(function(selectElement, index) {
			var traineeEmail = traineeEmails[index].value;
			var score = selectElement.value;
			var data = {
				trainee : traineeEmail,
				professor : sessionEmail, // 교수님의 이름은 세션에서 가져옵니다.
				score : score,
				subjectCode : subjectCode,
				courseCode : courseCode
			};
			attendData.push(data);

			console.log("trainee:", traineeEmail);

			console.log("score:", score);

			console.log("subjectCode:", subjectCode);

			console.log("courseCode:", courseCode);

			$.ajax({
				type : "POST",
				url : "/ehr/subject/doSave.do",
				dataType : "json",
				data : {
					trainee : traineeEmail,
					professor : sessionEmail, // 교수님의 이름은 세션에서 가져옵니다.
					score : score,
					subjectCode : subjectCode,
					coursesCode : courseCode
				},
				success : function(data) { // 통신 성공
					console.log("success data:", data);
					if ("1" === data.msgId) {
						console.log(data.msgContents);
						count++;
						// 성공 시 필요한 작업 수행
					} else {
						console.log(data.msgContents);

						// 실패 시 필요한 작업 수행
					}
				},
				error : function(xhr, status, error) { // 실패시 처리
					console.error("error:", error);
				},
				complete : function(xhr, status) { // 성공/실패와 관계없이 수행!
					console.log("complete:", status);

					// 모든 AJAX 요청이 완료되었을 때 count와 loop의 길이를 비교하여 alert 표시
					if (count === selectElements.length) {
						alert("학생들의 점수를 저장했습니다.");
						window.location.reload();
					}

				}
			});
		});

		console.log(attendData);
	}

	function doUpdate(button) {
		// 클릭한 버튼의 부모 요소를 통해 해당 행(tr)을 찾습니다.
		var row = button.parentNode.parentNode;

		// 해당 행에서 이름과 출석 여부를 찾아 값을 가져옵니다.
		var traineeName = row.querySelector("#traineeName").innerText;
		var traineeEmail = row.querySelector("#traineeEmail").value;
		var score = row.querySelector("#score").value;

		var courseCode = document.getElementById('courseCode').value;
		var subjectCode = '${param.subjectCode}'; // URL 파라미터에서 searchDiv 값 가져오기

		// 가져온 값 확인
		console.log("traineeEmail:", traineeEmail);
		console.log("score:", score);

		// 여기에 수정 로직을 추가하세요.
		// AJAX 요청을 통해 서버에 수정 요청을 보낼 수 있습니다.

		//confirm
		if (confirm("수정 하시겠습니까?") == false)
			return;

		$.ajax({
			type : "POST",
			url : "/ehr/subject/doUpdate.do",
			asyn : "true",
			dataType : "html",
			data : {
				trainee : traineeEmail,
				score : score,
				subjectCode : subjectCode,
				coursesCode : courseCode
			},
			success : function(data) {//통신 성공     
				console.log("success data:" + data);
				alert(traineeName + "의 출석정보가 수정되었습니다.");
				window.location.reload();
			},
			error : function(data) {//실패시 처리
				console.log("error:" + data);
			},
			complete : function(data) {//성공/실패와 관계없이 수행!
				console.log("complete:" + data);
			}
		});
	}
</script>

<style>
.form-control1 {
    display: block;
    width: 160%;
    padding: 0.375rem -1.25rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: var(--bs-body-color);
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background-color: var(--bs-body-bg);
    background-clip: padding-box;
    border: var(--bs-border-width) solid var(--bs-border-color);
    border-radius: var(--bs-border-radius);
    transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
}

.my-custom-row {
    display: flex;
    flex-wrap: wrap;
    margin: -85px -87px 0px -212px;
}
/* 테이블과 관련된 스타일 */
.table th, .table td {
  padding: 0.5rem; /* 셀 내부의 padding을 조절합니다 */ 
}

 /* 선택적으로 테이블 행의 높이를 조절합니다 */
.table tr {
  height: auto; /* 필요에 따라 조절 */
}

.table-responsive {
    max-width: 960px; 
    margin: 0 auto; 
    overflow-x: auto;
}

.table {
    width: 100%;
    margin-bottom: 1rem;
    background-color: transparent;
}

@media (max-width: 768px) {
    .table-responsive {
        max-width: 100%;
    }
}
</style>
</head>
<body>
	
		<!-- Spinner Start -->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>
	<div class="container">
	
		<input type="hidden" id="sessionEmail"
			value="${sessionScope.user.email}" />

			<!-- 제목 -->
			<div class="row">
				<div class="col-lg-12">
					<h2 class="page-header" style="text-align: center;">성적등록</h2>
				</div>
			</div>
			<br> <br>
		
			<div class="container col-md-6">
				<table class="table">
					<tbody>
						<tr>
							<td class="form-label">훈련과정명</td>
							<td><input type="text" class="form-control ppl_input"
								readonly="readonly" name="courseName" id="courseName"
								value="${course.courseName}_${course.numberOfTimes}회차" style="width: 110%;"
								maxlength="30"> <input type="hidden" id="courseCode"
								value="${course.courseCode }" /></td>
						</tr>
						<tr>
							<td class="form-label">훈련 기관명</td>
							<td><input type="text" class="form-control"
								name="academyName" id="academyName" size="20"
								value="${course.academyName}" style="width: 110%;" maxlength="21" readonly></td>
						</tr>
						<tr>
							<td class="form-label">훈련기간</td>
							<td><input type="text" class="form-control" name="period"
								id="period" value="${course.startDate} ~ ${course.endDate}"
								readonly="readonly" style="width: 110%;" maxlength="30"></td>
						</tr>
					</tbody>
				</table>
			</div>

	<br>

	<!-- 검색구분 -->
	<div class="text-center" >
		<label for="searchDiv">과목선택:</label> <select name="searchDiv"
			id="searchDiv" class="pcwk_select"
			onchange="doRetrieve();">
			<c:forEach var="subject" items="${subjectCodeList}">
				<option value="${subject.detCode}"
					<c:if test="${subject.detCode == param.searchDiv}">selected</c:if>>${subject.detName}</option>
			</c:forEach>
		</select>
	</div>
	<br>
	<div class="container-fluid testimonial py-2" >
		<!-- table -->
		<table id="subjectScoreTable" class="table table-responsive">
			<thead>
				<tr>
					<th scope="col" class="text-center col-lg-2  col-sm-2">순번</th>
					<th scope="col" class="text-center col-lg-2  col-sm-2">이름</th>
					<th scope="col" class="text-center col-lg-2  col-sm-2">과목</th>
					<th scope="col" class="text-center col-lg-2  col-sm-2">점수</th>
					<c:choose>
						<c:when test="${not empty subjectScores }">
							<th scope="col" class="text-center col-lg-2  col-sm-2"></th>
						</c:when>
					</c:choose>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty trainees }">
						<c:forEach var="vo" items="${trainees}" varStatus="loop">
							<tr>
								<td class="text-center">${loop.index + 1}</td>
								<td class="text-center" id="traineeName">${vo.name}<input
									type="hidden" id="traineeEmail" value="${vo.email }">
								</td>
								<c:forEach var="subject" items="${subjectCodeList}">
									<c:if test="${subject.detCode eq param.subjectCode}">
										<!-- subjectCode와 detCode가 일치하는 경우 -->
										<td class="text-center">
											<div class="col-auto" id="subjectName">
												${subject.detName}</div>
										</td>
									</c:if>
								</c:forEach>


								<c:forEach var="subjectScore" items="${subjectScores}">
									<c:if test="${subjectScore.trainee eq vo.email}">
										<td class="text-center">
											<div class="col-auto">
												<input type="number" value="${subjectScore.score}"
													id="score" name="score" min="0" max="100" />
											</div>
										</td>
									</c:if>
								</c:forEach>
								<!-- 추가 코드: subjectScore가 없을 때 빈 칸 생성 -->
								<c:if test="${empty subjectScores}">
									<td class="text-center">
										<div class="col-auto">
											<input type="number" value="0" id="score" name="score"
												min="0" max="100" />
										</div>
									</td>
								</c:if>

								<c:choose>
									<c:when test="${not empty subjectScores }">
										<td class="text-center"><input type="button" value="수정"
											class="btn btn-primary" id="doUpdate"
											onclick="doUpdate(this);"></td>
									</c:when>
								</c:choose>
							</tr>
						</c:forEach>
					</c:when>
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
		<!-- button --------------------------------------------------------------->
		<c:choose>
			<c:when test="${empty subjectScores }">
				<div class="row g-1 justify-content-end">
					<div class="col-auto">
						<!-- 열의 너비를 내용에 따라 자동으로 설정 -->
						<input type="button" value="전체 저장" class="button" id="doSave"
							onclick="window.doSave();">
					</div>
				</div>
			</c:when>
		</c:choose>
	</div>
</div>
	
	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

</body>
</html>