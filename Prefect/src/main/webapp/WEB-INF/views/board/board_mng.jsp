<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />     
<!DOCTYPE html>
<html>
<head> 
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>게시판 수정</title>
<style>
   .readonly-input {
    background-color: #e9ecef ;
   }

</style>
<script>
document.addEventListener("DOMContentLoaded",function(){ 
    
    //목록버튼
    const moveToListBTN = document.querySelector("#moveToList");
    //삭제버튼
    const doDeleteBTN   = document.querySelector("#doDelete");
    //수정버튼
    const doUpdateBTN   = document.querySelector("#doUpdate");

    //수정 이벤트 감지 및 처리
    doUpdateBTN.addEventListener("click", function(e){
  
        const div = document.querySelector("#div").value;
        const seq = document.querySelector("#seq").value;

        if(eUtil.isEmpty(seq) == true){
            alert('순번을 확인 하세요.');
            return;
        }
  
        const title = document.querySelector("#title");
        if(eUtil.isEmpty(title.value) == true){
            alert('제목을 입력 하세요.');
            title.focus();
            return;  
        }        
  
        const contents = document.querySelector("#contents");
        if(eUtil.isEmpty(contents.value) == true){
            alert('내용을 입력 하세요.');
            contents.focus();
            return;
        }               

        if(confirm('수정 하시겠습니까?')==false){
            return;
        }
     
        const modId = '${sessionScope.user.userId}';
        
      	$.ajax({
    		type: "POST",
    		url:"/ehr/board/doUpdate.do",
    		asyn:"true", 
    		dataType:"json",
    		data:{
                "div"  : div,
                "seq"  : seq,
    			"title": title.value,
                "modId": modId,  
    			"contents": contents.value
    		},
    		success:function(data){//통신 성공
                console.log("success data.msgId:"+data.msgId);
                console.log("success data.msgContents:"+data.msgContents);
                
                if(1==data.msgId){
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




    });

    //삭제 이벤트 감지 및 처리
    doDeleteBTN.addEventListener("click",function(e){
        console.log('doDeleteBTN click');
        
        const seq = document.querySelector("#seq").value;
        console.log('seq :'+seq);
        
        if(eUtil.isEmpty(seq) == true){
            alert('순번을 확인 하세요.');
            return;
        }

        if(window.confirm('삭제 하시겠습니까?')==false){
            return;
        }


       	$.ajax({
    		type: "GET",
    		url:"/ehr/board/doDelete.do",
    		asyn:"true",
    		dataType:"json",
    		data:{
    			"seq": seq
    		},
    		success:function(data){//통신 성공
        		console.log("success data.msgId:"+data.msgId);
        		console.log("success data.msgContents:"+data.msgContents);
                if("1" == data.msgId){
                   alert(data.msgContents);
                   moveToList();     
                }else{
                    alert(data.msgContents);
                }
        	},
        	error:function(data){//실패시 처리
        		console.log("error:"+data);
        	}
    	});

   

    });      

    //목록 이벤트 감지 및 처리
    moveToListBTN.addEventListener("click",function(e){
        console.log('moveToListBTN click');
        if(confirm('목록 화면으로 이동 하시겠습니까?')==false){
            return;
        }           
        moveToList();
    
        
    })
    
    function moveToList(){
    	window.location.href = "${CP}/board/doRetrieve.do";
    }
    

});//--DOMContentLoaded
</script>
</head>
<body>
<div class="container">
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">게시수정</h1>
        </div>
    </div>    
    <!--// 제목 ----------------------------------------------------------------->
    
    <!-- 버튼 -->
    <div class="row justify-content-end">
        <div class="col-auto">
            <input type="button" value="목록" class="btn btn-primary" id="moveToList">
            <input type="button" value="수정" class="btn btn-primary" id="doUpdate" >
            <input type="button" value="삭제" class="btn btn-primary" id="doDelete" >
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
        <div class="mb-3 row"> <!--  아래쪽으로  여백 -->
	        <label for="seq" class="col-sm-2 col-form-label">구분</label>
	        <div class="col-sm-10">
		        <select class="form-select" aria-label="Default select example" id="div" name="div" disabled="disabled">
		          <c:forEach var="codeVO" items="${divCode}">
		             <option   value="<c:out value='${codeVO.detCode}'/>"  
		                <c:if test="${codeVO.detCode == vo.getDiv() }">selected</c:if>  
		             ><c:out value="${codeVO.detName}"/></option>
		          </c:forEach>
		          
				</select>
			</div>  
        </div>
        
        <div class="mb-3 row"> <!--  아래쪽으로  여백 -->
            <label for="seq" class="col-sm-2 col-form-label">순번</label>
            <div class="col-sm-10">
                <input type="text" class="form-control readonly-input" id="seq" name="seq" maxlength="100"
                 value="${vo.seq }"
                 readonly>
            </div>
        </div>

        <div class="mb-3 row"> <!--  아래쪽으로  여백 -->
            <label for="readCnt" class="col-sm-2 col-form-label">조회수</label>
            <div class="col-sm-10">
                <input type="text" class="form-control readonly-input" id="readCnt" name="readCnt" maxlength="100"
                 value="${vo.readCnt }" 
                placeholder="조회수를 입력 하세요">
            </div>
        </div>

        <div class="mb-3 row">
            <label for="regId" class="col-sm-2 col-form-label">등록자</label>
            <div class="col-sm-10">
                <input type="text" class="form-control readonly-input" id="regId" name="regId"  readonly="readonly"
                 value=${vo.regId }
                 >
            </div>        
        </div>
        <div class="mb-3 row">
            <label for="regId" class="col-sm-2 col-form-label">등록일</label>
            <div class="col-sm-10">
                <input type="text" class="form-control readonly-input" id="regDt" name="regDt" 
                value="${vo.regDt }"  readonly="readonly" >
            </div>        
        </div>        
        <div class="mb-3 row">
            <label for="regId" class="col-sm-2 col-form-label">수정자</label>
            <div class="col-sm-10">
                <input type="text" class="form-control readonly-input" id="modId" name="modId" 
                value="${vo.modId }"  readonly="readonly"  >
            </div>        
        </div>
        <div class="mb-3"> <!--  아래쪽으로  여백 -->
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" maxlength="100" 
             value=${vo.title }
            placeholder="제목을 입력 하세요">
        </div>      
        <div class="mb-3">
            <label for="contents" class="form-label">내용</label>
            <textarea rows="7" class="form-control"  id="contents" name="contents">${vo.contents }</textarea>
        </div>
    </form> 
    <!--// form --------------------------------------------------------------->
    
    
    
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>       
</div>

</body>
</html>