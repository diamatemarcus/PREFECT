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
    <div class="container" id="subjectReg" style="display: none;">
        <!-- 과목 등록 부분 -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">과목 등록</h1>
            </div>
        </div>
        <div class="row justify-content-end">
            <div class="col-auto">
                <input type="button" class="btn btn-primary" value="등록" id="doUpdate" onclick="doSave()">
                <input type="button" class="btn btn-primary" value="목록" id="moveToList" onclick="location.href='doRetrieve.do'">
            </div>
        </div>
        <div>
            <form action="#" name="subjectRegFrm">
                <div class="mb-3">
                    <label for="subject" class="form-label">새 과목 이름</label>
                    <input type="text" class="form-control" name="subject" id="subject" value="" placeholder="추가 할 과목 이름을 입력해 주세요." size="20" maxlength="11">
                </div>
            </form>
        </div>
    </div>
    <div class="container" id="subjectList" style="display: none;">
        <!-- 과목 목록 부분 -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">과목 목록</h1>
            </div>
        </div>
        <div class="row justify-content-end">
            <div class="col-auto">
                <input type="button" class="btn btn-primary" value="등록" id="doUpdate" onclick="doSave()">
                <input type="button" class="btn btn-primary" value="목록" id="moveToList" onclick="location.href='doRetrieve.do'">
            </div>
        </div>
        <div>
            <form action="#" name="subjectRegFrm">
                <div class="mb-3">
                    <label for="subject" class="form-label">새 과목 이름</label>
                    <input type="text" class="form-control" name="subject" id="subject" value="" placeholder="추가 할 과목 이름을 입력해 주세요." size="20" maxlength="11">
                </div>
            </form>
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
	</script>
</body>
</html>
