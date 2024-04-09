<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link rel="stylesheet" href="css/login.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
	<link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
    <title>로그인</title>
    
    <script src="https://accounts.google.com/gsi/client" async defer></script>
  </head>

  <body>
    <div class="container" id="container">
      <div class="form-container sign-up">
        <form method="post" action="/dosignup">
		  <h1>회원가입</h1>
		  <br><br>
		  <input type="email" placeholder="Email" name="email" />
		  <input type="password" placeholder="Password" name="password" />
		  <input type="password" placeholder="PasswordCheck" name="PasswordCheck" />
		  <button onclick="submitForm()">회원가입</button>
		</form>
      </div>
      <div class="form-container sign-in">
        <form method="post" action="/dologin">
          <h1>로그인</h1>
          <div class="social-icons">
          <div id="g_id_onload"
			     data-client_id="api"
			     data-callback="handleCredentialResponse">
			</div>
          	  <a data-type="icon" data-shape="circle" class="g_id_signin"></a>
              <a href="javascript:kakaoLogin()" class="icon" style="margin-top: 20px;"><i class="xi-kakaotalk" style="font-size: 40px; margin-top: 5px;"></i></a>
              <a id="naver_id_login" class="icon"><i class="xi-naver" style="font-size: 30px;"></i></a>
          </div>
          <span>or use your email password</span>
          <input type="email" placeholder="Email" name="email"/>
          <input type="password" placeholder="Password" name="password"/>
          <a href="#">Forget Your Password?</a>
          <button type="submit">로그인</button>
        </form>
      </div>
      <div class="toggle-container">
        <div class="toggle">
          <div class="toggle-panel toggle-left">
            <h1>환영합니다!</h1>
            <p style="font-size: 12px;">사이트를 이용하시려면 회원가입을 하세요</p>
            <button class="hidden" id="login">로그인</button>
          </div>
          <div class="toggle-panel toggle-right">
            <h1>환영합니다!</h1>
            <p style="font-size: 12px;">사이트를 이용하시려면 회원가입을 하세요</p>
            <button class="hidden" id="register">회원가입</button>
          </div>
        </div>
      </div>
    </div>
    
  </body>
  <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.0/kakao.min.js" integrity="sha384-l+xbElFSnPZ2rOaPrU//2FF5B4LB8FiX5q4fXYTlfcG4PGpMkE1vcL7kNXI6Cci0" crossorigin="anonymous"></script>
  <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
  <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>



Kakao.init('api');

//카카오톡 로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
              let email = response.kakao_account.email ;
              let kakaoId = response.id;
              console.log("email:", email);
              console.log("kakaoId:", kakaoId);
              $.ajax({
					type : "post",
					url : '/kakaoLogin',
					data : {"kakaoId":kakaoId,
						    "email":response.kakao_account.email},
					dataType :"text",
					success : function(data){
						var referrer = document.referrer
						if(data=='1'){
							// 로그인
								
							 window.location.href=referrer;		    							
						} else {
							alert('카카오 회원가입 실패. 일반계정으로 로그인하시기 바랍니다.');
						}
					},
					error: function(request, status, error){
		                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		                }
				});
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
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

  // 아래는 데모를 위한 UI 코드입니다.
  function deleteCookie() {
    document.cookie = 'authorize-access-token=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
  }

// deleteCookie 함수 정의
function deleteCookie() {
    document.cookie = 'authorize-access-token=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

function kakaoLogout() {
	    Kakao.Auth.logout().then(function() {
	        // 카카오 로그아웃 성공 후 서버 측 로그아웃 요청
	        fetch('/logout')
	            .then(response => window.location.href = "/login")
	            .catch(error => console.error('Error:', error));
	    });
	}


const container = document.getElementById('container');
const registerBtn = document.getElementById('register');
const loginBtn = document.getElementById('login');

registerBtn.addEventListener('click', () => {
    container.classList.add("active");
});

loginBtn.addEventListener('click', () => {
    container.classList.remove("active");
});
</script>

<!-- -----------------------------네이버----------------------------- -->
 
<script type="text/javascript">

	var naver_id_login = new naver_id_login("api키 ", "http://localhost:8081/home");
	var state = naver_id_login.getUniqState();
	//naver_id_login.setButton("white", 2,40);
	naver_id_login.setDomain(".service.com");
	naver_id_login.setState(state);
	//naver_id_login.setPopup();
	naver_id_login.init_naver_id_login();
</script>

<script>
//구글 로그인 콜백 함수
function handleCredentialResponse(response) {
    // decodeJwtResponse() is a custom function defined by you
    // to decode the credential response.
    const responsePayload = parseJwt(response.credential);

    const email = responsePayload.email;
    const id = responsePayload.sub;

    $.ajax({
        type: "POST",
        url: "/googleLogin",
        data: { email: email, googleId: id },
        success: function(data) {
        	var referrer = document.referrer
            if (data === '1') {
                location.href = referrer;
            }
        },
        error: function(xhr, status, error) {
            console.error(xhr.responseText); // 에러 시 콘솔에 출력
        }
    });

    console.log(responsePayload);
    console.log("ID: " + responsePayload.sub);
    console.log('Full Name: ' + responsePayload.name);
    console.log('Given Name: ' + responsePayload.given_name);
    console.log('Family Name: ' + responsePayload.family_name);
    console.log("Image URL: " + responsePayload.picture);
    console.log("Email: " + responsePayload.email);
}

// JWT 토큰 디코딩 함수
function parseJwt(token) {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));

    return JSON.parse(jsonPayload);
}

</script>

</html>

