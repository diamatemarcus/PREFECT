<%@page import="com.pcwk.ehr.file.domain.FileVO"%>
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
/* 읽기 전용 필드의 배경색을 흰색으로 설정 */
.readonly-input[readonly] {
    background-color: #ffffff; /* 흰색 배경 */
    border: 1px solid #ced4da; /* 테두리 색상 추가 (부트스트랩 스타일과 유사하게) */
    color: gray; /* 텍스트 색상 설정 */
}
</style>
<script>
document.addEventListener("DOMContentLoaded",function(){
    
    const div = document.querySelector("#div").value;
    const seq = document.querySelector("#seq").value;
    const uuid = document.querySelector("#uuid").value;
    const modId = '${sessionScope.user.email}';
    
    console.log('uuid:' + uuid);
    
    const doUpdateBTN   = document.querySelector("#doUpdate");
    const doDeleteBTN   = document.querySelector("#doDelete");
    const moveToListBTN = document.querySelector("#moveToList");
    const upFileDeleteBTN = document.querySelector("#upFileDelete");
    const fileUploadBTN = document.querySelector("#fileUpload");
    
    // 파일 업로드
    fileUploadBTN.addEventListener("click",function(e){
        console.log("fileUploadBTN click");
        console.log('uuid:' + uuid);
        
        let formData = new FormData();
        formData.append('uuid', uuid);
        
        // 선택된 파일을 formData에 추가
        $('input[type="file"]').each(function() {
            let fileInput = $(this)[0];
            if(fileInput.files.length > 0) {
                for(let i = 0; i < fileInput.files.length; i++) {
                    formData.append('uploadFile', fileInput.files[i]);
                }
            }
        });
        
        // AJAX 요청으로 서버에 파일 업로드
        $.ajax({
            url: '${CP}/file/reUpload.do',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false, 
            success: function(data) {
                console.log('Upload success: ', data);
                alert('파일이 성공적으로 업로드되었습니다.');
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error('Upload failed: ', error);
                alert('파일 업로드 중 오류가 발생했습니다.');
            }
        });
        
    });
        
    // 파일 삭제 버튼 클릭 이벤트를 모든 삭제 버튼에 대해 추가
    document.querySelectorAll('.delete-file').forEach(function(button) {
        button.addEventListener('click', function(e) {
            const uuid = this.getAttribute('data-uuid');
            const seq = this.getAttribute('data-seq');
            
            console.log('upFileDeleteBTN click');
            console.log('uuid :'+uuid);
            console.log('seq :'+seq);
            
            if(confirm('해당 파일을 삭제하시겠습니까?')) {
                $.ajax({
                    url: '${CP}/file/doDelete.do',
                    type: 'GET',
                    data: {
                        "uuid": uuid,
                        "seq": seq
                    },
                    success: function(response) {
                        console.log('파일 삭제 성공');
                        alert('파일이 삭제되었습니다.');
                        
                        // 성공 시 페이지 새로고침 등의 추가 동작
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        console.log('파일 삭제 실패');
                        alert('파일 삭제 중 오류가 발생했습니다.');
                    }
                });
            }
        });
    });
    
    // 수정 이벤트 감지 및 처리
    doUpdateBTN.addEventListener("click", function(e){
        console.log('div:'+div)
        
        if(eUtil.isEmpty(seq) == true){
            alert('순번을 확인 하세요.');
            return;
        }
        
        const title = document.querySelector("#title").value;
        if(eUtil.isEmpty(title) == true){
            alert('제목을 입력 하세요.');
            title.focus();
            return;  
        }
        
        const contents = document.querySelector("#contents").value;
        if (eUtil.isEmpty(contents) == true) {
            alert('내용을 입력 하세요.');
            contents.focus();
            return;
        }
        
        if(confirm('수정 하시겠습니까?')==false){
            return;
        }
        
        $.ajax({
            type: "POST",
            url:"/ehr/board/doUpdate.do",
            asyn:"true", 
            dataType:"json",
            data:{
                "div"  : div,
                "seq"  : seq,
                "title": title,
                "modId": modId,
                "contents": contents
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
        window.location.href = "${CP}/board/doRetrieve.do?div="+div;
    }
    
});

</script>
</head>
<body>

<div class="container">

    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">${title}</h1>
        </div>
    </div>    
    <!--// 제목 ----------------------------------------------------------------->
    
    <!-- 
        seq : sequence별도 조회
        div : 10(공지사항)고정
        read_cnt : 0 
        title,contents : 화면에서 전달
        reg_id,mod_id  : session에서 처리
    -->
    <!-- form -->
    
    <form action="#" name="regFrm" id="regFrm">
        <!-- <input type="text" name="div" id="div"> -->
        <input type="hidden" name="uuid" id="uuid" value="${uuid}">
        
        <div class="mb-3 row" style="display:none;"> <!--  아래쪽으로  여백 -->
            <label for="seq" class="col-sm-2 col-form-label">구분</label>
            <div class="col-sm-10">
                <select class="form-select" aria-label="Default select example" id="div" name="div">
                  <c:forEach var="codeVO" items="${divCode}">
                     <option   value="<c:out value='${codeVO.detCode}'/>"  
                        <c:if test="${codeVO.detCode == vo.getDiv() }">selected</c:if>  
                     ><c:out value="${codeVO.detName}"/></option>
                  </c:forEach>
                </select>
            </div>  
        </div>
        
        <div class="mb-3 row" style="display:none;"> <!--  아래쪽으로  여백 -->
            <label for="seq" class="col-sm-2 col-form-label">순번</label>
            <div class="col-sm-10">
                <input type="text" class="form-control readonly-input" id="seq" name="seq" maxlength="100"
                 value="${vo.seq }"
                 readonly>
            </div>
        </div>

        <div class="mb-3 row" style="display:none;"> <!--  아래쪽으로  여백 -->
            <label for="readCnt" class="col-sm-2 col-form-label">조회수</label>
            <div class="col-sm-10">
                <input type="text" class="form-control readonly-input" id="readCnt" name="readCnt" maxlength="100"
                 value="${vo.readCnt }" readonly>
            </div>
        </div>

        <div class="mb-3 row">
            <label for="regId" class="col-sm-2 col-form-label">등록자</label>
            <div class="col-sm-10">
                <input type="text" class="form-control readonly-input" id="regId" name="regId"  readonly="readonly"
                 value=${vo.regId }>
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
        <div class="mb-3 row">
            <label for="regId" class="col-sm-2 col-form-label">수정일</label>
            <div class="col-sm-10">
                <input type="text" class="form-control readonly-input" id="modDt" name="modDt" 
                value="${vo.modDt }"  readonly="readonly"  >
            </div>        
        </div>
        <div class="mb-3"> <!--  아래쪽으로  여백 -->
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" maxlength="100" 
             value='${vo.title }' style="color:black;"
            placeholder="제목을 입력 하세요">
        </div>      
        <div class="mb-3">
            <label for="contents" class="form-label">내용</label>
            <textarea rows="7" class="form-control"  id="contents" name="contents" style="color:black;">${vo.contents } </textarea>
        </div>
        
        <div class="container">
            <form action="${CP}/file/reUpload.do" method="post" enctype="multipart/form-data" name="regForm">
                <div class="form-group">
                    <label for="file1">파일 첨부</label>
                    <input type="file" name="file1" id="file1" placeholder="파일을 선택 하세요."  multiple/>
                    <input type="button" value="파일 등록" class="button" id="fileUpload">
                </div>  
            </form>
        </div>
        
        <div class="container">
            <table id="fileList" class="table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>파일 이름</th>
                        <th style="display:none;">저장파일명</th>
                        <th>파일크기(MB)</th>
                        <th style="display:none;">확장자</th>
                        <th style="display:none;">저장경로</th>
                        <th style="display:none;">UUID</th>
                        <th style="display:none;">SEQ</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty fileList}">
                        <c:forEach var="file" items="${fileList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${file.orgFileName}</td>
                                <td style="display:none;">${file.saveFileName}</td>
                                <td>${file.fileSize}</td>
                                <td style="display:none;">${file.extension}</td>
                                <td style="display:none;">${file.savePath}</td>
                                <td style="display:none;">${file.uuid }</td>
                                <td style="display:none;">${file.seq }</td>
                                <td><button id="upFileDelete" class="btn btn-danger delete-file" data-uuid="${file.uuid}" data-seq="${file.seq}">삭제</button></td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty fileList}">
                        <tr>
                            <td colspan="6">첨부된 파일이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        
    </form> 
    <!--// form --------------------------------------------------------------->
    
    
    <!-- 버튼 -->
    <div class="row justify-content-end" style="margin-bottom: 20px;">
        <div class="col-auto">
            <input type="button" value="취소" class="button" id="moveToList">
            <input type="button" value="수정" class="button" id="doUpdate" >
            <input type="button" value="삭제" class="button" id="doDelete" >
        </div>
    </div>
    <!--// 버튼 ----------------------------------------------------------------->
    
    
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
</div>

</body>
</html>