<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="/ehr/favicon.ico">
<meta name="viewport"  content="width=device-width, initial-scale=1">
<link href="${CP}/resources/css/bootstrap.min.css" rel="stylesheet" >
<link rel="stylesheet" href="${CP}/resources/css/user.css">
<title>게시등록</title>
<script src="${CP}/resources/js/bootstrap.bundle.min.js"></script>
<script src="${CP}/resources/js/jquery-3.7.1.js"></script>
<script src="${CP}/resources/js/eUtil.js"></script>
</head>
<body>

<ul class="nav">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="<c:url value='/login/loginView.do'/>">로그인</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="<c:url value='/naver/naverApiView.do'/>">naver 검색</a>
  </li> 
  <li class="nav-item">
    <a class="nav-link" href="<c:url value='/user/doRetrieve.do'/>">회원목록</a>
  </li>  
  <li class="nav-item">
    <a class="nav-link" href="<c:url value='/board/doRetrieve.do'/>">게시목록</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="<c:url value='/board/moveToReg.do'/>">게시등록</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="<c:url value='/chart/viewPie.do'/>">파이차트</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="<c:url value='/chart/viewLineChart.do'/>">라인차트</a>
  </li>  
  <li class="nav-item">
    <a class="nav-link" href="<c:url value='/template/viewBlank.do'/>">blank</a>
  </li>  
      
  <li class="nav-item">
    <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
  </li>
</ul>        

</body>
</html>