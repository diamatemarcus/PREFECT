<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
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
<style>
#myScheduleForm {
	display: none;
}

.col-lg-10 {
	max-width: 60%;
}

.day-cell:hover {
	background-color: #64FF64; /* 호버 시 배경색을 변경합니다. */
	cursor: pointer; /* 마우스 커서 모양을 변경합니다. */
}

#doSaveSchedule, #doDeleteSchedule, #doUpdateSchedule, .btn-close {
	color: aliceblue;
}

#calendarTable th {
	background-color: #FFFFFF;
	color: black; */
	padding: 8px;
	text-align: center;
}

#calendarTable th {
	background-color: #3986FF;
	color: white;
	padding: 8px;
	text-align: center;
}

#calendarTable td {
	padding: 8px;
	text-align: center;
	border: 1px solid #ddd;
}

#calendarTable .day-cell {
	text-align: left;
	cursor: pointer;
	transition: background-color 0.3s;
	padding-left: 10px;
}

#calendarTable .day-cell:hover {
	background-color: #D2E6FA;
}

#calendarTable .weekend {
	color: #ef3b3b;
}

#calendarTable .today {
	background-color: #a7d8a7;
}

#calendarTable {
	width: 100%;
	table-layout: auto;
	border-collapse: collapse;
	width: 100%;
}

#calendarTable th, #calendarTable td {
	padding: 8px;
	text-align: center;
	border: 3px solid #3986FF;
	word-break: break-word;
	max-width: 200px;
}

#calendarTable td {
	padding: 8px;
	text-align: center;
	border: 3px solid #3986FF;
	word-break: break-word;
	max-width: 200px;
	height: 100px;
}

#calendarTable .inner-table td {
	height: 40px; /* 원하는 높이로 조절하세요 */
}

.modal-content {
	background-color: #f8f9fa; /* 모달 배경색 */
	border-radius: 10px; /* 모달의 모서리를 둥글게 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 모달에 그림자 효과 추가 */
}

.modal-header {
	border-bottom: 1px solid #dee2e6; /* 헤더 하단에 선 추가 */
	background-color: #e9ecef; /* 헤더 배경색 */
	border-top-left-radius: 10px; /* 왼쪽 위 모서리 둥글게 */
	border-top-right-radius: 10px; /* 오른쪽 위 모서리 둥글게 */
}

.modal-body {
	padding: 20px; /* 내부 패딩 */
}

.modal-footer {
	border-top: 1px solid #dee2e6; /* 푸터 상단에 선 추가 */
	background-color: #e9ecef; /* 푸터 배경색 */
	border-bottom-left-radius: 10px; /* 왼쪽 아래 모서리 둥글게 */
	border-bottom-right-radius: 10px; /* 오른쪽 아래 모서리 둥글게 */
}
</style>

<script>
	document
			.addEventListener(
					"DOMContentLoaded",
					function() {
						//DOMContentLoaded-----------------------------------------
						console.log("DOMContentLoaded");

						let email = document.querySelector("#email").value;

						const saveScheduleBTN = document
								.querySelector("#doSaveSchedule");

						const nextMonthBTN = document
								.querySelector("#nextMonth");
						const lastMonthBTN = document
								.querySelector("#lastMonth");

						let year = document.querySelector("#year").value;
						let month = document.querySelector("#month").value;

						console.log("년도 : ", year);
						console.log("월 : ", month);

						// "01" 형식을 정수 1로 바꾸는 과정
						let monthInt = parseInt(month, 10);
						console.log(monthInt);

						/* let now = new Date();   // 현재 날짜 및 시간
						let month = now.getMonth();   // 월
						console.log("월 : ", month + 1); */

						if (monthInt <= 1) {
							lastMonthBTN.style.display = "none";
						}

						if (monthInt >= 12) {
							nextMonthBTN.style.display = "none";
						}

						//------------------------------다음 달 버튼
						nextMonthBTN
								.addEventListener(
										"click",
										function(e) {

											console.log("nextMonthBTN click");

											//다음 달
											monthInt++;

											//정수를 "01" 형식 String으로 바꾸는 과정
											let stringValue = monthInt < 10 ? '0'
													+ monthInt
													: String(monthInt);
											console.log(stringValue);

											//(#month) value 값 변경
											month = stringValue;
											console.log(month);

											window.location.href = "${CP}/calendar/doRetrieveCalendar.do?year="
													+ year + "&month=" + month;

										});

						//--------------------------이전 달 버튼
						lastMonthBTN
								.addEventListener(
										"click",
										function(e) {

											console.log("lastMonthBTN click");

											//다음 달
											monthInt--;

											//정수를 "01" 형식 String으로 바꾸는 과정
											let stringValue = monthInt < 10 ? '0'
													+ monthInt
													: String(monthInt);
											console.log(stringValue);

											//(#month) value 값 변경
											month = stringValue;
											console.log(month);

											window.location.href = "${CP}/calendar/doRetrieveCalendar.do?year="
													+ year + "&month=" + month;

										});

						let isFormVisible = false;

						//-------------------------------- 일정 테이블 가져오는 메소드
						function scheduleRetrieve(calID) {
							let form = document
									.getElementById("myScheduleForm");
							form.style.display = "none";
							isFormVisible = false;

							console.log('----------------------------');
							console.log('scheduleRetrieve');
							console.log(calID);
							console.log('----------------------------');

							document.querySelector("#calID").value = calID;

							if (calID == "") {
								return;
							}

							let calIDNum = parseInt(calID);
							console.log(calIDNum);

							//window.location.href ="/ehr/user/doSelectOne.do?email="+email;
							$
									.ajax({
										type : "GET",
										url : "/ehr/schedule/doSelectAllSchedule.do",
										asyn : "true",
										dataType : "json",
										data : {
											"calID" : calID,
											"email" : email
										},
										success : function(data) {//통신 성공
											console.log("success data:"
													+ data.length);
											//동적인 테이블 헤더 생성
											let tableHeader = '<thead>\
										                    <tr>\
										                    	<th scope="col" class="text-center"></th>\
											                    <th scope="col" class="text-center" >순번</th>\
											                    <th scope="col" class="text-center" >일정</th>\
											                    <th scope="col" class="text-center" >설명</th>\
										                    </tr>\
										                </thead>';
											//동적 테이블 body		                
											let tableBody = ' <tbody>';

											/* for (let i = 0; i < data.length; i++) {
												tableBody += '<tr>\
													<td class="text-center">'
														+ data[i].calID
														+ '</td>\
											        <td class="text-left">'
														+ data[i].scheduleID
														+ '</td>\
											        <td class="text-left">'
														+ data[i].title
														+ '</td>\
											        <td class="text-left">'
														+ data[i].explanation
														+ '</td>\
											      </tr>\
											     ';
											} */

											for (let i = 0; i < data.length; i++) {
												tableBody += '<tr>\
											                        <td class="text-center"><input type="checkbox" name="scheduleID" value="' + data[i].scheduleID + '"></td>\
											                        <td class="text-left"><input type="hidden" id="scheduleID" value="'
											                            + data[i].scheduleID + '">'
														+ (i + 1)
														+ '</td>\
											                        <td class="text-left">'
														+ data[i].title
														+ '</td>\
											                        <td class="text-left">'
														+ data[i].explanation
														+ '</td>\
											                    </tr>';
											}

											tableBody += ' </tbody>';

											console.log(tableHeader);
											console.log(tableBody);

											let dynamicTable = '<table id="scheduleTable"  class="table table-bordered border-primary table-hover table-striped">'
													+ tableHeader
													+ tableBody
													+ '</table>';
											//
											$("#modalTable").html(dynamicTable);
											$('#staticBackdrop').modal('show');

											// modal popup 닫기 및 페이지 리로드
											$('#staticBackdrop').on(
													'hidden.bs.modal',
													function(e) {
														// 모달이 숨겨지면 페이지를 리로드합니다.
														location.reload();
													});
										},
										error : function(data) {//실패시 처리
											console.log("error:" + data);
										},
										complete : function(data) {//성공/실패와 관계없이 수행!
											console.log("complete:" + data);
										}
									});

						}

						//----------------------------------------- 날짜 선택해서 일정 보여주기 (jquery:table 데이터 선택)     
						$("#calendarTable>tbody")
								.on(
										"dblclick",
										"td",
										function(e) {

											// 클릭된 요소의 날짜 값 가져오기
											let calID = $(this).data("day");
											console.log("Clicked day:", calID);

											document
													.querySelector("#explanation").value = "";
											document.querySelector("#title").value = "";

											let form = document
													.getElementById("myScheduleForm");
											form.style.display = "none";
											isFormVisible = false;

											console
													.log('----------------------------');
											console.log('calendarTable>tbody');
											console
													.log('----------------------------');

											document.querySelector("#calID").value = calID;

											if (calID == "") {
												return;
											}

											let calIDNum = parseInt(calID);
											console.log(calIDNum);

											scheduleRetrieve(calID);
										});

						//-------------------------------------------------------------- 일정 추가 버튼
						saveScheduleBTN
								.addEventListener(
										"click",
										function(e) {
											let form = document
													.getElementById("myScheduleForm");

											console
													.log('saveScheduleBTN click');

											// form을 숨겼으면 보이도록, 보이면 숨기도록 설정
											if (!isFormVisible) {
												form.style.display = "block";
											} else {

												let calID = document
														.querySelector("#calID").value;
												let title = document
														.querySelector("#title").value;
												let explanation = document
														.querySelector("#explanation").value;

												console.log("title:" + title);
												console.log("calID:" + calID);
												console.log("explanation:"
														+ explanation);
												console.log("email:" + email);

												if (eUtil.isEmpty(title) === true) {
													alert("제목을 입력하세요.");
													form.title.focus();
													return;
												}

												if (eUtil.isEmpty(explanation) === true) {
													alert("내용을 입력하세요.");
													from.explanation.focus();
													return;
												}

												if (window.confirm("등록하시겠습니까?") === false) {
													return;
												}

												$
														.ajax({
															type : "POST",
															url : "/ehr/schedule/doSave.do",
															async : true,
															dataType : "json",
															data : {
																"calID" : calID,
																"title" : title,
																"explanation" : explanation,
																"email" : email
															},
															success : function(
																	data) {// 통신 성공 시의 처리
																console
																		.log("data.msgId:"
																				+ data.msgId);
																console
																		.log("data.msgContents:"
																				+ data.msgContents);

																if ('1' == data.msgId) {
																	alert(data.msgContents);
																	scheduleRetrieve(calID);
																} else {
																	alert(data.msgContents);
																}
															},
															error : function(
																	data) {// 통신 실패 시의 처리
																console
																		.log("error:"
																				+ data);
															},
															complete : function(
																	data) {// 성공/실패와 관계없이 수행되는 처리
																console
																		.log("complete:"
																				+ data);
															}
														});

												form.style.display = "none";
												document
														.querySelector("#explanation").value = "";
												document
														.querySelector("#title").value = "";

											}

											// isFormVisible 변수 업데이트
											isFormVisible = !isFormVisible;
										});

						//------------------------------------------------------여러 일정 한번에 삭제
						$("#doDeleteSchedule")
								.click(
										function() {
											// 체크된 일정의 scheduleID 값을 배열로 저장
											var scheduleIDs = [];
											$(
													"input[name='scheduleID']:checked")
													.each(
															function() {
																scheduleIDs
																		.push($(
																				this)
																				.val());
															});

											// 배열이 비어 있는지 확인
											if (scheduleIDs.length === 0) {
												alert("삭제할 일정을 선택해주세요.");
												return;
											}

											let calID = document
													.querySelector("#calID").value;

											// scheduleIDs 배열을 콘솔에 출력
											console.log("scheduleIDs:",
													scheduleIDs);
											console.log("calID:", calID);
											let length = scheduleIDs.length;

											// 여러 일정 삭제 Ajax 요청
											$
													.ajax({
														type : "GET",
														url : "/ehr/schedule/doDeleteMultiple.do",
														dataType : "json",
														data : {
															"scheduleIDs" : JSON
																	.stringify(scheduleIDs)
														},
														success : function(
																response) {
															// 삭제 성공 여부 확인
															if (response.msgId == length) {
																alert(response.msgContents); // 성공 메시지 표시
																scheduleRetrieve(calID);
															} else {
																alert(response.msgContents); // 실패 메시지 표시
															}
														},
														error : function(xhr,
																status, error) {
															console
																	.error(xhr.responseText); // 오류 메시지 출력
															alert("일정 삭제 중 오류가 발생했습니다.");
														}
													});
										});

						//------------------------------------------------------일정 수정
						$("#doUpdateSchedule")
								.click(
										function() {
											let form = document
													.getElementById("myScheduleForm");

											// 체크된 일정의 scheduleID 값을 배열로 저장
											var scheduleIDs = [];
											$(
													"input[name='scheduleID']:checked")
													.each(
															function() {
																scheduleIDs
																		.push($(
																				this)
																				.val());
															});

											// 배열이 비어 있는지 확인
											if (scheduleIDs.length === 0) {
												alert("수정할 일정을 선택해주세요.");
												return;
											}

											// 체크가 하나만 되어있는지 확인
											if (scheduleIDs.length > 1) {
												alert("수정할 일정을 한개만 선택해주세요.");
												return;
											}

											let calID = document
													.querySelector("#calID").value;

											// scheduleIDs 배열을 콘솔에 출력
											console.log("scheduleIDs:",
													scheduleIDs);
											console.log("calID:", calID);

											let scheduleID = scheduleIDs[0]

											// 여러 일정 삭제 Ajax 요청
											$
													.ajax({
														type : "GET",
														url : "/ehr/schedule/doSelectOne.do",
														dataType : "json",
														data : {
															"scheduleID" : scheduleID
														},
														success : function(data) {
															console
																	.log("success data:"
																			+ data);

															// form을 숨겼으면 보이도록, 보이면 숨기도록 설정
															if (!isFormVisible) {
																form.style.display = "block";

																console
																		.log("title: "
																				+ data.title);
																console
																		.log("explanation: "
																				+ data.explanation);

																document
																		.querySelector("#title").value = data.title;
																document
																		.querySelector("#explanation").value = data.explanation;

																console
																		.log("block");

															} else {

																let calID = document
																		.querySelector("#calID").value;
																let title = document
																		.querySelector("#title").value;
																let explanation = document
																		.querySelector("#explanation").value;

																console
																		.log("title:"
																				+ title);
																console
																		.log("calID:"
																				+ calID);
																console
																		.log("explanation:"
																				+ explanation);

																if (eUtil
																		.isEmpty(title) === true) {
																	alert("제목을 입력하세요.");
																	form.title
																			.focus();
																	return;
																}

																if (eUtil
																		.isEmpty(explanation) === true) {
																	alert("내용을 입력하세요.");
																	from.explanation
																			.focus();
																	return;
																}

																if (window
																		.confirm("수정하시겠습니까?") === false) {
																	return;
																}

																$
																		.ajax({
																			type : "POST",
																			url : "/ehr/schedule/doUpdate.do",
																			async : true,
																			dataType : "json",
																			data : {
																				"scheduleID" : scheduleIDs[0],
																				"title" : title,
																				"explanation" : explanation
																			},
																			success : function(
																					data) {// 통신 성공 시의 처리
																				console
																						.log("data.msgId:"
																								+ data.msgId);
																				console
																						.log("data.msgContents:"
																								+ data.msgContents);

																				if ('1' == data.msgId) {
																					alert(data.msgContents);
																					scheduleRetrieve(calID);
																				} else {
																					alert(data.msgContents);
																				}
																			},
																			error : function(
																					data) {// 통신 실패 시의 처리
																				console
																						.log("error:"
																								+ data);
																			},
																			complete : function(
																					data) {// 성공/실패와 관계없이 수행되는 처리
																				console
																						.log("complete:"
																								+ data);
																			}
																		});

																form.style.display = "none";
																document
																		.querySelector("#explanation").value = "";
																document
																		.querySelector("#title").value = "";

																console
																		.log("none");
															}

															// isFormVisible 변수 업데이트
															isFormVisible = !isFormVisible;

														},
														error : function(xhr,
																status, error) {
															console
																	.error(xhr.responseText); // 오류 메시지 출력
															alert("일정 수정 중 오류가 발생했습니다.");
														}
													});

										});

					});//--DOMContentLoaded
</script>
</head>
<body>

	<!-- Spinner Start -->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>
	<!-- Spinner End -->

	<!-- Tastimonial Start -->
	<div class="container">
		<input type="text" id="email" name="email"
			value="${sessionScope.user.email}">
		<!-- 제목 -->


		<div class="row page-header">
			<div class="col-lg-12" style="text-align: center;">
				<h2>캘린더</h2>
				<br>
			</div>
		</div>

		<div class="row">
			<div
				class="col-lg-12 d-flex justify-content-center align-items-center">
				<input type="button" value="이전" class="btn btn-primary me-2"
					id="lastMonth">
				<h2>${year}년${month}월</h2>
				<input type="button" value="다음" class="btn btn-primary ms-2"
					id="nextMonth">
			</div>
		</div>

		<div class="row">
			<div class="col-lg-12" style="text-align: center;">
				<!-- 연도 표시 -->
				<input type="hidden" name="year" id="year" value="${year}" readonly
					class="form-control" style="width: 80px;">
				<!-- 월 표시 -->
				<input type="hidden" name="month" id="month" value="${month}"
					readonly class="form-control" style="width: 60px;">
			</div>
			<!-- 텍스트 -->
			<div>
				<span style="color: #ef3b3b;">*날짜를 더블클릭하여 일정을 추가하세요.</span>
			</div>
		</div>

		<!-- 캘린더 table -->
		<div class="col-lg-12 "
			style="margin-top: 10px; margin-left: auto; margin-right: auto;">
			<table class="table table-bordered border-primary table-hover"
				id="calendarTable" style="margin-top: 10px; margin-bottom: 10px">
				<thead>
					<tr>
						<th scope="col" class="text-center weekend" style="width: 14.28%;">SUN</th>
						<th scope="col" class="text-center " style="width: 14.28%;">MON</th>
						<th scope="col" class="text-center " style="width: 14.28%;">TUE</th>
						<th scope="col" class="text-center " style="width: 14.28%;">WED</th>
						<th scope="col" class="text-center " style="width: 14.28%;">THU</th>
						<th scope="col" class="text-center " style="width: 14.28%;">FRI</th>
						<th scope="col" class="text-center weekend" style="width: 14.28%;">SAT</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty calendarList}">
							<!-- 반복문 -->
							<c:forEach var="vo" items="${calendarList}" varStatus="status">
								<tr>
									<!-- 일요일 -->
									<td class="day-cell" data-day="${vo.sun}">
										${vo.sun.substring(6)}
										<table class="inner-table">
											<!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
											<c:forEach var="schedule" items="${scheduleList}"
												varStatus="loop">
												<c:if test="${schedule.calID == vo.sun}">
													<tr>
														<td>${schedule.title}</td>
														<!-- 필요한 정보 추가 -->
													</tr>
												</c:if>
											</c:forEach>
										</table>
									</td>
									<!-- 월요일 -->
									<td class="day-cell" data-day="${vo.mon}">
										${vo.mon.substring(6)}
										<table class="inner-table">
											<!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
											<c:forEach var="schedule" items="${scheduleList}"
												varStatus="loop">
												<c:if test="${schedule.calID == vo.mon}">
													<tr>
														<td>${schedule.title}</td>
														<!-- 필요한 정보 추가 -->
													</tr>
												</c:if>
											</c:forEach>
										</table>
									</td>
									<!-- 화요일 -->
									<td class="day-cell" data-day="${vo.tue}">
										${vo.tue.substring(6)}
										<table class="inner-table">
											<!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
											<c:forEach var="schedule" items="${scheduleList}"
												varStatus="loop">
												<c:if test="${schedule.calID == vo.tue}">
													<tr>
														<td>${schedule.title}</td>
														<!-- 필요한 정보 추가 -->
													</tr>
												</c:if>
											</c:forEach>
										</table>
									</td>
									<!-- 수요일 -->
									<td class="day-cell" data-day="${vo.wed}">
										${vo.wed.substring(6)}
										<table class="inner-table">
											<!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
											<c:forEach var="schedule" items="${scheduleList}"
												varStatus="loop">
												<c:if test="${schedule.calID == vo.wed}">
													<tr>
														<td>${schedule.title}</td>
														<!-- 필요한 정보 추가 -->
													</tr>
												</c:if>
											</c:forEach>
										</table>
									</td>
									<!-- 목요일 -->
									<td class="day-cell" data-day="${vo.thu}">
										${vo.thu.substring(6)}
										<table class="inner-table">
											<!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
											<c:forEach var="schedule" items="${scheduleList}"
												varStatus="loop">
												<c:if test="${schedule.calID == vo.thu}">
													<tr>
														<td>${schedule.title}</td>
														<!-- 필요한 정보 추가 -->
													</tr>
												</c:if>
											</c:forEach>
										</table>
									</td>
									<!-- 금요일 -->
									<td class="day-cell" data-day="${vo.fri}">
										${vo.fri.substring(6)}
										<table class="inner-table">
											<!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
											<c:forEach var="schedule" items="${scheduleList}"
												varStatus="loop">
												<c:if test="${schedule.calID == vo.fri}">
													<tr>
														<td>${schedule.title}</td>
														<!-- 필요한 정보 추가 -->
													</tr>
												</c:if>
											</c:forEach>
										</table>
									</td>
									<!-- 토요일 -->
									<td class="day-cell" data-day="${vo.sat}">
										${vo.sat.substring(6)}
										<table class="inner-table">
											<!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
											<c:forEach var="schedule" items="${scheduleList}"
												varStatus="loop">
												<c:if test="${schedule.calID == vo.sat}">
													<tr>
														<td>${schedule.title}</td>
														<!-- 필요한 정보 추가 -->
													</tr>
												</c:if>
											</c:forEach>
										</table>
									</td>
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
		</div>

	</div>
	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<input type="hidden" name="calID" id="calID" /> <input
						type="button" value="새 일정 등록" class="btn btn-primary"
						id="doSaveSchedule" style="margin-right: 2px"> <input
						type="button" value="삭제" class="btn btn-primary"
						id="doDeleteSchedule" style="margin-right: 2px" style="aliceblue">
					<input type="button" value="수정" class="btn btn-primary"
						id="doUpdateSchedule">
					<button type="button" class="btn-close" id="close"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" id="modalTable">
					<!-- 일정 table -->
				</div>

				<!-- form -->
				<div id="myScheduleForm" class="modal-body">
					<form id="scheduleForm">
						<!-- 여기에 form 요소들을 넣으세요 -->
						<input type="hidden" name="calID"> <input type="hidden"
							name="scheduleID">
						<div class="mb-3">
							<!--  아래쪽으로  여백 -->
							<label for="title" class="form-label">제목</label> <input
								type="text" class="form-control" id="title" name="title"
								placeholder="일정제목을 입력 하세요.">
						</div>
						<div class="mb-3">
							<!--  아래쪽으로  여백 -->
							<label for="explantaion" class="form-label">설명</label> <input
								type="text" class="form-control" id="explanation"
								name="explanation" placeholder="일정설명을 입력 하세요.">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Tastimonial End -->
	<br>


	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
</body>

</html>