<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${CP}/resources/css/user20231225.css">
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>게시판 등록</title> <!-- http://localhost:8080/ehr/board/moveToReg.do -->
<script>
document.addEventListener("DOMContentLoaded",function(){
    console.log("DOMContentLoaded");
    
    const regForm       = document.querySelector("#regFrm");
    const moveToListBTN = document.querySelector("#moveToList");
    const doSaveBTN     = window.document.querySelector("#doSave");
    
    function moveToListFun(){
        window.location.href = "/ehr/board/doRetrieve.do";
    }
    
    //event감지 및 처리
    moveToListBTN.addEventListener("click",function(e){
        console.log("moveToListBTN click");
        moveToListFun();
    }); //-- moveToListBTN
    
    function moveToListFun() {
        window.location.href = "/ehr/board/doRetrieve.do";
    }

    // event 감지 및 처리
    moveToListBTN.addEventListener("click", function (e) {
        console.log("moveToListBTN click");
        moveToListFun();
    });

    // doSave event 감지 및 처리
    doSaveBTN.addEventListener("click", function (e) {
        console.log("doSaveBTN click");

        let div = document.querySelector("#div").value;
        let title = document.querySelector("#title").value;
        let regId = document.querySelector("#regId").value;
        let contents = document.querySelector("#contents").value;
        let uuid = document.querySelector("#uuid").value;

        console.log("title:" + title);
        console.log("regId:" + regId);
        console.log("contents:" + contents);
        
        if(eUtil.isEmpty(regId) == true){
            alert("로그인 하세요.")
            regId.focus();
            return;
        }

        if (eUtil.isEmpty(title) === true) {
            alert("제목을 입력하세요.");
            regForm.title.focus();
            return;
        }

        if (eUtil.isEmpty(contents) === true) {
            alert("내용을 입력하세요.");
            regForm.contents.focus();
            return;
        }

        if (window.confirm("등록하시겠습니까?") === false) {
            return;
        }

        $.ajax({
            type: "POST",
            url: "/ehr/board/doSave.do",
            async: true,
            dataType: "json",
            data: {
                "div": div,
                "title": title,
                "contents": contents,
                "readCnt": 0,
                "regId": regId
            },
            success: function (data) {// 통신 성공 시의 처리
                console.log("data.msgId:" + data.msgId);
                console.log("data.msgContents:" + data.msgContents);

                if ('1' == data.msgId) {
                    alert(data.msgContents);
                    moveToListFun();
                } else {
                    alert(data.msgContents);
                }
            },
            error: function (data) {// 통신 실패 시의 처리
                console.log("error:" + data);
            },
            complete: function (data) {// 성공/실패와 관계없이 수행되는 처리
                console.log("complete:" + data);
            }
        });
    });
    
    
    /* 파일 등록 */
    //fileUpload
    $("#fileUpload").on("click",function(e){
        console.log('fileUpload click');
        
        let formData = new FormData();
        formData.append("uuid", uuid); // 게시글 작성 시 생성한 UUID
        // 파일 데이터 추가
        $("input[type='file']").each(function() {
            let files = $(this)[0].files;
            for (let i = 0; i < files.length; i++) {
                formData.append("uploadFile", files[i]);
            }
        });

        $.ajax({
            type: "POST",
            url:"${CP}/file/fileUploadAjax.do",
            data: formData,
            processData: false,
            contentType: false,
            success:function(data){//통신 성공
               console.log("success data:"+data);
               let target = $('#tableTbody');
               
               let listData = "";
               
               $.each(data,function( index, value ){
                   //console.log("vo.orgFileName:"+value.orgFileName);
                   console.log("index:"+index);
                   listData += "<tr>"; 
                   listData +="<td>"+(index+1)+"</td>";
                   listData +="<td>"+(value.orgFileName)+"</td>";
                   listData +="<td>"+(value.saveFileName)+"</td>";
                   listData +="<td>"+(value.fileSize)+"</td>";
                   listData +="<td>"+(value.extension)+"</td>";
                   listData +="<td>"+(value.savePath)+"</td>";
                   listData += "</tr>";
               });
               
               //tbody 내용 삭제
               $("#tableTbody").empty();
               console.log("listData:"+listData);
               //tbody에 내용 추가
               target.append(listData);
            },
            error:function(data){//실패시 처리
               console.log("error:"+data);
            },
            complete:function(data){//성공/실패와 관계없이 수행!
               console.log("complete:"+data);
            }           
        });//-- $.ajax
        
    });
    
}); //--DOMContentLoaded
</script>
</head>
<body>

<div class="container">
    
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Board Register</h1>
        </div>
    </div>    
    <!--// 제목 ----------------------------------------------------------------->
    
    <!-- 버튼 -->    
    <div class="row justify-content-end">
        <div class="col-auto">
            <input type="button" value="목록" class="btn btn-primary" id="moveToList">
            <input type="button" value="등록" class="btn btn-primary" id="doSave">
        </div>
    </div>
    <!--// 버튼 ----------------------------------------------------------------->
    
     <!-- 
	    seq : sequence별도 조회
	    div : 10(공지사항)고정
	    read_cnt : 0
	    title, contents : 화면에서 전달
	    reg_id, mod_id  : session에서 처리
     -->
    <!-- form -->
    <form action="#" name="regFrm" id="regFrm">
<!--         <div class="mb-3">
            <label for="title" class="form-label">구분</label>
            <select class="form-select" aria-label="Default select example" id="div" name="div">
              <c:forEach var="codeVO" items="${divCode}">
                 <option   value="<c:out value='${codeVO.detCode}'/>"  
                    <c:if test="${codeVO.detCode == paramVO.getDiv() }">selected</c:if>  
                 ><c:out value="${codeVO.detName}"/></option>
              </c:forEach>
              
            </select>            
        </div> -->
    
        <input type="hidden" name="div" id="div" value="10">
        <input type="hidden" name="uuid" id="uuid">
     
        <div class="mb-3"> <!--  아래쪽으로  여백 -->
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" maxlength="100" placeholder="제목을 입력 하세요.">
        </div>
        <div class="mb-3">
            <label for="regId" class="form-label">ID</label>
            <input type="text" class="form-control" id="regId" name="regId" value="dlgkssk1627@naver.com" 
            readonly="readonly" >        
        </div>
        <div class="mb-3">
            <label for="title" class="form-label">내용</label>
            <textarea rows="7" class="form-control"  id="contents" name="contents"></textarea>
        </div>
    </form>
    <!--// form --------------------------------------------------------------->
    
    <!-- 파일 업로드 -->
    <div class="container">
		<form action="${CP}/file/fileUpload.do" method="post" enctype="multipart/form-data" name="regForm">
		    <div class="form-group">
		        <label for="file1">파일1</label>
		        <input type="file" name="file1" id="file1" placeholder="파일을 선택 하세요."  multiple/>
		        <input type="button" value="파일 등록" class="button" id="fileUpload">
		    </div>  
		</form>
	</div>
	
	<div class="container">
       <table id="fileList">
           <thead>
               <tr>
                   <th>번호</th>
                   <th>원본파일명</th>
                   <th>저장파일명</th>
                   <th>파일크기</th>              
                   <th>확장자</th>       
                   <th>저장경로</th>                               
               </tr>
           </thead>
           <tbody id="tableTbody">
               <c:choose>
                   <c:when test="${list.size()>0 }">
                      <c:forEach var="vo" items="${list}"  varStatus="status">
                      <!-- 순번출력: status 
                      items: collection
                      var: collection데이터 추출
                      varStatus:status
                       index: 현재 반복순서(0번부터 시작)
                       first: 첫 번째 반복인 경여 true
                       last: 마지막 반복인 경우 true
                       being: 반복의 시작인덱스
                       end: 반복의 끝 인덱스
                      -->
                       <tr>
                           <td>${ status.index+1 }</td>
                           <td>${ vo.orgFileName}</td>
                           <td>${ vo.saveFileName}</td>
                           <td>${ vo.fileSize}</td>
                           <td>${ vo.extension}</td>
                           <td>${ vo.savePath}</td>
                       </tr>
                      </c:forEach>
                   </c:when>
                   <c:otherwise>
                       <tr>
                           <td colspan="99">no data found</td>
                       </tr>
                   </c:otherwise>
               </c:choose>
           </tbody>
       </table>
    </div>
    <!-- 파일 업로드 ------------------------------------------------------------->
    
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
    
</div>
	
</body>
</html>