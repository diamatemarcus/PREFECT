<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function(){
            const seq = document.querySelector("#room").value;
            const sender = '${sessionScope.users.email}';
            console.log(sender);
            
            // 추가: 로그인 세션 정보 가져오기
            const userId = '${sessionScope.users.id}';
            const userName = '${sessionScope.users.name}';
            
            const moveToListBTN = document.querySelector("#moveToList");

            // AJAX 요청
            $.ajax({
                type: "POST",
                url: "/dm/doContentsList.do",
                async: "true",
                dataType: "json",
                data: {
                    "seq": seq,
                    "room": room,
                    "sender": sender,
                    "contents": contents,
                    "userId": userId,  // 추가: 로그인 세션 정보
                    "userName": userName  // 추가: 로그인 세션 정보
                },
                success: function(data) {
                    // 성공적으로 통신 완료시 처리
                    console.log("success: " + data);
                },
                error: function(data) {
                    // 통신 실패시 처리
                    console.log("error: " + data);
                },
                complete: function(data) {
                    // 통신 성공/실패 여부와 관계없이 처리
                    console.log("complete: " + data);
                }
            });

            // 삭제 이벤트 처리
            $("#doDeleteBTN").click(function(e){
                console.log('doDeleteBTN click');
                console.log('seq :' + seq);
                
                if(eUtil.isEmpty(seq) == true){
                    alert('순번을 확인하세요.');
                    return;
                }

                if(window.confirm('삭제 하시겠습니까?') == false){
                    return;
                }

                $.ajax({
                    type: "GET",
                    url: "${CP}/board/doDelete.do",
                    async: "true",
                    dataType: "json",
                    data: {
                        "seq": seq
                    },
                    success: function(data) {
                        console.log("success data.msgId:" + data.msgId);
                        console.log("success data.msgContents:" + data.msgContents);
                        if("1" == data.msgId){
                            alert(data.msgContents);
                            moveToList();
                        }else{
                            alert(data.msgContents);
                        }
                    },
                    error: function(data) {
                        console.log("error: " + data);
                    }
                });
            });

            // 목록 이동 이벤트 처리
            moveToListBTN.addEventListener("click", function(e){
                console.log('moveToListBTN click');
                if(confirm('목록 화면으로 이동 하시겠습니까?') == false){
                    return;
                }
                </script>
                </head>
<body>
    <c:choose>
        <c:when test="${not empty list}">
            <c:forEach var="vo" items="${list}">
                <div class="chat-container">
                    <div class="chat-history">
                        <ul class="chat-messages">
                            <li class="message user-message">
                                <div class="name">${vo.sender}</div>
                                ${vo.contents}
                                <div class="time">${vo.sendDt}</div>
                            </li>
                            <li class="message bot-message">
                                <div class="name">${vo.receiver}</div>
                                ${vo.contents}
                                <div class="time">${vo.sendDt}</div>
                            </li>
                            <!-- 추가적인 메시지들을 여기에 추가할 수 있습니다. -->
                        </ul>
                    </div>
                </div>
            </c:forEach>
        </c:when>
    </c:choose>

    <div class="input-container">
        <input type="text">
        <button>전송</button>
    </div>
</body>
</html>