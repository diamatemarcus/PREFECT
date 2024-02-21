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
<meta charset="utf-8">
<title>ARMS - IT훈련학원 커뮤니티</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
    rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="${CP}/resources/template/lib/lightbox/css/lightbox.min.css" rel="stylesheet" type="text/css">
<link href="${CP}/resources/template/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" type="text/css">


<!-- Customized Bootstrap Stylesheet -->
<link href="${CP}/resources/template/css/bootstrap.min.css" rel="stylesheet" type="text/css">

<!-- Template Stylesheet -->
<link href="${CP}/resources/template/css/style.css" rel="stylesheet" type="text/css">
<title>달력</title>
<style>
#myScheduleForm {
	display: none;
}
.button {
    width: auto;
    /* 버튼의 크기를 내용에 맞게 자동으로 조절합니다. */
    /* 다른 스타일을 원하는 대로 추가할 수 있습니다. */
    padding: 10px 20px;
    /* 내용과 버튼의 테두리 간격을 조정합니다. */
    border: none;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    cursor: pointer;
    border-radius: 8px;
    background-color: #FFA500
}
.day-cell:hover {
    background-color: #64FF64; /* 호버 시 배경색을 변경합니다. */
    cursor: pointer; /* 마우스 커서 모양을 변경합니다. */
}

#doSaveSchedule,
#doDeleteSchedule,
#doUpdateSchedule,
.btn-close {
    color: aliceblue;
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
							 let form = document.getElementById("myScheduleForm");
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
												"calID" : calID,
												"email" : email
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

												
												// modal popup 닫기 및 페이지 리로드
												$('#staticBackdrop').on('hidden.bs.modal', function (e) {
												    // 모달이 숨겨지면 페이지를 리로드합니다.
												    location.reload();
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
											
											// 클릭된 요소의 날짜 값 가져오기
										    let calID = $(this).data("day");
										    console.log("Clicked day:", calID);
											
											document.querySelector("#explanation").value = "";
							                document.querySelector("#title").value = "";
							                
											let form = document.getElementById("myScheduleForm");
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
						saveScheduleBTN.addEventListener("click", function(e) {
							let form = document.getElementById("myScheduleForm");
							
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

				                $.ajax({
				                    type: "POST",
				                    url: "/ehr/schedule/doSave.do",
				                    async: true,
				                    dataType: "json",
				                    data: {
				                        "calID": calID,
				                        "title": title,
				                        "explanation": explanation,
				                        "email": email
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
							let form = document.getElementById("myScheduleForm");
							
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
				            
				            let scheduleID = scheduleIDs[0]
				            
				         // 여러 일정 삭제 Ajax 요청
				            $.ajax({
				                type: "GET",
				                url: "/ehr/schedule/doSelectOne.do",
				                dataType: "json",
				                data: {
				                    "scheduleID": scheduleID
				                },
				                success: function(data) {
				                	console
									.log("success data:"
											+ data);
				                	
				                	// form을 숨겼으면 보이도록, 보이면 숨기도록 설정
						            if (!isFormVisible) {
						                form.style.display = "block";
						                
						                console.log("title: " + data.title);
						                console.log("explanation: " + data.explanation);

						                document.querySelector("#title").value = data.title;
						                document.querySelector("#explanation").value = data.explanation;
						                
						                console.log("block");

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

						                if (window.confirm("수정하시겠습니까?") === false) {
						                    return;
						                }

						                $.ajax({
						                    type: "POST",
						                    url: "/ehr/schedule/doUpdate.do",
						                    async: true,
						                    dataType: "json",
						                    data: {
						                        "scheduleID": scheduleIDs[0],
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

						                console.log("none");
						            }
					                
						            // isFormVisible 변수 업데이트
						            isFormVisible = !isFormVisible;
							
				         
				                },
				                error: function(xhr, status, error) {
				                    console.error(xhr.responseText); // 오류 메시지 출력
				                    alert("일정 수정 중 오류가 발생했습니다.");
				                }
				            });
				         
				         
				           

				            
				        });

						
						
						
						
						
					});//--DOMContentLoaded
</script>
</head>
<body>
    <!-- Navbar start -->
    <div class="container-fluid fixed-top">
        <div class="container px-5">
            <nav class="navbar navbar-light bg-white navbar-expand-xl">
                <a href="index.jsp" class="navbar-brand">
                    <h1 class="text-primary display-6" style="padding-top: 28px;">A R M S</h1>
                </a>
                <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-primary"></span>
                </button>
                <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                    <div class="navbar-nav mx-auto" style="padding-top: 8px;">
                        <a href="index.jsp" class="nav-item nav-link" style="font-size: 18px;">게시판</a>
                        <a href="/board/doRetrieve.do?div=10" class="nav-item nav-link" style="font-size: 18px;">공지사항</a>
                        <a href="#" class="nav-item nav-link active" style="font-size: 18px;">일정표</a>
                        <a href="/dm/doContentsList.do" class="nav-item nav-link" style="font-size: 18px;">메시지</a>
                        <a href="/book/bookApiView.do" class="nav-item nav-link" style="font-size: 18px;">도서구매</a>
                        <a href="/user/doSelectOne.do" class="nav-item nav-link" style="font-size: 18px;">회원 목록</a> <!-- 관리자에게만 보이게 할 예정-->
                    </div>
                    

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button class="button me-md-2" type="button" onclick="location.href='/login/loginView.do'" style="background-color: #FFA500; font-size: 15px; color: aliceblue;">로그인</button>
                        <button class="button" type="button" onclick="location.href='/ehr/user/moveToReg.do'" style="background-color: #FFA500; font-size: 15px; color: aliceblue">회원가입</button>
                    </div>
                    <div class="d-flex m-3 me-0">
                        <a href="/ehr/user/doSelectOne.do" class="my-auto">
                            <i class="fas fa-user fa-2x"></i>
                        </a>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->
    
   <!-- Tastimonial Start -->
    <div class="container-fluid testimonial py-2">
      <input type="text" id="email" name="email" value="${sessionScope.user.email}">
        <!-- 제목 -->
        <div class="row">
            <div class="col-lg-7" style="margin-left: 15%">
                <div>
                    <h1 class="page-header" style="margin-bottom: 10px; color: #e44646; font-family: Montserrat; font-style: italic;">Calendar</h1>
                <div class="col-auto d-flex flex-column ">
                    <!-- 버튼 그룹 -->
                    <div class="d-flex" style="margin-bottom: 30px;">
                        <!-- 이전 버튼 -->
                        <input type="button" value="이전" class="btn btn-primary me-2" id="lastMonth" style="color: aliceblue;"> 
                        <!-- 연도 표시 -->
                        <input type="text" name="year" id="year" value="${year}" readonly class="form-control" style="width: 80px;">
                        <!-- 월 표시 -->
                        <input type="text" name="month" id="month" value="${month}" readonly class="form-control" style="width: 60px;">
                        <!-- 다음 버튼 -->
                        <input type="button" value="다음" class="btn btn-primary ms-2" id="nextMonth" style="color: aliceblue;">
                    </div>
                    <!-- 텍스트 -->
                    <div>
                        <span style="color: #81c408;">*날짜를 더블클릭하여 일정을 추가하세요.</span>
                    </div>
                </div>
                
            </div>
        </div>
        

        
        

        <!-- 캘린더 table -->
        <div class="col-lg-7" style="margin-top: 10px; margin-left: 15%;">
        <table
            class="table table-bordered border-primary table-hover"
            id="calendarTable" style="margin-top: 10px;" >
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
                                <!-- 일요일 -->
                                <td class="text-center col-lg-1 col-sm-1 day-cell" data-day="${vo.sun}">
                                    ${vo.sun.substring(6)}
                                    <ul>
                                        <!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
                                        <c:forEach var="schedule" items="${scheduleList}">
                                            <c:if test="${schedule.calID == vo.sun}">
                                              <li>
                                                <strong>일정:</strong> ${schedule.title}
                                              </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </td>
                                <!-- 월요일 -->
                                <td class="text-center col-lg-1 col-sm-1 day-cell" data-day="${vo.mon}">
                                    ${vo.mon.substring(6)}
                                    <ul>
                                        <!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
                                        <c:forEach var="schedule" items="${scheduleList}" varStatus="loop">
                                            <c:if test="${schedule.calID == vo.mon}">
                                                  <li>
                                                    <strong>일정 ${loop.index + 1}:</strong> ${schedule.title}<br>
                                                    <!-- 필요한 정보 추가 -->
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </td>
                                <!-- 화요일 -->
                                <td class="text-center col-lg-1 col-sm-1 day-cell" data-day="${vo.tue}">
                                    ${vo.tue.substring(6)}
                                    <ul>
                                        <!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
                                        <c:forEach var="schedule" items="${scheduleList}" varStatus="loop">
                                            <c:if test="${schedule.calID == vo.tue}">
                                                  <li>
                                                    <strong>일정 ${loop.index + 1}:</strong> ${schedule.title}<br>
                                                    <!-- 필요한 정보 추가 -->
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </td>
                                <!-- 수요일 -->
                                <td class="text-center col-lg-1 col-sm-1 day-cell" data-day="${vo.wed}">
                                    ${vo.wed.substring(6)}
                                    <ul>
                                        <!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
                                        <c:forEach var="schedule" items="${scheduleList}" varStatus="loop">
                                            <c:if test="${schedule.calID == vo.wed}">
                                                  <li>
                                                    <strong>일정 ${loop.index + 1}:</strong> ${schedule.title}<br>
                                                    <!-- 필요한 정보 추가 -->
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </td>
                                <!-- 목요일 -->
                                <td class="text-center col-lg-1 col-sm-1 day-cell" data-day="${vo.thu}">
                                    ${vo.thu.substring(6)}
                                    <ul>
                                        <!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
                                        <c:forEach var="schedule" items="${scheduleList}" varStatus="loop">
                                            <c:if test="${schedule.calID == vo.thu}">
                                                  <li>
                                                    <strong>일정 ${loop.index + 1}:</strong> ${schedule.title}<br>
                                                    <!-- 필요한 정보 추가 -->
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </td>
                                <!-- 금요일 -->
                                <td class="text-center col-lg-1 col-sm-1 day-cell" data-day="${vo.fri}">
                                    ${vo.fri.substring(6)}
                                    <ul>
                                        <!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
                                        <c:forEach var="schedule" items="${scheduleList}" varStatus="loop">
                                            <c:if test="${schedule.calID == vo.fri}">
                                                  <li>
                                                    <strong>일정 ${loop.index + 1}:</strong> ${schedule.title}<br>
                                                    <!-- 필요한 정보 추가 -->
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </td>
                                <!-- 토요일 -->
                                <td class="text-center col-lg-1 col-sm-1 day-cell" data-day="${vo.sat}">
                                    ${vo.sat.substring(6)}
                                    <ul>
                                        <!-- scheduleList와 비교하여 동일한 calID가 있는지 확인 -->
                                        <c:forEach var="schedule" items="${scheduleList}" varStatus="loop">
                                            <c:if test="${schedule.calID == vo.sat}">
                                                  <li>
                                                    <strong>일정 ${loop.index + 1}:</strong> ${schedule.title}<br>
                                                    <!-- 필요한 정보 추가 -->
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
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

        <!-- Modal -->
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
            data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <input type="hidden" name="calID" id="calID" /> 
                        <input
                            type="button" value="새 일정 등록" class="btn btn-primary"
                            id="doSaveSchedule" style="margin-right: 2px">
                        <input
                            type="button" value="삭제" class="btn btn-primary"
                            id="doDeleteSchedule" style="margin-right: 2px" style="aliceblue">
                        <input
                            type="button" value="수정" class="btn btn-primary"
                            id="doUpdateSchedule" >
                        <button type="button" class="btn-close" id="close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
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
    </div>
    <!-- Tastimonial End -->


    <!-- Copyright Start -->
    <div class="container-fluid copyright bg-dark py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    <span class="text-light"><a href="#"><i class="fas fa-copyright text-light me-2"></i>ARMS</a>, All right reserved.</span>
                </div>
            </div>
        </div>
    </div>
    <!-- Copyright End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
            class="fa fa-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/lightbox/js/lightbox.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>