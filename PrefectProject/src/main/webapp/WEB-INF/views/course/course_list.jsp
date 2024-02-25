<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.board.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />     
<!DOCTYPE html>
<html> 
<head>
<link href="${CP}/resources/css/layout.css" rel="stylesheet" type="text/css">
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<script>
document.addEventListener("DOMContentLoaded",function(){
	console.log("DOMContentLoaded");
	


	
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
    <br>
    <br>
    <br>
    <br>
    <br>
    
    ${trainees}
    

   </div>
<br>
<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

</body>
</html>