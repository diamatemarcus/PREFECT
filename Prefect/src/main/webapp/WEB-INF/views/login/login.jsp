<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<link rel="shortcut icon" type="image/x-icon" href="/ehr/favicon.ico">
<title>PCWK</title>
<script src="/ehr/resources/js/jquery-3.7.1.js"></script>
<script src="/ehr/resources/js/eUtil.js"></script>
<script type="text/javascript">
 $(document).ready(function(){
	 console.log( "ready!" );
	 
	 $("#doLogin").on("click",function(e){
		 console.log( "doLogin click!" );
		 
		 let userId = document.querySelector("#userId").value;
		 if(eUtil.isEmpty(userId)==true){
			 alert('아이드를 입력 하세요.');
			 document.querySelector("#userId").focus();
			 return;
		 }
		 console.log( "userId:"+userId );
		 
         let password = document.querySelector("#password").value;
         if(eUtil.isEmpty(password)==true){
             alert('비번을 입력 하세요.');
             document.querySelector("#password").focus();
             return;
         }
         console.log( "password:"+password );
		 
         if(confirm("로그인 하시겠습니까?")===false) return;
         
         $.ajax({
             type: "POST",
             url:"/ehr/login/doLogin.do",
             asyn:"true",
             dataType:"json",
             data:{
            	 "userId": userId,
            	 "password": password
             },
             success:function(data){//통신 성공
                 console.log("data.msgId:"+data.msgId);
                 console.log("data.msgContents:"+data.msgContents);
                 
                 if("10" == data.msgId){
                	 alert(data.msgContents);
                	 document.querySelector("#userId").focus();
                 }else if("20" == data.msgId){
                     alert(data.msgContents);
                     document.querySelector("#password").focus();                 
                 }else if("30" == data.msgId){
                	 alert(data.msgContents);
                	 window.location.href = "/ehr/main/mainView.do";
                 }
             },
             error:function(data){//실패시 처리
                 console.log("error:"+data);
             },
             complete:function(data){//성공/실패와 관계없이 수행!
                 console.log("complete:"+data);
             }
         });         
         
         
	 });//--#doLogin
	 
	 
 });//--document ready
</script>
</head>
<body>
    <fieldset style="width:300px;">
      <legend>로그인</legend>
	    <form action="#" method="post">
	       <table>
	        <tr>
	            <td>
	               <label for="userId">아이디</label>
	            </td>
	            <td>        
	               <input type="text" id="userId" name="userId" size="20" maxlength="30" value="p99">
	            </td>
	        </tr>
	        <tr>
	           <td>
	             <label for="password">비밀번호</label>
	           </td>
	           <td>     
	             <input  type="password" id="password" name="password" size="20" maxlength="30" class="input" value="4321">
	           </td>  
	        </tr>
	        </table>         
	    </form>
	    <input type="button" value="로그인"  id="doLogin" class="btn">
    </fieldset>
</body>
</html>