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
document.addEventListener("DOMContentLoaded",function(){
	const sender = '${sessionScope.user.email}';
};
</script>
</head>
${paramVO}
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
                                <div class="name">${vo.sender}</div>
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