<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Websocket Tutorial</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no"/>
  <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'>
  <link rel="stylesheet" href="./css/style1.css">
  <link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
    

<style>

.showid{
opacity:0.3;
color:yellow;
}

</style>
</head>
<body>
<input type=hidden id=userid value=${email }>
<input type=hidden id=admin value=${admin }>
<header id="herder">
     <%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>
<div class="head01"> 
 <h1 >도그비앤비 채팅방</h1>
 <a href="/" style=color:#00491e>홈으로</a>
</div>
<div class="floating-chat expand enter">
   <b class="showid" id=showid style="font-size:20px">${email } 님 안녕하세요</b>
    <i class="fa fa-comments" aria-hidden="true"></i>
   
    <div class="chat">
        <div class="header">
            <span class="title">
                Chat or Cat
            </span>
        </div>
        <ul id="msgArea" class="messages">
        </ul>
        <div class="footer">
            <div id="opinion" class="text-box" contenteditable="true" disabled="true" onkeyup="enterkey()"></div>
        </div>
    </div>
  
</div>

<div>
  <video class="chatMovie01" autoplay loop  muted style="height: auto; width: auto;">
      <source src="image/chatMovie01.mp4"></source>
   
   </video>
</div>


<!-- partial -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js'></script><script  src="./js/script.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
   
   let q=setInterval(function(){

      $('#showid').fadeToggle();
      },3000)
})

</script>
<script type="text/javascript">
   let userid=$('#userid').val();
   console.log(userid)
   let admin=$('#admin').val();
   console.log(admin)
    const username = [[userid]];

    //아이피 변경하는 부분 
    const websocket = new WebSocket("ws://localhost:8081/ws/chat");
    websocket.onmessage = onMessage;
    websocket.onopen = onOpen;
    websocket.onclose = onClose;

    let isSeeing = true;
    document.addEventListener("visibilitychange", function() {
       
        console.log(document.visibilityState);
        if(document.visibilityState == "hidden"){
            isSeeing = false;
        }else{
            isSeeing = true;
        }
    });

    var newExcitingAlerts = (function () {
       
        var oldTitle = document.title;
        var msg = "★Message!★";
        var timeoutId;
        var blink = function() { document.title = document.title == msg ? ' ' : msg;
            if(isSeeing == true){
                clear();
            }
        };
        var clear = function() {
            clearInterval(timeoutId);
            document.title = oldTitle;
            window.onmousemove = null;
            timeoutId = null;
        };
        return function () {
            if (!timeoutId) {
                timeoutId = setInterval(blink, 1000);
            }
        };
    }());

    setInterval(() => console.log(new Date()), 10000); //prevent chrome refresh

    
    $(document).ready(function(){
        $(".floating-chat").click();

        $("#disconn").on("click", (e) => {
            disconnect();
        })

        $("#button-send").on("click", (e) => {
            send();
        });
    })

    function enterkey(){
        if (window.event.keyCode == 13) {
            send();
        }
    }
    function send(){
        console.log(username + ":" + $("#opinion").text());
        if($("#opinion").text() != ""){
            websocket.send(username + ":" + $("#opinion").text());
            $("#opinion").text('');
          
        }
     
    }

    function onClose(evt) {
        var str = username + ": 님이 방을 나가셨습니다.";
        websocket.send(str);
    }

    function onOpen(evt) {
       
        var str = username + ": 님이 입장하셨습니다.";
        websocket.send(str);
    }

    //메세지 도착시에 알람뜨는곳
    function onMessage(msg) {
//        alert('메세지도착')
//        alert('맞지여기')
        var data = msg.data;
        var sessionId = null;
        var message = null;
        var arr = data.split(":");

        for(var i=0; i<arr.length; i++){
            console.log('arr[' + i + ']: ' + arr[i]);
        }

        var cur_session = username;

        console.log("cur_session : " + cur_session);


        sessionId = arr[0];
        message = arr[1];

        console.log("sessionID : " + sessionId);
        console.log("cur_session : " + cur_session);


        if(message == " 님이 입장하셨습니다."){
            message = sessionId + "님이 입장하셨습니다.";
        }
        if(message == undefined){
            message = "채팅이 종료되었습니다.";
        }
        if(sessionId == cur_session){
            var str = "<li class='other'>";
            str += message;
            str += "</li>";
            $("#msgArea").append(str);
        }
        else{
            var str = "<li class='self'>";
            str += message;
            str += "</li>";
            $("#msgArea").append(str);

            if(isSeeing == false){
                newExcitingAlerts();
            }
        }

        document.getElementById("msgArea").scrollTop = document.getElementById("msgArea").scrollHeight;
        
        
        if($('#userid').val()==sessionId){
           return ; 
           
        }else{
            //알람 띄우기 ajax;
           Notification.requestPermission();
              var permission = Notification.requestPermission();
              console.log(permission)
              //알림 권한 요청
                  function getNotificationPermission() {
                      // 브라우저 지원 여부 체크
                      if (!("Notification" in window)) {
                          alert("데스크톱 알림을 지원하지 않는 브라우저입니다.");
                      }
                      // 데스크탑 알림 권한 요청
                      Notification.requestPermission(function (result) {
                          // 권한 거절
                          if(result == 'denied') {
                              Notification.requestPermission();
                              alert('알림을 차단하셨습니다.\n브라우저의 사이트 설정에서 변경하실 수 있습니다.');
                              return false;
                          }
                          else if (result == 'granted'){
                              alert('알림을 허용하셨습니다.');
                          }
                      });
                  }
                  
              new Notification("메세지도착.",{body:'메세지가 왔서!.'});
       
           // 알림 띄우기
           function notify(msg) {
              var options = {
                 body: msg
              }        
              // 데스크탑 알림 요청    
              var notification = new Notification("DororongJu", options);        
              // 3초뒤 알람 닫기    
              setTimeout(function(){ 
                 console.log('1');       
                 notification.close();    
                 console.log('1');
                 }, 3000);
              console.log('2');
           }
            
           
        }

        
    }
</script>
<script>
var element = $('.floating-chat');
var myStorage = localStorage;

if (!myStorage.getItem('chatID')) {
    myStorage.setItem('chatID', createUUID());
}

setTimeout(function() {
    element.addClass('enter');
}, 1000);

element.click(openElement);

function openElement() {
    var messages = element.find('.messages');
    var textInput = element.find('.text-box');
    element.find('>i').hide();
    element.addClass('expand');
    element.find('.chat').addClass('enter');
    var strLength = textInput.val().length * 2;
    textInput.keydown(onMetaAndEnter).prop("disabled", false).focus();
    element.off('click', openElement);
    element.find('.header button').click(closeElement);
    element.find('#sendMessage').click(sendNewMessage);
    messages.scrollTop(messages.prop("scrollHeight"));
}

function closeElement() {
    element.find('.chat').removeClass('enter').hide();
    element.find('>i').show();
    element.removeClass('expand');
    element.find('.header button').off('click', closeElement);
    element.find('#sendMessage').off('click', sendNewMessage);
    element.find('.text-box').off('keydown', onMetaAndEnter).prop("disabled", true).blur();
    setTimeout(function() {
        element.find('.chat').removeClass('enter').show()
        element.click(openElement);
    }, 500);
}

function createUUID() {
    // http://www.ietf.org/rfc/rfc4122.txt
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";

    var uuid = s.join("");
    return uuid;
}

function sendNewMessage() {
    var userInput = $('.text-box');
    var newMessage = userInput.html().replace(/\<div\>|\<br.*?\>/ig, '\n').replace(/\<\/div\>/g, '').trim().replace(/\n/g, '<br>');

    if (!newMessage) return;

    var messagesContainer = $('.messages');

    messagesContainer.append([
        '<li class="self">',
        newMessage,
        '</li>'
    ].join(''));

    // clean out old message
    userInput.html('');
    // focus on input
    userInput.focus();

    messagesContainer.finish().animate({
        scrollTop: messagesContainer.prop("scrollHeight")
    }, 250);
}


function onMetaAndEnter(event) {
    if ((event.metaKey || event.ctrlKey) && event.keyCode == 13) {
        sendNewMessage();
    }
}
</script>

<style>
    .text-box div:nth-child(n+1) {
        display: none;
    }
</style>
</html>