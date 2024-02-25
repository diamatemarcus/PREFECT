<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
    //JSP (JavaServer Pages)에서 캐시 컨트롤을 구현하려면 일반적으로 HTTP 응답 헤더를 사용하여 캐싱 동작을 제어합니다
    //현재 날짜와 시간
    Date currentDate=new Date();

    //날짜 포맷 지정
    SimpleDateFormat  sdf=new SimpleDateFormat("yyyyMMdd HH:mm:ss z");
    
    //Cache-Control 헤더 설정 (캐시를 사용하지 않도록 설정)
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");

    //Pragma 헤더 설정 (이전 버전과의 호환성을 위해 설정)
    response.setHeader("Pragma","no-cache");
    
    //Expires 헤더설정 (현재 시간으로부터 0으로 설정: 즉시 만료)
    response.setHeader("Expires",sdf.format(new Date(0)));
    
    //out.print("currentDate:"+sdf.format(new Date(0)));
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />
<!-- html head -->
<meta charset="UTF-8">

<%-- 탭 아이콘 변경--%>
<link rel="shortcut icon" type="image/x-icon" href="/ehr/Arms.ico">

<meta name="viewport"  content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" 
   integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" href="${CP}/resources/css/user.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" 
   integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="${CP}/resources/js/eUtil.js"></script>
<style>
.button {
    width: auto;
    /* 버튼의 크기를 내용에 맞게 자동으로 조절합니다. */
    /* 다른 스타일을 원하는 대로 추가할 수 있습니다. */
    padding: 10px 20px;
    /* 내용과 버튼의 테두리 간격을 조정합니다. */
    border: none;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 17px;
    cursor: pointer;
    border-radius: 8px;
    background-color: #FFA500;
    color: white;
}
</style>

<!-- html head ------------------------------------------------------------------->

<meta charset="utf-8">
<title>ARMS - IT 훈련학원 커뮤니티</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
    rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="${CP}/resources/template/lib/lightbox/css/lightbox.min.css" rel="stylesheet" type="text/css">
<link href="${CP}/resources/template/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" type="text/css">

<!-- Customized Bootstrap Stylesheet -->
<link href="${CP}/resources/template/css/bootstrap.min.css" rel="stylesheet" type="text/css">

<!-- Template Stylesheet -->
<link href="${CP}/resources/template/css/style.css" rel="stylesheet" type="text/css">

<!--// html head --------------------------------------------------------------> 

    <!-- Navbar start -->
    <div class="container-fluid fixed-top">
        <div class="container px-0">
            <nav class="navbar navbar-light bg-white navbar-expand-xl">
                <a href="/ehr/index.jsp" class="navbar-brand">
                    <div class="arms-container">
                        <img src="${CP}/resources/template/img/acorn.png" width="50" height="50">
                        <h1 class="text-primary display-6">A R M S</h1>
                    </div>
                </a>
                <button class="navbar-toggler py-2 px-3" type="button"
                    data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-primary"></span>
                </button>
                <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                    <div class="navbar-nav mx-auto" style="padding-top: 8px;">
                        <a href="/ehr/board/doRetrieve.do?div=10" class="nav-item nav-link">공지사항</a>
                        <a href="/ehr/board/doRetrieve.do?div=20" class="nav-item nav-link">게시판</a>
                        <li class="nav-item dropdown">
                          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                  게시판
                          </a>
                          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="/ehr/board/doRetrieve.do?div=20">자유게시판</a></li>
                            <li><a class="dropdown-item" href="#">Another action</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Something else here</a></li>
                          </ul>
                        </li>
                        <a href="/ehr/calendar/doRetrieveCalendar.do" class="nav-item nav-link">캘린더</a>
                        <c:if test="${role eq '10'}">
   							 <a href="/ehr/user/doRetrieve.do" class="nav-item nav-link">회원 목록</a><!-- 관리자에게만 보이게 할 예정-->
						</c:if>  
                        <c:if test="${role eq '20' || role eq '30'}">   
    						 <a href="/ehr/subject/doRetrieve.do" class="nav-item nav-link">성적 관리</a>
						</c:if>
                        <a href="/ehr/book/bookApiView.do" class="nav-item nav-link">도서검색</a>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <% if(session.getAttribute("user") == null) { %>
                        <button class="button me-md-2" type="button" onclick="location.href='/ehr/login/loginView.do'">로그인</button>
                        <button class="button" type="button" onclick="location.href='/ehr/user/moveToReg.do'">회원가입</button>
                        <% } else { %>
                            <!-- 사용자 이름과 로그아웃 버튼 표시 -->
                            <span class="navbar-text">
                                ${sessionScope.user.name}님 환영합니다.
                            </span>
                            <button class="button" type="button" onclick="location.href='/ehr/login/doLogout.do'">로그아웃</button>
                        <% } %>
                    </div>
                    <div class="d-flex m-3 me-0">
                 		<c:choose>
    						<c:when test="${role eq '30'}"> <!-- 학생 -->
         						<a href="/ehr/user/doSelectOne.do" class="my-auto"> <i class="fas fa-user fa-2x"></i></a>
    			  		    </c:when>
    						<c:when test="${role eq '20'}"> <!-- 교수 -->
         						<a href="/ehr/user/doSelectOne.do" class="my-auto"> <i class="fas fa-user fa-2x"></i></a>
    			   			</c:when>
    			   			<c:when test="${role eq '10'}"> <!-- 관리자 -->
                                <a href="/ehr/user/doSelectOne.do" class="my-auto"> <i class="fas fa-user fa-2x"></i></a>
                            </c:when>
						</c:choose>
                    </div>
                    <div class="d-flex m-3 me-0">
                        <a href="/ehr/dm/doContentsList.do" class="my-auto"> 
                        <i class="fas fa-envelope fa-2x"></i> <!-- 메시지 아이콘 -->
                        </a>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->