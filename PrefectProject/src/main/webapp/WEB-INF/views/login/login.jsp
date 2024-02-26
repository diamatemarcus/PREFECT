<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />

<!doctype html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/53a8c415f1.js"
	crossorigin="anonymous"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="${CP}/resources/js/eUtil.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${CP}/resources/template/login/assets/css/bootstrap.min.css" type="text/css">
<!-- FontAwesome CSS -->
<link rel="stylesheet" href="${CP}/resources/template/login/assets/css/all.min.css" type="text/css">
<link rel="stylesheet" href="${CP}/resources/template/login/assets/css/uf-style.css" type="text/css">
<style>
.arms-container {
    display: flex; /* 항목들을 가로로 정렬 */
    align-items: center; /* 항목들을 세로 중앙에 위치 */
}


</style>
<script>

        $(document).ready(function(){
            console.log( "ready!" );
            
            $("#doLogin").on("click",function(e){
                console.log( "doLogin click!" );
                
                let email = document.querySelector("#email").value;
                if(eUtil.isEmpty(email)==true){
                    swal("아이디를 입력 하세요","", {icon: "info"});
                    document.querySelector("#email").focus();
                    return;
                }
                console.log( "email:"+email );
                
                let password = document.querySelector("#password").value;
                if(eUtil.isEmpty(password)==true){
                    swal("비번을 입력 하세요","", {icon: "info"});
                    document.querySelector("#password").focus();
                    return;
                }
                console.log( "password:"+password );
                
                if(swal("로그인을 하시겠습니까?","", {icon: "info"})===false) return;
                
                $.ajax({
                    type: "POST",
                    url:"/ehr/login/doLogin.do",
                    asyn:"true",
                    dataType:"json",
                    data:{
                        "email": email,
                        "password": password
                    },
                    success:function(data){//통신 성공
                        console.log("data.msgId:"+data.msgId);
                        console.log("data.msgContents:"+data.msgContents);
                        
                        if("10" == data.msgId){
                            swal(data.msgContents,"", {icon: "error"});
                            document.querySelector("#email").focus();
                            window.location.href = "/ehr/login/loginView.do";
                        }else if("20" == data.msgId){
                            swal(data.msgContents,"", {icon: "error"});
                            document.querySelector("#password").focus();
                            window.location.href = "/ehr/login/loginView.do";
                        }else if("30" == data.msgId){
                            swal(data.msgContents,"", {icon: "success"});
                            window.location.href = "/ehr/index.jsp";
                        }
                    },
                    error:function(data){//실패시 처리
                        console.log("error:"+data);
                    },
                    complete:function(data){//성공/실패와 관계없이 수행!
                        console.log("complete:"+data);
                    }
                });         
                
                
            });//--#doLogin
            
            
        });       
</script>
<title>ARMS Login</title>
</head>

<body>
	<div class="uf-form-signin">
 		 <a href="/ehr/index.jsp" class="navbar-brand">
             	<div class="arms-container d-flex align-items-center">
                    <img src="${CP}/resources/template/img/acorn.png" alt="ARMS Logo" width="50" height="50">
                    <h1 class="text-primary display-6">ARMS</h1> <!-- ms-3은 왼쪽 여백을 추가합니다 -->
                </div>
        </a>
		<form class="login-form" action="/ehr/login/doLogin.do" method="post">
			<div class="input-group uf-input-group input-group-lg mb-3">
				<span class="input-group-text fa fa-user"></span>
				<input type="text" id="email" name="email" class="form-control" placeholder="Email address">
			</div>
			<div class="d-flex mb-3 justify-content-between">
				<div class="form-check">
					<!-- 빈공간을 만들기 위함-->
				</div>
				<div class="search_email">
					<a href="${CP}/search/searchEmailView.do">이메일 찾기</a>
				</div>
			</div>
			<div class="input-group uf-input-group input-group-lg mb-3">
				<span class="input-group-text fa fa-lock"></span>
				<input type="password" id="password" name="password" class="form-control" placeholder="Password">
			</div>
			<div class="d-flex mb-3 justify-content-between">
				<div class="form-check">
					<!-- 빈공간을 만들기 위함-->
				</div>
				<a href="/ehr/search/searchPasswordView.do">비밀번호 찾기</a>
			</div>
			<div class="d-grid mb-4">
				<button type="submit" class="btn uf-btn-primary btn-lg" id="doLogin">로그인</button>
			</div>
			<div class="d-flex mb-3">
				<div class="dropdown-divider m-auto w-25"></div>
				<small class="text-nowrap text-white">다른 방법 로그인</small>
				<div class="dropdown-divider m-auto w-25"></div>
			</div>
			<div class="uf-social-login d-flex justify-content-center">
				<a href="#" class="uf-social-ic" title="Login with Facebook"><i class="fab fa-facebook-f"></i></a>
			</div>
			<div class="mt-4 text-center">
				<span class="text-white">회원이 아니신가요?</span> <a
					href="/ehr/user/moveToReg.do">회원가입</a>
			</div>
		</form>
	</div>

</body>
</html>