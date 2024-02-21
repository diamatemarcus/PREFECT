<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.subject.domain.SubjectVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<meta charset="EUC-KR">
<title>점수 등록</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

<script>
function moveToList(){
	   console.log("----------------------");
	   console.log("-moveToList()-");
	   console.log("----------------------");
	   
	   window.location.href = "/ehr/subject/doRetrieve.do";
}


function doUpdate(){
    console.log("----------------------");
    console.log("-doUpdate()-");
    console.log("----------------------");
    
    //javascript
    console.log("javascript email:"+document.querySelector("#email").value);
    console.log("javascript ppl_input:"+document.querySelector(".ppl_input").value);
    
    //$("#email").val() : jquery id선택자
    //$(".email")
    
    console.log("jquery email:"+$("#email").val());
    console.log("jquery ppl_input:"+$(".ppl_input").val());      
      

    //confirm
    if(confirm("수정 하시겠습니까?")==false)return;
    
    $.ajax({
        type: "POST",
        url:"/ehr/subject/doUpdate.do",
        asyn:"true",
        dataType:"html",
        data:{
         trainee:document.querySelector("#trainee").value,
            score: document.querySelector("#score").value,
        },
        success:function(data){//통신 성공     
            console.log("success data:"+data);
           //data:{"msgId":"1","msgContents":"dd가 등록 되었습니다.","no":0,"totalCnt":0,"pageSize":0,"pageNo":0}
           let parsedJSON = JSON.parse(data);
           if("1" === parsedJSON.msgId){
               alert(parsedJSON.msgContents);
               moveToList();
           }else{
               alert(parsedJSON.msgContents);
           }
        
        },
        error:function(data){//실패시 처리
            console.log("error:"+data);
        },
        complete:function(data){//성공/실패와 관계없이 수행!
            console.log("complete:"+data);
        }
    });
    
}

</script>
</head>
<body>
<div class="container">
         <!-- 제목 -->
	    <div class="row">
	        <div class="col-lg-12">
	            <h1 class="page-header">점수등록</h1>
	        </div>
	    </div>    
	    <!--// 제목 ----------------------------------------------------------------->
	    <!-- 버튼 -->
	    <div class="row justify-content-end">
	        <div class="col-auto">
		       <input type="button" class="btn btn-primary" value="등록" id="doUpdate"      onclick="window.doUpdate();">
		       <input type="button" class="btn btn-primary" value="목록" id="moveToList"  onclick="window.moveToList();">
	        </div>
	    </div>
        <!--// 버튼 ----------------------------------------------------------------->
	     
	     <!-- 회원 등록영역 -->  
	     <div>
	       <form action="#" name="subjectRegFrm">
 
               <div class="mb-3"> <!--  아래쪽으로  여백 -->
                   <label for="trainee" class="form-label">학생</label>
                   <input type="text"  class="form-control" readonly="readonly"  name="name" id="name" 
                   value= "${vo.trainee} " size="20"  maxlength="21">
               </div>	               
               <div class="mb-3">
                   <label for="score" class="form-label">점수</label>
                   <input type="text"  class="form-control numOnly" name="score" id="score" placeholder="점수입력" size="20"  maxlength="11">
               </div>    
                                                         
	       </form>
	     </div>
	     <!--// 회원 등록영역 ------------------------------------------------------>
	     <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>    
     </div>
     <script>
     
     </script>
</body>
</html>