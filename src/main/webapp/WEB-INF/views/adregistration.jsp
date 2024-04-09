<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/adrequest.css" />
    <link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
</head>
<script src="https://js.tosspayments.com/v1"></script>
<body>

<form method="post" action="adsave" enctype="multipart/form-data">
<div class="board_wrap" >
        <div class="board_title">
<input type=hidden name=userid value="${email }">        
            <strong>광고문의-등록</strong>
            <p>우리 홈페이지는 사진 광고만을 사용하고 있습니다</p>
        </div>
        <div class="board_write_wrap">
            <div class="board_write">

                <div class="info">
                    <dl>
                        <dt>주의사항</dt>
                    </dl>
                    <dl>
                        <dt>파일 추가</dt>
                        <dd><input type="file" name='file' id="image"></dd>
                        
                    </dl>
                </div>
                <div class="cont">
               <ul style="font-size:20px;">
                  <li>1.사진의 크기는 모두 자동적으로 가로 200px 세로 300px로 변환되어 사이트에 나타나게됩니다. </li>
                  <li>2.결제는 최소 1달단위부터 시작되며 결제한 기간내에서는 광고 이미지를 변경이 가능하나 추가비용이 들수도 있습니다 </li>
               </ul>
                </div>
                <div class="pay">
                   <dl>
                      <dt>사이트 url</dt>
                   </dl>
                   <dl>
                      <dt>
                     <input name=url style="width:400px;">                        
                      </dt>
                      
                   </dl>   
                </div>
            </div>
            <div class="bt_wrap">
               <input class="on1" type="submit" id="notice" value="광고등록">
                <a href="/notice">취소</a>
            </div>
        </div>
    </div>
</form>
</body>
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script> 
$(document).ready(function(){
      let userid = $("#userid").val();
  
 })

   
</script>
</html>