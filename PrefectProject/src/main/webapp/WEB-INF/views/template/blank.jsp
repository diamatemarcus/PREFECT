<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />     
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>no name</title>
</head>
<body>
    <div class="container">
	    <!-- 제목 -->
	    <div class="row">
	        <div class="col-lg-12">
	            <h1 class="page-header">제목</h1>
	        </div>
	    </div>    
	    <!--// 제목 ------------------------------------------------------------->    
    
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
    </div>
</body>
</html>