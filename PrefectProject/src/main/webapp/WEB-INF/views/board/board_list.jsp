<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.board.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />     
<!DOCTYPE html>
<html> 
<head>  
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<meta charset="utf-8">
<title>${title }</title>
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
    <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
<script>
document.addEventListener("DOMContentLoaded",function(){
	console.log("DOMContentLoaded");
	
	const moveToRegBTN  = document.querySelector("#moveToReg");
	const doRetrieveBTN = document.querySelector("#doRetrieve");//목록 버튼
	const searchDivSelect = document.querySelector("#searchDiv");//id 등록 버튼
    const boardForm = document.querySelector("#boardForm");
    const searchWordTxt = document.querySelector("#searchWord");
    const rows = document.querySelectorAll("#boardTable>tbody>tr");
    
    rows.forEach(function(row) {
        row.addEventListener('click', function(e) {
            let cells = row.getElementsByTagName("td");
            const seq = cells[5].innerText;  
            console.log('seq:' + seq);

            const div = document.querySelector("#div").value;
            console.log('div:'+div);
            
            window.location.href = "${CP}/board/doSelectOne.do?seq="+seq +"&div=" + div;   
        });
    });
	
	// 등록 이동 이벤트
    moveToRegBTN.addEventListener("click",function(e){
        console.log("moveToRegBTN click");
        
        const div = document.querySelector("#div").value;
        window.location.href = "${CP}/board/moveToReg.do?div=" + div;
        
    });
	
    searchWordTxt.addEventListener("keyup", function(e) {
        console.log("keyup:"+e.keyCode);
        if(13==e.keyCode){//
            doRetrieve(1);
        }
        //enter event:
    });
    
    //form submit방지
    boardForm.addEventListener("submit", function(e) {
        console.log(e.target)
        e.preventDefault();//submit 실행방지
        
    }); 
	

	
	 //목록버튼 이벤트 감지
    doRetrieveBTN.addEventListener("click",function(e){
        console.log("doRetrieve click");
        doRetrieve(1);
    });
	
    function doRetrieve(pageNo){
        console.log("doRetrieve pageNO:"+pageNo);
        
        let boardForm = document.boardForm;
        boardForm.pageNo.value = pageNo;
        boardForm.action = "/ehr/board/doRetrieve.do";
        console.log("doRetrieve pageNO:"+boardForm.pageNo.value);
        boardForm.submit();
    }
    
    //검색조건 변경!:change Event처리 
    searchDivSelect.addEventListener("change",function(e){
        console.log("change:"+e.target.value);
        
        let chValue = e.target.value;
        if(""==chValue){ //전체
           
            //input text처리
            let searchWordTxt = document.querySelector("#searchWord");
            searchWordTxt.value = "";
            
            //select값 설정
            let pageSizeSelect =  document.querySelector("#pageSize");
            pageSizeSelect.value = "10";    
        }
    });	

	
});//--DOMContentLoaded

function pageDoRerive(url,pageNo){
    console.log("url:"+url);
    console.log("pageNo:"+pageNo);
    
    let boardForm = document.boardForm;
    boardForm.pageNo.value = pageNo;
    boardForm.action = url;
    boardForm.submit();
}


</script>
<style>
.page-link {
  color: #000; 
  background-color: #fff;
  border: 1px solid #ccc; 
}

.page-link.active{
 z-index: 1;
 color: #fff;
 font-weight:bold;
 background-color: orange;
 border-color: orange;
 }
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
<!-- Navbar start -->
    <div class="container-fluid fixed-top">
        <div class="container px-0">
            <nav class="navbar navbar-light bg-white navbar-expand-xl">
                <a href="index.jsp" class="navbar-brand">
                    <h1 class="text-warning display-6" style="color: #ffb526;font-family: 'Raleway', sans-serif; font-weight: bold;padding-top: 8px;">A R M S</h1>
                </a>
                <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-warning"></span>
                </button>
                <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                    <div class="navbar-nav mx-auto" style=" padding-top: 8px;">
                        <a href="index.jsp" class="nav-item nav-link active">게시판</a>
                        <a href="/board/doRetrieve.do?div=10" class="nav-item nav-link">공지사항</a>
                        <a href="#" class="nav-item nav-link">일정표</a>
                        <a href="/dm/doContentsList.do'" class="nav-item nav-link">메시지</a>
                        <a href="/book/bookApiView.do" class="nav-item nav-link">도서구매</a>
                        <a href="/user/doSelectOne.do" class="nav-item nav-link">마이페이지</a>
                        <a href="/user/doSelectOne.do" class="nav-item nav-link">회원 목록</a> <!-- 관리자에게만 보이게 할 예정-->
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button class="button me-md-2" type="button" onclick="location.href='/login/loginView.do'" style="color:white;background-color: FFA500; font-size: 16px; ">로그인</button>
                        <button class="button" type="button" onclick="location.href='/ehr/user/moveToReg.do'" style="color:white;background-color: FFA500; font-size: 16px">회원가입</button>
                    </div>
                    <div class="d-flex m-3 me-0">
                        <button
                            class="btn-search btn border border-warning btn-md-square rounded-circle bg-white me-4" 
                            data-bs-toggle="modal" data-bs-target="#searchModal">
                            <i class="fas fa-search text-warning" ></i></button>
                        <a href="#" class="my-auto">
                            <i class="fas fa-user fa-2x" style="color: #ffb526;"></i>
                        </a>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->

    <br>
    <br>
    <br>
    <br>
    <br>
<div class="container">
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
        <br>
        <br>
            <h2 class="page-header" style="text-align: center;">${title }</h2>
        </div>
    </div>    
    <br>
    <br>
    <!--// 제목 ----------------------------------------------------------------->

    <!-- 검색 -->
    <form action="#" method="get" id="boardForm" name="boardForm">
      <input type="hidden" name="div"    id="div"  value="${paramVO.getDiv() }"/>
      <input type="hidden" name="pageNo" id="pageNo" />
      <div class="row g-1 justify-content-end ">
          <label for="searchDiv" class="col-auto col-form-label">검색조건</label>
          <div class="col-auto">
              <select class="form-select pcwk_select" id="searchDiv" name="searchDiv">
                     <option value="">전체</option>
                     <c:forEach var="vo" items="${boardSearch }">
                        <option value="<c:out value='${vo.detCode}'/>"  <c:if test="${vo.detCode == paramVO.searchDiv }">selected</c:if>  ><c:out value="${vo.detName}"/></option>
                     </c:forEach>
              </select>
          </div>    
          <div class="col-auto">
              <input type="text" class="form-control" id="searchWord" name="searchWord" maxlength="100" placeholder="검색어를 입력 하세요" value="${paramVO.searchWord}">
          </div>   
          <div class="col-auto"> 
               <select class="form-select" id="pageSize" name="pageSize">
                  <c:forEach var="vo" items="${pageSize }">
                    <option value="<c:out value='${vo.detCode }' />" <c:if test="${vo.detCode == paramVO.pageSize }">selected</c:if>  ><c:out value='${vo.detName}' /></option>
                  </c:forEach>
               </select>  
          </div>    
          <div class="col-auto "> <!-- 열의 너비를 내용에 따라 자동으로 설정 -->
            <input type="button" value="검색" class="btn btn-primary"  id="doRetrieve" style="background-color: orange; border-color: orange;">
            <input type="button" value="글쓰기" class="btn btn-primary"  id="moveToReg" style="background-color: orange; border-color: orange;">
          </div>              
      </div>
                           
    </form>
    <br>
    <br>
    <!--// 검색 ----------------------------------------------------------------->
    
    
    <!-- table -->
    <table class="table table-bordered table-hover table-responsive" id="boardTable">
      <thead>
        <tr >
          <th scope="col" class="text-center col-lg-1  col-sm-1">NO</th>
          <th scope="col" class="text-center col-lg-6  col-sm-8">제목</th>
          <th scope="col" class="text-center col-lg-2  col-sm-1">등록일</th>
          <th scope="col" class="text-center col-lg-1  ">등록자</th>
          <th scope="col" class="text-center col-lg-1  ">조회수</th>
          <th scope="col" class="text-center   " style="display: none;">SEQ</th>
        </tr>
      </thead>         
      <tbody>
        <c:choose>
            <c:when test="${ not empty list }">
              <!-- 반복문 -->
              <c:forEach var="vo" items="${list}" varStatus="status">
                <tr>
                  <td class="text-center col-lg-1  col-sm-1"><c:out value="${vo.no}" escapeXml="true"/> </th>
                  <td class="text-left   col-lg-6  col-sm-8" ><c:out value="${vo.title}" escapeXml="true"/></td>
                  <td class="text-center col-lg-2  col-sm-1"><c:out value="${vo.modDt}" escapeXml="true"/></td>
                  <td class="            col-lg-1 "><c:out value="${vo.modId}" /></td>
                  <td class="text-end    col-lg-1 "><c:out value="${vo.readCnt}" /></td>
                  <td  style="display: none;"><c:out value="${vo.seq}" /></td>
                </tr>              
              </c:forEach>
              <!--// 반복문 -->      
            </c:when>
            <c:otherwise>
               <tr>
                <td colspan="99" class="text-center">조회된 데이터가 없습니다..</td>
               </tr>              
            </c:otherwise>
        </c:choose>
      </tbody>
    </table>
    <!--// table --------------------------------------------------------------> 
    
    <!-- 페이징 : 함수로 페이징 처리 
         총글수, 페이지 번호, 페이지 사이즈, bottomCount, url,자바스크립트 함수
    -->      
    <br>     
    <div class="d-flex justify-content-center">
        <nav>
           ${pageHtml }
        </nav>    
    </div>
    <br>
    <!--// 페이징 ---------------------------------------------------------------->
</div>
<br>
<!-- Copyright Start -->
    <div class="container-fluid copyright py-4" style="background-color: #45595b;">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    <span class="text-light" ><a href="#"  style="color:#ffb526;"><i class="fas fa-copyright text-light me-2"></i>ARMS</a>, All right reserved.</span>
                </div>
                    <div class="col-md-6 my-auto text-center text-md-end text-white">
                    </div>
                 </div>
        </div>
    </div>
    <!-- Copyright End -->

</body>
</html>