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
/* 읽기 전용 필드의 배경색을 흰색으로 설정 */
.readonly-input[readonly] {
    background-color: #ffffff; /* 흰색 배경 */
    border: 1px solid #ced4da; /* 테두리 색상 추가 (부트스트랩 스타일과 유사하게) */
    color: #495057; /* 텍스트 색상 설정 */
}

.flex-container {
    display: flex;
    align-items: center;
}

.dynamicReply {
    margin-bottom: 10px;
    padding: 10px;
}

.button {
    margin-left: 5px;
}

.container-main {
    background-color: #ffffff; /* 흰색 배경 */
    border: 1px solid #dcdcdc; /* 연한 회색 테두리 */
    padding: 20px;
    margin-top: 20px;
    border-radius: 5px;
}

.divider {
    border-bottom: 1px solid #dcdcdc; /* 연한 회색 실선 */
    margin-bottom: 20px;
}

.button-area {
    margin: 20px; /* 메인 컨테이너의 상단 마진과 동일하게 설정 */
}
</style>

 <script>
document.addEventListener("DOMContentLoaded",function(){
	
	//댓글 조회 
    replyRetrieve();
	 
	console.log('ready');
	const div = document.querySelector("#div").value;
    const seq = document.querySelector("#seq").value;
    const regId = document.querySelector("#regId").value;
    const modId = '${sessionScope.user.email}';
    const userRole = '${sessionScope.user.role}';
    
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
    	console.log('doDeleteBTN click'); 
    	
        console.log('seq :'+seq);
        
        if(eUtil.isEmpty(seq) == true){
            alert('순번을 확인 하세요.');
            return;
        }
        
        if (window.confirm('삭제 하시겠습니까?')) {
            if (!(userRole === "10" || userRole === "20") && modId !== regId) {
                alert('삭제 권한이 없습니다.');
                return; // 시스템 관리자나 학원 관리자가 아니고, 수정자와 등록자가 다를 경우에만 경고 메시지 출력 후 리턴
            }
        } else {
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
        console.log('boardSeq:'+boardSeq)
       
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
                    
                
                for(let i=0; i<data.length; i++){
                    replyDiv += '<div class="dynamicReply"> \n';
                    // Flex 컨테이너 시작
                    replyDiv += '<div class="flex-container" style="justify-content: space-between; margin-bottom: 5px;"> \n'; 
                    // 왼쪽 부분: 등록자와 등록일
                    replyDiv += '<div> \n'; 
                    replyDiv += '<span>' + data[i].regId + '</span> \n';
                    replyDiv += '<span>(' + data[i].modDt + ')</span> \n';
                    replyDiv += '</div> \n';
                    // 오른쪽 부분: 수정 및 삭제 버튼
                    replyDiv += '<div> \n';
                    replyDiv += '<input type="button" value="댓글수정" class="button replyDoUpdate"> \n';
                    replyDiv += '<input type="button" value="댓글삭제" class="button replyDoDelete"> \n';
                    replyDiv += '</div> \n';
                    // Flex 컨테이너 종료
                    replyDiv += '</div> \n';

                    replyDiv += '<div class="mb-3"> \n';
                    replyDiv += '<input type="hidden" name="replySeq" value="' + data[i].replySeq + '"> \n';
                    replyDiv += '<textarea rows="3" class="form-control dyReplyContents" name="dyReplyContents">' + data[i].reply + '</textarea> \n';
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

<div class="container" style="margin-top: 150px;">
    <div class="container-main">
    
	    <!-- 버튼 --> 
	    <div class="row button-area">
            <div class="col d-flex justify-content-between">
		        <div class="col-auto">
		            <input type="button" value="목록" class="button" id="moveToList">
		        </div>
		        
		        <div class="col-auto">
		            <input type="button" value="수정" class="button" id="moveToMod">
		            <input type="button" value="삭제" class="button" id="doDelete">
		        </div>
		    </div>
		</div>

	    <!--// 버튼 ----------------------------------------------------------------->
	    <div class="divider"></div> <!-- 연한 회색 실선 -->
	    <!-- 
		    seq : sequence별도 조회
		    div : 10(공지사항)고정
		    read_cnt : 0 
		    title,contents : 화면에서 전달
		    reg_id,mod_id  : session에서 처리
	    -->
	    <!-- form -->
	    
	    
	    <form action="#" name="regFrm" id="regFrm">
	                        
	        <div class="mb-2"> <!--  아래쪽으로  여백 -->
	            <h3 id="title" class="form-label">${vo.title}</h3>
	        </div>  
	
			<div class="mb-3 row" style="display: flex; align-items: center;">
			    <label id="regId" style="margin-right: 10px;">${user.name} ${vo.regId}</label>
			    <div style="flex-grow: 1; text-align: left; color: gray;">
			            조회 ${vo.readCnt} | ${vo.regDt}
			    </div>   
			</div>
	        
	        <div class="mb-3">
	            <label for="contents" class="form-label"></label>
	            <textarea rows="7" class="form-control readonly-input"  id="contents" name="contents" readonly="readonly">${vo.contents}</textarea>
	        </div>        
	                
	        <!-- VIEW에 나오지 않음 --------------------------------------------------->
	        <div class="mb-3 row" style="display:none;"> <!--  아래쪽으로  여백 -->
	            <label for="seq" class="col-sm-2 col-form-label">순번</label>
	            <div class="col-sm-10">
	                <input type="text" class="form-control readonly-input" id="seq" name="seq" maxlength="100"
	                 value="${vo.seq }"
	                 readonly>
	            </div>
	        </div>
	        
	        <div class="mb-3 row" style="display:none;"> <!--  아래쪽으로  여백 -->
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
	
	        <div class="mb-3 row" style="display:none;">
	            <label for="regId" class="col-sm-2 col-form-label">수정자</label>
	            <div class="col-sm-10">
	                <input type="text" class="form-control readonly-input" id="modId" name="modId" 
	                value="${vo.modId }"  readonly="readonly"  >
	            </div>        
	        </div>            
	        <!-- // --------------------------------------------------------------->
	        
	        <!-- 파일 목록 -->        
	        <div class="container">
			    <table id="fileList" class="table" style="width: auto;">
			        <thead>
			            <tr>
			                <th>번호</th>
			                <th>파일 이름</th>
			                <th style="display:none;">저장파일명</th>
			                <th style="display:none;">파일크기</th>
			                <th style="display:none;">확장자</th>
			                <th style="display:none;">저장경로</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:if test="${not empty fileList}">
			                <c:forEach var="file" items="${fileList}" varStatus="status">
			                    <tr data-org-file-name="${file.orgFileName}" data-save-file-name="${file.saveFileName}" data-save-path="${file.savePath}">
			                        <td class="text-center">${status.index + 1}</td>
			                        <td>${file.orgFileName}</td>
			                        <td style="display:none;">${file.saveFileName}</td>
			                        <td style="display:none;">${file.fileSize}</td>
			                        <td style="display:none;">${file.extension}</td>
			                        <td style="display:none;">${file.savePath}</td>
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
	    
		<!-- 파일 다운로드 -->
		<form action="${CP}/file/download.do" method="POST" name="fileDownloadForm">
	       <input type="hidden" name="orgFileName" id="orgFileName">
	       <input type="hidden" name="saveFileName" id="saveFileName">
	       <input type="hidden" name="savePath" id="savePath">
	    </form>
	</div>
	
    <!-- reply -->  
    <!-- 댓글 영역 전체를 감싸는 컨테이너 -->
    <div id="commentsSection" class="comments-container">
        
        <!-- 기존 댓글 목록을 표시할 영역 -->
	    <div id="replyDoSaveArea"></div>
	
	    <!-- 댓글 등록 영역 -->
	    <div class="reply-input-area">
	        <div class="row justify-content-end" style="margin-bottom: 5px;">
	            <div class="col-auto">
	                <input type="button" value="댓글 등록" class="button" id="replyDoSave" >
	            </div>
	        </div>
	        <div class="mb-3">
	            <textarea rows="3" class="form-control" id="replyContents" name="replyContents"></textarea>
	        </div>        
	    </div>
	</div>
    <!--// reply --------------------------------------------------------------> 
	   
</div>

	<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
	
</body>
</html>