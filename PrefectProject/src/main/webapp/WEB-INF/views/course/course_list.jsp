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
	
	

});//--DOMContentLoaded
</script>
<style>

</style>
</head>
<body>
	<input type="hidden" id="sessionEmail"
		value="${sessionScope.user.email}" />

	<br>
	<br>
	<br>
	<br>
	<br>
	
	<div class="row">
		<div class="container col-md-6">
		    
		    <!-- Title -->
		    <div class="col-lg-12">
		      ${ trainees }
		        <h2 class="title" style="text-align: left;"> 학생 조회 </h2>
		    </div>
		    
		    <!-- Trainees List -->
			<table class="table">
		        <thead>
					<tr>
					    <th scope="col" class="text-center col-lg-1">NO</th>
					    <th scope="col" class="text-center col-lg-2">학생</th>
					    <th scope="col" class="text-center col-lg-5">훈련 과정</th>
					</tr>
				</thead>
			    <tbody>
                    <c:choose>
                        <c:when test="${ not empty trainees }">
                            <!-- 반복문 -->
                            <c:forEach var="vo" items="${ trainees }" varStatus="status">
                                <tr>
                                    <td class="text-center col-lg-1  col-sm-1">${ status.count }</td>
                                                             
                                    <!-- 학생 : 이름으로 조회 ------------------------------------------------------->           
                                    <!-- 등록자 이름을 한 번만 출력하기 위한 변수 선언 -->
                                    <c:set var="printedName" value="false" />
                                                                        
                                    <!-- 사용자 목록을 순회하면서 조건을 확인 -->
	                                <c:forEach items="${users}" var="user">
	                                    <c:if test="${vo.email eq user.email and not printedName}">	                                        
	                                        <!-- 조건을 만족하는 경우에만 사용자 이름을 출력하고, printedName을 true로 설정 -->
	                                        <td class="text-center col-lg-2">${user.name}</td>
	                                        <c:set var="printedName" value="true" />
	                                    </c:if>
	                                </c:forEach>
	                                
	                                <!-- 사용자 이름이 출력되지 않은 경우 빈 칸 출력 -->
		                            <c:if test="${not printedName}">
		                                <td class="text-center col-lg-2">-</td>
		                            </c:if>
		                            <!-- // 학생 : 이름으로 조회 ----------------------------------------------------->
	                                
                                    <td class="text-center col-lg-1  col-sm-1">${ vo.courseName } ${ vo.numberOfTimes }회차</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                    </c:choose>
				</tbody>
			</table> 
		</div>
	</div>

	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

</body>
</html>