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
body {
    font-family: 'Arial', sans-serif;
}

#drop-area {
    border: 2px dashed #ccc;
    border-radius: 8px;
    padding: 20px;
    text-align: center;
    margin: 50px auto;
    max-width: 400px;
    cursor: pointer;
}

.drop-text {
    font-size: 16px;
    color: #666;
}

#file-list {
    list-style-type: none;
    padding: 0;
}

.drag-over {
    background-color: skyblue;
}
</style>
<title>File Upload with Drag and Drop</title>
<script src="${CP}/resources/js/jquery-3.7.1.js"></script>
<script src="${CP}/resources/js/eUtil.js"></script>
<script >
document.addEventListener('DOMContentLoaded', function () {
	console.log('DOMContentLoaded');

    let fileList = document.getElementById('file-list');
    let dropArea = document.querySelector('#drop-area');
    let fileInput = document.querySelector('#file1');

    
    dropArea.addEventListener('dragover', function (e) {
        e.preventDefault();
        
        //class추가
        dropArea.classList.add('drag-over');
    });

    // Remove the 'drag-over' class when the drag operation is finished
    dropArea.addEventListener('dragleave', function () {
        dropArea.classList.remove('drag-over');
    });

    // Handle the drop event
    dropArea.addEventListener('drop', function (e) {
        e.preventDefault();
        dropArea.classList.remove('drag-over');
        // Process dropped files
        handleFiles(e.dataTransfer.files);
        addFilesToInput(e.dataTransfer.files);
    });

    // Handle file input change event
    fileInput.addEventListener('change', function () {
    	handleFiles(e.dataTransfer.files);
    	addFilesToInput(fileInput.files);
    });
    function addFilesToInput(files) {
        // 기존 파일들에 새로운 파일 추가
        let existingFiles = fileInput.files;
        let newFiles = new DataTransfer();

        for (var i = 0; i < existingFiles.length; i++) {
            newFiles.items.add(existingFiles[i]);
        }

        for (var j = 0; j < files.length; j++) {
            newFiles.items.add(files[j]);
        }

        // 파일 인풋에 새로운 파일 설정
        fileInput.files = newFiles.files;
    }
    function handleFiles(files) {
        fileList.innerHTML = ''; // Clear previous file list

        
        for (let i = 0; i < files.length; i++) {
            let file = files[i];
            // 파일 처리 로직 추가
            console.log('File added:', file.name);            
            displayFile(file);
        }
    }

    function displayFile(file) {
        let listItem = document.createElement('li');
        listItem.className = 'file-item';

        let fileName = document.createElement('span');
        fileName.textContent = file.name;

        listItem.appendChild(fileName);
        fileList.appendChild(listItem);
    }
    
    
    let sendButton = document.querySelector('#sendButton');
    sendButton.addEventListener('click', function () {
    	console.log('sendButton click');
    	
        //form생성
        let formData = new FormData();
        
        let files = fileInput.files;
        
        console.log("files:"+files);
        for(let i=0;i<files.length;i++){
        	console.log("files:"+files[i].name);
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
});
</script>
</head>
<body>
	<h2>File Upload with Drag and Drop</h2>
	<button id="sendButton">Send Server</button>
    <div id="drop-area">
        <span class="drop-text">Drag & Drop files here or click to select</span>
        <input type="file" name="file1" id="file1" multiple>
        <ul id="file-list"></ul>
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