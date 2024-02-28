<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}" />     
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<title>naver검색</title>
<script>
document.addEventListener("DOMContentLoaded", function() {
    console.log("DOMContentLoaded");
    // doRetrieve
    const doRetrieveBTN = document.querySelector("#doRetrieve");
    const searchDivSelect = document.querySelector("#searchDiv");

    // blog,news,... table view 제어
    $("#bookTable").css("display");

    searchDivSelect.addEventListener("change", function(e) {
        console.log("searchDivSelect change:");

        $("#bookTable").css("display", "none");

        let selectValue = searchDivSelect.value;
        console.log("selectValue change:" + selectValue);

        if (10 == selectValue) { // blog
            $("#bookTable").css("display", "");
        }
    });

    doRetrieveBTN.addEventListener("click", function(e) {
        console.log("doRetrieveBTN click:");

        // 검색어 필수 처리
        const searchWordValue = document.querySelector("#searchWord").value;
        if (eUtil.isEmpty(searchWordValue) == true) {
            alert("검색어를 입력 하세요.");
            document.querySelector("#searchWord").focus();
            return;
        }

        console.log("searchDiv:" + document.querySelector("#searchDiv").value);

        $.ajax({
            type: "GET",
            url: "/ehr/book/doRetrieve.do",
            asyn: "true",
            dataType: "json",
            data: {
                "pageNo": "1",
                "searchDiv": document.querySelector("#searchDiv").value,
                "searchWord": document.querySelector("#searchWord").value
            },
            success: function(data) { // 통신 성공
                console.log("data.items:" + data.items);
                console.log("data.items.length:" + data.items.length);

                let htmlData = "";
                let selectValue = searchDivSelect.value;
                console.log("selectValue change:" + selectValue);

                if (null != data && data.items.length > 0) {

                    // 기존 데이터 삭제
                    // $("#blogTable>tbody").empty();
                    document.querySelector("#bookTable>tbody").innerHTML = "";

                    if (10 == selectValue) { // blog
                        data.items.forEach(function(item, idx) {
                            console.log(idx, item.title, item.link);
                            let i = idx + 1;
                            htmlData += "<tr>";
                            htmlData += "<td class='text-center'>" + i + "</td>";
                            htmlData += "<td class='text-left'><a href='" + item.link + "'>" + item.title + "</a></td>";
                            htmlData += "<td class='text-left'>" + item.author + "</td>";
                            htmlData += "<td class='text-center'>" + item.pubdate + "</td>";
                            htmlData += "</tr>\n";
                        });

                        $("#blogTable>tbody").append(htmlData);
                    }
                    document.querySelector("#bookTable>tbody").innerHTML = htmlData;

                }

                // table에 추가

            },
            error: function(data) { // 실패시 처리
                console.log("error:" + data);
            },
            complete: function(data) { // 성공/실패와 관계없이 수행!
                console.log("complete:" + data);
            }
        });
    });
    
    /* 페이징 로직 */
    
    
}); //--DOMContentLoaded end
</script>
</head>
<body>
	<!-- Spinner Start -->
    <div id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->
    

    <div class="container">
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
        <br>
        <br>
            <h2 class="page-header" style="text-align: center;">도서 검색</h2>
        </div>
    </div>    
    <br>
    <br>      
    <!--// 제목 ----------------------------------------------------------------->    
	<div class="col-auto"> 
	    <select class="form-select form-select-sm" id="pageSize" name="pageSize" style="width: auto;"> <!-- 너비 조정 및 크기 축소를 위한 form-select-sm 클래스 추가 -->
	        <c:forEach var="vo" items="${pageSize }">
	            <option value="<c:out value='${vo.detCode }' />"><c:out value='${vo.detName}' /></option>
	        </c:forEach>
	    </select>  
	</div>
   <br>
    <!-- book -->
    <table class="table table-bordered border-primary table-hover table-striped" id="bookTable">
      <thead>
        <tr >
          <th scope="col" class="text-center col-lg-1">NO</th>
          <th scope="col" class="text-center col-lg-4">책 제목</th>
          <th scope="col" class="text-center col-lg-2">저자</th>
          <th scope="col" class="text-center col-lg-1">출간일</th>
        </tr>
      </thead>     
      <tbody>
      </tbody>
    </table>

    
    <!--// book --------------------------------------------------------------->
    <form action="#" method="get" id="boardFrm" name="boardFrm">
        <input type="hidden" name="pageNo" id="pageNo" />
        <div class="row g-1 justify-content-end ">
          <div class="col-auto">
              <select class="form-select pcwk_select" id="searchDiv" name="searchDiv">
                     <c:forEach var="vo" items="${bookSearch }">
                        <option value="<c:out value='${vo.detCode}'/>"  ><c:out value="${vo.detName}"/></option>
                     </c:forEach>
              </select>
          </div>  
          <div class="col-auto">
               <input type="text" class="form-control" id="searchWord" name="searchWord" maxlength="100" placeholder="검색어를 입력 하세요">
          </div> 
         
          <div class="col-auto "> <!-- 열의 너비를 내용에 따라 자동으로 설정 -->
               <input type="button" value="검색" class="btn btn-primary"  id="doRetrieve">  
          </div>        
        </div>
    </form>

    
     <jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>
</body>
</html>
