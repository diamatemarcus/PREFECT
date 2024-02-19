<%@page import="com.pcwk.ehr.subject.domain.SubjectVO"%>
<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />   
<%
	SubjectVO dto = (SubjectVO)request.getAttribute("searchVO");

%>  
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<head>
<title>학생목록</title>
</head>
<body>
<div class="container mt-3">
    <h2>성적 관리</h2>
    <table class="table table-hover">
        <thead>
        <tr>
            <th>과목 코드</th>
            <th>과정 코드</th>
            <th>교수</th>
            <th>훈련생</th>
            <th>점수</th>
        </tr>
        </thead>
	     <tbody>
	        <c:forEach var="subject" items="${list}">
	            <c:if test="${subject.professor == sessionScope.userEmail}">
	                <tr>
	                    <td>${subject.subjectCode}</td>
	                    <td>${subject.coursesCode}</td>
	                    <td>${subject.professor}</td>
	                    <td>${subject.trainee}</td>
	                    <td>${subject.score}</td>
	                </tr>
	            </c:if>
	        </c:forEach>
	        <c:if test="${empty list}">
	            <tr>
	                <td colspan="5" class="text-center">조회된 데이터가 없습니다.</td>
	            </tr>
	        </c:if>
        </tbody>
    </table>
</div> 
<%--  <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>   --%>
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
  
 
   //jquery:table 데이터 선택     
   $("#subjectTable>tbody").on("dblclick","tr" , function(e){
       console.log('----------------------------');
       console.log('subjectTable>tbody');
       console.log('----------------------------');    
       
       let tdArray = $(this).children();//td
       
       let email = tdArray.eq(1).text();
       console.log('email:'+email);
       
       window.location.href ="/ehr/subject/doSelectOne.do?email="+email;
       
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
</script>  
    
</body>
</html>