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
<link href="${CP}/resources/css/bootstrap.min.js" rel="stylesheet" >
<link rel="stylesheet" href="${CP}/resources/css/user.css">

<title>게시등록</title>
<script src="${CP}/resources/js/bootstrap.bundle.min.js"></script>
<script src="${CP}/resources/js/jquery-3.7.1.js"></script>
<script src="${CP}/resources/js/eUtil.js"></script>
</head>
<body>

<%-- <nav class="navbar navbar-dark bg-primary navbar-expand-lg">
  <div class="container-fluid">
    <span class="navbar-brand mb-0 h1">PCWK</span>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <div class="navbar-nav">
        <a class="nav-link active" href="<c:url value='/user/doRetrieve.do'/>">회원목록</a>
        <a class="nav-link" href="<c:url value='/board/doRetrieve.do?div=10'/>">공지사항</a>
        <a class="nav-link" href="<c:url value='/board/doRetrieve.do?div=20'/>">자유게시판</a>
        <a class="nav-link active" href="<c:url value='/dm/doContentsList.do'/>">쪽지</a>
        <a class="nav-link active" aria-current="page" href="<c:url value='/login/loginView.do'/>">로그인</a>
        <a class="nav-link active" aria-current="page" href="<c:url value='/book/bookApiView.do'/>">도서구매</a>
        <a class="nav-link active" aria-current="page" href="<c:url value='/user/doSelectOne.do'/>">마이페이지</a>
        
        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
      </div>           
    </div>    
  </div>
</nav> --%>
<nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
    <div class="container-fluid">
        <a class="navbar-brand">ARMS</a>
        <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0">
              <li class="nav-item">
                  <a class="nav-link" href="<c:url value='/user/doRetrieve.do'/>">회원목록</a>
              </li>
              <li class="nav-item">
                  <a class="nav-link" href="<c:url value='/board/doRetrieve.do?div=10'/>">공지사항</a>
              </li>
              <li class="nav-item">
                  <a class="nav-link" href="<c:url value='/board/doRetrieve.do?div=20'/>">자유게시판</a>
              </li>
              <li class="nav-item">
                  <a class="nav-link" href="<c:url value='/dm/doContentsList.do'/>">쪽지</a>
              </li>
              <li class="nav-item">
                  <a class="nav-link" href="<c:url value='/login/loginView.do'/>">로그인</a>
              </li>
               <li class="nav-item">
                  <a class="nav-link" href="<c:url value='/book/bookApiView.do'/>">도서구매</a>
              </li>
               <li class="nav-item">
                  <a class="nav-link" href="<c:url value='/user/doSelectOne.do'/>">마이페이지</a>
              </li>
          </ul>
        </div>
    </div>
</nav>

</body>
</html>