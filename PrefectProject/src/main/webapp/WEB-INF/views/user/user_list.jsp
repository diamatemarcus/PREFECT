<%@page import="com.pcwk.ehr.user.domain.UserVO"%>
<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />   
<%
    UserVO dto = (UserVO)request.getAttribute("searchVO");
%>  
<!DOCTYPE html>
<html> 
<head>  
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>회원목록</title>
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
.pagenation {
        display: flex;
        list-style-type: none;
        padding: 0;
    }

.pagenation .page-item {
        margin-right: 5px; /* 페이지 아이템 사이의 간격을 조절할 수 있습니다. */
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


	<!-- Navbar start -->
	<div class="container-fluid fixed-top">
		<div class="container px-0">
			<nav class="navbar navbar-light bg-white navbar-expand-xl">
				<a href="index.jsp" class="navbar-brand">
					<h1 class="text-primary display-6" style="padding-top: 8px;">A R M S</h1>
				</a>
				<button class="navbar-toggler py-2 px-3" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
					<span class="fa fa-bars text-primary"></span>
				</button>
				<div class="collapse navbar-collapse bg-white" id="navbarCollapse">
					<div class="navbar-nav mx-auto" style="padding-top: 8px;">
						<a href="/ehr/index.jsp" class="nav-item nav-link">게시판</a>
						<a href="/ehr/board/doRetrieve.do?div=10" class="nav-item nav-link">공지사항</a>
						<a href="/ehr/calendar/doRetrieveCalendar.do" class="nav-item nav-link">캘린더</a>
						<a href="/ehr/dm/doContentsList.do" class="nav-item nav-link">메시지</a> 
						<a href="/ehr/book/bookApiView.do" class="nav-item nav-link">도서구매</a>
						<a href="/ehr/user/doSelectOne.do" class="nav-item nav-link">마이페이지</a>
						<a href="/ehr/user/doRetrieve.do" class="nav-item nav-link active">회원 목록</a><!-- 관리자에게만 보이게 할 예정-->
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
  <div class="container">
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">회원조회</h1>
        </div>
    </div>    
    <!--// 제목 ----------------------------------------------------------------->
    <form action="#" method="get" name="userFrm" style="display: inline;">
           <input type="hidden" name="pageNo" >
            <!-- 검색구분 -->
           <div class="row g-1 justify-content-end "> 
                <label for="searchDiv" class="col-auto col-form-label">검색조건</label>
                <div class="col-auto">
		            <select name="searchDiv" id="searchDiv" class="form-select pcwk_select">
		              <option value="">전체</option>
                      <c:forEach var="vo" items="${userSearch }">
                        <option value="<c:out value='${vo.detCode}'/>"  <c:if test="${vo.detCode == searchVO.searchDiv }">selected</c:if>  ><c:out value="${vo.detName}"/></option>
                      </c:forEach>
		            </select>
	            </div> 
	            <!-- 검색어 -->
	            <div class="col-auto">
	               <input type="text"  class="form-control" value="${searchVO.searchWord }" name="searchWord" id="searchWord" placeholder="검색어를 입력하세요">
	            </div>
	            <div class="col-auto"> 
		            <!-- pageSize: 10,20,30,50,10,200 -->
               <select class="form-select" id="pageSize" name="pageSize">
                  <c:forEach var="vo" items="${pageSize }">
                    <option value="<c:out value='${vo.detCode }' />" <c:if test="${vo.detCode == searchVO.pageSize }">selected</c:if>  ><c:out value='${vo.detName}' /></option>
                  </c:forEach>
               </select>   
	            </div>   
			    <!-- button -->
			    <div class="col-auto "> <!-- 열의 너비를 내용에 따라 자동으로 설정 -->
				    <input type="button" class="btn btn-primary" value="조회"   id="doRetrieve"    onclick="window.doRetrieve(1);">
				    <input type="button" class="btn btn-primary" value="등록"   id="moveToReg"     onclick="window.moveToReg();">
			    </div>
            </div>
    </form>
    
    <!-- table -->
    <table id="userTable"  class="table table-bordered border-primary table-hover table-striped mt-2">    
        <thead>
        <tr>
            <th scope="col" class="text-center col-lg-2  col-sm-2">번호</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >사용자이메일</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >이름</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >전화번호</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >학력</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2"  >역할</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <%-- 조회데이터가 있는 경우:jsp comment(html에 노출 않됨) --%>
            <c:when test="${not empty list }">
		        <c:forEach var="vo" items="${list}">
			        <tr>
			            <td class="text-center">${vo.no}</td>
			            <td class="text-left">${vo.email}</td>
			            <td class="text-left">${vo.name }</td>
			            <td class="text-left">${vo.tel }</td>
			            <c:forEach items="${education}" var="eduVO">
						    <c:if test="${eduVO.detCode == vo.edu}">
						        <td class="text-end">
						            <c:out value="${eduVO.detName}"/>
						        </td>
						    </c:if>
						</c:forEach>
			            	<c:forEach items="${role}" var="roleVO">
			            		<c:if test="${roleVO.detCode == vo.role}">
			            			<td class="text-end">
						            <c:out value="${roleVO.detName}"/>
						            </td>  
						        </c:if>
			        	</c:forEach>
			        </tr>
		        </c:forEach>
	        </c:when>
	        <%-- 조회데이터가 없는 경우:jsp comment(html에 노출 않됨) --%>
	        <c:otherwise>
	           <tr>
	               <td colspan="99" class="text-center">No data found.</td>
	           </tr>
	        </c:otherwise>
        </c:choose>
        </tbody>
    </table>
    <!--// table -------------------------------------------------------------->
    <!-- 페이징 : 함수로 페이징 처리 
         총글수, 페이지 번호, 페이지 사이즈, bottomCount, url,자바스크립트 함수
    -->
              
  	<div class="container">
			<div class="row">
				<div class="col">
            				${pageHtml}
        		</div>
        	</div>  
    </div>
    <!--// 페이징 ---------------------------------------------------------------->    
    
 <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>    
 </div>  
<%--  <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>   --%>
 <script type="text/javascript">
 
 
  function pageDoRerive(url, pageNo){
	  console.log('url:'+url);
	  console.log('pageNo:'+pageNo);
	  
      let frm = document.forms['userFrm'];//form

      frm.pageNo.value = pageNo;
      //pageNo
      frm.action = url;
      //서버 전송
      frm.submit();	  
  }
  //jquery event감지
  $("#searchWord").on("keypress",function(e){
	  console.log('searchWord:keypress');
	  //e.which : 13
	  console.log(e.type+':'+e.which);
	  if(13==e.which){
		  e.preventDefault();//버블링 중단
		  doRetrieve(1);
	  }
  });
  
 
   //jquery:table 데이터 선택     
   $("#userTable>tbody").on("dblclick","tr" , function(e){
       console.log('----------------------------');
       console.log('userTable>tbody');
       console.log('----------------------------');    
       
       let tdArray = $(this).children();//td
       
       let email = tdArray.eq(1).text();
       console.log('email:'+email);
       
       window.location.href ="/ehr/user/doSelectOne.do?email="+email;
       
   });
    
    function moveToReg(){
        console.log('----------------------------');
        console.log('moveToReg');
        console.log('----------------------------');  
        
        let frm = document.userFrm;
        frm.action = "/ehr/login/moveToReg.do";
        frm.submit();
        
       //window.location.href= '/ehr/user/moveToReg.do';
      
    }
    
    function  doRetrieve(pageNo){
        console.log('----------------------------');
        console.log('doRetrieve');
        console.log('----------------------------');
        
        let frm = document.forms['userFrm'];//form
        let pageSize = frm.pageSize.value;
        console.log('pageSize:'+pageSize);
        
        let searchDiv = frm.searchDiv.value;
        console.log('searchDiv:'+searchDiv);
        
        let searchWord = frm.searchWord.value;
        console.log('searchWord:'+searchWord);
        
        console.log('pageNo:'+pageNo);
        frm.pageNo.value = pageNo;
        
        console.log('pageNo:'+frm.pageNo.value);
        //pageNo
        frm.action = "/ehr/user/doRetrieve.do";
        //서버 전송
        frm.submit();
    }
</script>

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