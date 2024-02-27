<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.subject.domain.SubjectVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
    <meta charset="UTF-8">
    <title>점수 등록</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">점수 등록</h1>
        </div>
    </div>    

    <div class="row justify-content-end">
        <div class="col-auto">
            <input type="button" class="btn btn-primary" value="등록" id="doUpdate">
            <input type="button" class="btn btn-primary" value="목록" id="moveToList" onclick="location.href='doRetrieve.do'">
        </div>
    </div>
     
    <div>
        <form action="#" name="subjectRegFrm">
            <div class="mb-3">
                <label for="name" class="form-label">학생</label>
                <input type="text" class="form-control" readonly="readonly" name="name" id="name" 
                value="${outVO.traineeEmail}" size="20" maxlength="21">
            </div>
            <div class="mb-3">
                <label for="score" class="form-label">점수</label>
                <input type="text" class="form-control" name="score" id="score" value="${outVO.score}" placeholder="점수입력" size="20" maxlength="11">
            </div>                                                        
        </form>
    </div>

    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>    
</div>
</body>
</html>
