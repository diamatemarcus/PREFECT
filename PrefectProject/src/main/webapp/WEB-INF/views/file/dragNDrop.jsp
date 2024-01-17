<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${CP}/resources/css/user.css">
<style>
#drop-area {
    max-width: 400px;
    border: 2px dashed #ccc;
    padding: 20px;
    text-align: center;
    margin: 50px auto;
    cursor: pointer;
}

#file-list{
    padding: 0;
    list-style-type: none;
}

.drag-over {
    background-color: skyblue;
}


</style>
<title>Insert title here</title>
<script src="${CP}/resources/js/jquery-3.7.1.js"></script>
<script src="${CP}/resources/js/eUtil.js"></script>
<script >
    document.addEventListener('DOMContentLoaded', function() {
		console.log('DOMContentLoaded~~');
		
		//javascript:id가져 오기
		let dropArea  = document.getElementById("drop-area");
		let fileInput = document.querySelector('#file1');
		let fileList  = document.querySelector('#file-list');
		let sendServerBtn = document.querySelector("#sendServer");
		
		sendServerBtn.addEventListener('click', function(e) {
			console.log('sendServerBtn click~~');
			
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
		
		dropArea.addEventListener('dragover', function(e) {
			e.preventDefault();	
			//style 추가
			dropArea.classList.add('drag-over');
		});
		
        dropArea.addEventListener('dragleave', function(e) {
            e.preventDefault(); 
            //style 제거
            dropArea.classList.remove('drag-over');
        });		
		
        dropArea.addEventListener('drop', function(e) {
        	e.preventDefault();    
        	//style 제거
            dropArea.classList.remove('drag-over');
        	//DateTransfer 객체는 드래그 앤 드롭 작업 중에 드래그되고 있는 데이터를 보관하기 위해 사용됩니다
            console.log('drop~~'+e.dataTransfer.files);
            handleFiles(e.dataTransfer.files);
            
            //<input type="file"  파일 정보 추가
            addFilesToInput(e.dataTransfer.files);
        });
        
        //input type =file에, 파일 정보 추가!
        function addFilesToInput(files){
        	let  existingFiles = fileInput.files;
        	
        	let  newFiles = new DataTransfer();
        	
        	//기존 정보 읽기
        	for( let i=0;i<existingFiles.length;i++){
        		newFiles.items.add(existingFiles[i]);
        	}
        	
        	//신규파일 정보
        	for(let i=0;i<files.length;i++){
        		newFiles.items.add(files[i]);
        	}
        	
        	fileInput.files = newFiles.files;
        	
        }
        
        
        
        
        
        
        //file-list: 파일이름 출력
        function handleFiles(files){
        	fileList.innerHTML = "";
        	
        	for(let i=0;i<files.length;i++){
        		let file = files[i];
        		console.log('File add: '+file.name)
        		displayFile(file);
        	}
        }
        /*
           <li>
               <span>HomeController.java</span> 
           </li>
           <li>
               <span>pom.xml</span> 
           </li>        
        */
        function displayFile(file){
        	//HTML 문서에서, Document.createElement() 메서드는 지정한 tagName의 HTML 요소를 만들어 반환합니다.
        	let listItem = document.createElement('li');
        	
        	let fileName = document.createElement('span');
        	fileName.textContent = file.name;
        	
        	listItem.appendChild(fileName);
        	fileList.appendChild(listItem);
        }
		
	});
</script>



</head>
<body>
	<h2>Drag And Drop</h2>
	<button id="sendServer">Send Server</button>
	<div id="drop-area">
	   <span>파일을 드래그 And 드롭 하세요.</span>
	   <input type="file" name="file1" id="file1" multiple="multiple">
	   <ul id="file-list">
       
	   </ul>
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
               <tr>
                   <td colspan="99">no data found</td>
               </tr>
           </tbody>
       </table>
    </div>  	
</body>
</html>