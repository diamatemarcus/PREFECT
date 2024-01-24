<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />     
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>회원등록</title>
<script >

	//A $( document ).ready() block.
	//body에 모든 element가 로딩이 완료되면 동작
	$( document ).ready(function() {
	    console.log( "ready!" );
	    //숫자만 입력
	    //keyup: keyboard event로 키보드를 keyup 했을때 발생
	    $(".numOnly").on("keyup",function(e){
	        console.log("numOnly:"+$(this).val());
	        
	        let replaceNum = $(this).val().replace(/[^0-9]/g, "");
	        
	        $(this).val(replaceNum);
	    });
	    	    
	    
	});//document ready

   function emailDuplicateCheck(){
	   console.log("-emailDuplicateCheck()-");	
	   let email = document.querySelector("#email").value;
       if(eUtil.isEmpty(email) == true){
           alert('이메일을 입력 하세요.');
           //$("#email").focus();//사용자 email에 포커스
           document.querySelector("#email").focus();
           return;
       }
       
       $.ajax({
           type: "GET",
           url:"/ehr/user/emailDuplicateCheck.do",
           asyn:"true",
           dataType:"json", /*return dataType: json으로 return */
           data:{
               email: email
           },
           success:function(data){//통신 성공
               console.log("success data:"+data);
               //let parsedJSON = JSON.parse(data);
               if("1" === data.msgId){
                   alert(data.msgContents);
                   document.querySelector("#idCheck").value = 0;
               }else{
                   alert(data.msgContents);
                   document.querySelector("#idCheck").value = 1;
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
	
	
   function moveToList(){
	   console.log("----------------------");
	   console.log("-moveToList()-");
	   console.log("----------------------");
	   
	   window.location.href = "/ehr/user/doRetrieve.do";
   }
   
   function doSave(){
       console.log("----------------------");
       console.log("-doSave()-");
       console.log("----------------------");
       
       //javascript
       console.log("javascript email:"+document.querySelector("#email").value);
       console.log("javascript ppl_input:"+document.querySelector(".ppl_input").value);
       
       //$("#email").val() : jquery id선택자
       //$(".email")
       
       console.log("jquery email:"+$("#email").val());
       console.log("jquery ppl_input:"+$(".ppl_input").val());      
       
       if(eUtil.isEmpty(document.querySelector("#email").value) == true){
    	   alert('아이디를 입력 하세요.');
    	   //$("#email").focus();//사용자 id에 포커스
    	   document.querySelector("#email").focus();
    	   return;
       }
       
       if(eUtil.isEmpty(document.querySelector("#name").value) == true){
           alert('이름을 입력 하세요.');
           //$("#email").focus();//사용자 email에 포커스
           document.querySelector("#name").focus();
           return;
       }       
       
       
       if(eUtil.isEmpty(document.querySelector("#password").value) == true){
           alert('비밀번호를 입력 하세요.');
           //$("#email").focus();//사용자 email에 포커스
           document.querySelector("#password").focus();
           return;
       } 
       
       if(eUtil.isEmpty(document.querySelector("#tel").value) == true){
           alert('전화번호을 입력 하세요.');
           //$("#email").focus();//사용자 email에 포커스
           document.querySelector("#tel").focus();
           return;
       }      
       
       if(eUtil.isEmpty(document.querySelector("#edu").value) == true){
           alert('학력을 입력 하세요.');
           //$("#email").focus();//사용자 email에 포커스
           document.querySelector("#edu").focus();
           return;
       }

       if(eUtil.isEmpty(document.querySelector("#role").value) == true){
           alert('역할을 입력 하세요.');
           //$("#email").focus();//사용자 email에 포커스
           document.querySelector("#role").focus();
           return;
       }      

       
       if(document.querySelector("#emailCheck").value == '0'){
           alert('이메일 중복체크를 수행 하세요.');
           //$("#email").focus();//사용자 email에 포커스
           document.querySelector("#emailCheck").focus();
           return;
       }
       
       //confirm
       if(confirm("등록 하시겠습니까?")==false)return;
       
       
       $.ajax({
           type: "POST",
           url:"/ehr/user/doSave.do",
           asyn:"true",
           dataType:"html",
           data:{
        	   email:document.querySelector("#email").value,
        	   name: document.querySelector("#name").value,
        	   password: document.querySelector("#password").value,
        	   tel: document.querySelector("#tel").value,
        	   edu: document.querySelector("#edu").value,
        	   role: document.querySelector("#role").value,
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
	            <h1 class="page-header">회원등록</h1>
	        </div>
	    </div>    
	    <!--// 제목 ----------------------------------------------------------------->
	    <!-- 버튼 -->
	    <div class="row justify-content-end">
	        <div class="col-auto">
		       <input type="button" class="btn btn-primary" value="등록" id="doSave"      onclick="window.doSave();">
		       <input type="button" class="btn btn-primary" value="목록" id="moveToList"  onclick="window.moveToList();">
	        </div>
	    </div>
        <!--// 버튼 ----------------------------------------------------------------->
	     
	     <!-- 회원 등록영역 -->  
	     <div>
	       <form action="#" name="userRegFrm">
	           <%-- email중복체크 수행 여부 확인:0(미수행),1(수행) --%>
	           <input type="hidden" name="emailCheck" id="emailCheck" value="0">
	           <div class="mb-3">
	               <label for="email" class="form-label">이메일</label>
	               <input type="text"  class="form-control ppl_input" name="email" id="email" placeholder="아이디를 입력 하세요." size="20"  maxlength="30">
	               <input type="button" class="btn btn-primar" value="등록" id="emailDuplicateCheck"      onclick="window.emailDuplicateCheck();">
	           </div>
               <div class="mb-3"> <!--  아래쪽으로  여백 -->
                   <label for="name" class="form-label">이름</label>
                   <input type="text"  class="form-control"  name="name" id="name" placeholder="이름을 입력 하세요." size="20"  maxlength="21">
               </div>	
               <div class="mb-3">
                   <label for="password" class="form-label">비밀번호</label>
                   <input type="password"  class="form-control"  name="password" id="password" placeholder="비밀번호를 입력 하세요." size="20"  maxlength="30">
               </div>                 
               <div class="mb-3">
                   <label for="tel" class="form-label">전화번호</label>
                   <input type="text"  class="form-control numOnly" name="tel" id="tel" placeholder="전화번호를 입력하세요" size="20"  maxlength="11">
               </div>    
               <div class="mb-3">     
                   <label for="edu" class="form-label">학력</label>
                   <input type="text" class="form-control"  name="edu" id="edu" placeholder="학력를 입력하세요" size="20"  maxlength="8">
               </div>
    
               <div class="mb-3">
                   <label for="role" class="form-label">역할</label>
                   <input type="text" class="form-control"  name="role" id="role" placeholder="" size="20"  maxlength="7">
               </div>                                                        
	       </form>
	     </div>
	     <!--// 회원 등록영역 ------------------------------------------------------>
	     <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>    
     </div>
</body>
</html>