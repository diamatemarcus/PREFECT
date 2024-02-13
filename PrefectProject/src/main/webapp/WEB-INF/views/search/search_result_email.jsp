<%@ page import="com.pcwk.ehr.user.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />  
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<head>
<meta charset="UTF-8">
<title>이메일 검색 결과</title>
<style>
       .resultWrap {
            width: 100%;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .emailResult {
            width: 40%;
            background: white;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            text-align: center;
        }
    </style>

</head>

<body>
   <div class="resultWrap">
    <div class="emailResult">
        <h3>이메일 검색 결과</h3>
        <% 
            UserVO user = (UserVO) session.getAttribute("user");
            if(user != null && user.getEmail() != null && !user.getEmail().isEmpty()) {
        %>
       
                <p>이메일: <strong><%= user.getEmail() %></strong></p>
        <%  } else { %>
                <p>검색된 이메일 정보가 없습니다.</p>
        <%  } %>
       <a href="/ehr/login/loginView.do" class="w3-button w3-black">로그인 화면으로 돌아가기</a>
    </div>
</div>

</body>
</html>