<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <link rel="stylesheet" href="css/notice.css" />
    <link rel="stylesheet" href="css/noticecss.css" />
    <link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
</head>
<body>
	<form method="get" action="/noticeWrite">
	    <div class="board_wrap">
	        <div class="board_title">	
	            <strong>공지사항</strong>
	            <p>공지사항을 빠르고 정확하게 안내해드립니다.</p>
	        </div>
	        
	        <div class="board_view_wrap">
	            <div class="board_view">
	                <div class="title">
	                    ${notice.title}
	                </div>
	                <div class="info">
	                    <dl>
	                        <dt>번호</dt>
	                        <dd>${notice.id}</dd>
	                    </dl>
	                    <dl>
	                        <dt>글쓴이</dt>
	                        <dd>${notice.title}</dd>
	                    </dl>
	                    <dl>
	                        <dt>작성일</dt>
	                        <dd>${notice.created_at}</dd>
	                    </dl>
	                    <dl>
	                        <dt>조회</dt>
	                        <dd>${notice.views}</dd>
	                    </dl>
	                </div>
	                <div class="cont">
	                	<c:if test="${not empty notice.image}">
					        <img src="image/${notice.image}" style="width: 50%;">
					    </c:if>
					    <br>
	                    <textarea cols="100" rows="5" style="border: none; resize: none; background-color: #f8f1e5; font-size: 20px;" readonly> ${notice.detail}</textarea>
	                </div>
	            </div>
	            <div class="bt_wrap">
	                <a href="/notice" class="on">목록</a>
	                <% 
					    if(session.getAttribute("admin") != null) { 
					%>
						<a href="/noticeUpdate?id=${notice.id}">수정</a>
						<a href="#" class="Del" data-id="${notice.id}">삭제</a>
					<% } %>
	                
	            </div>
	        </div>
	    </div>
	  </form>
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function(){
    
})
.on('click', '.Del', function() {
        if(confirm('정말로 삭제하겠습니까?')){
            let noticeid = $(this).data('id');
            console.log("id:", noticeid);
            $.ajax({
                type: 'post',
                url: '/delete',
                data: { id: noticeid },
                dataType: 'text',
                success: function(data){
                    if(data === '1') {
                        alert("삭제 성공");
                        location.href = '/notice';
                    } else {
                        alert("삭제 실패");
                    }
                }
            });
        }
    })
</script>
</html>