<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>공지사항</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
      <link rel="stylesheet" href="css/notice.css" />
    <link rel="stylesheet" href="css/noticecss.css" />
    <link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
    <!-- 다크 모드 스타일 -->
<style>

</style>
</head>
<body>
 <header id="herder">
     <%@ include file="include/header.jsp" %>
</header>

<input type="hidden" id="hpage" value="${page}">
<input type="hidden" id="hlastpage" value="${lastpage}">
<input type="hidden" id=userid value="${email }">
<!-- 다크 모드 토글 버튼 -->
<button class="toggle-btn" onclick="toggleDarkMode()">다크 모드 <span id="darkModeStatus">${darkMode ? '끄기' : '켜기'}</span></button>

<div class="board_wrap">
    <div class="board_title">
        <strong>공지사항</strong>
        <p>공지사항을 빠르고 정확하게 안내해드립니다.</p>
    </div>
    <div class="board_list_wrap">
        <div class="board_list" id=noticelist>
            <div class="top">
                <div class="num">번호</div>
                <div class="title">제목</div>
                <div class="writer">글쓴이</div>
                <div class="date">작성일</div>
                <div class="count">조회</div>
            </div >
            
        </div>
        <div class="board_page">
            <a href="#" id="first" class="bt first"><<</a>
            <a href="#" id="prev" class="bt prev"><</a>
            <c:forEach var="num" items="${showpage}">
                <a href="/notice?page=${num}" class="num">${num}</a>
            </c:forEach>
            <a href="#" id="next" class="bt next">></a>
            <a href="#" id="last" class="bt last">>></a>
        </div>
        <div class="bt_wrap">
            <a href="home" class="on">홈으로</a>
            <% 
             if(session.getAttribute("admin") != null) { 
         %>
             <a href="/noticeWrite">공지사항 등록</a>
         <% } %>
        </div>
    </div>
</div>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
   // 공지사항 리스트 가져오기
   $.ajax({
      type:'get',
      url:'/noticelist',
      data:{email:$('#userid').val(),page:$('#hpage').val()},
      dataType:'json',
      success:function(data){
         for(let i=0;i<data.length;i++){
            let ob=data[i]
            let logid=ob.email.split("@")
            let str='<div><div class="num">'+ob.id+'</div><div class="title"><a href="/noticeView?id='+ob.id+'" target="_self">'+ob.title+'</a></div><div class="writer">'+logid[0]+'</div><div class="date">'+ob.created_at+'</div><div class="count">'+ob.views+'</div></div>'
            console.log(str)
            $('#noticelist').append(str)
         }
      }
      
   })
    // 이전 페이지 버튼 숨기기 처리
    if($('#hpage').val() == 1){
        $('#prev').hide();
    }
    // 다음 페이지 버튼 숨기기 처리
    if($('#hpage').val() == $('#hlastpage').val()){
        $('#next').hide();
    }
})


.on('click', '#prev', function(){
    // 이전 페이지로 이동
    let num = $('#hpage').val();
    let page = num - 1;
    location.href = "/notice?page=" + page;
})
.on('click', '#next', function(){
    // 다음 페이지로 이동
    let num = parseInt($('#hpage').val());
    console.log(num)
    let page = num + 1;
    location.href = "/notice?page=" + page;
})
.on('click', '#first', function(){
    // 첫 페이지로 이동
    let num = 1;
    location.href = "/notice?page=" + num;
})
.on('click', '#last', function(){
    // 마지막 페이지로 이동
    let num = parseInt($('#hlastpage').val());
    location.href = "/notice?page=" + num;
});

// 다크 모드 토글 함수
function toggleDarkMode() {
    const body = document.body;
    const darkMode = body.classList.toggle('dark-mode');
    localStorage.setItem('darkMode', darkMode ? 'enabled' : 'disabled');
    document.getElementById('darkModeStatus').innerText = darkMode ? '끄기' : '켜기';
}
// 페이지 로드 시 다크 모드 적용
const darkMode = localStorage.getItem('darkMode') === 'enabled';
if (darkMode) {
    document.body.classList.add('dark-mode');
}
</script>
</html>
