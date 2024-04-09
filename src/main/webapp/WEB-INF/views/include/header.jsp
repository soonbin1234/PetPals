<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<style>
gowun-dodum-regular  {
	    font-family: "Gowun Dodum", sans-serif;
	    font-weight: bold;
	    font-style: normal;
	}
* {
   font-weight: bold;
    font-family: "Gowun Dodum", sans-serif;
}
ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    text-align: right; 
}

li {
    display: inline;
}

li a {
    display: inline-block;
    padding: 10px 20px;
    text-decoration: none;
    color: #B29079;
    font-size: 16px;
    transition: color 0.3s ease; /* 색상 변화에 대한 전환 효과 */
    font-family: "Gowun Dodum", sans-serif;
}

li a:hover {
    color: #634522; /* 마우스 호버 시 색상 변경 */
}


</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
</head>
<body>
     <div >         
          <div >
              <ul >
                  <li>
                      <c:choose>
						<c:when test="${not empty email}">
							<a href="/logout" style="color: #B29079;">logout</a>
						</c:when>
						<c:otherwise>
							<a href="/login" class="btn-11" style="color: #B29079;">login</a>
						</c:otherwise>
                	 </c:choose>
                  </li>
                  <li >
                      <a href="/" style="color: #B29079;">home</a>
                  </li>
                  <li >
                      <a href="/notice" style="color: #B29079;">notice</a>
                  </li>
                  <li>
                      <a href="/Qna" style="color: #B29079;">Q&A</a>
                  </li>
                  <c:if test="${not empty email}">
					<li>
						<a href="/mypage" style="color: #B29079;">mypage</a>
					</li>
					<li>
						<a href="/basket" style="color: #B29079;">장바구니</a>
					</li>
				  </c:if>
              </ul>
          </div>
     </div>
                

</body>
</html>