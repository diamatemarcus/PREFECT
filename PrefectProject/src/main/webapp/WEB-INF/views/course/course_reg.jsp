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
document.addEventListener("DOMContentLoaded", function() {
    console.log("DOMContentLoaded");
    
    const regForm       = document.querySelector("#regFrm");
    const moveToListBTN = document.querySelector("#moveToList");
    const doSaveBTN     = window.document.querySelector("#doSave");
    
    // doSave event 감지 및 처리
    doSaveBTN.addEventListener("click", function (e) {
        console.log("doSaveBTN click");
        
        e.preventDefault();
        
        const courseCode = document.querySelector("#courseCode").value;
        const courseName = document.querySelector("#courseName").value;
        const numberOfTimes = document.querySelector("#numberOfTimes").value;
        const courseInfo = document.querySelector("#courseInfo").value;
        const academysSeq = document.querySelector("#academysSeq").value;
        const startDate = document.querySelector("#startDate").value;
        const endDate = document.querySelector("#endDate").value;
        
        if(window.confirm('등록 하시겠습니까?')==false){
            return;
        }
        
        $.ajax({
            type: "POST",
            url: "/ehr/course/doSave.do",
            async: true,
            dataType: "json",
            data: {
            	"courseCode": courseCode,
                "courseName": courseName,
                "numberOfTimes": numberOfTimes,
                "courseInfo": courseInfo,
                "academysSeq": academysSeq,
                "startDate": startDate,
                "endDate": endDate
            },
            success: function (data) {// 통신 성공 시의 처리
                console.log("data.msgId:" + data.msgId);
                console.log("data.msgContents:" + data.msgContents);

                if ('1' == data.msgId) {
                    alert(data.msgContents);
                    moveToListFun();
                } else {
                    alert(data.msgContents);
                }
            },
            error: function (data) {// 통신 실패 시의 처리
                console.log("error:" + data);
            }
            
         });                
        
    });
        
    function moveToListFun() {
        window.location.href = "/ehr/course/moveToList.do";
    }

    // event 감지 및 처리
    moveToListBTN.addEventListener("click", function (e) {
        console.log("moveToListBTN click");
        
        Swal.fire({
            title: '등록하지 않고 목록으로 가시겠습니까?',
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#6fa1ff',
            cancelButtonColor: '#cccccc',
            confirmButtonText: '예',
            cancelButtonText: '아니오'
        }).then((result) => {
            if (result.isConfirmed) {
                moveToListFun();
            }
        });   
    });

});//--DOMContentLoaded
</script>
<style>

.my-custom-row {
    display: flex;
    flex-wrap: wrap;
    margin: -85px -87px 0px -212px;
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
                <h2 class="page-header">코스 추가</h2>
            </div>
        </div>
        <!-- Course Save Form Start -->
        <form action="#" name="regFrm" id="regFrm">
        
            <input type="text" name=academysSeq id="academysSeq">
            
            <div class="mb-3">
                <label for="courseCode" class="form-label">코스 코드</label>
                <input type="text" class="form-control" id="courseCode" name="courseCode" maxlength="100" placeholder="코스 코드를 입력하세요" required>
            </div>
            <div class="mb-3">
                <label for="courseName" class="form-label">코스 이름</label>
                <input type="text" class="form-control" id="courseName" name="courseName" maxlength="100" placeholder="코스 이름을 입력하세요" required>
            </div>
            <div class="mb-3">
                <label for="numberOfTimes" class="form-label">회차</label>
                <input type="number" class="form-control" id="numberOfTimes" name="numberOfTimes" placeholder="회차를 입력하세요" required>
            </div>
            <div class="mb-3">
                <label for="courseInfo" class="form-label">코스 정보</label>
                <textarea class="form-control" id="courseInfo" name="courseInfo" rows="3" placeholder="코스 정보를 입력하세요"></textarea>
            </div>
            <div class="mb-3">
                <label for="startDate" class="form-label">시작 날짜</label>
                <input type="date" class="form-control" id="startDate" name="startDate" required>
            </div>
            <div class="mb-3">
                <label for="endDate" class="form-label">종료 날짜</label>
                <input type="date" class="form-control" id="endDate" name="endDate" required>
            </div>
            <button type="submit" class="btn btn-primary" id="doSave">저장</button>
            <button class="btn btn-primary" id="moveToList">목록</button>
        </form>
        <!-- Course Save Form End -->
        
        <br><br><br>
    </div>
    
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

</body>
</html>
