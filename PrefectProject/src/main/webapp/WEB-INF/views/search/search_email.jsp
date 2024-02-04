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
 <meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>이메일 찾기</title>
	<style>
		* {
		  margin: 0;
		  padding: 0;
		  box-sizing: border-box;}
		  
		.wrap{
			width: 100%;
		  	height: 100vh;
		  	display: flex;
		  	align-items: center;
			justify-content: center;
		}
		.searchEmail{
		  width: 30%;
		  height: 600px;
		  background: white;
		  border-radius: 20px;
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  flex-direction: column;
		
		}
		.w3-input {
		  margin-top: 20px;
		  width: 80%;
		  }
	</style>
</head>
<body>
    <div class="wrap">
        <div class="searchEmail">
             <h3>이메일 찾기</h3>
             <div class="name">
                 <label>이름</label>
                 <input class="w3-input" type="text" id="name" name="name" placeholder="이름을 입력하세요"required>
             </div>
              <div class="tel">
                 <label>전화번호</label>
                 <input class="w3-input" type="text" id="tel" name="tel" placeholder="전화번호를 입력하세요"required>
             </div>
             <p class="w3-center">
                 <button type="submit" id=searchEmailResult class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">이메일 확인</button>
                 <button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">취소</button>
             </p>
         </div>
     </div>
     <script type="text/javascript">
     $(document).ready(function(){
         console.log("ready!");
         
         $("#searchEmailResult").on("click",function(e){
             console.log("searchEmailResult click!");
             
             let name = $("#name").val();
             if(name.trim() === ""){
                 alert('이름을 입력하세요.');
                 $("#name").focus();
                 return;
             }
             console.log("이름:" + name);
             
             let tel = $("#tel").val();
             if(tel.trim() === ""){
                 alert('전화번호 입력하세요.');
                 $("#tel").focus();
                 return;
             }
             console.log("전화번호:" + tel);
             
             if(confirm("이메일을 확인하시겠습니까?") === false) return;
             $.ajax({
                 type: "POST",
                 url: "/ehr/search/searchEmail.do",
                 async: true,
                 dataType: "json",
                 data: {
                     "name": name,
                     "tel": tel
                 },
                 success: function(data){
                     console.log("data.msgId:" + data.msgId);
                     console.log("data.msgContents:" + data.msgContents);
                     
                     if("10" == data.msgId){
                         alert(data.msgContents);
                         $("#name").focus();
                     } else if("20" == data.msgId){
                         alert(data.msgContents);
                         $("#tel").focus();                 
                     } else if("30" == data.msgId){
                         window.location.href = "/ehr/search/searchEmailResultView.do";
                     }
                 },
                 error: function(data){
                     console.log("error:" + data);
                 },
                 complete: function(data){
                     console.log("complete:" + data);
                 }
             });
         });
     });
             
     </script>
</body>
</html>