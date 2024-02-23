<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ARMS - 마이페이지</title>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>

<style>
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
</style>
<style>
#regDt {
    width: 200px;
}

.hidden {
    display: none;
}
</style>

<!-- chart -->
<style>
#chartdiv1 {
  width: 100%;
  height: 500px;
}
</style>


<title>마이페이지</title>

</head>
<body>

<!-- Spinner Start -->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>
	<!-- Spinner End -->


	

	<!-- Modal Search Start -->
	<div class="modal fade" id="searchModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen">
			<div class="modal-content rounded-0">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Search by
						keyword</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex align-items-center">
					<div class="input-group w-75 mx-auto d-flex">
						<input type="search" class="form-control p-3"
							placeholder="keywords" aria-describedby="search-icon-1">
						<span id="search-icon-1" class="input-group-text p-3"><i
							class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Search End -->

	<%--   <jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
  <jsp:include page="/WEB-INF/cmn/nav.jsp"></jsp:include> --%>
 
	<div class="container">
		<!-- 제목 -->
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header" style="margin-bottom: 10px; color: #e44646; font-family: Montserrat; font-style: italic;">My Page</h1>
			</div>
		
		<!--// 제목 ----------------------------------------------------------------->
		<!-- 버튼 -->
		<div class="row justify-content-end">
			<div class="col-auto">
				<input type="button" class="btn btn-primary" value="수정"
					id="doUpdate" onclick="window.doUpdate();"> <input
					type="button" class="btn btn-primary" value="삭제" id="doDelete"
					onclick="window.doDelete();"> <input type="button"
					class="btn btn-primary" value="목록" id="moveToList"
					onclick="window.moveToList();">
			</div>
		</div>
		<!--// 버튼 ----------------------------------------------------------------->

		<!-- 회원 등록영역 -->
	  <div class = "row">
		<div class = "container col-md-6">
			<form action="#" name="userRegFrm">
				<div class="mb-3">
					<label for="email" class="form-label">이메일</label> <input
						type="text" class="form-control ppl_input" readonly="readonly"
						name="email" id="email" value="${outVO.email }" size="20"
						maxlength="30">
				</div>
				<div class="mb-3">
					<!--  아래쪽으로  여백 -->
					<label for="name" class="form-label">이름</label> <input type="text"
						class="form-control" name="name" id="name"
						placeholder="이름을 입력 하세요." size="20" value="${outVO.name }"
						maxlength="21">
				</div>
				<div class="mb-3">
					<label for="password" class="form-label">비밀번호</label> <input
						type="password" class="form-control" name="password" id="password"
						placeholder="비밀번호를 입력 하세요." value="${outVO.password }" size="20"
						maxlength="30">
				</div>
				<div class="mb-3">
					<label for="tel" class="form-label">전화번호</label> <input type="text"
						class="form-control" name="tel" id="tel" placeholder="전화번호 수정"
						value="${outVO.tel }" size="20" maxlength="11">
				</div>
				<div class="mb-3">
					<label for="edu" class="form-label">학력</label>
					<div class="col-auto">
						<select id="education" name="education">
							<!-- 검색 조건 옵션을 동적으로 생성 -->
							<c:forEach items="${education}" var="vo">
								<option value="<c:out value='${vo.detCode}'/>"
									<c:if test="${vo.detCode == outVO.edu }">selected</c:if>><c:out
										value="${vo.detName}" /></option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="mb-3">
					<label for="role" class="form-label">역할</label>
					<div class="col-auto">
						<select id="role" name="role">
							<!-- 검색 조건 옵션을 동적으로 생성 -->
							<c:forEach items="${role}" var="vo">
								<option value="<c:out value='${vo.detCode}'/>"
									<c:if test="${vo.detCode == outVO.role }">selected</c:if>><c:out
										value="${vo.detName}" /></option>
							</c:forEach>
						</select>
					</div>
				</div>

                <!-- 라이센스 부분 -->

                <!-- 셀렉트 박스 -->
				<div class="mb-3">
				    <label for="licenses" class="form-label">자격증</label>
				    <div class="row align-items-center">
				        <!-- 자격증 선택 셀렉트 박스 -->
				        <div class="col-auto">
				            <select id="licenses" name="licenses" class="form-control">
				                <!-- 검색 조건 옵션을 동적으로 생성 -->
				                <c:forEach items="${licenses}" var="vo">
				                    <option value="${vo.licensesSeq}">${vo.licensesName}</option>
				                </c:forEach>
				            </select>
				        </div>
				        <!-- 등록일 텍스트 상자 -->
				        <div class="mb-6">
				            <label for="regDt" class="form-label">등록일</label>
				            <input type="date" id="regDt" name="regDt" class="form-control">
				        </div>
				        <!-- 자격증 저장 버튼 -->
				        <div class="col-auto">
				            <input type="button" value="선택" class="btn btn-primary" id="doSaveLicenses" style="margin-top: 10px">
				        </div>
				    </div>
				</div>

                <!-- 선택한 자격증에 대한 목록을 표시할 테이블 -->
                <table id="licensesList">
                    <thead>
                        <tr>
                            <th>자격증명</th>
                            <th>등록일</th>
                        </tr>
                    </thead>
                    <tbody id="tableTbody">
                        <c:choose>
                            <c:when test="${userLicenses.size()>0 }">
                                <c:forEach var="vo" items="${userLicenses}" >
                                    <tr>
                                        <td class="hidden">${vo.licensesSeq}</td>
                                        <td>${vo.licensesName}</td>
                                        <td>${vo.regDt}</td>
                                        <td><button class="deleteRowBtn btn" style="margin-bottom: 5px">
                                        <img src="${CP}/resources/template/img/x.png" alt="삭제" style="width: 20px; height: 20px;">
                                        </button>
                                    </tr>
                                </c:forEach>
                            </c:when>
                        </c:choose>
                    </tbody>
                </table>
			</form>
		</div>
		<!--// 회원 등록영역 ------------------------------------------------------>
		<!-- chart -->
		<div class="container col-md-6 mt-4">
             <div class = "col-sm">
       				 <!-- Area Chart -->
            		 <div id="chartdiv1"></div>
   			 </div>   
        </div>
	</div>
 </div>
</div>
		
     
	
	<script>
	function doDelete() {
		console.log("----------------------");
		console.log("-doDelete()-");
		console.log("----------------------");

		let email = document.querySelector("#email").value;
		console.log("email:" + email);

		if (eUtil.isEmpty(email) == true) {
			alert('아이디를 입력 하세요.');
			document.querySelector("#email").focus();
			return;
		}

		if (window.confirm('삭제 하시겠습니까?') == false) {
			return;
		}
		console.log("-confirm:");
		$.ajax({
			type : "GET",
			url : "/ehr/user/doDelete.do",
			asyn : "true",
			dataType : "json", /*return dataType: json으로 return */
			data : {
				"email" : email
			},
			success : function(data) {//통신 성공
				console.log("success data:" + data);
				//let parsedJSON = JSON.parse(data);
				if ("1" === data.msgId) {
					alert(data.msgContents);
					moveToList();
				} else {
					alert(data.msgContents);
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

		window.location.href = "/ehr/user/doRetrieve.do";
	}

	function doUpdate() {
		console.log("----------------------");
		console.log("-doUpdate()-");
		console.log("----------------------");

		//javascript
		console.log("javascript email:"
				+ document.querySelector("#email").value);
		console.log("javascript ppl_input:"
				+ document.querySelector(".ppl_input").value);

		//$("#email").val() : jquery id선택자
		//$(".email")

		console.log("jquery email:" + $("#email").val());
		console.log("jquery ppl_input:" + $(".ppl_input").val());

		if (eUtil.isEmpty(document.querySelector("#email").value) == true) {
			alert('아이디를 입력 하세요.');
			//$("#email").focus();//사용자 id에 포커스
			document.querySelector("#email").focus();
			return;
		}

		if (eUtil.isEmpty(document.querySelector("#name").value) == true) {
			alert('이름을 입력 하세요.');
			//$("#email").focus();//사용자 email에 포커스
			document.querySelector("#name").focus();
			return;
		}

		if (eUtil.isEmpty(document.querySelector("#password").value) == true) {
			alert('비밀번호를 입력 하세요.');
			//$("#email").focus();//사용자 email에 포커스
			document.querySelector("#password").focus();
			return;
		}

		if (eUtil.isEmpty(document.querySelector("#tel").value) == true) {
			alert('전화번호을 입력 하세요.');
			//$("#email").focus();//사용자 email에 포커스
			document.querySelector("#tel").focus();
			return;
		}

		if (eUtil.isEmpty(document.querySelector("#education").value) == true) {
			alert('학력을 입력 하세요.');
			//$("#email").focus();//사용자 email에 포커스
			document.querySelector("#education").focus();
			return;
		}

		if (eUtil.isEmpty(document.querySelector("#role").value) == true) {
			alert('역할을 입력 하세요.');
			//$("#email").focus();//사용자 email에 포커스
			document.querySelector("#role").focus();
			return;
		}

		//confirm
		if (confirm("수정 하시겠습니까?") == false)
			return;

		$.ajax({
			type : "POST",
			url : "/ehr/user/doUpdate.do",
			asyn : "true",
			dataType : "html",
			data : {
				email : document.querySelector("#email").value,
				name : document.querySelector("#name").value,
				password : document.querySelector("#password").value,
				tel : document.querySelector("#tel").value,
				edu : document.querySelector("#education").value,
				role : document.querySelector("#role").value,
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
	$(document).ready(function() {
		
		var selectedLicenses = [];
	 // 선택 버튼 클릭 시
	    $('#doSaveLicenses').click(function() {
	        console.log('licensesdoSave click');
	        var licensesSeq = $('#licenses').val();
	        var licenseName = $('#licenses option:selected').text();
	        var regDt = $('#regDt').val(); // 등록일 가져오기

	        // 등록일 유효성 검사
	        if (!validateDate(regDt)) {
	            return;
	        }

	     // 이미 선택된 자격증인지 확인
	        $('#tableTbody tr').each(function() {
	            var licenseSeq = $(this).find('td:first').text();
	            selectedLicenses.push(licenseSeq);
	        });

	        if (selectedLicenses.includes(licensesSeq)) {
	            alert('이미 선택된 자격증입니다.');
	            return; // 이미 선택된 자격증이면 함수 종료
	        }

	        // AJAX 요청 - 선택 버튼 클릭 시 수행할 작업
	        $.ajax({
	            type: "POST",
	            url: "/ehr/licenses/doSave.do",
	            async: true,
	            dataType: "json",
	            data: {
	                licensesSeq: licensesSeq,
	                email: $("#email").val(),
	                regDt: regDt
	            },
	            success: function(data) { // 통신 성공
	                console.log("success data:" + data);
	                // AJAX 요청 완료 후 페이지 리로드
	                location.reload();
	            },
	            error: function(data) { // 실패시 처리
	                console.log("error:" + data);
	            },
	            complete: function(data) { // 성공/실패와 관계없이 수행!
	                console.log("complete:" + data);
	            }
	        });

	        // 표에 추가
	        var newRow = '<tr><td data-license-seq="' + licensesSeq + '">' + licenseName + '</td><td>' + regDt + '</td><td><button class="deleteRowBtn">삭제</button></td></tr>';
	        $('#licensesList tbody').append(newRow);

	        // 선택된 자격증을 배열에 추가
	        selectedLicenses.push(licensesSeq);

	        // 로컬 스토리지에 선택된 자격증 목록 저장
	        localStorage.setItem('selectedLicenses', JSON.stringify(selectedLicenses));
	        localStorage.setItem('regDt_' + licensesSeq, regDt);
	    });

	 // 삭제 버튼 클릭 시
	    $(document).on('click', '.deleteRowBtn', function() {
	        console.log('deleteRowBtn click');
	        var licensesSeqText = $(this).closest('tr').find('td:first').text();
	        var licensesSeq = parseInt(licensesSeqText);

	        // 배열에서 해당 자격증 제거
	        var index = selectedLicenses.indexOf(licensesSeq);
	        if (index !== -1) {
	            selectedLicenses.splice(index, 1);
	        }

	        // 로컬 스토리지에서 해당 자격증 정보 삭제
	        localStorage.removeItem('regDt_' + licensesSeq);

	        // 테이블에서 행 제거
	        $(this).closest('tr').remove();

	        // 로컬 스토리지에 업데이트된 선택된 자격증 목록 저장
	        localStorage.setItem('selectedLicenses', JSON.stringify(selectedLicenses));

	        // AJAX를 사용하여 선택된 자격증을 삭제하는 요청 보내기
	        $.ajax({
	            type: "POST",
	            url: "/ehr/licenses/doDelete.do",
	            async: true,
	            dataType: "json",
	            data: {
	                licensesSeq: licensesSeq,
	                email: $("#email").val()
	            },
	            success: function(data) { // 통신 성공
	                console.log("success data:" + data);
	                // AJAX 요청 완료 후 페이지 리로드
	                location.reload();
	            },
	            error: function(data) { // 실패시 처리
	                console.log("error:" + data);
	                // 실패 처리를 추가할 수 있습니다.
	            },
	            complete: function(data) { // 성공/실패와 관계없이 수행!
	                console.log("complete:" + data);
	            }
	        });
	    });

	   

	 // 등록일 유효성 검사 함수
	    function validateDate(dateString) {
	        var regex = /^\d{4}-\d{2}-\d{2}$/; // YYYY-MM-DD 형식의 정규식
	        if (!regex.test(dateString)) {
	            alert('날짜 형식이 올바르지 않습니다. (YYYY-MM-DD)');
	            return false;
	        }

	        var parts = dateString.split('-');
	        var year = parseInt(parts[0]);
	        var month = parseInt(parts[1]);
	        var day = parseInt(parts[2]);

	        if (isNaN(year) || isNaN(month) || isNaN(day)) {
	            alert('숫자 형식이 아닌 값이 포함되어 있습니다.');
	            return false;
	        }

	        return true;
	    }
	});

</script>


<!--  chart Resources -->
<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
<script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
<script src="https://cdn.amcharts.com/lib/5/radar.js"></script>
<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
<script src="${CP}/resources/js/amchart.js" type="text/javascript"></script>

<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>  
</body>
</html>
