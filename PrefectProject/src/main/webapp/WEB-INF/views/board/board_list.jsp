<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.board.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/WEB-INF/cmn/header.jsp"/>
    <title>게시판 목록</title>
    <script>
        // JavaScript 코드가 추가될 부분
    </script>
</head>
<body>
    <div class="container">

        <!-- 제목 -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">게시목록</h1>
            </div>
        </div>
        <!--// 제목 ----------------------------------------------------------------->

        <!-- 검색 -->
        <form action="#" method="get" id="boardFrm" name="boardFrm">
            <input type="hidden" name="pageNo" id="pageNo">
            <div class="row g-1 justify-content-end">
                <label for="searchDiv" class="col-auto col-form-label">검색조건</label>
                <div class="col-auto">
                    <select id="searchDiv" name="searchDiv">
                        <option value="">전체</option>
                        <!-- 검색 조건 옵션을 동적으로 생성 -->
                        <c:forEach var="vo" items="${boardSearch}">
                            <option value="<c:out value='${vo.detCode}'/>"
                                <c:if test="${vo.detCode == paramVO.searchDiv }">selected</c:if>><c:out
                                    value="${vo.detName}" /></option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-auto">
                <!-- 페이지 크기 옵션을 동적으로 생성 -->
                <select class="form-select" id="pageSize" name="pageSize">
                    <c:forEach var="vo" items="${pageSize}">
                        <option value="<c:out value='${vo.detCode }' />"
                            <c:if test="${vo.detCode == paramVO.pageSize }">selected</c:if>><c:out
                                value='${vo.detName}' /></option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-auto">
                <!-- 버튼 열 -->
                <input type="button" value="목록" class="btn btn-primary" id="doRetrieve">
                <input type="button" value="등록" class="btn btn-primary" id="moveToReg">
            </div>
        </form>
        <!--// 검색 ----------------------------------------------------------------->

        <!-- 게시판 목록 테이블 -->
        <table class="table table-boardered border-primary table-hover table-striped" id="boardTable">
            <thead>
                <tr>
                    <!-- 테이블 헤더 -->
                    <th scope="col" class="text-center col-lg-1 col-sm-1">NO</th>
                    <th scope="col" class="text-center col-lg-7 col-sm-8">제목</th>
                    <th scope="col" class="text-center col-lg-2 col-sm-1">등록일</th>
                    <th scope="col" class="text-center col-lg-1">등록자</th>
                    <th scope="col" class="text-center col-lg-1">조회수</th>
                    <th scope="col" class="text-center" style="display: none;">SEQ</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty list }">
                        <!-- 게시글이 있을 경우 -->
                        <c:forEach var="vo" items="${list}" varStatus="status">
                            <!-- 각 행에 대한 반복문 -->
                            <tr>
                                <td class="text-center col-lg-1 col-sm-1"><c:out value="${vo.no}" escapeXml="true" /></td>
                                <td class="text-left col-lg-7 col-sm-8"><c:out value="${vo.title}" escapeXml="true" /></td>
                                <td class="text-center col-lg-2 col-sm-1"><c:out value="${vo.modDt}" escapeXml="true" /></td>
                                <td><c:out value="${vo.modId}" /></td>
                                <td class="text-end col-lg-1"><c:out value="${vo.readCnt}" /></td>
                                <td style="display: none;"><c:out value="${vo.seq}" /></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- 게시글이 없을 경우 -->
                        <tr>
                            <td colspan="99" class="text-center">조회된 데이터가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        <!--// table --------------------------------------------------------------> 

        <!-- 페이징 -->
        <div class="d-flex justify-content-center">
            <nav>${pageHtml}</nav>
        </div>
        <!--// 페이징 ---------------------------------------------------------------->

       
        <jsp:include page="/WEB-INF/cmn/footer.jsp"/>
    </div>
</body>
</html>
