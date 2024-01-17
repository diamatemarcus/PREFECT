<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
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
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />
<!-- html head -->
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="/ehr/favicon.ico">
<meta name="viewport"  content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" 
   integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" href="${CP}/resources/css/user.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" 
   integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="${CP}/resources/js/eUtil.js"></script>
<!--// html head --------------------------------------------------------------> 