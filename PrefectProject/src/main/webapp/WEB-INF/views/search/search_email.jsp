<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>이메일 찾기</title>
</head>
<body>
    <div class="w3-content w3-container w3-margin-top">
        <div class="w3-container w3-card-4">
            <form action="../member/find_id.do" method="post">
                <div class="w3-center w3-large w3-margin-top">
                    <h3>이메일 찾기</h3>
                </div>
                <div>
                    <p>
                        <label>이름</label>
                        <input class="w3-input" type="text" id="name" name="name" required>
                    </p>
                     <p>
                        <label>전화번호</label>
                        <input class="w3-input" type="text" id="tel" name="tel" required>
                    </p>
                    <p class="w3-center">
                        <button type="submit" id=findBtn class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">이메일 확인</button>
                        <button type="button" onclick="history.go(-1);" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round">취소</button>
                    </p>
                </div>
            </form>
        </div>
    </div>
</body>
</html>