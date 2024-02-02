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
<title>달력</title>
<script>
document.addEventListener("DOMContentLoaded",function(){
	console.log("DOMContentLoaded");

	const nextMonthBTN  = document.querySelector("#nextMonth");
	const lastMonthBTN  = document.querySelector("#lastMonth");
	let month  = document.querySelector("#month").value;
	
	console.log("월 : ", month);
	
	// "01" 형식을 정수 1로 바꾸는 과정
	let monthInt = parseInt(month, 10);
	console.log(monthInt);
	
	
	/* let now = new Date();	// 현재 날짜 및 시간
	let month = now.getMonth();	// 월
	console.log("월 : ", month + 1); */
	
	 if (monthInt <= 1) {
	        lastMonthBTN.style.display = "none";
	    }
	
	if (monthInt >= 12) {
		nextMonthBTN.style.display = "none";
    }
	

	nextMonthBTN.addEventListener("click",function(e){
		
		console.log("nextMonthBTN click");
		
		//다음 달
		monthInt ++;
		
		//정수를 "01" 형식 String으로 바꾸는 과정
		let stringValue = monthInt < 10 ? '0' + monthInt : String(monthInt);
		console.log(stringValue);
		
		//(#month) value 값 변경
		month = stringValue;
		console.log(month);
	     
	    window.location.href = "${CP}/calendar/doRetrieveCalendar.do?month="+month; 
      
  	});
	
	lastMonthBTN.addEventListener("click",function(e){
			
			console.log("lastMonthBTN click");
			
			//다음 달
			monthInt --;
			
			//정수를 "01" 형식 String으로 바꾸는 과정
			let stringValue = monthInt < 10 ? '0' + monthInt : String(monthInt);
			console.log(stringValue);
			
			//(#month) value 값 변경
			month = stringValue;
			console.log(month);
		     
		    window.location.href = "${CP}/calendar/doRetrieveCalendar.do?month="+month; 
	      
	  });
    
});//--DOMContentLoaded



</script>
</head>
<body>
${calendarList }
<div class="container">
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">달력</h1>
            <div class="col-auto "> <!-- 열의 너비를 내용에 따라 자동으로 설정 -->
            <input type="button" value="이전" class="btn btn-primary"  id="lastMonth">
            <input type="button" value="다음" class="btn btn-primary"  id="nextMonth">
          </div>
        </div>
    </div>    
    
    <input type="text" name="month"    id="month"  value="${month}"/>
    
    <!--// 제목 ----------------------------------------------------------------->

    <!-- 검색 -->
    <%-- <form action="#" method="get" id="calendar" name="calendar">
      <input type="hidden" name="div"    id="div"  value="${paramVO.getDiv() }"/>
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
                           
    </form> --%>
    <!--// 검색 ----------------------------------------------------------------->
    
    
    <!-- table -->
    <table class="table table-bordered border-primary table-hover table-striped" id="calendarTable">
      <thead>
        <tr >
          <th scope="col" class="text-center col-lg-1  col-sm-1">일</th>
          <th scope="col" class="text-center col-lg-1  col-sm-1">월</th>
          <th scope="col" class="text-center col-lg-1  col-sm-1">화</th>
          <th scope="col" class="text-center col-lg-1  col-sm-1">수</th>
          <th scope="col" class="text-center col-lg-1  col-sm-1">목</th>
          <th scope="col" class="text-center col-lg-1  col-sm-1">금</th>
          <th scope="col" class="text-center col-lg-1  col-sm-1">토</th>
        </tr>
      </thead>         
      <tbody>
        <c:choose>
            <c:when test="${ not empty calendarList }">
              <!-- 반복문 -->
              <c:forEach var="vo" items="${calendarList}" varStatus="status">
                <tr>
                  <td class="text-center col-lg-1  col-sm-1"><c:out value="${vo.sun}"/> </td>
                  <td class="text-center col-lg-1  col-sm-1" ><c:out value="${vo.mon}"/> </td>
                  <td class="text-center col-lg-1  col-sm-1"><c:out value="${vo.tue}"/> </td>
                  <td class="text-center col-lg-1  col-sm-1"><c:out value="${vo.wed}" /> </td>
                  <td class="text-center col-lg-1  col-sm-1"><c:out value="${vo.thu}" /> </td>
                  <td class="text-center col-lg-1  col-sm-1"><c:out value="${vo.fri}" /> </td>
                  <td class="text-center col-lg-1  col-sm-1"><c:out value="${vo.sat}" /> </td>
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
    <%-- <div class="d-flex justify-content-center">
        <nav>
           ${pageHtml }
        </nav>    
    </div> --%>
    <!--// 페이징 ---------------------------------------------------------------->
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>               
</div>

</body>
</html>