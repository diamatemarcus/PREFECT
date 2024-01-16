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
</head>
<body>
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
				    <input type="button" class="btn btn-primary" value="조회" id="doRetrieve" onclick="window.doRetrieve(1);">
				    <input type="button" class="btn btn-primary" value="등록" id="moveToReg"  onclick="window.moveToReg();">
			    </div>
            </div>
    </form>
    
    <!-- table -->
    <table id="userTable"  class="table table-bordered border-primary table-hover table-striped">    
        <thead>
        <tr>
            <th scope="col" class="text-center col-lg-1  col-sm-1">번호</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >사용자ID</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >이름</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >이메일</th>
            <th scope="col" class="text-center col-lg-1  col-sm-1" >등급</th>
            <th scope="col" class="text-center col-lg-1  col-sm-1"  >로그인</th>
            <th scope="col" class="text-center col-lg-1  col-sm-1" >추천</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >수정일</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <%-- 조회데이터가 있는 경우:jsp comment(html에 노출 않됨) --%>
            <c:when test="${not empty list }">
		        <c:forEach var="vo" items="${list}">
			        <tr>
			            <td class="text-center">${vo.no}</td>
			            <td class="text-left">${vo.userId}</td>
			            <td class="text-left">${vo.name }</td>
			            <td class="text-left">${vo.email }</td>
			            <td class="text-left">${vo.level }</td>
			            <td class="text-end">${vo.login}</td>
			            <td class="text-end">${vo.recommend }</td>   
			            <td class="text-center">${vo.regDt }</td>         
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
    <div class="d-flex justify-content-center">
        <nav>
            ${pageHtml}
        </nav>    
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
       
       let userId = tdArray.eq(1).text();
       console.log('userId:'+userId);
       
       window.location.href ="/ehr/user/doSelectOne.do?userId="+userId;
       
   });
    
    function moveToReg(){
        console.log('----------------------------');
        console.log('moveToReg');
        console.log('----------------------------');  
        
        let frm = document.userFrm;
        frm.action = "/ehr/user/moveToReg.do";
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
</body>
</html>