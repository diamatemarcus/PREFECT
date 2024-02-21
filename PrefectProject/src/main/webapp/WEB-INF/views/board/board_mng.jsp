<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />     
<!DOCTYPE html>
<html>
<head> 
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<meta charset="utf-8">
<title>게시판 상세 조회</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
 <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
<style>
   .readonly-input {
    background-color: #e9ecef ;
   }
    .button {
            width: auto;
            /* 버튼의 크기를 내용에 맞게 자동으로 조절합니다. */
            /* 다른 스타일을 원하는 대로 추가할 수 있습니다. */
            padding: 10px 20px;
            /* 내용과 버튼의 테두리 간격을 조정합니다. */
            border: none;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 8px;
            background-color: #FFA500
}
</style>
<script>
document.addEventListener("DOMContentLoaded",function(){
	
	//댓글 조회 
    //replyRetrieve();
	 
	console.log('ready');
	const div = document.querySelector("#div").value;
    const seq = document.querySelector("#seq").value;
    const modId = '${sessionScope.user.email}';
    const regId = document.querySelector("#regId").value;
    
    const moveToModBTN   = document.querySelector("#moveToMod");
    const doDeleteBTN   = document.querySelector("#doDelete");
    const moveToListBTN = document.querySelector("#moveToList");
    
    //댓글 등록버튼 : replyDoSave
    const replyDoSaveBTN = document.querySelector("#replyDoSave");
    //수정버튼
    const doUpdateBTN   = document.querySelector("#doUpdate");
    
    replyDoSaveBTN.addEventListener("click",function(e){
        console.log('replyDoSaveBTN click');
        //board_seq,reply,reg_id
        
        const boardSeq = document.querySelector('#seq').value;
        if(eUtil.isEmpty(boardSeq) == true){
            alert('게시글 순번을 확인 하세요.');
            return;
        }
        console.log('boardSeq:'+boardSeq);
        
        
        const replyContents = document.querySelector('#replyContents').value;
        if(eUtil.isEmpty(replyContents) == true){
            alert('댓글을 확인 하세요.');
            document.querySelector('#replyContents').focus();
            return;
        }
        console.log('replyContents:'+replyContents);
        
        
        $.ajax({
            type: "POST",
            url:"/ehr/reply/doSave.do",
            asyn:"true",
            dataType:"json",
            data:{
                "boardSeq": boardSeq,
                "reply": replyContents
            },
            success:function(data){//통신 성공
                console.log("success msgId:"+data.msgId);
                console.log("success msgContents:"+data.msgContents);
                
                if("1"==data.msgId){
                    alert(data.msgContents);
                    replyRetrieve();//댓글 조회
                   
                    //등록 댓글 초기화
                    document.querySelector('#replyContents').value = '';
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
    
    // file download
	$('#fileList tbody').on("dblclick", 'tr', function() {
		console.log('fileList dbclick');
	    const orgFileName = $(this).data('org-file-name');
	    const saveFileName = $(this).data('save-file-name');
	    const savePath = $(this).data('save-path');
	    
	    // 파일 다운로드 로직
	    const form = document.fileDownloadForm;
	    form.orgFileName.value = orgFileName;
	    form.saveFileName.value = saveFileName;
	    form.savePath.value = savePath;
	    form.submit();
	});
   
    
    // 수정 이벤트 감지 및 처리
    moveToModBTN.addEventListener("click", function(e){
    	if(modId == regId){
            // 수정 페이지로 이동
            window.location.href = "/ehr/board/moveToMod.do?seq="+seq+"&div="+div;
        } else {
            // 일치하지 않는 경우, 경고 메시지 출력
            alert('수정 권한이 없습니다.');
        }
    });
    
    //삭제 이벤트 감지 및 처리
    doDeleteBTN.addEventListener("click",function(e){
    	const div = document.querySelector("#div").value;
        const seq = document.querySelector("#seq").value;
        const modId = '${sessionScope.user.email}';
        const regId = document.querySelector("#regId").value;
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
    
//------Reply---------------------------------------------------------------
    
    function replyRetrieve(){
        const boardSeq = document.querySelector("#seq").value
        //const div = document.querySelector("#div").value
        console.log('boardSeq:'+boardSeq)
        //window.location.href = "${CP}/board/doSelectOne.do?seq="+boardSeq+"&div="+div
        if(eUtil.isEmpty(boardSeq) == true){
            alert('게시글 번호를 확인 하세요.');
            return;
        }
        
        $.ajax({
            type: "GET",
            url:"/ehr/reply/doRetrieve.do",
            asyn:"true",
            dataType:"json", //return type
            data:{
                "boardSeq": boardSeq  
            },
            success:function(data){//통신 성공
                console.log("success data:"+data);
                console.log("data.length:"+data.length);
                
                let replyDiv = '';
                
                //기존 댓글 모두 삭제
                //#요소의 내용을 모두 지웁니다.
                //$("#replyDoSaveArea").html('');
                document.getElementById("replyDoSaveArea").innerHTML = "";
                
                
                if(0==data.length){
                    console.log("댓글이 없어요1");
                    return;
                }
                    
                
                for(let i=0;i<data.length;i++){
                    replyDiv += '<div class="dynamicReply"> \n';
                    replyDiv += '<div class="row justify-content-end"> \n';
                    replyDiv += '<div class="col-auto"> \n';
                    replyDiv += '<span>등록일:'+data[i].modDt+'</span> \n';
                    replyDiv += '\t\t\t <input type="button" value="댓글수정" class="btn btn-primary replyDoUpdate"  >   \n';
                    replyDiv += '\t\t\t <input type="button" value="댓글삭제" class="btn btn-primary replyDoDelete"  >   \n';
                    replyDiv += '</div> \n';
                    replyDiv += '</div> \n';
                    
                    replyDiv += '<div class="mb-3">  \n';
                    replyDiv += '<input type="hidden" name="replySeq" value="'+data[i].replySeq +'"> \n';
                    
                    replyDiv += '<textarea rows="3" class="form-control dyReplyContents"   name="dyReplyContents">'+data[i].reply+'</textarea> \n';
                    replyDiv += '</div> \n';
                    
                    replyDiv += '</div> \n';
                    
                }
                
                //console.log(replyDiv);
                
                //조회 댓글 출력
                document.getElementById("replyDoSaveArea").innerHTML = replyDiv;
                //$("#replyDoSaveArea").html(replyDiv);
                
                
                //-댓글:삭제,수정-------------------------------------------------------------
                //댓글 수정
/*                 $(".replyDoUpdate").on("click", function(e){
                    console.log('replyDoUpdate click');
                }); */

                //javascript
                replyDoUpdateBTNS = document.querySelectorAll(".replyDoUpdate");
                replyDoUpdateBTNS.forEach(function(e){
                    e.addEventListener("click",function(e){
                        console.log('replyDoUpdate click');
                        
                        //reply,reply_seq
                        const replySeq =this.closest('.dynamicReply').querySelector('input[name="replySeq"]')
                        console.log('replySeq:'+replySeq.value);
                        if(eUtil.isEmpty(replySeq.value)==true){
                            alert('댓글 순번을 확인하세요.');
                            return;
                        }
                        
                        const reply =this.closest('.dynamicReply').querySelector('textarea[name="dyReplyContents"]')
                        if(eUtil.isEmpty(reply.value)==true){
                            alert('댓글을 확인하세요.');
                            reply.focus();
                            return;
                        }
                        
                        console.log('reply:'+reply.value);
                        
                        if(window.confirm('수정 하시겠습니까?')==false){
                            return ;
                        }
                        
                        $.ajax({
                            type: "POST",
                            url:"/ehr/reply/doUpdate.do",
                            asyn:"true",
                            dataType:"json",
                            data:{
                                "replySeq": replySeq.value,
                                "reply":reply.value
                            },
                            success:function(data){//통신 성공
                                console.log("success data:"+data.msgId);
                                console.log("success data:"+data.msgContents);
                                
                                if("1" == data.msgId){
                                    alert(data.msgContents);
                                    replyRetrieve();
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
                    
                });//-----replyDoUpdateBTNS-------------------------------------
                
                //댓글삭제
                $(".replyDoDelete").on("click", function(e){
                    console.log('replyDoDelete click');
                    
                    const replySeq = $(this).closest('.dynamicReply').find('input[name="replySeq"]').val();
                    console.log('replySeq:'+replySeq);
                    
                    if(window.confirm("삭제 하시겠습니까?")==false){
                        return;
                    }
                    
                    $.ajax({
                        type: "GET",
                        url:"/ehr/reply/doDelete.do",
                        asyn:"true",
                        dataType:"json",
                        data:{
                            "replySeq": replySeq
                        },
                        success:function(data){//통신 성공
                            console.log("success data:"+data.msgId);
                            console.log("success data:"+data.msgContents);
                            
                            if("1" == data.msgId){
                                alert(data.msgContents);
                                replyRetrieve();
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
                
                
                //--------------------------------------------------------------
            },
            error:function(data){//실패시 처리
                console.log("error:"+data);
            },
            complete:function(data){//성공/실패와 관계없이 수행!
                console.log("complete:"+data);
            }
        });     
        
    }
    
    
    
    //------Reply---------------------------------------------------------------
	
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
                        <button class="button me-md-2" type="button" onclick="location.href='/login/loginView.do'" style="color:white;background-color: #FFA500; font-size: 16px; ">로그인</button>
                        <button class="button" type="button" onclick="location.href='/ehr/user/moveToReg.do'" style="color:white;background-color: #FFA500; font-size: 16px">회원가입</button>
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
    <br>
    <br>
    <br>
    <br>
    <br>
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
            <input type="button" value="수정" class="btn btn-primary" id="moveToMod" >
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
             value='${vo.title }' readonly="readonly">
        </div>      
        <div class="mb-3">
            <label for="contents" class="form-label">내용</label>
            <textarea rows="7" class="form-control"  id="contents" name="contents" readonly="readonly">${vo.contents }</textarea>
        </div>
        
        
        <!-- 파일 목록 -->        
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
		            </tr>
		        </thead>
		        <tbody>
		            <c:if test="${not empty fileList}">
		                <c:forEach var="file" items="${fileList}" varStatus="status">
		                    <tr data-org-file-name="${file.orgFileName}" data-save-file-name="${file.saveFileName}" data-save-path="${file.savePath}">
		                        <td>${status.index + 1}</td>
		                        <td>${file.orgFileName}</td>
		                        <td>${file.saveFileName}</td>
		                        <td>${file.fileSize}</td>
		                        <td>${file.extension}</td>
		                        <td>${file.savePath}</td>
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
    
      <!-- reply -->  
    <div id="replyDoSaveArea">
        <!-- 버튼 -->
        <div class="dynamicReply">
            <div class="row justify-content-end">
                <div class="col-auto">
                    <input type="button" value="댓글수정" class="btn btn-primary replyDoUpdate"  >
                    <input type="button" value="댓글삭제" class="btn btn-primary replyDoDelete"  >
                </div>
            </div>
            <!--// 버튼 ----------------------------------------------------------------->
            <div class="mb-3">
                <input type="hidden" name="replySeq" value="">
                <textarea rows="3" class="form-control dyReplyContents"   name="dyReplyContents"></textarea>
            </div>
        </div>        
    </div>
    
    
    <div id="replyDoSaveArea">
        <!-- 버튼 -->
        <div class="row justify-content-end">
            <div class="col-auto">
                <input type="button" value="댓글 등록" class="btn btn-primary" id="replyDoSave" >
            </div>
        </div>
        <!--// 버튼 ----------------------------------------------------------------->
        <div class="mb-3">
            <textarea rows="3" class="form-control"  id="replyContents" name="replyContents"></textarea>
        </div>        
    </div>
    <!--// reply --------------------------------------------------------------> 
    
	<!-- 파일 다운로드 -->
	<form action="${CP}/file/download.do" method="POST" name="fileDownloadForm">
       <input type="hidden" name="orgFileName" id="orgFileName">
       <input type="hidden" name="saveFileName" id="saveFileName">
       <input type="hidden" name="savePath" id="savePath">
    </form>
	    
   
</div>
<!-- Copyright Start -->
    <div class="container-fluid copyright py-4" style="background-color: #45595b;">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    <span class="text-light" ><a href="#"  style="color:#ffb526;"><i class="fas fa-copyright text-light me-2"></i>ARMS</a>, All right reserved.</span>
                </div>
                    <div class="col-md-6 my-auto text-center text-md-end text-white">
                    </div>
                 </div>
        </div>
    </div>
    <!-- Copyright End -->

</body>
</html>