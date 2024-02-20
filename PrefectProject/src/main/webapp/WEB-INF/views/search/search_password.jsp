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
             <h3>비밀번호 찾기</h3>
             <div class="name">
                 <label>이름</label>
                 <input class="w3-input" type="text" id="name" name="name" placeholder="이름을 입력하세요"required>
             </div>
                 <!-- 이메일 본인 인증 -->
		           <div class="form-group email-form">
		            <label for="email">이메일</label>
		                 <div class="input-group">
		                    <input type="text" class="form-control" name="userEmail1" id="userEmail1" placeholder="이메일" required>
		                    <select class="form-control" name="userEmail2" id="userEmail2">
		                    <option>@naver.com</option>
		                    <option>@daum.net</option>
		                    <option>@gmail.com</option>
		                    <option>@hanmail.com</option>
		                     <option>@yahoo.co.kr</option>
		                    </select>
		                </div>   
		            <div class="input-group-addon">
		                <span class="id_ok" style="color:green; display:none;">사용 가능한 아이디입니다.</span>
		                <span class="id_already" style="color:red; display:none;">중복된 아이디입니다!</span>
		                <button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
		            </div>
		                <div class="mail-check-box">
		            <input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
		            </div>
		                <span id="mail-check-warn"></span>
		            </div>
             </div>
             <p class="w3-center">
                 <button type="submit" id="searchPasswordResult" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">비밀번호 찾기</button>
                 <button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">취소</button>
             </p>
         </div>
     <script type="text/javascript">
     $(document).ready(function(){
         console.log("ready!");
         
         //이메일 인증, 이름, 이메일 있는지 확인
         $('#mail-Check-Btn').click(function() {
             const email = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
             console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
             const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
             
             let name = $("#name").val();
             if(name.trim() === ""){
                 alert('이름을 입력하세요.');
                 $("#name").focus();
                 return;
             }
             console.log("이름:" + name);
             
             if($('#userEmail1').val() === ""){
                 alert('이메일을 입력하세요.');
                 $("#email").focus();
                 return;
             }
             console.log("이메일:" + email);
             
             $.ajax({
                 type: "POST",
                 url: "/ehr/search/searchPassword.do",
                 async: true,
                 dataType: "json",
                 data: {
                     "name": name,
                     "email": email
                 },
                 success: function(data){
                     console.log("data.msgId:" + data.msgId);
                     console.log("data.msgContents:" + data.msgContents);
                     
                     if("10" == data.msgId){
                         alert(data.msgContents);
                         $("#name").focus();
                     } else if("20" == data.msgId){
                         alert(data.msgContents);
                         $("#userEmail1").focus();                 
                     } else if("30" == data.msgId){
                    	 
                    	 //이름, 이메일  있으면 인증 이메일 보내기
                    	 $.ajax({
                             type : 'get',
                             url : '/ehr/search/findPassword.do?email='+email, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
                             success : function (data) {
                                 console.log("data : " +  data);
                                 checkInput.attr('disabled',false);
                                 code =data;
                                 alert('인증번호가 전송되었습니다.')
                             }           
                         }); // end ajax
                     }
                 },
                 error: function(data){
                     console.log("error:" + data);
                 },
                 complete: function(data){
                     console.log("complete:" + data);
                 }
             });
            
         }); // end send eamil

         // 인증번호 비교 
         // blur -> focus가 벗어나는 경우 발생
         $('.mail-check-input').blur(function () {
             const inputCode = $(this).val();
             const $resultMsg = $('#mail-check-warn');
             
             if(inputCode == code){
                 $resultMsg.html('인증번호가 일치합니다.');
                 $resultMsg.css('color','green');
                 $('#mail-Check-Btn').attr('disabled',true);
                 $('#userEamil1').attr('readonly',true);
                 $('#userEamil2').attr('readonly',true);
                 $('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
                 $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
             }else{
                 $resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
                 $resultMsg.css('color','red');
             }
         });
         
         $("#searchPasswordResult").on("click",function(e){
             console.log("searchPasswordResult click!");
             const email = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
             window.location.href ="/ehr/search/changePassword.do";
         });
     });
             
     </script>
</body>
</html>