<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>도그비앤비</title>
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
    <link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/hung1001/font-awesome-pro@4cac1a6/css/all.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fittext/1.2.0/jquery.fittext.min.js"></script>
    
    
    
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="70">
    
    <section class="home svg_shape bg_image" id="home" style="background-image: url(image/배경.png)">
        
        <div class="full_height">
            
            <nav class="navbar navbar-default nav_scroll navbar-fixed-top">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                            data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>

                        <!-- LOGO -->
                        <a class="navbar-brand" href="/popupContent" style="color: #B29079;">petB&B</a>
                        
                    </div>
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav navbar-right">
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
                                <a href="/notice" style="color: #B29079;">notice</a>
                            </li>
                            <li>
                                <a href="/Qna" style="color: #B29079;">Q&A</a>
                            </li>
                            <li >
                                <a href="/calendar" style="color: #B29079;">Calendar</a>
                            </li>
                     
                     <c:if test="${not empty email}">
                            <li>
                                <a href="/mypage" style="color: #B29079;">mypage</a>
                            </li>
                            </c:if>
                            
                            <li style="margin-bottom: 10px;"> 
                                <form method="get" action="search">
                                    <div class="search">
                                        <input type="text" name="search" />
                                        <div class="material-icons"><i class="fas fa-search"></i></div>
                                    </div>
                                </form>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <div class="navigation" style="margin-top: 100px;">
                   
                    <a class="frame-btn" href="store?text=반려동물용품">
                  <span class="frame-btn__outline frame-btn__outline--tall">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__outline frame-btn__outline--flat">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__solid"></span>
                  <span class="frame-btn__text">애견용품점</span>
               </a>  

               <a class="frame-btn" href="store?text=동물병원">
                  <span class="frame-btn__outline frame-btn__outline--tall">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__outline frame-btn__outline--flat">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__solid"></span>
                  <span class="frame-btn__text">동물병원</span>
               </a>  

               <a class="frame-btn" href="store?text=동물약국">
                  <span class="frame-btn__outline frame-btn__outline--tall">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__outline frame-btn__outline--flat">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__solid"></span>
                  <span class="frame-btn__text">동물약국</span>
               </a>  

               <a class="frame-btn" href="store?text=식당,카페,문예회관">
                  <span class="frame-btn__outline frame-btn__outline--tall">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__outline frame-btn__outline--flat">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__solid"></span>
                  <span class="frame-btn__text">문화시설</span>
               </a>  
               
               <a class="frame-btn" href="store?text=펜션">
                  <span class="frame-btn__outline frame-btn__outline--tall">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__outline frame-btn__outline--flat">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__solid"></span>
                  <span class="frame-btn__text">숙박시설</span>
               </a>  
               
               <a class="frame-btn" href="/itemList">
                  <span class="frame-btn__outline frame-btn__outline--tall">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__outline frame-btn__outline--flat">
                     <span class="frame-btn__line frame-btn__line--tall"></span>
                     <span class="frame-btn__line frame-btn__line--flat"></span>
                  </span>
                  <span class="frame-btn__solid"></span>
                  <span class="frame-btn__text">미니숍</span>
               </a> 
            </div>
            </nav>
            
            <div class="display-table">
                <div class="display-table-cell">
                    <div class="container">
                        <h3>
                        <c:choose>
                      <c:when test="${not empty email}">
                             
                          <p>${email}님 환영합니다.</p>
                      </c:when>
                  </c:choose>
                        <h1 class="cd-headline letters rotate-2 is-full-width">
                            <span class="cd-words-wrapper">
                                <b class="is-visible">반려동물</b>
                                <b>서비스 이용하기</b>
                                <b>도그비앤비입니다</b>
                            </span>
                        </h1>
                    </div>
                </div>
            </div>
            <div class="container go_down_container">
                <div class="go_down">
                    <a href="#about" class="smooth_scroll">
                        
                    </a>
                </div>
            </div>
        </div>
        <div class="floating-button">
           <span class="move-myWebSite">
              <a class="myWebSite-btn" href="/chattingRoom"></a>
           </span>
        </div>
    </section>
    
</body>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.0/kakao.min.js"
  integrity="sha384-l+xbElFSnPZ2rOaPrU//2FF5B4LB8FiX5q4fXYTlfcG4PGpMkE1vcL7kNXI6Cci0" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.isotope/3.0.6/isotope.pkgd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.bundle.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/animateHeader.js"></script>
<script src="js/custom.js"></script>   

   
<script>

const searchEl = document.querySelector('.search')
const searchInputEl = searchEl.querySelector('input')

searchEl.addEventListener('click',function(){
  searchInputEl.focus();
})

searchInputEl.addEventListener('focus', function(){
  searchEl.classList.add('focused')
  searchInputEl.setAttribute('placeholder','통합검색')
})

searchInputEl.addEventListener('blur', function(){
  searchEl.classList.remove('focused')
  searchInputEl.setAttribute('placeholder','')
})

window.addEventListener('pageshow', function(event) {
        if (event.persisted) {
            searchInputEl.value = '';
            document.cookie = 'search=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
        }
    });
Kakao.init('api');

//카카오로그아웃  
function kakaoLogout() {
    if (!Kakao.Auth.getAccessToken()) {
      alert('로그인을 해주세요.');
      return
    }
    Kakao.Auth.logout(function() {
        // 카카오 로그아웃 성공 후 서버 측 로그아웃 요청
        fetch('/logout')
            .then(response => window.location.reload()) // 페이지 새로고침
            .catch(error => console.error('Error:', error));
    });
}

//카카오톡 탈퇴
function unlinkApp() {
    Kakao.API.request({
        url: '/v1/user/unlink',
    })
    .then(function(res) {
        alert('success: ' + JSON.stringify(res));
        deleteCookie();
    })
    .catch(function(err) {
        alert('fail: ' + JSON.stringify(err));
    });
}



// deleteCookie 함수 정의
function deleteCookie() {
    document.cookie = 'authorize-access-token=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}
</script>

<!-- 네이버아디디로로그인 초기화 Script -->
<script type="text/javascript">
   var naver_id_login = new naver_id_login("네이버 api 키", "http://localhost:8081/home");
   var state = naver_id_login.getUniqState();
   naver_id_login.setDomain(".service.com");
   naver_id_login.setState(state);

</script>
<script type="text/javascript">
   // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
   function naverSignInCallback() {
       naver_id_login.getProfileData('프로필항목명');
       let email = naver_id_login.getProfileData('email');
       let nickname = naver_id_login.getProfileData('nickname');
       let id = naver_id_login.getProfileData('id'); // 수정된 부분: 변수 이름을 id로 변경
       console.log(email);
       console.log(nickname);
       console.log(id);
       // Ajax 요청으로 이메일 정보를 컨트롤러로 전송
       $.ajax({
           type: "POST",
           url: "/naverLogin",
           data: { email: email, naverId: id },
           success: function(data) {
              var referrer = document.referrer
               if(data === '1'){
                  window.location.href = referrer;
               }
           },
           error: function(xhr, status, error) {
               console.error(xhr.responseText); // 에러 시 콘솔에 출력
           }
       });
   }
   
   // 네이버 사용자 프로필 조회
   naver_id_login.get_naver_userprofile("naverSignInCallback()");       
   
</script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$()

.ready(function(){
   

   notify(msg);
   console.log(notify)
   
})
   
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
       
   new Notification("환영합니다.",{body:'저희 홈페이지에 와주셔서 감사합니다.'});

// 알림 띄우기
function notify(msg) {
   var options = {
      body: msg
   }        
   // 데스크탑 알림 요청    
   var notification = new Notification("DororongJu", options);        
   // 3초뒤 알람 닫기    
   setTimeout(function(){        
      notification.close();    
      }, 3000);
}
</script>
</html>
