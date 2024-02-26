<%@page import="com.pcwk.ehr.user.domain.UserVO"%>
<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />   
<%
    UserVO dto = (UserVO)request.getAttribute("searchVO");
%>  
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${CP}/resources/css/layout.css" rel="stylesheet" type="text/css">  

<style>

.table td {
    text-align: center; /* 모든 데이터 셀을 가운데 정렬합니다. */
}
.text-center {
    text-align: center;
}

.table-bordered {
    border: none; /* 테이블 전체 테두리 제거 */
}

.table-bordered th,
.table-bordered td {
    border: none; /* 셀 테두리 제거 */
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
	background-color: #3986ff
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
<script type="text/javascript">
<!-- 이 함수는 페이지를 로드 하기 전에 적용되야 하기에  이 함수만 위에서 작용 -->
$(document).ready(function(){
    // 전화번호 형식을 변환하는 함수
    function formatPhoneNumber(phoneNumber) {
    	//전화번호 사이에 숫자를 제외한 문자 삭제
        var cleaned = ('' + phoneNumber).replace(/\D/g, '');
        //정규식 함수를 이용 해서 010,1234,1234 3파트로 나누기
        var match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);
        // 파트 사이마다 -를 적용
        if (match) {
            return match[1] + '-' + match[2] + '-' + match[3];
        }
        return null;
    }

    // 모든 전화번호에 대해 형식을 변환합니다.
    //$('.tel').each(function(){ 선언 함으로써 클래스에 tel이 붙은걸 찾아서 위 함수 적용
    $('.tel').each(function(){
        var formattedTel = formatPhoneNumber($(this).text());
        $(this).text(formattedTel);
    });
});    
</script>
</head>
<body>

	<!-- Spinner Start -->
    <div id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->
    

    <div class="container">
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
        <br>
        <br>
            <h2 class="page-header" style="text-align: center;">회원 조회</h2>
        </div>
    </div>    
    <br>
    <br>  
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
     <br>
     <br>
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
			            <td class="text-left tel">${vo.tel }</td>
			          	<c:forEach items="${education}" var="eduVO">
						    <c:if test="${eduVO.detCode == vo.edu}">
						        <td class="text-center">
						            <c:out value="${eduVO.detName}"/>
						        </td>
						    </c:if>
						</c:forEach>
						<c:forEach items="${role}" var="roleVO">
						    <c:if test="${roleVO.detCode == vo.role}">
						        <td class="text-center">
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
		        <td colspan="6" class="text-center" style="border: none;">No data found.</td>
		    </tr>
		</c:otherwise>


        </c:choose>
        </tbody>
    </table>
    <!--// table -------------------------------------------------------------->
    <!-- 페이징 : 함수로 페이징 처리 
         총글수, 페이지 번호, 페이지 사이즈, bottomCount, url,자바스크립트 함수
    -->
              
    <div class="container-fluid py-5">
	    <div class="container">
	        <div class="row">
	            <div class="col-lg-12">
	                <!-- Pagination -->
	                <div class="pagination d-flex justify-content-center mt-5">
	                    <nav>
				            ${pageHtml }
				        </nav>
	                </div>
	                <!-- End of Pagination -->
	            </div>
	        </div>
	    </div>
	</div>    
    <!--// 페이징 ---------------------------------------------------------------->    
	


 </div>  
   
  <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

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

</body>
</html>