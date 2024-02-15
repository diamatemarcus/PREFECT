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
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>달력</title>
<style>
/* 초기에는 form 숨기기 */
#myForm {
	display: none;
}
</style>
<script>
	document
			.addEventListener(
					"DOMContentLoaded",
					function() {
						//DOMContentLoaded-----------------------------------------
						console.log("DOMContentLoaded"); 
						

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
							 let form = document.getElementById("myForm");
								form.style.display = "none";
								isFormVisible = false;
								
								console
										.log('----------------------------');
								console.log('scheduleRetrieve');
								console.log(calID);
								console
										.log('----------------------------');

								
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
												"calID" : calID
											},
											success : function(data) {//통신 성공
												console
														.log("success data:"
																+ data.length);
												//동적인 테이블 헤더 생성
												let tableHeader = '<thead>\
										                    <tr>\
										                    	<th scope="col" class="text-center col-lg-1 col-sm-1"></th>\
											                    <th scope="col" class="text-center col-lg-1  col-sm-1">calID</th>\
											                    <th scope="col" class="text-center col-lg-2  col-sm-2" >scheduleID</th>\
											                    <th scope="col" class="text-center col-lg-2  col-sm-2" >일정 제목</th>\
											                    <th scope="col" class="text-center col-lg-2  col-sm-2" >일정 설명</th>\
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
												                    <td class="text-center">' + data[i].calID + '</td>\
												                    <td class="text-left">' + data[i].scheduleID + '</td>\
												                    <td class="text-left">' + data[i].title + '</td>\
												                    <td class="text-left">' + data[i].explanation + '</td>\
												                </tr>';
												}
												
												tableBody += ' </tbody>';

												console
														.log(tableHeader);
												console
														.log(tableBody);

												let dynamicTable = '<table id="scheduleTable"  class="table table-bordered border-primary table-hover table-striped">'
														+ tableHeader
														+ tableBody
														+ '</table>';
												//
												$("#modalTable")
														.html(
																dynamicTable);
												$('#staticBackdrop')
														.modal(
																'show');

												//회원정보 double click
												$(
														"#userTable>tbody")
														.on(
																"dblclick",
																"tr",
																function(
																		e) {
																	console
																			.log("userTable click!");

																	let tdArray = $(
																			this)
																			.children();
																	let userId = tdArray
																			.eq(
																					1)
																			.text();
																	let password = tdArray
																			.eq(
																					3)
																			.text();

																	console
																			.log('userId:'
																					+ userId);
																	console
																			.log('password:'
																					+ password);

																	$(
																			"#userId")
																			.val(
																					userId);
																	$(
																			"#password")
																			.val(
																					password);

																	//modal popup닫기
																	$(
																			'#staticBackdrop')
																			.modal(
																					'hide');

																});
											},
											error : function(data) {//실패시 처리
												console
														.log("error:"
																+ data);
											},
											complete : function(
													data) {//성공/실패와 관계없이 수행!
												console
														.log("complete:"
																+ data);
											}
										});

								
							 
						 }
						
						//----------------------------------------- 날짜 선택해서 일정 보여주기 (jquery:table 데이터 선택)     
						$("#calendarTable>tbody")
								.on(
										"dblclick",
										"td",
										function(e) {
											
											document.querySelector("#explanation").value = "";
							                document.querySelector("#title").value = "";
							                
											let form = document.getElementById("myForm");
											form.style.display = "none";
											isFormVisible = false;
											
											console
													.log('----------------------------');
											console.log('calendarTable>tbody');
											console
													.log('----------------------------');

											let calID = $(this).text();
											console.log('calID:' + calID);
											console.log(typeof calID);
											
											document.querySelector("#calID").value = calID;

											if (calID == "") {
												return;
											}

											let calIDNum = parseInt(calID);
											console.log(calIDNum);

											scheduleRetrieve(calID);
										});
						
						//-------------------------------------------------------------- 일정 추가 버튼
						saveScheduleBTN.addEventListener("click", function(e) {
							let form = document.getElementById("myForm");
							
							console.log('saveScheduleBTN click');
							
							// form을 숨겼으면 보이도록, 보이면 숨기도록 설정
				            if (!isFormVisible) {
				                form.style.display = "block";
				            } else {
				            	
				            	let calID = document.querySelector("#calID").value;
				                let title = document.querySelector("#title").value;
				                let explanation = document.querySelector("#explanation").value;

				                console.log("title:" + title);
				                console.log("calID:" + calID);
				                console.log("explanation:" + explanation);

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

				                $.ajax({
				                    type: "POST",
				                    url: "/ehr/schedule/doSave.do",
				                    async: true,
				                    dataType: "json",
				                    data: {
				                        "calID": calID,
				                        "title": title,
				                        "explanation": explanation
				                    },
				                    success: function (data) {// 통신 성공 시의 처리
				                        console.log("data.msgId:" + data.msgId);
				                        console.log("data.msgContents:" + data.msgContents);

				                        if ('1' == data.msgId) {
				                            alert(data.msgContents);
				                            scheduleRetrieve(calID);
				                        } else {
				                            alert(data.msgContents);
				                        }
				                    },
				                    error: function (data) {// 통신 실패 시의 처리
				                        console.log("error:" + data);
				                    },
				                    complete: function (data) {// 성공/실패와 관계없이 수행되는 처리
				                        console.log("complete:" + data);
				                    }
				                });
				                
				                form.style.display = "none";
				                document.querySelector("#explanation").value = "";
				                document.querySelector("#title").value = "";
				                
				            }
			                
				            // isFormVisible 변수 업데이트
				            isFormVisible = !isFormVisible;
						});
						
						
						//------------------------------------------------------여러 일정 한번에 삭제
						$("#doDeleteSchedule").click(function() {
				            // 체크된 일정의 scheduleID 값을 배열로 저장
				            var scheduleIDs = [];
				            $("input[name='scheduleID']:checked").each(function() {
				                scheduleIDs.push($(this).val());
				            });

				            // 배열이 비어 있는지 확인
				            if (scheduleIDs.length === 0) {
				                alert("삭제할 일정을 선택해주세요.");
				                return;
				            }
				            
				            let calID = document.querySelector("#calID").value;
				            
				         // scheduleIDs 배열을 콘솔에 출력
				            console.log("scheduleIDs:", scheduleIDs);
				            console.log("calID:", calID);
				            let length = scheduleIDs.length;

				            // 여러 일정 삭제 Ajax 요청
				            $.ajax({
				                type: "GET",
				                url: "/ehr/schedule/doDeleteMultiple.do",
				                dataType: "json",
				                data: {
				                    "scheduleIDs": JSON.stringify(scheduleIDs)
				                },
				                success: function(response) {
				                    // 삭제 성공 여부 확인
				                    if (response.msgId == length) {
				                        alert(response.msgContents); // 성공 메시지 표시
				                        scheduleRetrieve(calID);	
				                    } else {
				                        alert(response.msgContents); // 실패 메시지 표시
				                    }
				                },
				                error: function(xhr, status, error) {
				                    console.error(xhr.responseText); // 오류 메시지 출력
				                    alert("일정 삭제 중 오류가 발생했습니다.");
				                }
				            });
				        });

						//------------------------------------------------------일정 수정
						$("#doUpdateSchedule").click(function() {
				            // 체크된 일정의 scheduleID 값을 배열로 저장
				            var scheduleIDs = [];
				            $("input[name='scheduleID']:checked").each(function() {
				                scheduleIDs.push($(this).val());
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
				            
				            let calID = document.querySelector("#calID").value;
				            
				         // scheduleIDs 배열을 콘솔에 출력
				            console.log("scheduleIDs:", scheduleIDs);
				            console.log("calID:", calID);
				            let length = scheduleIDs.length;

				            // 여러 일정 삭제 Ajax 요청
				            $.ajax({
				                type: "POST",
				                url: "/ehr/schedule/doUpdateMultiple.do",
				                dataType: "json",
				                data: {
				                    "title": ,
				                    "explanation": ,
				                    "scheduleID":
				                },
				                success: function(response) {
				                    // 삭제 성공 여부 확인
				                    if (response.msgId == length) {
				                        alert(response.msgContents); // 성공 메시지 표시
				                        scheduleRetrieve(calID);	
				                    } else {
				                        alert(response.msgContents); // 실패 메시지 표시
				                    }
				                },
				                error: function(xhr, status, error) {
				                    console.error(xhr.responseText); // 오류 메시지 출력
				                    alert("일정 삭제 중 오류가 발생했습니다.");
				                }
				            });
				        });

						
						
						
						
						
					});//--DOMContentLoaded
</script>
</head>
<body>
	<div class="container">
		<!-- 제목 -->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">달력</h1>
				<div class="col-auto ">
					<!-- 열의 너비를 내용에 따라 자동으로 설정 -->
					<input type="button" value="이전" class="btn btn-primary"
						id="lastMonth"> <input type="button" value="다음"
						class="btn btn-primary" id="nextMonth">
				</div>
			</div>
		</div>

		<input type="text" name="year" id="year" value="${year}" /> <input
			type="text" name="month" id="month" value="${month}" />

		<!--// 제목 ----------------------------------------------------------------->

		<!-- 검색 -->
		<%-- <form action="#" method="get" id="calendar" name="calendar">
      <input type="hidden" name="div"    id="div"  value="${paramVO.getDiv() }"/>
      <div class="row g-1 justify-content-end ">
          <label for="searchDiv" class="col-auto col-form-label">검색조건</label>
          <div class="col-auto">
              <select class="form-select pcwk_select" id="searchDiv" name="searchDiv">
                     <option value="">전체</option>
                     <c:forEach var="vo" items="${boardSearch }">
                        <option value="<c:out value='${vo.detCode}'/>"  <c:if test="${vo.detCode == paramVO.searchDiv }">selected</c:if>  ><c:out value="${vo.detName}"/></option>
                     </c:forEach>
              </select>
          </div>    
          <div class="col-auto">
              <input type="text" class="form-control" id="searchWord" name="searchWord" maxlength="100" placeholder="검색어를 입력 하세요" value="${paramVO.searchWord}">
          </div>   
          <div class="col-auto"> 
               <select class="form-select" id="pageSize" name="pageSize">
                  <c:forEach var="vo" items="${pageSize }">
                    <option value="<c:out value='${vo.detCode }' />" <c:if test="${vo.detCode == paramVO.pageSize }">selected</c:if>  ><c:out value='${vo.detName}' /></option>
                  </c:forEach>
               </select>  
          </div>    
          <div class="col-auto "> <!-- 열의 너비를 내용에 따라 자동으로 설정 -->
            <input type="button" value="목록" class="btn btn-primary"  id="doRetrieve">
            <input type="button" value="등록" class="btn btn-primary"  id="moveToReg">
          </div>              
      </div>
                           
    </form> --%>
		<!--// 검색 ----------------------------------------------------------------->


		<!-- table -->
		<table
			class="table table-bordered border-primary table-hover table-striped"
			id="calendarTable">
			<thead>
				<tr>
					<th scope="col" class="text-center col-lg-1  col-sm-1">일</th>
					<th scope="col" class="text-center col-lg-1  col-sm-1">월</th>
					<th scope="col" class="text-center col-lg-1  col-sm-1">화</th>
					<th scope="col" class="text-center col-lg-1  col-sm-1">수</th>
					<th scope="col" class="text-center col-lg-1  col-sm-1">목</th>
					<th scope="col" class="text-center col-lg-1  col-sm-1">금</th>
					<th scope="col" class="text-center col-lg-1  col-sm-1">토</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${ not empty calendarList }">
						<!-- 반복문 -->
						<c:forEach var="vo" items="${calendarList}" varStatus="status">
							<tr>
								<td class="text-center col-lg-1  col-sm-1"><c:out
										value="${vo.sun}" /></td>
								<td class="text-center col-lg-1  col-sm-1"><c:out
										value="${vo.mon}" /></td>
								<td class="text-center col-lg-1  col-sm-1"><c:out
										value="${vo.tue}" /></td>
								<td class="text-center col-lg-1  col-sm-1"><c:out
										value="${vo.wed}" /></td>
								<td class="text-center col-lg-1  col-sm-1"><c:out
										value="${vo.thu}" /></td>
								<td class="text-center col-lg-1  col-sm-1"><c:out
										value="${vo.fri}" /></td>
								<td class="text-center col-lg-1  col-sm-1"><c:out
										value="${vo.sat}" /></td>
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

		<!-- Modal -->
		<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="staticBackdropLabel">일정</h1>
						<input type="text" name="calID" id="calID" /> 
						<input
							type="button" value="일정 추가" class="btn btn-primary"
							id="doSaveSchedule">
						<input
							type="button" value="일정 삭제" class="btn btn-primary"
							id="doDeleteSchedule">
						<input
							type="button" value="일정 수정" class="btn btn-primary"
							id="doUpdateSchedule">
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body" id="modalTable">
						<!-- 일정 table -->
					</div>

					<!-- form -->
					<div id="myForm" class="modal-body">
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

		<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
	</div>

</body>
</html>