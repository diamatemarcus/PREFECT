<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="com.pcwk.ehr.dm.domain.DmVO"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />     

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
        }

        .chat-container {
            display: flex;
            flex-direction: column;
            max-width: 800px;
            margin: 20px auto;
        }

        .chat-history {
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
            max-height: 300px;
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
    	const sender = '${sessionScope.user.email}';
    	const contents = document.querySelector("#contents").value;
    	
        const receiver = document.querySelector("#receiver").value;
        const room = document.querySelector("#room").value; // 여기에 메시지 내용을 가져오는 코드를 넣으세요;
        $.ajax({
            type: "POST",
            url: "/ehr/dm/doSend.do",
            async: true,
            dataType: "json",
            data: {
            	
            	"room":room,
                "sender": sender,
                "receiver":receiver,
                "contents": contents,
                "readChk":0
            },
            success: function (data) { // 통신 성공
                console.log("success data.msgId:" + data.msgId);
                console.log("success data.msgContents:" + data.msgContents);

                if (1 == data.msgId) {
                    alert(data.msgContents);
                    moveToList();
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
        window.location.href = "${CP}/dm/doContentsList.do";
    }
});

</script>
</head>
<body>
<div class="chat-container">
<div class="chat-history">
 <ul class="chat-messages">
    <c:forEach var="vo" items="${list}">
        <c:set var="isCurrentUser" value="${vo.sender eq sessionScope.user.email}" />
        <li class="message ${isCurrentUser ? 'user-message' : 'bot-message'}">
            <div class="name">${isCurrentUser ? sessionScope.user.email : vo.sender}</div>
            ${vo.contents}
            <div class="time">${vo.sendDt}</div>
        </li>
    </c:forEach>
</ul>
 </div>
 <div class="input-container">
        
        <input type="hidden" id="receiver" name="receiver" value="dlgkssk1627@naver.com"> 
        <input type="hidden" name="room" id="room" value="1">
        <input type="text"  id = "contents" name="contents">
        <button id = "doSend" name="doSend">전송</button>
    </div>
  </div>

   
    
</body>
</html>