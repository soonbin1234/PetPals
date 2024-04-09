<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>petB&B</title>
<link rel="stylesheet" href="/css/popupContent.css">
<link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
<script language="JavaScript">
        function setCookie( name, value, expiredays ) {
            var todayDate = new Date();
            todayDate.setDate( todayDate.getDate() + expiredays ); 
            document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
        }
        function closePop() {
            if ( document.pop_form.chkbox.checked ){
                setCookie( "maindiv", "done" , 1 );
            }
            document.all['layer_popup'].style.visibility = "hidden";
        }
</script>
</head>

<body>
	<jsp:include page="/WEB-INF/views/home.jsp" />
	<div class="layerPopup" id="layer_popup" style="visibility: visible;">
    <div class="layerBox">
        <h4 class="title">petB&B 공지사항</h4>
        <div class="cont">
            <p>
				<img src="./image/공지사항.jpg" style= "width=350 height=500" usemap="#popup" alt="event page">
            </p>
        </div>
          <form name="pop_form">
        <div id="check" ><input type="checkbox" name="chkbox" value="checkbox" id='chkbox' >
        <label for="chkbox">&nbsp&nbsp오늘 하루동안 보지 않기</label></div>
		<div id="close" ><a href="javascript:closePop();">닫기</a></div>    
		</form>
	</div>
</div>

</body>
<script src='http://code.jquery.com/jquery-latest.js'></script>

 <script language="Javascript">
    cookiedata = document.cookie;   
    if ( cookiedata.indexOf("maindiv=done") < 0 ){     
        document.all['layer_popup'].style.visibility = "visible";
    }
    else {
        document.all['layer_popup'].style.visibility = "hidden";
    }
</script>
</html>