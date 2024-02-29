<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>

<style>
#mainchartdiv {
  width: 100%;
  height: 300px;
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
<!--  Modal Search End
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
 -->    
    <!-- Middle -->
    <br>
    <br>
    <br>
   <div class="container mt-10">
        <div class="row ">
   			<div class="col-5 g-4 mt-10 justify-content-center;">
   				<div id = mainchartdiv></div>
   			</div>
   			<div class="col-3 g-4 mt-10 justify-content-center;">
   				<div id = mainchartdiv2></div>
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
                            <h5>회원수</h5>
                            <div class="d" style="font-size: 17px">${totalUsers}</div>
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
                            <h5>게시글 수</h5>
                            <div class="d" style="font-size: 17px">${totalBoard}</div>
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
                <h4 class="text-primary">출석이벤트</h4>
                <h1 class="display-5 mb-5 text-dark">수상자</h1>
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

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
    <i class="fa fa-arrow-up"></i>
    </a>

<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

<!--  chart Resources -->
<script src="https://cdn.amcharts.com/lib/5/index.js"></script>
<script src="https://cdn.amcharts.com/lib/5/percent.js"></script>
<script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>
<script src="${CP}/resources/js/piechart.js" type="text/javascript"></script>
</body>

<script>

</script>

</html>