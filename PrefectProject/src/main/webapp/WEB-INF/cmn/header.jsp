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
                    <h1 class="text-primary display-6" style="padding-top: 8px;">A
                        R M S</h1>
                </a>
                <button class="navbar-toggler py-2 px-3" type="button"
                    data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-primary"></span>
                </button>
                <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                    <div class="navbar-nav mx-auto" style="padding-top: 8px;">
                        <a href="/ehr/board/doRetrieve.do?div=10" class="nav-item nav-link">공지사항</a>
                        <a href="/ehr/board/doRetrieve.do?div=20" class="nav-item nav-link active">게시판</a>
                        <a href="/ehr/calendar/doRetrieveCalendar.do" class="nav-item nav-link">캘린더</a>
                        <a href="/ehr/dm/doContentsList.do" class="nav-item nav-link">메시지</a> 
                        <a href="/ehr/book/bookApiView.do" class="nav-item nav-link">도서구매</a>
                        <a href="/ehr/user/doSelectOne.do" class="nav-item nav-link">마이페이지</a>
                        <a href="/ehr/user/doRetrieve.do" class="nav-item nav-link">회원 목록</a><!-- 관리자에게만 보이게 할 예정-->
                        <a href="/ehr/subject/doRetrieve.do" class="nav-item nav-link">성적 관리</a>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button class="button me-md-2" type="button" onclick="location.href='/ehr/login/loginView.do'" style="background-color: FFA500; font-size: 12px;">로그인</button>
                        <button class="button" type="button" onclick="location.href='/ehr/user/moveToReg.do'" style="background-color: FFA500; font-size: 12px">회원가입</button>
                    </div>
                    <div class="d-flex m-3 me-0">
                        <button
                            class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4"
                            data-bs-toggle="modal" data-bs-target="#searchModal">
                            <i class="fas fa-search text-primary"></i>
                        </button>
                        <a href="#" class="my-auto"> <i class="fas fa-user fa-2x"></i>
                        </a>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->