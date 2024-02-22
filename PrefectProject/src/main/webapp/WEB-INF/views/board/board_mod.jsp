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
                // 추가적으로 페이지를 새로고침하거나 업로드된 파일 목록을 갱신하는 로직을 추가할 수 있음
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
<!-- Navbar start -->
    <div class="container-fluid fixed-top">
        <div class="container px-0">
            <nav class="navbar navbar-light bg-white navbar-expand-xl">
                <a href="index.jsp" class="navbar-brand">
                    <h1 class="text-warning display-6" style="color: #ffb526;font-family: 'Raleway', sans-serif; font-weight: bold;padding-top: 8px;">A R M S</h1>
                </a>
                <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-warning"></span>
                </button>
                <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                    <div class="navbar-nav mx-auto" style=" padding-top: 8px;">
                        <a href="index.jsp" class="nav-item nav-link active">게시판</a>
                        <a href="/board/doRetrieve.do?div=10" class="nav-item nav-link">공지사항</a>
                        <a href="#" class="nav-item nav-link">일정표</a>
                        <a href="/dm/doContentsList.do'" class="nav-item nav-link">메시지</a>
                        <a href="/book/bookApiView.do" class="nav-item nav-link">도서구매</a>
                        <a href="/user/doSelectOne.do" class="nav-item nav-link">마이페이지</a>
                        <a href="/user/doSelectOne.do" class="nav-item nav-link">회원 목록</a> <!-- 관리자에게만 보이게 할 예정-->
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button class="button me-md-2" type="button" onclick="location.href='/login/loginView.do'" style="color:white;background-color: FFA500; font-size: 16px; ">로그인</button>
                        <button class="button" type="button" onclick="location.href='/ehr/user/moveToReg.do'" style="color:white;background-color: FFA500; font-size: 16px">회원가입</button>
                    </div>
                    <div class="d-flex m-3 me-0">
                        <button
                            class="btn-search btn border border-warning btn-md-square rounded-circle bg-white me-4" 
                            data-bs-toggle="modal" data-bs-target="#searchModal">
                            <i class="fas fa-search text-warning" ></i></button>
                        <a href="#" class="my-auto">
                            <i class="fas fa-user fa-2x" style="color: #ffb526;"></i>
                        </a>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->
<div class="container">

    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">${title}</h1>
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
        <!-- <input type="text" name="div" id="div"> -->
        <input type="text" name="uuid" id="uuid" value="${uuid}">
        
        <div class="mb-3 row"> <!--  아래쪽으로  여백 -->
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
        <div class="mb-3"> <!--  아래쪽으로  여백 -->
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="title" maxlength="100" 
             value='${vo.title }'
            placeholder="제목을 입력 하세요">
        </div>      
        <div class="mb-3">
            <label for="contents" class="form-label">내용</label>
            <textarea rows="7" class="form-control"  id="contents" name="contents">${vo.contents }</textarea>
        </div>
        
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
            <table id="fileList" class="table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>원본파일명</th>
                        <th>저장파일명</th>
                        <th>파일크기</th>
                        <th>확장자</th>
                        <th>저장경로</th>
                        <th>UUID</th>
                        <th>SEQ</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty fileList}">
                        <c:forEach var="file" items="${fileList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${file.orgFileName}</td>
                                <td>${file.saveFileName}</td>
                                <td>${file.fileSize}</td>
                                <td>${file.extension}</td>
                                <td>${file.savePath}</td>
                                <td>${file.uuid }</td>
                                <td>${file.seq }</td>
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
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
</div>

</body>
</html>