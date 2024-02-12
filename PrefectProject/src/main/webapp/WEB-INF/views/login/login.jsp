<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.board.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인</title>
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
</head>
<body>
	<div class="wrap">
		<div class="login">
			<h2>로그인</h2>
			<div class="login_email">
				<h4>E-mail</h4>
				<input type="text" class="form-control" id="email" name="email"
					placeholder="이메일을 입력하세요" required="required">
			</div>
			<div class="login_pw">
				<h4>비밀번호</h4>
				<input type="password" class="form-control" id="password"
					name="password" placeholder="비밀번호를 입력하세요" required="required">
			</div>
			<div class="search">
				<div class="search_email">
					<a href="${CP}/search/searchEmailView.do">이메일을 잊어버리셨나요?</a>
				</div>
				<div class="search_password" id="searchPassword">
					<a href="/login/search_password">비밀번호를 잊어버리셨나요?</a>
				</div>
			</div>
			<div class="submit">
				<input type="submit" id="doLogin" value="로그인">
			</div>
			<br>
			<div class="register">
				<a href="/ehr/login/moveToReg.do"><u>Prefect가 처음이신가요?</u></a>
			</div>
			</p>
			<div class="login_sns">
				<li><a id="custom-login-btn" href="javascript:kakaoLogin()">
						<img
						src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
						width="280" />
				</a>
			</div>
		</div>
	</div>
	

	<script type="text/javascript">
		$(document).ready(function() {
			console.log("ready!");

			$("#doLogin").on("click", function(e) {
				console.log("doLogin click!");

				let email = $("#email").val();
				if (email.trim() === "") {
					alert('이메일을 입력하세요.');
					$("#email").focus();
					return;
				}
				console.log("email:" + email);

				let password = $("#password").val();
				if (password.trim() === "") {
					alert('비밀번호를 입력하세요.');
					$("#password").focus();
					return;
				}
				console.log("password:" + password);

				if (confirm("로그인 하시겠습니까?") === false)
					return;

				$.ajax({
					type : "POST",
					url : "/ehr/login/doLogin.do",
					async : true,
					dataType : "json",
					data : {
						"email" : email,
						"password" : password
					},
					success : function(data) {
						console.log("data.msgId:" + data.msgId);
						console.log("data.msgContents:" + data.msgContents);

						if ("10" == data.msgId) {
							alert(data.msgContents);
							$("#email").focus();
						} else if ("20" == data.msgId) {
							alert(data.msgContents);
							$("#password").focus();
						} else if ("30" == data.msgId) {
							alert(data.msgContents);
							window.location.href = "/ehr/main/mainView.do";
						}
					},
					error : function(data) {
						console.log("error:" + data);
					},
					complete : function(data) {
						console.log("complete:" + data);
					}
				});
			});
		});
	</script>
</body>
</html>