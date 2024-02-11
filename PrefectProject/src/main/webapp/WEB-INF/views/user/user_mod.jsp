<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />     
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>마이페이지</title>
<script>
function doDelete(){
    console.log("----------------------");
    console.log("-doDelete()-");
    console.log("----------------------");   
    
    let email = document.querySelector("#email").value;
    console.log("-email:"+email);
    
    if(eUtil.isEmpty(email) == true){
        alert('아이디를 입력 하세요.');
        document.querySelector("#email").focus();
        return;
    }
    
    if(window.confirm('삭제 하시겠습니까?')==false){
        return;
    }
    console.log("-confirm:");
    $.ajax({
        type: "GET",
        url:"/ehr/user/doDelete.do",
        asyn:"true",
        dataType:"json", /*return dataType: json으로 return */
        data:{
            "email": email
        },
        success:function(data){//통신 성공
            console.log("success data:"+data);
            //let parsedJSON = JSON.parse(data);
            if("1" === data.msgId){
                alert(data.msgContents);
                moveToList();
            }else{
                alert(data.msgContents);
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
    
    //confirm
    if(confirm("수정 하시겠습니까?")==false)return;
    
    $.ajax({
        type: "POST",
        url:"/ehr/user/doUpdate.do",
        asyn:"true",
        dataType:"html",
        data:{
         email:document.querySelector("#email").value,
            name: document.querySelector("#name").value,
            password: document.querySelector("#password").value,
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
</script>
</head>
<body>
<%--   <jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
  <jsp:include page="/WEB-INF/cmn/nav.jsp"></jsp:include> --%>
     <div class="container">
         <!-- 제목 -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">마이페이지</h1>
            </div>
        </div>    
        <!--// 제목 ----------------------------------------------------------------->
        <!-- 버튼 -->
        <div class="row justify-content-end">
            <div class="col-auto">
           <input type="button" class="btn btn-primary" value="수정" id="doUpdate"      onclick="window.doUpdate();">
           <input type="button" class="btn btn-primary" value="삭제" id="doDelete"      onclick="window.doDelete();">
           <input type="button" class="btn btn-primary" value="목록" id="moveToList"    onclick="window.moveToList();">
            </div>
        </div>
        <!--// 버튼 ----------------------------------------------------------------->
         
         <!-- 회원 등록영역 -->  
         <div>
           <form action="#" name="userRegFrm">
               <div class="mb-3">
                   <label for="email" class="form-label">이메일</label>
                   <input type="text"  class="form-control ppl_input" readonly="readonly" name="email" id="email"
                    value="${outVO.email }"
                    size="20"  maxlength="30">
               </div>
               <div class="mb-3"> <!--  아래쪽으로  여백 -->
                   <label for="name" class="form-label">이름</label>
                   <input type="text"  class="form-control"  name="name" id="name" placeholder="이름을 입력 하세요." size="20"  
                   value="${outVO.name }"
                   maxlength="21">
               </div>   
                <div class="mb-3">
                   <label for="password" class="form-label">비밀번호</label>
                   <input type="password"  class="form-control"  name="password" id="password" placeholder="비밀번호를 입력 하세요." 
                   value="${outVO.password }"
                   size="20"  maxlength="30">
               </div>                    
               <div class="mb-3">
                   <label for="tel" class="form-label">전화번호</label>
                   <input type="text"  class="form-control" name="tel" id="tel" placeholder="전화번호 수정" 
                   value="${outVO.tel }"
                   size="20"  maxlength="11">
               </div>    
               <div class="mb-3">

                   <label for="edu" class="form-label">학력</label>
                   <div class="col-auto">
                    <select id="education" name="education">
                        <!-- 검색 조건 옵션을 동적으로 생성 -->
                         <c:forEach items="${education}" var="vo">
                            <option value="<c:out value='${vo.detCode}'/>"  <c:if test="${vo.detCode == outVO.edu }">selected</c:if>  ><c:out value="${vo.detName}"/></option>
                        </c:forEach>
                    </select>
                    </div>
               </div>
               <div class="mb-3">
                <label for="role" class="form-label">역할</label>
                   <div class="col-auto">
                    <select id="role" name="role">
                        <!-- 검색 조건 옵션을 동적으로 생성 -->
                         <c:forEach items="${role}" var="vo">
                            <option value="<c:out value='${vo.detCode}'/>"  <c:if test="${vo.detCode == outVO.role }">selected</c:if>  ><c:out value="${vo.detName}"/></option>
                        </c:forEach>
                    </select>
                    </div>
            </div>
                                                        
           </form>
         </div>
         <!--// 회원 등록영역 ------------------------------------------------------>
         <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
     </div>
     
</body>
</html>