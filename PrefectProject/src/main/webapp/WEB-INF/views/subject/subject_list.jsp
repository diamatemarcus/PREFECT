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
  <div class="container">
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">훈련생 조회</h1>
        </div>
    </div>  

<!-- table -->
 <table id="subjectTable"  class="table table-bordered border-primary table-hover table-striped">    
        <thead>
        <tr>
            <th scope="col" class="text-center col-lg-2  col-sm-2">학생</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >자바</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >SQL</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >스프링</th>
            <th scope="col" class="text-center col-lg-2  col-sm-2" >파이썬</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <%-- 조회데이터가 있는 경우:jsp comment(html에 노출 않됨) --%>
            <c:when test="${not empty list }">
		        <c:forEach var="vo" items="${list}">
			        <tr>
			            <td class="text-center">
				            <c:forEach var="user" items="${userList}">
				                <c:if test="${user.email == vo.trainee}">
				                <input type="hidden" id="traineeEmail" value="${user.email }"/>
				                    ${user.name} <!-- 사용자 이름을 표시 -->
				                </c:if>
				            </c:forEach>
				        </td>       			
			            <td class="text-left">${vo.javaScore}</td> <!-- 자바 점수 -->
    					<td class="text-left">${vo.sqlScore}</td> <!-- SQL 점수 -->
				        <td class="text-left"></td>

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

<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>    
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
  $("#subjectTable>tbody").on("dblclick", "tr", function(e) {
      console.log('----------------------------');
      console.log('subjectTable>tbody');
      console.log('----------------------------');

      let tdArray = $(this).children(); //td
      let email = document.querySelector("#traineeEmail").value;
      let trainee = tdArray.eq(0).text().trim();
      console.log('trainee:' + trainee);
      console.log('email:' + email);

      // .do 제거 및 파라미터 이름 변경
      // window.location.href = "/ehr/subject/doSelectOne.do?trainee=" + trainee;
      window.location.href = "/ehr/subject/doSelectOne.do?email=" + email;
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