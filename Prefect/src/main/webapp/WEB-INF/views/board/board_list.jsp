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
<title>게시판 목록</title>
<script>
document.addEventListener("DOMContentLoaded",function(){
	console.log("DOMContentLoaded");
	
	//javasript 선택자 
	const moveToRegBTN  = document.querySelector("#moveToReg");
	const doRetrieveBTN = document.querySelector("#doRetrieve");//목록 버튼
	const searchDivSelect = document.querySelector("#searchDiv");//id 등록 번튼
  
	//let searchDivSelect = document.querySelector(".pcwk_select");//style class선택
	  
	//jQuery
	//const doRetrieveBTN = $("#doRetrieve")
	//const doRetrieveBTN = $(".doRetrieve")
	
	//form submit방지
	const boardForm = document.querySelector("#boardFrm");
	const searchWordTxt = document.querySelector("#searchWord");
	//변경

	//jquery
/* 	$("#boardTable>tbody").on("click","tr" , function(e){
		 console.log('boardTable:');
		 let tdArray = $(this).children();
		 let seq = tdArray.eq(5).text();
		 console.log('seq:'+seq);
	}); */
	 


	//javascript:다건 이벤트 처리
	const rows = document.querySelectorAll("#boardTable>tbody>tr");
	//각행에 이벤트 처리
	rows.forEach(function(row) {
		row.addEventListener('click',function(e){
	         //클릭된 행의 모든 셀(td)을 가져 오기		
			 let cells = row.getElementsByTagName("td");
			 const seq   = cells[5].innerText;
			 console.log('seq:'+seq);

       //javascript
       if(confirm('상세 조회 하시겠어요!')==false) return;
      //http://localhost:8080/board/doSelectOne.do?seq=5151
       window.location.href = "${CP}/board/doSelectOne.do?seq="+seq;   

		});
	});

	
	
	moveToRegBTN.addEventListener("click",function(e){
		console.log("moveToRegBTN click");
		
		boardForm.action = "/ehr/board/moveToReg.do";
		boardForm.submit();
		
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
		
		let boardForm = document.boardFrm;
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
			//console.log("chValue:"+chValue);
		    
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
    
    let boardForm = document.boardFrm;
    boardForm.pageNo.value = pageNo;
    boardForm.action = url;
    boardForm.submit();
}
</script>
</head>
<body>
<div class="container">
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">게시목록</h1>
        </div>
    </div>    
    <!--// 제목 ----------------------------------------------------------------->

    <!-- 검색 -->
    <form action="#" method="get" id="boardFrm" name="boardFrm">
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
            <input type="button" value="목록" class="btn btn-primary"  id="doRetrieve">
            <input type="button" value="등록" class="btn btn-primary"  id="moveToReg">
          </div>              
      </div>
                           
    </form>
    <!--// 검색 ----------------------------------------------------------------->
    
    
    <!-- table -->
    <table class="table table-bordered border-primary table-hover table-striped" id="boardTable">
      <thead>
        <tr >
          <th scope="col" class="text-center col-lg-1  col-sm-1">NO</th>
          <th scope="col" class="text-center col-lg-7  col-sm-8">제목</th>
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
                  <td class="text-left   col-lg-7  col-sm-8" ><c:out value="${vo.title}" escapeXml="true"/></td>
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
    <div class="d-flex justify-content-center">
        <nav>
           ${pageHtml }
        </nav>    
    </div>
    <!--// 페이징 ---------------------------------------------------------------->
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>               
</div>

</body>
</html>