<%@page import="com.pcwk.ehr.subject.domain.SubjectVO"%>
<%@page import="com.pcwk.ehr.user.domain.UserVO"%>
<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />   
<%
	SubjectVO dto = (SubjectVO)request.getAttribute("subjectVO");

%>  
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<head>
<title>학생목록</title>
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
            <h2 class="page-header" style="text-align: center;">훈련생 조회</h2>
        </div>
    </div>    
    <br>
    <br>
    <!--// 제목 ----------------------------------------------------------------->
    <form action="#" method="get" name="subjectFrm" style="display: inline;">
           <input type="hidden" name="pageNo" >
            <!-- 검색구분 -->
 			<div class="row g-1 justify-content-end "> 
 			<label for="searchDiv" class="col-auto col-form-label">검색조건</label>
                <div class="col-auto">
		            <select class="form-select" name="searchDiv" id="searchDiv">
					    <option value="">전체</option>
					    <c:forEach var="subject" items="${subjectCode}">
					        <option value="${subject.detCode}" <c:if test="${subject.detCode == param.searchDiv}">selected</c:if>>${subject.detName}</option>
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
                   <!--  <input type="button" class="btn btn-primary" value="등록"   id="moveToReg"     onclick="window.moveToReg();"> -->
                </div>	           
            </div>
    </form>
    ${sessionScope}
	<!-- table -->
	 <table id="subjectTable"  class="table table-bordered border-primary table-hover table-striped">    
	        <thead>
	        <tr>
	            <th scope="col" class="text-center col-lg-2  col-sm-2">학생</th>
	            <th scope="col" class="text-center col-lg-2  col-sm-2" >과목</th>
	            <th scope="col" class="text-center col-lg-2  col-sm-2" >점수</th>
	        </tr>
	        </thead>
	       <tbody>
	    <c:choose>
	        <%-- 데이터가 있는 경우 --%>
	        <c:when test="${not empty list}">
	            <c:forEach var="vo" items="${list}">
	                <tr>
	                    <%-- 학생 이름을 출력 --%>
	                    <td class="text-center">
	                        <c:forEach var="user" items="${userList}">
	                            <c:if test="${user.email == vo.trainee}">
	                                <input type="hidden" id="traineeEmail" value="${user.email}"/>
	                                ${user.name} <!-- 사용자 이름을 표시 -->
	                            </c:if>
	                        </c:forEach>
	                    </td>		        	 
	                    <%-- 과목 이름을 출력 --%>
	                    <td class="text-left" data-code="${vo.subjectCode}">
	                        <c:forEach var="subject" items="${subjectCode}">
	                            <c:if test="${subject.detCode == vo.subjectCode}">
	                                ${subject.detName} <!-- 과목 이름을 표시 -->
	                            </c:if>
	                        </c:forEach>
	                    </td>
	                    <%-- 점수를 출력 --%>
	                    <td class="text-left">${vo.score}</td>
	                </tr>
	            </c:forEach>
	        </c:when>
	        <%-- 데이터가 없는 경우 --%>
	        <c:otherwise>
	            <tr>
	                <td colspan="3" class="text-center">No data found.</td>
	            </tr>
	        </c:otherwise>
	    </c:choose>
	</tbody>
    </table>
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
                            ${pageHtml}
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
     
     let frm = document.forms['subjectFrm'];//form

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
 
 function  doRetrieve(pageNo){
     console.log('----------------------------');
     console.log('doRetrieve');
     console.log('----------------------------');
     
     let frm = document.forms['subjectFrm'];//form
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
     frm.action = "/ehr/subject/doRetrieve.do";
     //서버 전송
     frm.submit();
 }
 
 $(document).ready(function() {
	    $('.traineeEmail').click(function() {
	        var trainee = $(this).data('trainee');
	        var subjectCode = $(this).data('subjectcode');
	        var coursesCode = $(this).data('coursescode');

	        // AJAX 요청으로 서버에 단건 조회를 요청
	        $.ajax({
	            url: "/ehr/subject/doSelectOne.do",
	            type: 'GET',
	            data: {
	                trainee: trainee,
	                subjectCode: subjectCode,
	                coursesCode: coursesCode
	            },
	            success: function(data) {
	                // 성공적으로 정보를 받아온 경우 처리 로직
	                console.log(data);
	                // 예: 상세 정보 표시 로직
	            },
	            error: function(xhr, status, error) {
	                console.error('Error: ' + error);
	            }
	        });
	    });
	});

 document.addEventListener("DOMContentLoaded", function() {
     // 과목 선택 드롭다운의 변경사항을 감지합니다.
     document.getElementById('searchDiv').addEventListener('change', function() {
         var selectedSubjectCode = this.value; // 선택된 과목 코드를 가져옵니다.
         var tableRows = document.querySelectorAll("#subjectTable tbody tr"); // 테이블의 모든 행을 선택합니다.

         // 각 행에 대해 반복하여 선택된 과목과 일치하는지 여부에 따라 표시합니다.
         tableRows.forEach(function(row) {
             var subjectCode = row.querySelector("td:nth-child(2)").getAttribute('data-code'); // 각 행의 과목 코드를 가져옵니다.

             // 과목 코드가 선택된 과목 코드와 일치하거나, 전체 과목이 선택된 경우(값이 빈 문자열)에 행을 표시합니다.
             if(subjectCode === selectedSubjectCode || selectedSubjectCode === "") {
                 row.style.display = ""; // 행을 표시합니다.
             } else {
                 row.style.display = "none"; // 과목 코드가 일치하지 않는 행은 숨깁니다.
             }
         });
     });
 });
</script>
    
</body>
</html>