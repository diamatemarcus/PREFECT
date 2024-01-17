<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="/ehr/favicon.ico">
<style >
/* Reset */
html,body,h1,h2,h3,h4,h5,h6,div,p,blockquote,pre,code,address,ul,ol,li,nav,section,article,header,footer,main,aside,dl,dt,dd,table,thead,tbody,tfoot,label,caption,th,td,form,fieldset,legend,hr,input,button,textarea,object,figure,figcaption {margin:0;padding:0;}
body,input,select,textarea,button,img,fieldset {border:none;}
ul,ol,li{list-style:none;}
table{width:100%;border-spacing:0;border-collapse:collapse;}
address,cite,code,em,i{font-style:normal;font-weight:normal;}
label,img,input,select,textarea,button,a {vertical-align:middle;}
u,ins,a{text-decoration:none;}
button { cursor: pointer;}

@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');
body{
    
    font-family: 'Nanum Gothic', sans-serif;
    border: 1px solid #000;
}
a {
    text-decoration: none;
    color: white;
}
header {
  height: 50px; 
  background-color : #005b9f;
  line-height: 50px;  /*line-height은 CSS 속성 중 하나로, 텍스트 줄 내의 높이를 설정하는 데 사용됩니다. 이 속성은 텍스트의 수직 정렬 및 텍스트 줄 간격을 제어하는 데에 영향을 미칩니다.*/
}

footer {
  height: 40px; 
  background-color : #616161;
  line-height: 40px; 
  color: white;
  text-align: center;
  font-size: 12px;
}

/* header,
nav,
article,
footer,
aside{
    border: 1px solid #ccc;
} */


.content_wrap {
    display: flex; /*  Flex Container */
    flex-direction: row; /*Flex Container 내의 자식 요소들을 수평 방향으로 배치합니다. */
    min-height: calc(100vh - 30vh);/*요소의 최소 높이를 설정합니다. 100vh는 뷰포트 높이(브라우저 화면의 100% 높이)를 나타냅니다. */
}
    
article{
   width: 75%;
}
aside{
  width: 25%;
}    

.navbar{
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 8px 12px;
    background-color: #243342;
}

.navbar__menu {
    display: flex;
    list-style: none;
    padding-left: 0;    
}

.navbar__menu li{
  padding: 8px 12px;
}
.navbar__icons li {
    padding: 8px 12px;
}
/*menu에 마우스 오버*/
.navbar__menu li:hover{
  background: #d26060;
  border-radius: 4px;
}

.navbar__icons{
    list-style: none;
    color: #ffffff;
    display: flex;
    padding-left: 0;
}

.navbar__logo{
    font-size: 25px;
    color: white;   
}


</style>
<title>layout</title>
<script src="/ehr/resources/js/jquery-3.7.1.js"></script>
<script src="/ehr/resources/js/eUtil.js"></script>
<script src="https://kit.fontawesome.com/2cd03604af.js" crossorigin="anonymous"></script>

</head>
<body>
    <header>
	    <div class="navbar__logo">
	      <i class="fab fa-accusoft"></i>
	      <a href="#">PCWK</a>
	    </div> 
    </header>
    <nav class="navbar">
	   <ul class="navbar__menu">
	      <li ><a href="#">Home</a></li>
	      <li ><a href="#">User</a></li>
	      <li ><a href="#">FAQ</a></li>
	      <li ><a href="#">Board</a></li>
	      <li ><a href="#">MyPage</a></li>
	    </ul>
	    <ul class="navbar__icons">
	      <li><i class="fab fa-twitter"></i></li>
	      <li><i class="fab fa-facebook-f"></i></li>
	    </ul>
    </nav>
    <div class="content_wrap">
        <article>article</article>
        <aside>aside</aside>
    </div>
    <footer>&copy; 2023 PCWK웹 페이지. All rights reserved.</footer>
</body>
</html>