<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>ARMS - IT훈련학원 커뮤니티</title>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
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
	font-size: 16px;
	cursor: pointer;
	border-radius: 8px;
	background-color: #FFA500
}
</style>
</head>

<body>
	<!-- Spinner Start -->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>
	<!-- Spinner End -->

<!-- Modal Search Start -->
	<div class="modal fade" id="searchModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen">
			<div class="modal-content rounded-0">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Search by
						keyword</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex align-items-center">
					<div class="input-group w-75 mx-auto d-flex">
						<input type="search" class="form-control p-3"
							placeholder="keywords" aria-describedby="search-icon-1">
						<span id="search-icon-1" class="input-group-text p-3"><i
							class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Search End -->
	<div class="container-fluid py-5">
		<div id="container">
			<div class="bg-light p-5 rounded">
				<div class="row g-4 justify-content-center">
					<div class="wrap col-md-2 col-lg-3 col-xl-3">
						<div class="d-flex" style="height: 200px;">
							<div class="vr mt-4"></div>
							<div class="group" style="padding-top: 10px; font-size: 12px">
								<ul>
									<li><a href="#" class="new"> Java 게시판 </a></li>
									<li><a href="#" class="new"> SQL 게시판 </a></li>
									<li><a href="#" class="new"> Spring 게시판 </a></li>
									<li><a href="#" class="new"> Spring-boot 게시판 </a></li>
									<li><a href="#" class="new"> Python 게시판 </a></li>
								</ul>
							</div>

						</div>
					</div>
					<div class="wrap col-md-3">
						<div class="d-flex" style="height: 200px;">
							<div class="vr mt-4"></div>
							<div class="group" style="padding-top: 10px; font-size: 12px;">
								<ul>
									<li><a href="#" class="new"> AI인공지능 게시판 </a></li>
									<li><a href="#" class="new"> 딥러닝 게시판 </a></li>
									<li><a href="#" class="new"> 머신러닝 게시판 </a></li>
									<li><a href="#" class="new"> 취업 게시판 </a></li>
									<li><a href="#" class="new"> 2023-9-7 Java 풀스택 개발자 과정
											게시판 </a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="wrap col-md-3">
						<div class="d-flex" style="height: 200px;">
							<div class="vr mt-4"></div>
							<div class="group" style="padding-top: 10px; font-size: 12px;">
								<ul>
									<li><a href="/ehr/board/doRetrieve.do?div=20'" class="new">
											자유 게시판 </a></li>
									<li><a href="#" class="new"> 고민 게시판 </a></li>
									<li><a href="#" class="new"> 점심메뉴추천 게시판 </a></li>
									<li><a href="#" class="new"> 취업 게시판 </a></li>
									<li><a href="#" class="new"> 2023-9-7 Java 풀스택 개발자 과정
											게시판 </a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="wrap col-md-3">
						<div class="d-flex" style="height: 200px;">
							<div class="vr mt-4"></div>
							<div class="group" style="padding-top: 10px; font-size: 12px;">
								<ul>
									<li><a href="#" class="new"> AI인공지능 게시판 </a></li>
									<li><a href="#" class="new"> 딥러닝 게시판 </a></li>
									<li><a href="#" class="new"> 머신러닝 게시판 </a></li>
									<li><a href="#" class="new"> 취업 게시판 </a></li>
									<li><a href="#" class="new"> 2023-9-7 Java 풀스택 개발자 과정
											게시판 </a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>

	<!-- Middle -->
	<div class="container py-4 col-md-3">
		<div class="row bg-light p-4 rounded">
			<div class="counter bg-white rounded p-4">
				<div class="wrap">
					<p>
						커뮤니티 이용을 위해 <span class="login-text" style="color: red">로그인</span>이
						필요합니다!
					</p>
					<button class="button" type="button"
						onclick="location.href='/ehr/login/loginView.do'"
						style="background-color: FFA500; width: 200px; height: 38px; margin-bottom: 10px; font-size: 13px;">로그인</button>
					<button class="button" type="button"
						onclick="location.href='/ehr/user/moveToReg.do'"
						style="background-color: FFA500; width: 200px; height: 38px; font-size: 13px">ARMS
						회원가입</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Middle End -->
	<!-- Fact Start -->
	<div class="container-fluid py-5">
		<div class="container">
			<div class="bg-light p-5 rounded">
				<div class="row g-4 justify-content-center;">
					<div class="col-md-3 col-lg-3 col-xl-3">
						<div class="counter bg-white rounded p-5">
							<i class="fa fa-users text-secondary"></i>
							<h5>방문자수</h5>
							<div class="d" style="font-size: 17px">1963</div>
						</div>
					</div>
					<div class="col-md-3 col-lg-3 col-xl-3">
						<div class="counter bg-white rounded p-5">
							<i class="fa fa-users text-secondary"></i>
							<h5>접속률</h5>
							<div class="d" style="font-size: 17px">89%</div>
							</h1>
						</div>
					</div>
					<div class="col-md-3 col-lg-3 col-xl-3">
						<div class="counter bg-white rounded p-5">
							<i class="fa fa-users text-secondary"></i>
							<h5>채팅방에 있는 인원</h5>
							<div class="d" style="font-size: 17px">33</div>
							</h1>
						</div>
					</div>
					<div class="col-md-3 col-lg-3 col-xl-3">
						<div class="counter bg-white rounded p-5">
							<i class="fa fa-users text-secondary"></i>
							<h5>업데이트 된 게시판</h5>
							<div class="d" style="font-size: 17px">12</div>
							</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Fact Start -->


	<!-- Tastimonial Start -->
	<div class="container-fluid testimonial py-5">
		<div class="container py-5">
			<div class="testimonial-header text-center">
				<h4 class="text-primary">이거 함 보쉴?</h4>
				<h1 class="display-5 mb-5 text-dark">BEST 게시물</h1>
			</div>
			<div class="owl-carousel testimonial-carousel">
				<div class="testimonial-item img-border-radius bg-light rounded p-4">
					<div class="position-relative">
						<i
							class="fa fa-quote-right fa-2x text-secondary position-absolute"
							style="bottom: 30px; right: 0;"></i>
						<div class="mb-4 pb-4 border-bottom border-secondary">
							<p class="mb-0">안쓰는 행거 나눔합니다.</p>
						</div>
						<div class="d-flex align-items-center flex-nowrap">
							<div class="bg-secondary rounded">
								<img src="${CP}/resources/template/img/testimonial-1.jpg"
									class="img-fluid rounded" style="width: 100px; height: 100px;"
									alt="">
							</div>
							<div class="ms-4 d-block">
								<h4 class="text-dark">김길동</h4>
								<p class="m-0 pb-3">student</p>
								<div class="d-flex pe-5">
									<i class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i> <i class="fas fa-star"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="testimonial-item img-border-radius bg-light rounded p-4">
					<div class="position-relative">
						<i
							class="fa fa-quote-right fa-2x text-secondary position-absolute"
							style="bottom: 30px; right: 0;"></i>
						<div class="mb-4 pb-4 border-bottom border-secondary">
							<p class="mb-0">ㅎㅎ 여친이 애플워치 사줌</p>
						</div>
						<div class="d-flex align-items-center flex-nowrap">
							<div class="bg-secondary rounded">
								<img src="${CP}/resources/template/img/gosong.jpg"
									class="img-fluid rounded" style="width: 100px; height: 100px;"
									alt="">
							</div>
							<div class="ms-4 d-block">
								<h4 class="text-dark">고송민</h4>
								<p class="m-0 pb-3">플러팅 고수</p>
								<div class="d-flex pe-5">
									<i class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="testimonial-item img-border-radius bg-light rounded p-4">
					<div class="position-relative">
						<i
							class="fa fa-quote-right fa-2x text-secondary position-absolute"
							style="bottom: 30px; right: 0;"></i>
						<div class="mb-4 pb-4 border-bottom border-secondary">
							<p class="mb-0">Lorem Ipsum is simply dummy text of the
								printing Ipsum has been the industry's standard dummy text ever
								since the 1500s,</p>
						</div>
						<div class="d-flex align-items-center flex-nowrap">
							<div class="bg-secondary rounded">
								<img src="${CP}/resources/template/img/testimonial-1.jpg" class="img-fluid rounded"
									style="width: 100px; height: 100px;" alt="">
							</div>
							<div class="ms-4 d-block">
								<h4 class="text-dark">Client Name</h4>
								<p class="m-0 pb-3">Profession</p>
								<div class="d-flex pe-5">
									<i class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i> <i
										class="fas fa-star text-primary"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Tastimonial End -->




	<!-- Copyright Start -->
	<div class="container-fluid copyright bg-dark py-4">
		<div class="container">
			<div class="row">
				<div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
					<span class="text-light"><a href="#"><i
							class="fas fa-copyright text-light me-2"></i>ARMS</a>, All right
						reserved.</span>
				</div>
				<div class="col-md-6 my-auto text-center text-md-end text-white">
					<!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
					<!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
					<!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
					Designed By <a class="border-bottom" href="#">노동자</a> Distributed
					By <a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Copyright End -->



	<!-- Back to Top -->
	<a href="#"	class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
	<i class="fa fa-arrow-up"></i>
	</a>


	<!-- JavaScript Libraries -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="${CP}/resources/template/lib/easing/easing.min.js" type="text/javascript"></script>
	<script src="${CP}/resources/template/lib/waypoints/waypoints.min.js" type="text/javascript"></script>
	<script src="${CP}/resources/template/lib/lightbox/js/lightbox.min.js" type="text/javascript"></script>
	<script src="${CP}/resources/template/lib/owlcarousel/owl.carousel.min.js" type="text/javascript"></script>

	<!-- Template Javascript -->
	<script src="${CP}/resources/template/js/main.js" type="text/javascript"></script>


</body>

</html>