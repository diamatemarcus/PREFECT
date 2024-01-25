<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>


<c:forEach var="tmp" items="${clist}">
    <c:choose>
        <c:when test="${sessionScope.nick ne tmp.sender }">
        <div class="incoming_msg">
            <div class="received_msg">
                <p>${tmp.contents}</p>
                <span class="time_date">${tmp.sendDt}</span>
            </div>
        </div>
        </c:when>
        <c:otherwise>
            <div class="outgoing_msg">
                <div class="sent_msg">
                    <p>%{tmp.contents}</p>
                    <span class="time_date">${tmp.sendDt}</span>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</c:forEach>