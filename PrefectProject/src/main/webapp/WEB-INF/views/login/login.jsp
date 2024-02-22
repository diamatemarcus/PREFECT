<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.board.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />

<!doctype html>
<html lang="en">
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

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${CP}/resources/template/login/assets/css/bootstrap.min.css" type="text/css">
<!-- FontAwesome CSS -->
<link rel="stylesheet" href="${CP}/resources/template/login/assets/css/all.min.css" type="text/css">
<link rel="stylesheet" href="${CP}/resources/template/login/assets/css/uf-style.css" type="text/css">
<title>Login Form Bootstrap 1 by UIFresh</title>
</head>
<body>
	<div class="uf-form-signin">
		<div class="text-center">
			<a href="#"><img src="${CP}/resources/template/login/assets/img/logo-fb.png" alt="" width="100" height="100"></a>
			<h1 class="text-white h3">Account Login</h1>
		</div>
		<form class="login-form" action ="/ehr/login/doLogin.do" method= "POST">
			<div class="input-group uf-input-group input-group-lg mb-3">
				<span class="input-group-text fa fa-user"></span>
				<input type="text" id="user-email" name="email" class="form-control" placeholder="Email address" required="required">
			</div>
			<div class="d-flex mb-3 justify-content-between">
				<div class="form-check">
					<!-- 빈공간을 만들기 위함-->
				</div>
				<div class="search_email">
					<a href="${CP}/search/searchEmailView.do">Forgot Email?</a>
				</div>
			</div>
			<div class="input-group uf-input-group input-group-lg mb-3">
				<span class="input-group-text fa fa-lock"></span>
				<input type="password" id="user-password" name="password" class="form-control" placeholder="Password" required="required">
			</div>
			<div class="d-flex mb-3 justify-content-between">
				<div class="form-check">
					<!-- 빈공간을 만들기 위함-->
				</div>
				<a href="/ehr/search/searchPasswordView.do">Forgot password?</a>
			</div>
			<div class="d-grid mb-4">
				<button type="submit" class="btn uf-btn-primary btn-lg" id="doLogin">Login</button>
			</div>
			<div class="d-flex mb-3">
				<div class="dropdown-divider m-auto w-25"></div>
				<small class="text-nowrap text-white">Or login with</small>
				<div class="dropdown-divider m-auto w-25"></div>
			</div>
			<div class="uf-social-login d-flex justify-content-center">
				<a href="#" class="uf-social-ic" title="Login with Facebook"><i class="fab fa-facebook-f"></i></a>
			</div>
			<div class="mt-4 text-center">
				<span class="text-white">Don't have an account?</span> <a
					href="/ehr/user/moveToReg.do">Sign Up</a>
			</div>
		</form>
	</div>

	<!-- JavaScript -->
<script>
        $('#doLogin').on('click', function () {
        	console.log("click 하였슴")
        	
        if (confirm('로그인 하시겠습니까?')) {
            if ($('#user-email').val() == '') {
                alert('아이디를 입력하세요.');
                return;
            }
            if ($('#user-password').val() == ''){
                alert('비밀번호를 입력하세요.');
                return;
            }
        }});
</script>
</body>
</html>