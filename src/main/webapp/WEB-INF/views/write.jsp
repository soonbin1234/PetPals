<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성하기</title>
<link href="/css/write.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
</head>



<body>
<input type=hidden id=userid value=${email }>
<div id="container">

    <main id="main">
     <div id="mainContent"> 
     
 
<div class="layout" id='data_div'>
      <label>작성하기</label>
      <input type="hidden" id="idDisplay">
      <input type="text" id="title"  placeholder="제목">
    <input type="text" id="writer"  placeholder="작성자" readonly>
    <textarea id="content" placeholder="내용"></textarea>
    
    <button id="do_write" >Qna등록하기</button>
    <button id="clear" >취소하기</button>
</div>
</div>


</body>


<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>
$(document)
.ready(function(){
   getIdFromURL();
   displayId();
   
   if($('#idDisplay').val() != ''){
      roda(); 
   }
   
   let userid=$('#userid').val()
   let id=userid.split("@")
   $('#writer').val(id[0])
})
$("#do_write").on('click',function(){
   if($('#title').val() == "" || $('#content').val()==""){
      alert("빈 칸에 값을 입력해주세요.");
   }else{
   $.ajax({
      type: 'post', 
        url: '/addQna',
        data: {title:$('#title').val(),writer:$('#writer').val(), 
             content:$('#content').val(),
             userId: $('#userid').val()}, 
        dataType: 'text',
        success: function(data) {
           if(data==1){
               alert('성공');
              window.close();
               window.opener.showList();
              /*  window.opener.showpage();  */
           }

           }
       })
   }
});
$("#clear").on('click',function(){
   $('#content,title').val('');
})
function getIdFromURL() { // URL에서 id 값을 가져오는 함수
   const urlParams = new URLSearchParams(window.location.search);
   return urlParams.get('id');
}

function displayId() {
   const id = getIdFromURL();
   $('#idDisplay').val(id);
}
function roda(){
   console.log($('#idDisplay').val());
   $.ajax({
      type: 'post', 
        url: '/reLoad',
        data: {idDisplay:$('#idDisplay').val()}, 
        dataType: 'json',
        success: function(data) {
           $('#content').text(data.content);
        }
   });
}

</script>
</body>
</html>