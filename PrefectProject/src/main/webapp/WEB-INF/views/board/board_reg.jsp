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
				
				data.forEach(function(item, index) {
					 console.log('Item ' + index + ':', item); // 각 항목 로그 출력
				     console.log('UUID of item ' + index + ':', item.uuid);
				});
				
				if (data.length > 0) {
				    var uuid = data[0].uuid; // 배열의 첫 번째 객체에서 UUID 값을 가져옴
				    console.log(uuid); // 콘솔에 UUID 출력
				}
				
				document.getElementById('uuid').value = uuid;
				
				/* var uuid = data.uuid;
				console.log(uuid);
				
				let uuidV = document.querySelector("#uuid").value;
				console.log(uuidV); */
            
				let target = $('#tableTbody');
				
				let listData = "";
				
				$.each(data,function( index, value ){
					 let fileSizeInBytes = value.fileSize; // 바이트 단위의 파일 크기
					 let fileSizeInMB = fileSizeInBytes / (1024 * 1024); // MB 단위로 변환
					 fileSizeInMB = fileSizeInMB.toFixed(2); // 소수점 둘째 자리까지 표시
				    //console.log("vo.orgFileName:"+value.orgFileName);
				    console.log("index:"+index);
				    listData += "<tr>"; 
				    listData +="<td>"+(index+1)+"</td>";
				    listData +="<td>"+(value.orgFileName)+"</td>";
				    listData +="<td>"+fileSizeInMB+"</td>";
				    listData +="<td>"+(value.extension)+"</td>";
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
    background-color: #FFA500;
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
        <div class="col-lg-12" style="text-align: center;">
            <h1 class="page-header">${title }</h1>
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
		            <select class="form-select" aria-label="Default select example" id="div" name="div">
		              <c:forEach var="codeVO" items="${divCode}">
		                 <option   value="<c:out value='${codeVO.detCode}'/>"  
		                    <c:if test="${codeVO.detCode == vo.getDiv() }">selected</c:if>  
		                 ><c:out value="${codeVO.detName}"/></option>
		              </c:forEach>
		            </select>            
		       </div>
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
		</form>
	</div>
	<br>
	<div class="fileinfo">
       <table id="fileList"">
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
    
  
    
</div>
	  <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
</body>
</html>