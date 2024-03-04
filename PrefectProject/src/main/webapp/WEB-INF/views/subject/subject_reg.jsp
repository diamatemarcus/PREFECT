<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.subject.domain.SubjectVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<meta charset="UTF-8">
<title>과목 등록 및 목록</title>
</head>
<body>
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>

	<div class="container" id="subjectReg" style="display: none;">
		<!-- 과목 등록 부분 -->
		<div class="row">
			<div class="col-lg-12">
				<h3 class="page-header" style="text-align: center;">과목 등록</h3>
			</div>
		</div>
		<br><br>
		<div class="row justify-content-end">
			<div class="col-auto">
				<input type="button" class="btn btn-primary" value="등록"
					id="doUpdate" onclick="doSave()"> <input type="button"
					class="btn btn-primary" value="목록" id="moveToList"
					onclick="moveToList()">
			</div>
		</div>
		<div class="container-fluid testimonial py-2" >
			<form action="#" name="subjectRegFrm">
				<label for="subject" class="form-label">새 과목 이름</label> <input
					type="text" class="form-control" name="subject" id="subject"
					value="" placeholder="추가 할 과목 이름을 입력해 주세요."
					maxlength="11">
			</form>
		</div>
	</div>


	<div class="container" id="subjectList" style="display: none;">
		<!-- 과목 목록 부분 -->
		<div class="row">
			<div class="col-lg-12">
				<h2 class="page-header" style="text-align: center;">과목 목록</h2>
			</div>
		</div>
		<br> <br>
		<div class="row justify-content-end">
			<div class="col-auto">
				<input type="button" class="btn btn-primary" value="등록"
					id="doUpdate" onclick="moveToReg()"> <input type="button"
					class="btn btn-primary" value="목록" id="moveToList"
					onclick="moveToList()">
			</div>
		</div>
		<div class="container-fluid testimonial py-2">
			<!-- table -->
			<table id="subjectTable" class="table table-responsive">
				<thead>
					<tr>
						<th scope="col" class="text-center col-lg-2  col-sm-2">순번</th>
						<th scope="col" class="text-center col-lg-2  col-sm-2">과목</th>
						<th scope="col" class="text-center col-lg-2  col-sm-2"></th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty subjectCodeList }">
							<c:forEach var="vo" items="${subjectCodeList}" varStatus="loop">
								<tr>
									<td class="text-center">${loop.index + 1}</td>
									<td class="text-center" id="subjectName">${vo.detName}<input
										type="hidden" id="detCode" value="${vo.detCode }" />
									</td>
									<td class="text-center"><input type="button" value="삭제"
										class="btn btn-primary" id="doDelete"
										onclick="doDelete(this);"></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="99" class="text-center">등록된 과목이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
	<script>
		$(document).ready(function() {
			// 현재 URL 가져오기
			var currentUrl = window.location.href;

			// URL에 따라 분기
			if (currentUrl.indexOf("moveToSubjectReg.do") !== -1) {
				// moveToSubjectReg.do인 경우의 처리
				console.log("moveToSubjectReg.do 요청입니다.");
				document.getElementById('subjectReg').style.display = 'block'; // 과목 등록 부분 보이기
			} else if (currentUrl.indexOf("moveToSubjectList.do") !== -1) {
				// moveToSubjectList.do인 경우의 처리
				console.log("moveToSubjectList.do 요청입니다.");
				document.getElementById('subjectList').style.display = 'block'; // 과목 목록 부분 보이기
			} else {
				// 다른 경우의 처리
				console.log("다른 URL 요청입니다.");
			}
		});

		function doSave() {
			console.log("----------------------");
			console.log("-doSave()-");
			console.log("----------------------");

			let subject = document.querySelector("#subject").value;

			var regDd = "${sessionScope.user.email}";
			console.log("User Email:", regDd);

			if (eUtil.isEmpty(subject) == true) {
				alert('과목이름을 입력 하세요.');
				//$("#email").focus();//사용자 id에 포커스
				document.querySelector("#subject").focus();
				return;
			}

			//confirm
			if (confirm("등록 하시겠습니까?") == false)
				return;

			$.ajax({
				type : "POST",
				url : "/ehr/subject/doSaveSubject.do",
				asyn : "true",
				dataType : "html",
				data : {
					regDd : regDd,
					detName : subject,
					modId : regDd
				},
				success : function(data) {//통신 성공     
					console.log("success data:" + data);
					//data:{"msgId":"1","msgContents":"dd가 등록 되었습니다.","no":0,"totalCnt":0,"pageSize":0,"pageNo":0}
					let parsedJSON = JSON.parse(data);
					if ("1" === parsedJSON.msgId) {
						alert(parsedJSON.msgContents);
						moveToList();
					} else {
						alert(parsedJSON.msgContents);
					}

				},
				error : function(data) {//실패시 처리
					console.log("error:" + data);
				},
				complete : function(data) {//성공/실패와 관계없이 수행!
					console.log("complete:" + data);
				}
			});
		}

		function moveToList() {
			console.log("----------------------");
			console.log("-moveToList()-");
			console.log("----------------------");

			window.location.href = "/ehr/subject/moveToSubjectList.do";

		}

		function moveToReg() {
			console.log("----------------------");
			console.log("-moveToReg()-");
			console.log("----------------------");

			window.location.href = "/ehr/subject/moveToSubjectReg.do";

		}

		function doDelete(button) {
			// 클릭한 버튼의 부모 요소를 통해 해당 행(tr)을 찾습니다.
			var row = button.parentNode.parentNode;

			// 해당 행에서 이름과 출석 여부를 찾아 값을 가져옵니다.;
			var detCode = row.querySelector("#detCode").value;
			var subjectName = row.querySelector("#subjectName").innerText;

			console.log("detCode:", detCode);

			// 여기에 수정 로직을 추가하세요.
			// AJAX 요청을 통해 서버에 수정 요청을 보낼 수 있습니다.

			//confirm
			if (confirm("삭제 하시겠습니까?") == false)
				return;

			$.ajax({
				type : "GET",
				url : "/ehr/subject/doDeleteSubject.do",
				asyn : "true",
				dataType : "json",
				data : {
					detCode : detCode
				},
				success : function(data) {//통신 성공     
					console.log("success data:" + data);
					alert(subjectName + "이 삭제되었습니다.");
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
</body>
</html>
