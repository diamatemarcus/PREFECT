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

        const moveToListBTN = document.querySelector("#moveToList"); // 과정 조회 버튼

        moveToListBTN.addEventListener("click", function(e) {
            console.log("moveToListBTN click");

            window.location.href = "${CP}/course/moveToList.do";
        });

    });//--DOMContentLoaded
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

    <!-- Spinner Start -->
    <div id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h2 class="page-header" style="text-align: center;">과정정보</h2>
            </div>
        </div>
        <br><br>

        <input type="hidden" id="sessionEmail"
            value="${sessionScope.user.email}" /> 

            <div class="container col-md-10">
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
                        <tr>
                            <td class="form-label">훈련과정 안내</td>
                            <td><textarea class="form-control" name="courseInfo"
                                    id="courseInfo" readonly="readonly" rows="11" cols="50"
                                    maxlength="500">${course.courseInfo}</textarea></td>
                        </tr>

                    </tbody>
                </table>

                <div class="button-container">
                    <input type="button" value="과정 조회" class="button" id="moveToList">
                </div>
            </div>
        </div>
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

</body>
</html>