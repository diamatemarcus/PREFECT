<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="CP" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>게시판 등록</title> <!-- http://localhost:8080/ehr/board/moveToReg.do -->
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
<script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
<style>
  .ck-editor__editable { height: 400px; }
</style>
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
    
    
    let editorInstance; // CKEditor 인스턴스를 저장할 변수

    // CKEditor 로드 여부 확인
    if (typeof ClassicEditor === 'undefined') {
        console.error("CKEditor is not loaded.");
        return;
    }
    
    // CKEditor 인스턴스 초기화
    ClassicEditor
	    .create(document.querySelector('#editor'), {
	        //removePlugins: [ 'Italic' ],
	        language: 'ko',
	        ckfinder: {
	            uploadUrl: '/ajax/image.do'
	        }
	    })
	    .then(function (editor) {
	        editorInstance = editor;
	        console.log("CKEditor is initialized.");
	    })
	    .catch(function (error) {
	        console.error(error);
	    });


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

        // CKEditor에서 작성한 내용을 가져옵니다.
        let contents = editorInstance.getData();

        console.log("title:" + title);
        console.log("regId:" + regId);
        console.log("contents:" + contents);

        if (eUtil.isEmpty(title) === true) {
            alert("제목을 입력하세요.");
            regForm.title.focus();
            return;
        }

        if (eUtil.isEmpty(contents) === true) {
            alert("내용을 입력하세요.");
            //regForm.contents.focus();
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
        <input type="hidden" name="div" id="div" value="10">
     
        <div class="mb-3"> <!--  아래쪽으로  여백 -->
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" id="title" name="title" maxlength="100" placeholder="제목을 입력 하세요.">
        </div>
        <div class="mb-3">
            <label for="regId" class="form-label">ID</label>
            <input type="text" class="form-control" id="regId" name="regId" value="dlgkssk1627@naver.com" 
            readonly="readonly" >        
        </div>
    </form>
    
	<form action="" method="POST">
        <textarea name="text" id="editor"></textarea>
    <p><input type="button" value="등록" class="btn btn-primary" id="doSave"></p>
    </form>
    <!--// form --------------------------------------------------------------->
    
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
    
</div>
	
</body>
</html>