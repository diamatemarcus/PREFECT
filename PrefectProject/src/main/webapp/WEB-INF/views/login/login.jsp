<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.board.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />  
<!DOCTYPE html>
<html lang="en">
<head>
      <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap Login Form</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        .login-form {
            width: 340px;
            margin: 50px auto;
        }
        .login-form form {
            margin-bottom: 15px;
            background: #f7f7f7;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            padding: 30px;
        }
        .login-form h2 {
            margin: 0 0 15px;
        }
        .form-control, .btn {
            min-height: 38px;
            border-radius: 2px;
        }
        .btn {        
            font-size: 15px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="login-form">
        <form action="/ehr/login/doLogin.do" method="post">
            <h2 class="text-center">로그인</h2>
            <div class="form-group">
                <input type="text" class="form-control" id="email" name="email" placeholder="아이디" required="required" value="sg8@gmail.com">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required="required" value="8888">
            </div>
            <div class="form-group">
                <button type="button" class="btn btn-primary btn-block" id="doLogin">로그인</button>
            </div>
        </form>
        <p class="text-center"><a href="#">계정 만들기</a></p>
    </div>
    <script type="text/javascript">
        $(document).ready(function(){
            console.log("ready!");
            
            $("#doLogin").on("click",function(e){
                console.log("doLogin click!");
                
                let email = $("#email").val();
                if(email.trim() === ""){
                    alert('아이디를 입력하세요.');
                    $("#email").focus();
                    return;
                }
                console.log("email:" + email);
                
                let password = $("#password").val();
                if(password.trim() === ""){
                    alert('비밀번호를 입력하세요.');
                    $("#password").focus();
                    return;
                }
                console.log("password:" + password);
                
                if(confirm("로그인 하시겠습니까?") === false) return;
                
                $.ajax({
                    type: "POST",
                    url: "/ehr/login/doLogin.do",
                    async: true,
                    dataType: "json",
                    data: {
                        "email": email,
                        "password": password
                    },
                    success: function(data){
                        console.log("data.msgId:" + data.msgId);
                        console.log("data.msgContents:" + data.msgContents);
                        
                        if("10" == data.msgId){
                            alert(data.msgContents);
                            $("#userId").focus();
                        } else if("20" == data.msgId){
                            alert(data.msgContents);
                            $("#password").focus();                 
                        } else if("30" == data.msgId){
                            alert(data.msgContents);
                            window.location.href = "/ehr/main/mainView.do";
                        }
                    },
                    error: function(data){
                        console.log("error:" + data);
                    },
                    complete: function(data){
                        console.log("complete:" + data);
                    }
                });
            });
        });
    </script>
</body>
</html>