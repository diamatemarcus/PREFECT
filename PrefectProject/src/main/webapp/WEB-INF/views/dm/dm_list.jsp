<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="com.pcwk.ehr.dm.domain.DmVO"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />     

<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body, html {
            height: 100%; /* body와 html 요소의 높이를 100%로 설정 */
            margin: 0;
            padding: 0;
        }
        .contact-list {
        display: flex;
        flex-direction: column;
        flex: 3; /* 최신 메시지 창이 전체 너비의 3/10을 차지하도록 설정 */
        background-color: #f2f2f2;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-right: 20px; /* 최신 메시지 창과 연락처 목록 사이의 간격 설정 */
        }

        .contact {
        padding: 10px;
        border-bottom: 1px solid #ccc;
        }

    /* 최신 메시지 창의 스크롤 바 설정 */
    .contact-list::-webkit-scrollbar {
        width: 5px;
    }

    .contact-list::-webkit-scrollbar-thumb {
        background-color: #aaa;
        border-radius: 10px;
    }

        .chat-container {
           display: flex;
        flex-direction: column;
        flex: 7; /* 채팅 창이 전체 너비의 7/10을 차지하도록 설정 */
        max-width: 800px;
        margin: auto;
        }

        .chat-history {
            overflow-y: scroll;
            flex: 1;
            background-color: #f2f2f2;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .chat-messages {
            list-style-type: none;
            margin: 0;
            padding: 10px;
            overflow-y: auto;
            height: 100%;
        }

        .message {
            margin-bottom: 10px;
            padding: 8px;
            border-radius: 8px;
            max-width: 70%;
            position: relative;
        }

        .user-message {
            background-color: #4CAF50;
            color: #fff;
            align-self: flex-end;
            margin-left: auto;
        }

        .bot-message {
            background-color: #fff;
            color: #333;
            align-self: flex-start;
            margin-right: auto;
        }

        .message .name {
            font-size: 0.8em;
            color: #777;
            margin-bottom: 4px;
        }

        .message .time {
            font-size: 0.8em;
            color: #777;
            position: absolute;
            bottom: -15px;
        }

        .input-container {
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: #fff;
            border-top: 1px solid #ccc;
        }

        .input-container input {
            flex: 1;
            padding: 8px;
            margin-right: 10px;
            border: none;
            border-radius: 4px;
            outline: none;
        }

        .input-container button {
            padding: 8px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
<script>
document.addEventListener("DOMContentLoaded", function () {
    
    const doSendBTN = document.querySelector("#doSend");
    

    doSendBTN.addEventListener("click", function (e) {
    	
    	
    	let sender = document.querySelector("#sender").value;
    	let receiver = document.querySelector("#receiver").value;
    	let contents = document.querySelector("#contents").value;
    	
        $.ajax({
            type: "POST",
            url: "/ehr/dm/doSend.do",
            async: "true",
            dataType: "json",
            data: {
            	
                "sender": sender,
                "receiver": receiver,
                "contents": contents,
                "readChk":0
            },
            success: function (data) { // 통신 성공
                console.log("success data.msgId:" + data.msgId);
                console.log("success data.msgContents:" + data.msgContents);
                
                if (1 == data.msgId) {
                    alert(data.msgContents);
                    doContentsList()
                } else {
                    alert(data.msgContents);
                }
            },
            error: function (data) { // 실패시 처리
                console.log("error:" + data);
            },
            complete: function (data) { // 성공/실패와 관계없이 수행!
                console.log("complete:" + data);
            }
        });
    });

    function moveToList() {
    	window.location.href = "/ehr/dm/doContentsList.do";
    }
    
    $("#doMemberPopup").on("click",function(e){
        console.log( "doMemberPopup click!" );
        
           $.ajax({
               type: "GET",
               url:"/ehr/user/doMemberPopup.do",
               asyn:"true",
               cache: false,
               dataType:"json",
               data:{
                   "pageNo": "1",
                   "pageSize": "10" 
               },
               success:function(data){//통신 성공
                   console.log("success data:"+data);
                   //동적인 테이블 헤더 생성
                   let tableHeader = '<thead>\
                                           <tr>\
                                               <th scope="col" class="text-center col-lg-1  col-sm-1">번호</th>\
                                               <th scope="col" class="text-center col-lg-2  col-sm-2" >사용자ID</th>\
                                               <th scope="col" class="text-center col-lg-2  col-sm-2" >이름</th>\
                                           </tr>\
                                       </thead>';
                   //동적 테이블 body                       
                   let tableBody = ' <tbody>';
                   
                   for(let i =0;i< data.length;i++){
                       tableBody +='<tr>\
                                       <td class="text-center">'+data[i].no+'</td>\
                                       <td class="text-left">'+data[i].email+'</td>\
                                       <td class="text-left">'+data[i].name+'</td>\
                                    </tr>\
                                    '; 
                   }
                   tableBody += ' </tbody>';                   
               
                   console.log(tableHeader);
                   console.log(tableBody);
                   
                   let dynamicTable = '<table id="userTable"  class="table table-bordered border-primary table-hover table-striped">'+tableHeader+tableBody+'</table>';
                   //
                   $(".modal-body").html(dynamicTable);
                   $('#staticBackdrop1').modal('show');
                   
                   //회원정보 double click
                   $("#userTable>tbody").on("dblclick","tr" , function(e){
                       console.log( "userTable click!" );
                       
                       let tdArray = $(this).children();
                       let email = tdArray.eq(1).text();
                       
                       
                       console.log('email:'+email);
                       
                       
                       $("#receiver").val(email);
                       doContentsList()
                       
                       //modal popup닫기
                       $('#staticBackdrop1').modal('hide');
                       
                   });
                   
                   
                   
                   $("#doRetrieve").on("click", function(e){
                       
                       
                       $.ajax({
                           type: "GET",
                           url:"/ehr/user/doMemberPopup.do",
                           asyn:"true",
                           cache: false,
                           dataType:"json",
                           data:{
                               "pageNo": "1",
                               "pageSize": "10" ,
                               "searchDiv": "20",
                               "searchWord":document.forms['userFrm'].searchWord.value
                           },
                           success:function(data){//통신 성공
                               console.log("success data:"+data);
                               //동적인 테이블 헤더 생성
                               let tableHeader = '<thead>\
                                                       <tr>\
                                                           <th scope="col" class="text-center col-lg-1  col-sm-1">번호</th>\
                                                           <th scope="col" class="text-center col-lg-2  col-sm-2" >사용자ID</th>\
                                                           <th scope="col" class="text-center col-lg-2  col-sm-2" >이름</th>\
                                                       </tr>\
                                                   </thead>';
                               //동적 테이블 body                       
                               let tableBody = ' <tbody>';
                               
                               for(let i =0;i< data.length;i++){
                                   tableBody +='<tr>\
                                                   <td class="text-center">'+data[i].no+'</td>\
                                                   <td class="text-left">'+data[i].email+'</td>\
                                                   <td class="text-left">'+data[i].name+'</td>\
                                                </tr>\
                                                '; 
                               }
                               tableBody += ' </tbody>';                   
                           
                               console.log(tableHeader);
                               console.log(tableBody);
                               
                               let dynamicTable = '<table id="userTable"  class="table table-bordered border-primary table-hover table-striped">'+tableHeader+tableBody+'</table>';
                               //
                               $(".modal-body").html(dynamicTable);
                               $('#staticBackdrop1').modal('show');
                               
                               //회원정보 double click
                               $("#userTable>tbody").on("dblclick","tr" , function(e){
                                   console.log( "userTable click!" );
                                   
                                   let tdArray = $(this).children();
                                   let email = tdArray.eq(1).text();
                                   
                                   
                                   console.log('email:'+email);
                                   
                                   
                                   $("#receiver").val(email);
                                   doContentsList()
                                   
                                   //modal popup닫기
                                   $('#staticBackdrop1').modal('hide');
                                   
                               });
                           },
                           error:function(data){//실패시 처리
                               console.log("error:"+data);
                           },
                           complete:function(data){//성공/실패와 관계없이 수행!
                               console.log("complete:"+data);
                           }
                       });
                       
                       
                   });
               },
               error:function(data){//실패시 처리
                   console.log("error:"+data);
               },
               complete:function(data){//성공/실패와 관계없이 수행!
                   console.log("complete:"+data);
               }
           });
        
           

    });
    $("#doReceiverList").on("click",function(e){
        console.log( "doReceiverList click!" );
        let sender = document.querySelector("#sender").value;
           $.ajax({
               type: "GET",
               url:"/ehr/dm/doReceiverList.do",
               asyn:"true",
               dataType:"json",
               data:{
                   "pageNo": "1",
                   "pageSize": "10",
                   "sender": sender
               },
               success:function(data){//통신 성공
                   console.log("success data:"+data);
                   //동적인 테이블 헤더 생성
                   let tableHeader = '<thead>\
                                           <tr>\
                                           <th scope="col" class="text-center col-lg-1  col-sm-1">이메일</th>\
                                           <th scope="col" class="text-center col-lg-2  col-sm-2" >이름</th>\
                                           <th scope="col" class="text-center col-lg-2  col-sm-1" >안 읽은 메세지</th>\
                                           </tr>\
                                       </thead>';
                   //동적 테이블 body                       
                   let tableBody = ' <tbody>';
                   
                   for(let i =0;i< data.length;i++){
                       tableBody +='<tr>\
                    	                 <td class="text-center">'+data[i].receiver+'</td>\
                                         <td class="text-center">'+data[i].receiverName+'</td>\
                                         <td class="text-center">'+data[i].readChk+'</td>\
                                    </tr>\
                                    '; 
                   }
                   tableBody += ' </tbody>';                   
                   console.log(data)
                   console.log(tableHeader);
                   console.log(tableBody);
                   
                   let dynamicTable = '<table id="userTable"  class="table table-bordered border-primary table-hover table-striped">'+tableHeader+tableBody+'</table>';
                   //
                   $(".modal-body").html(dynamicTable);
                   $('#staticBackdrop2').modal('show');
                   
                   //회원정보 double click
                   $("#userTable>tbody").on("dblclick","tr" , function(e){
                       console.log( "userTable click!" );
                       
                       let tdArray = $(this).children();
                       let email = tdArray.eq(0).text();
                       
                       
                       console.log('email:'+email);
                       
                       
                       $("#receiver").val(email);
                       doContentsList()
                       
                       //modal popup닫기
                       $('#staticBackdrop2').modal('hide');
                       
                   });
                   
               },
               error:function(data){//실패시 처리
                   console.log("error:"+data);
               },
               complete:function(data){//성공/실패와 관계없이 수행!
                   console.log("complete:"+data);
               }
           });
        
           

    });
    function doContentsList(){
    	let sender = document.querySelector("#sender").value;
        let receiver = document.querySelector("#receiver").value;
        
        
        $.ajax({
            type: "GET",
            url:"/ehr/dm/doContents.do",
            asyn:"true",
            dataType:"json", //return type
            data:{
            	 "sender": sender,
                 "receiver": receiver
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
                	alert("처음 보내는 상대입니다");
                    return;
                }
                    
                
                for(let i=0;i<data.length;i++){
                    replyDiv += '<div class="dynamicReply"> \n';
                    replyDiv += '<div class="row justify-content-end"> \n';
                    replyDiv += '<div class="col-auto"> \n';
                    replyDiv += '<span>등록일:'+data[i].sendDt+'</span> \n';
                   
                    replyDiv += '</div> \n';
                    replyDiv += '</div> \n';
                    
                    replyDiv += '<div class="mb-3">  \n';
                    replyDiv += '<input type="text" name="replySeq" value="'+data[i].senderName +'"> \n';
                    
                    replyDiv += '<textarea rows="3" class="form-control dyReplyContents"   name="dyReplyContents">'+data[i].contents+'</textarea> \n';
                    replyDiv += '</div> \n';
                    
                    replyDiv += '</div> \n';
                    
                }
                
                //console.log(replyDiv);
               
                //조회 댓글 출력
                document.getElementById("replyDoSaveArea").innerHTML = replyDiv;
                //$("#replyDoSaveArea").html(replyDiv);
                
            },
            error:function(data){//실패시 처리
                console.log("error:"+data);
            },
            complete:function(data){//성공/실패와 관계없이 수행!
                console.log("complete:"+data);
            }
        });     
        
    }
    
});

</script>
</head>
<body>

<div class="container">
    <div class="contact-list">
    <div class="contact">
        <button type="button" class="btn btn-primary btn-block" id="doReceiverList">채팅방</button>
        <button type="button" class="btn btn-primary btn-block" id="doMemberPopup">회원</button>  
    </div>
</div>
<div class="chat-container">
    <div id="replyDoSaveArea">
        <!-- 버튼 -->
        <div class="dynamicReply">
            <div class="row justify-content-end">
                <div class="col-auto">
                    
                </div>
            </div>
            <!--// 버튼 ----------------------------------------------------------------->
            <div class="mb-3">
                <input type="text" name="replySeq" value="">
                <textarea rows="3" class="form-control dyReplyContents"   name="dyReplyContents"></textarea>
            </div>
        </div>        
</div>
    <div class="chat-history">
        <ul class="chat-messages">
           <c:choose>
              <c:when test="${ not empty list }">
                <c:set var="userEmail" value="${sessionScope.user.email}" />
                <c:forEach var="vo" items="${list}">
                    <c:set var="isCurrentUser" value="${vo.sender eq userEmail}" />
                    <li class="message ${isCurrentUser ? 'user-message' : 'bot-message'}">
                        <div class="name">${isCurrentUser ? '나' : vo.senderName}</div>
                        ${vo.contents}
                        <div class="time">${vo.sendDt}</div>
                    </li>
                </c:forEach>
               </c:when>
               <c:otherwise>
               <tr>
                <td colspan="99" class="text-center">채팅방을 눌러주세요</td>
               </tr>              
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>
        <div class="input-container">
            <input type="hidden" id="sender" name="sender" value="${sessionScope.user.email}"> 
            <input type="text" id="receiver" name="receiver" value="${receiver}"> 
            <input type="hidden" name="room" id="room" value="1">
            <input type="text"  id="contents" name="contents">
            <button id="doSend" name="doSend">전송</button>
        </div>
    
</div>
    <div class="modal fade" id="staticBackdrop1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="staticBackdropLabel">회원</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="#" method="get" name="userFrm" style="display: inline;">
            <div class="col-auto">
                <input type="text"  class="form-control" value="${searchVO.searchWord }" name="searchWord" id="searchWord" placeholder="검색어를 입력하세요">
                <input type="button" class="btn btn-primary" value="조회"   id="doRetrieve" >
            </div>
          </form> 
          <div class="modal-body">
            <!-- 회원정보 table -->
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
 <div class="modal fade" id="staticBackdrop2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="staticBackdropLabel">채팅방</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
           
          <div class="modal-body">
            <!-- 회원정보 table -->
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
</body>
</html>