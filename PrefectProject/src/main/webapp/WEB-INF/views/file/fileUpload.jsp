<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${CP}/resources/css/user20231225.css">
<title>Insert title here</title>
<script src="${CP}/resources/js/jquery-3.7.1.js"></script>
<script src="${CP}/resources/js/eUtil.js"></script>
</head>
<body>
    <div class="page-title">
	   <h2>파일업로드</h2>
	</div>
	<div class="container">
	   <form action="${CP}/file/fileUpload.do" method="post" enctype="multipart/form-data" name="regForm">
	       <div class="form-group">
	           <label for="title">제목</label>
	           <input type="text" name="title" id="title" placeholder="제목을 입력하세요">
	       </div>
	       
           <div class="form-group">
              <label for="file1">파일1</label>
              <input type="file" name="file1" id="file1" placeholder="파일을 선택 하세요."  multiple/>
           </div>

           <div class="form-group">
                <label for="contents">내용</label>
                <textarea rows="8" cols="20" name="contents" id="contents"></textarea>
           </div>   
	   </form>
       <div class="form-group">
            <input type="button" value="전송" class="button" id="fileUpload">
       </div> 
           	   
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
	
	<form action="${CP}/file/download.do" method="POST" name="fileDownloadForm">
	   <input type="hidden" name="orgFileName" id="orgFileName">
	   <input type="hidden" name="saveFileName" id="saveFileName">
	   <input type="hidden" name="savePath" id="savePath">
	</form>
	
	<script >
	 //tableTbody
	 
	 //filedownload
	 $("#tableTbody").on("dblclick","tr" ,function(e) {
		 console.log('tableTbody dblclick');
		 let tdArrays = $(this).children();
		 let orgFileName = tdArrays.eq(1).text();
		 console.log('orgFileName:'+orgFileName);
		 

         let saveFileName = tdArrays.eq(2).text();
         console.log('saveFileName:'+saveFileName);
         
         let savePath = tdArrays.eq(5).text();
         console.log('savePath:'+savePath);      
         
         //jquery값 설정
         $("#orgFileName").val(orgFileName);
         
         document.fileDownloadForm.saveFileName.value = saveFileName;
         
         document.querySelector("#savePath").value = savePath;
         
         document.fileDownloadForm.submit();
         
	 });
	
	    
	 //fileUpload
	 $("#fileUpload").on("click",function(e){
		 console.log('fileUpload click');
		 
		 //form생성
		 let formData = new FormData();
		 let inputFile01 = $("input[name='file1']")
		 
		 let files = inputFile01[0].files;
		 
		 console.log("files:"+files);
		 
		 for(let i=0;i<files.length;i++){
			 formData.append("uploadFile", files[i]);	 
			 
		 }

		 $.ajax({
			 type: "POST",
			 url:"${CP}/file/fileUploadAjax.do",
			 processData: false,
			 contentType: false,
			 dataType:"json",
			 data: formData,
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
	
	</script>        
	
	
	
	
</body>
</html>