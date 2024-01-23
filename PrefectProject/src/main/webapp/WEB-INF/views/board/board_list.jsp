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

<title>게시판 목록</title>
<script>
	
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">게시목록</h1>
			</div>
		</div>
		<form action="#" method="get" id="boardFrm" name="boardFrm">
			<input type="hidden" name="pageNo" id="pageNo">
			<div class="row g-1 justify-content-end ">
			<label for="searchDiv" class="col-auto col-form-label">검색조건</label>
				<select>
					<option value="">전체</option>
					<c:forEach var="vo" items="${boardSearch }">
						<option value="<c:out value='${vo.detCode}'/>"
							<c:if test="${vo.detCode == paramVO.searchDiv }">selected</c:if>><c:out
								value="${vo.detName}" /></option>
					</c:forEach>
				</select>
			</div>
		</form>
	</div>
</body>
</html>