<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/itemList.css" />
<link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
<title>미니샵</title>
</head>
<body>

  <header id="herder">
      <%@ include file="include/header.jsp" %>
  </header>

  <main>
   
      <h1>애견용품</h1>
      <hr >
     <div id="middle_area">
     
       <div class="row" >           
           <c:forEach items="${itemList}" var="item">
            <input type="hidden" id="id" value=${item.id }>
               <div class="pet_item">     
                <a href="#" onclick="openPop(${item.id });">
                 <div style="text-align: center; padding: 30px;">
                   <div class=item_img >
                   <img style="width: 100%;  "src="/image/${item.img}" alt="상품이미지"/>  
                   </div>
                   <div>
                     <h4 >${item.title}</h4>
                     <fmt:formatNumber pattern="###,###" value="${item.price}" />원                 
                   </div>
                 </div>
                 </a>
            </div>
           </c:forEach>
       
       
      </div>

  </main>


</body>

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
   
})
.on('click','#buy',function(){
   openPop();
})
 function openPop(id){
  var popup = window.open('http://localhost:8081/goodorder?id='+id, '리뷰', 'width=700px,height=800px,scrollbars=yes');
 
}   

</script>

</html>