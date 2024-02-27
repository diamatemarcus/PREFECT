<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="CP" value="${pageContext.request.contextPath}"  scope="page"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>게시판 등록</title> <!-- http://localhost:8080/ehr/board/moveToReg.do -->
<script>
document.addEventListener("DOMContentLoaded",function(){
    console.log("DOMContentLoaded");
    
    let div = document.querySelector("#div").value;
    console.log('div:'+div);
    
    const regForm       = document.querySelector("#regFrm");
    const moveToListBTN = document.querySelector("#moveToList");
    const doSaveBTN     = window.document.querySelector("#doSave");
    
    function moveToListFun() {
    	let div = document.querySelector("#div").value;
        console.log('div:'+div);
        window.location.href = "/ehr/board/doRetrieve.do?div="+div;
    }

    // event 감지 및 처리
    moveToListBTN.addEventListener("click", function (e) {
        console.log("moveToListBTN click");
        
        let div = document.querySelector("#div").value;
        console.log("div:" + div);
        
        if (window.confirm("등록하지 않고 목록으로 가시겠습니까?") === false) {
            return;
        }
        
        moveToListFun();
        
    });

    function generateUUID() {
        var d = new Date().getTime();//Timestamp
        var d2 = (performance && performance.now && (performance.now()*1000)) || 0;//Time in microseconds since page-load or 0 if unsupported
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
            var r = Math.random() * 16;//random number between 0 and 16
            if(d > 0){//Use timestamp until depleted
                r = (d + r)%16 | 0;
                d = Math.floor(d/16);
            } else {//Use microseconds since page-load if supported
                r = (d2 + r)%16 | 0;
                d2 = Math.floor(d2/16);
            }
            return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
        });
    }

    // 사용 예:
    var uuid = generateUUID();
    
    // doSave event 감지 및 처리
    doSaveBTN.addEventListener("click", function (e) {
        console.log("doSaveBTN click");

        let div = document.querySelector("#div").value;
        let title = document.querySelector("#title").value;
        let regId = document.querySelector("#regId").value;
        let contents = document.querySelector("#contents").value;

        console.log("div:" + div);
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
                "regId": regId,
                "uuid": uuid
            },
            success: function (data) {// 통신 성공 시의 처리
                console.log("data.msgId:" + data.msgId);
                console.log("data.msgContents:" + data.msgContents);
                console.log("uuid:" + uuid);

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
    
    // 파일 리스트 업데이트 함수
    function updateFileList() {
        $.ajax({
            type: "GET",
            url: "${CP}/file/getFileList.do",
            data: {
                "uuid": uuid
            },
            success: function (data) {
                console.log("파일 리스트 업데이트 성공");
                console.log("data:", data);

                // 파일 목록 테이블의 tbody 선택
                let fileListTable = $("#tableTbody");

                // 파일 목록 초기화
                fileListTable.empty();

                // 파일 목록 생성
                data.forEach(function (item, index) {
                    console.log('Item ' + index + ':', item); // 각 항목 로그 출력
                    console.log('UUID of item ' + index + ':', item.uuid);

                    // 파일 정보를 파일 목록에 추가
                    let row = "<tr>";
                    row += "<td>" + (index + 1) + "</td>";
                    row += "<td>" + item.orgFileName + "</td>";
                    row += "<td>" + item.fileSize + "</td>";
                    row += "<td>" + item.extension + "</td>";
                    row += "<td><button id='upFileDelete' class='btn btn-danger delete-file' data-seq='" + item.seq + "'>삭제</button></td>";
                    row += "</tr>";

                    fileListTable.append(row);
                });
            },
            error: function (data) {// 실패 시 처리
                console.log("파일 리스트 업데이트 실패");
                console.log("error:", data);
            }
        });
    }
    
    /* 파일 등록 */
    //fileUpload
    $("#fileUpload").on("click",function(e){
        console.log('fileUpload click');
        
        let formData = new FormData();
        formData.append("uuid", uuid);
        
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
				console.log("data:"+data); // 응답 구조 확인
				
                // 파일 리스트 업데이트
                updateFileList();			    
			},
			error:function(data){//실패시 처리
			   console.log("error:"+data);
			},
			complete:function(data){//성공/실패와 관계없이 수행!
			   console.log("complete:"+data);
			}           
        });//-- $.ajax
        
        // 파일 재등록 버튼으로 변경
        $('#reUpload').show();
        $('#fileUpload').hide();
        
    });
    
    // 파일 삭제 버튼 클릭 이벤트를 모든 삭제 버튼에 대해 추가
    $(document).on("click", ".delete-file", function(e){
        console.log('delete-file click');
        
        const seq = $(this).data('seq'); // 삭제할 파일의 seq 가져오기
        console.log('seq:', seq);
        
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
                    
                    // 파일 삭제 후 파일 리스트 업데이트
                    updateFileList();
                },
                error: function(xhr, status, error) {
                    console.log('파일 삭제 실패');
                    alert('파일 삭제 중 오류가 발생했습니다.');
                }
            });
        }
    });
    
    // 파일 재업로드
     $("#reUpload").on("click",function(e){
        console.log("reUpload click");
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
                
                updateFileList();
            },
            error: function(xhr, status, error) {
                console.error('Upload failed: ', error);
                alert('파일 업로드 중 오류가 발생했습니다.');
            }
        });
        
    });
    
}); //--DOMContentLoaded
</script>
<style>
    input[type=file]::file-selector-button {
    width: auto;
    /* 버튼의 크기를 내용에 맞게 자동으로 조절합니다. */
    /* 다른 스타일을 원하는 대로 추가할 수 있습니다. */
    padding: 10px 20px;
    /* 내용과 버튼의 테두리 간격을 조정합니다. */
    border: none;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    border-radius: 8px;
    background-color: #3986ff;
    color: white;
}
    .filebox {
	  width: 80%; /* 넓이를 페이지의 80%로 설정 */
	  margin: 0 auto; /* 페이지 중앙에 위치하도록 마진 설정 */
	  text-align: right;
}
    .fileinfo{
     width: 65%; /* 넓이를 페이지의 80%로 설정 */
     margin: 0 auto; /* 페이지 중앙에 위치하도록 마진 설정 */
     text-align: center;
    }
</style>
</head>
<body>

<div class="container">
    
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12" style="text-align: left;">
            <h1 class="page-header">게시글 등록</h1>
        </div>
    </div>    
    <!--// 제목 ----------------------------------------------------------------->
    
    <!-- 버튼 -->    
    <div class="row justify-content-end">
        <div class="col-auto">
            <button class="button" id="moveToList">목록</button>
            <button class="button" id="doSave">등록</button>
        </div>
    </div>
    <br>
    <br>
    <!--// 버튼 ----------------------------------------------------------------->
    
     <!-- 
	    seq : sequence별도 조회
	    div : 10(공지사항)고정
	    read_cnt : 0
	    title, contents : 화면에서 전달
	    reg_id, mod_id  : session에서 처리
     -->
      <form action="#" name="regFrm" id="regFrm">
        <input type="hidden" name="uuid" id="uuid">
        </form>
     <table style="margin: auto;width: 80%;"> 
		
		  <tr>
		    <td style="padding:10px;width: 15%;">   
		        <div class="mb-3">
		        		        
		        <select class="form-select" aria-label="Default select example" id="div" name="div" style="width:auto;">
				    <c:forEach var="codeVO" items="${divCode}">
				        <option value="${codeVO.detCode}"  
				            <c:if test="${codeVO.detCode == selectedDiv}">selected</c:if>  
				        >${codeVO.detName}</option>
				    </c:forEach>
				</select>
				
            </td>
          <td style="padding:10px; width: 70%;">
		    <div class="mb-3"> <!--  아래쪽으로  여백 -->
                <input type="text" class="form-control" id="title" name="title" maxlength="100" placeholder="제목을 입력 하세요.">
            </div>
          </td>
		    <td style="width: 10%;"><div class="mb-3">
        
            <input type="hidden" class="form-control" id="regId" name="regId" value="${sessionScope.user.email}" 
                  readonly="readonly" style="text-align: center;">        
            <input type="text" class="form-control" id="regIdName" name="regIdName" value="${sessionScope.user.name}" 
            readonly="readonly" style="text-align: center;">        
        </div>
        </td>
		  </tr>
		  <tr>
		    <td colspan="3">
		      <div class="mb-3">
	             <textarea rows="14" class="form-control"  id="contents" name="contents" placeholder="내용을 입력해 주세요"></textarea>
	          </div>
           </td>
		  </tr>
	  </table>
    <!-- form -->
    
    <!--// form --------------------------------------------------------------->
    
    <!-- 파일 업로드 -->
    <br>
    <div class="filebox">
		<form action="${CP}/file/fileUpload.do" method="post" enctype="multipart/form-data" name="regForm">
	        <input type="file" name="file1" id="file1" multiple/>
	        <input type="button" class="button" value="파일 등록" id="fileUpload">
	        <input type="button" class="button" value="파일 등록" id="reUpload" style="display: none;">
		</form>
	</div>
	<br>
	
	<div class="fileinfo">
		<table id="fileList" class="table">
			<thead>
			    <tr>
			        <th>번호</th>
			        <th>파일명</th>
			        <th>파일크기(MB)</th>              
			        <th>확장자</th>                                      
			    </tr>
			</thead>
			<tbody id="tableTbody">
			    <tr>
			        <td style="height: 20px;" colspan="1"></td> <!-- 여백을 위한 빈 셀 -->
			    </tr>
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
							    <td>${ vo.fileSize}</td>
							    <td>${ vo.extension}</td>
							    <td><button class='btn btn-danger delete-file' data-seq='${vo.seq}'>삭제</button></td>
							</tr>
			            </c:forEach>
			        </c:when>
			        <c:otherwise>
						<tr>
						    <td colspan="99" style="text-align: center;">파일이 없습니다</td>
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