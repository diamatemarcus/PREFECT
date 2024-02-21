<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.board.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="EUC-KR">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${CP}/resources/template/login/assets/css/bootstrap.min.css" type="text/css">
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="${CP}/resources/template/login/assets/css/all.min.css" type="text/css">
    <link rel="stylesheet" href="${CP}/resources/template/login/assets/css/uf-style.css" type="text/css">
    <title>Register Form Bootstrap 1 by UIFresh</title>
    <script src="${CP}/resources/js/eUtil.js" type="text/javascript"></script>
    
  </head>
  <body>
    <div class="uf-form-signin">
      <div class="text-center">
        <a href="https://uifresh.net/"><img src="${CP}/resources/template/login/assets/img/logo-fb.png" alt="" width="100" height="100"></a>
      <h1 class="text-white h3">회원가입</h1>
      </div>
      <form class="mt-4">
        <div class="form-group email-form">
        	       <!-- 이메일 본인 인증 -->
                 <%-- email중복체크 수행 여부 확인:0(미수행),1(수행) --%>
        <input type="hidden" name="idCheckYet" id="idCheckYet" value="0">
        <div class="input-group uf-input-group input-group-lg mb-3">
          <span class="input-group-text fa fa-envelope"></span>
              <input type="text" class="form-control" name="userEmail1" id="userEmail1" placeholder="이메일" required oninput="idCheck()" >
              <select class="form-control" name="userEmail2" id="userEmail2" onchange="idCheck()">
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
            <input class="form-control mail-check-input mt-1" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
          </div>
            <span id="mail-check-warn"></span>
        </div>



        <div class="input-group uf-input-group input-group-lg mb-1 mt-1">
          <span class="input-group-text fa fa-user"></span>
          <input type="text"  class="form-control "  name="name" id="name" placeholder="이름" size="20"  maxlength="21">
        </div>

         <div class="input-group uf-input-group input-group-lg mb-1">
           <span class="input-group-text fa fa-lock"></span>
           <input type="password"  class="form-control"  name="password" id="user-password" placeholder="비밀번호" size="20"  maxlength="30" required oninput="passwordCheck()">
         </div>
                    <span class="password_ok" style="color:green; display:none;">사용 가능한 비밀번호입니다.</span>
				   <span class="password_notok" style="color:red; display:none;"> 8글자 이상, 영문, 숫자, 특수문자를 사용해주세요.</span>

        <div class="input-group uf-input-group input-group-lg mb-1">
          <span class="input-group-text fa fa-lock"></span>
          <input type="hidden" name="passwordCheckYet" id="passwordCheckYet" value="0">
		  <input type ="password" class="form-control form-control-user" name="password" id="user-password2" placeholder="비밀번호 확인" required oninput="passwordReCheck()">
        </div>
            <span class="ok-ok" style="color:green; display:none;">비밀번호가 일치합니다.</span>
			<span class="ok-no" style="color:red; display:none;">비밀번호가 일치하지 않습니다.</span>

        <div class="input-group uf-input-group input-group-lg mb-3 mt-2">
          <span class="input-group-text fa fa-phone"></span>
          <input type="text"  class="form-control numOnly" name="tel" id="tel" placeholder="전화번호" size="20"  maxlength="11">
        </div>
        
        <div class="input-group uf-input-group input-group-lg mb-3">
          <label for="edu" class="form-label">학력</label>
                   <div class="col-auto">
                    <select id="education" name="education">
                        <!-- 검색 조건 옵션을 동적으로 생성 -->
                         <c:forEach items="${education}" var="vo">
					     	<option value="${vo.detCode}">${vo.detName}</option>
					     </c:forEach>
                    </select>
                	</div>
        </div>

        <div class="input-group uf-input-group input-group-lg mb-3">
          <label for="role" class="form-label">역할</label>
                   <div class="col-auto">
                    <select id="role" name="role">
                        <!-- 검색 조건 옵션을 동적으로 생성 -->
                         <c:forEach items="${role}" var="vo">
					                 <option value="${vo.detCode}">${vo.detName}</option>
					              </c:forEach>
                    </select>
                	</div>
        </div>
	     <!--// 회원 등록영역 ------------------------------------------------------>


        
        <div class="d-grid mb-4">
          <input type="button" class="btn uf-btn-primary btn-lg" id="doSave" value ="회원가입 "onclick="window.doSave();">
        </div>
        <div class="mt-4 text-center">
          <span class="text-white">이미 회원이신가요?</span>
          <a href="/ehr/login/loginView.do">로그인</a>
        </div>
      </form>
    </div>

    <!-- JavaScript -->
     <script>
     function strongPassword(str) {
         return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(str);
     }

     function passwordCheck() {
         var str = document.querySelector("#user-password").value; // 값을 가져와야 함
         if (strongPassword(str) === true) { // 문자열을 전달해야 함
             $('.password_ok').css("display", "inline-block");
             $('.password_notok').css("display", "none");
             console.log('----비밀번호 인정----')
            
         } else {
             $('.password_notok').css("display", "inline-block");
             $('.password_ok').css("display", "none");
         }
     }

     function passwordReCheck(){
         var str1 = document.querySelector("#user-password").value;
         var str2 = document.querySelector("#user-password2").value;

         if(str1 === str2){
             $('.ok-ok').css("display", "inline-block");
             $('.ok-no').css("display", "none");
            document.querySelector("#passwordCheckYet").value = 1;

         }else{
             $('.ok-no').css("display", "inline-block");
             $('.ok-ok').css("display", "none");
         }
     }
     </script>
    <script>
$(document).ready(function () {
    $('#mail-Check-Btn').click(function() {
        const email = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
        console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
        const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 

        let email1 = document.querySelector("#userEmail1").value;
        /* console.log("javascript ppl_input:"+document.querySelector(".ppl_input").value);    */
         
         if(eUtil.isEmpty(email1) == true){
            alert('이메일을 입력 하세요.');
            //$("#email").focus();//사용자 id에 포커스
            document.querySelector("#userEmail1").focus();
            return;
         }
        
        $.ajax({
            type : 'get',
            url : '/ehr/user/mailCheck.do?email='+email, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
            success : function (data) {
                console.log("data : " +  data);
                checkInput.attr('disabled',false);
                code =data;
                alert('인증번호가 전송되었습니다.')
            }           
        }); // end ajax
    }); // end send eamil

    // 인증번호 비교 
    // blur -> focus가 벗어나는 경우 발생
    $('.mail-check-input').blur(function () {
        const inputCode = $(this).val();
        const $resultMsg = $('#mail-check-warn');
        const name = $('#name');
        const tel = $('#tel');
        const password1 = $('#user-password');
        const password2 = $('#user-password2');
        const education = $('#education');
        const role = $('#role');
        
        
        if(inputCode == code){
            $resultMsg.html('인증번호가 일치합니다.');
            $resultMsg.css('color','green');
            $('#mail-Check-Btn').attr('disabled',true);
            $('#userEamil1').attr('readonly',true);
            $('#userEamil2').attr('readonly',true);
            $('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
            $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
            name.attr('disabled',false);
            password1.attr('disabled',false);
            password2.attr('disabled',false);
            tel.attr('disabled',false);
            education.attr('disabled',false);
            role.attr('disabled',false);
        }else{
            $resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
            $resultMsg.css('color','red');
        }
    });

    });
    
function idCheck(){
       console.log("-emailDuplicateCheck()-");  
       const email = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
          
    $.ajax({
        type: "GET",
        url: "/ehr/user/emailDuplicateCheck.do",
        asyn: "true",
        dataType: "json", /*return dataType: json으로 return */
        data: {
            email : email
        },
        success: function (data) {//통신 성공
            console.log("success data:" + data);
            if ("1" != data.msgId && email.length > 0) {
                $('.id_ok').css("display", "inline-block");
                $('.id_already').css("display", "none");
                document.querySelector("#idCheckYet").value = 1;

            } else if ("1" == data.msgId && email.length > 0) {
                $('.id_already').css("display", "inline-block");
                $('.id_ok').css("display", "none");
                document.querySelector("#idCheckYet").value = 0;

            } else if (email.length == 0){
                $('.id_ok').css("display", "none");
                $('.id_already').css("display", "none");
                document.querySelector("#idCheckYet").value = 0;

            }
        },
        error: function (data) {//실패시 처리
            console.log("error:" + data);
        },
        complete: function (data) {//성공/실패와 관계없이 수행!
            console.log("complete:" + data);
        }
    });

    
    
}

function doSave(){
    console.log("----------------------");
    console.log("-doSave()-");
    console.log("----------------------");
    
   let email1 = document.querySelector("#userEmail1").value;
   let email2 = document.querySelector("#userEmail2").value;
   let email = email1 + email2;
       
    //javascript
    console.log("javascript email:"+email);
    /* console.log("javascript ppl_input:"+document.querySelector(".ppl_input").value);    */
    
    if(eUtil.isEmpty(email) == true){
       alert('아이디를 입력 하세요.');
       //$("#email").focus();//사용자 id에 포커스
       document.querySelector("#userEmail1").focus();
       return;
    }
    
    if(eUtil.isEmpty(document.querySelector("#name").value) == true){
        alert('이름을 입력 하세요.');
        //$("#email").focus();//사용자 email에 포커스
        document.querySelector("#name").focus();
        return;
    }       
    
    
    if(eUtil.isEmpty(document.querySelector("#user-password").value) == true){
        alert('비밀번호를 입력 하세요.');
        //$("#email").focus();//사용자 email에 포커스
        document.querySelector("#user-password").focus();
        return;
    } 
    
    if(document.querySelector("#passwordCheckYet").value == 0){
        alert('비밀번호 확인값이 일치하지 않습니다.');
        //$("#email").focus();//사용자 email에 포커스
        document.querySelector("#user-password2").focus();
        return;
    } 
    
    if(eUtil.isEmpty(document.querySelector("#tel").value) == true){
        alert('전화번호을 입력 하세요.');
        //$("#email").focus();//사용자 email에 포커스
        document.querySelector("#tel").focus();
        return;
    }      
    
    if(eUtil.isEmpty(document.querySelector("#education").value) == true){
        alert('학력을 입력 하세요.');
        //$("#email").focus();//사용자 email에 포커스
        document.querySelector("#education").focus();
        return;
    }

    if(eUtil.isEmpty(document.querySelector("#role").value) == true){
        alert('역할을 입력 하세요.');
        //$("#email").focus();//사용자 email에 포커스
        document.querySelector("#role").focus();
        return;
    }      

    
    if(document.querySelector("#idCheckYet").value == '0'){
        alert('이메일 중복체크를 수행 하세요.');
        //$("#email").focus();//사용자 email에 포커스
        document.querySelector("#idCheckYet").focus();
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
           email:email,
           name: document.querySelector("#name").value,
           password: document.querySelector("#user-password").value,
           tel: document.querySelector("#tel").value,
           edu: document.querySelector("#education").value,
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

function moveToList(){
       console.log("----------------------");
       console.log("-moveToList()-");
       console.log("----------------------");
       
       window.location.href = "/ehr/login/loginView.do";
}




</script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<script>
     function strongPassword(str) {
         return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(str);
     }

     function passwordCheck() {
         var str = document.querySelector("#user-password").value; // 값을 가져와야 함
         if (strongPassword(str) === true) { // 문자열을 전달해야 함
             $('.password_ok').css("display", "inline-block");
             $('.password_notok').css("display", "none");
             console.log('----비밀번호 인정----')
            
         } else {
             $('.password_notok').css("display", "inline-block");
             $('.password_ok').css("display", "none");
         }
     }

     function passwordReCheck(){
         var str1 = document.querySelector("#user-password").value;
         var str2 = document.querySelector("#user-password2").value;

         if(str1 === str2){
             $('.ok-ok').css("display", "inline-block");
             $('.ok-no').css("display", "none");
            document.querySelector("#passwordCheckYet").value = 1;

         }else{
             $('.ok-no').css("display", "inline-block");
             $('.ok-ok').css("display", "none");
         }
     }
     </script>


    <!-- Separate Popper and Bootstrap JS -->
    <script src="${CP}/resources/template/login/assets/js/popper.min.js"></script>
    <script src="${CP}/resources/template/login/assets/js/bootstrap.min.js"></script>


  </body>
</html>