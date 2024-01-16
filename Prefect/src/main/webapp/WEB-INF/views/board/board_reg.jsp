<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />     
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>게시판 등록</title>
<script>
document.addEventListener("DOMContentLoaded",function(){
	console.log("DOMContentLoaded");
	

	//const moveToListBTN = document.getElementById("moveToList");
	const moveToListBTN = document.querySelector("#moveToList");    
	const doSaveBTN     = window.document.querySelector("#doSave");
	const regForm       = document.querySelector("#regFrm");
	
	//doSave event감지 및 처리
	doSaveBTN.addEventListener("click", function(e){
		console.log("doSaveBTN click");
		
		let title = document.querySelector("#title");
		console.log("title:"+title.value);
		if(eUtil.isEmpty(title.value) == true){
			alert("제목을 입력 하세요.")
			regForm.title.focus();
			return;
		}
		
		
		let regId = document.querySelector("#regId");  
		console.log("regId:"+regId.value);
		if(eUtil.isEmpty(regId.value) == true){
            alert("로그인 하세요.")
            regId.focus();
            return;
        }		
		
		let contents = document.querySelector("#contents");
		console.log("contents:"+contents.value);
		if(eUtil.isEmpty(contents.value) == true){
            alert("내용을 하세요.")
            contents.focus();
            return;
        }   		
		
		
		if(window.confirm("등록 하시겠습니까?")==false){
			return;
		}
		
        $.ajax({
            type: "POST",
            url:"/ehr/board/doSave.do",
            asyn:"true",
            dataType:"json",
            data:{
            	"div": document.querySelector("#div").value,
                "title": title.value,
                "contents": contents.value,
                "regId": regId.value,
                "modId": regId.value,
                "readCnt": 0  
            },
            success:function(data){//통신 성공
            	//data.msgId가 1이면 : 메시지 출력,목록으로 이동
            	//data.msgId가 1이 아니면 : 메시지 출력
                console.log("data.msgId:"+data.msgId);
                console.log("data.msgContents:"+data.msgContents);
                
                if('1'==data.msgId){
                	alert(data.msgContents);//메시지 출력
                	moveToListFun();
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
		
	});
	
	
	function moveToListFun(){
		window.location.href = "/ehr/board/doRetrieve.do";
	}
	
	//event감지 및 처리
	moveToListBTN.addEventListener("click",function(e){
		console.log("moveToListBTN click");
		moveToListFun();
		
	});
});//--DOMContentLoaded

</script>
</head>
<body>
<div class="container">
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">게시등록</h1>
        </div>
    </div>    
    <!--// 제목 ----------------------------------------------------------------->
    
    <!-- 버튼 -->
    <div class="row justify-content-end">
        <div class="col-auto">
            <input type="button" value="목록" class="btn btn-primary" id="moveToList">
            <input type="button" value="등록" class="btn btn-primary" id="doSave" >
        </div>
    </div>
    <!--// 버튼 ----------------------------------------------------------------->
    <!-- 
    seq : sequence별도 조회
    div : 10(공지사항)고정
    read_cnt : 0
    title,contents : 화면에서 전달
    reg_id,mod_id  : session에서 처리
     -->
    <!-- form -->
    <form action="#" name="regFrm" id="regFrm">
        <input type="hidden" name="div" id="div" value="10">
        
        <div class="mb-3"> <!--  아래쪽으로  여백 -->
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" maxlength="100" placeholder="제목을 입력 하세요">
        </div>
        <div class="mb-3">
            <label for="regId" class="form-label">등록자</label>
            <input type="text" class="form-control" id="regId" name="regId" value="${sessionScope.user.userId}" 
            readonly="readonly" >        
        </div>
        <div class="mb-3">
            <label for="title" class="form-label">내용</label>
            <textarea rows="7" class="form-control"  id="contents" name="contents"></textarea>
        </div>
    </form>
    <!--// form --------------------------------------------------------------->
    
    
    
     <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>   
</div>

</body>
</html>