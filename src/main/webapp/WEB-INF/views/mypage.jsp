<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
   <link rel="stylesheet" href="css/mypage.css" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
</head>
<style>

</style>
<body>
<input type=hidden id=hemailId value=${email }>
<input type=hidden id=hkakaoId value=${kakaoId }>
<input type=hidden id=hnaverId value=${naverId }>
<input type=hidden id=hpass value=${password }>
<input type=hidden id=hid value=${id }>
<input type=hidden id=jid value=${jjim }>

 <form>
     <input type="radio" name="tab" id="menu"/>
     <div class="container">
       <input type="radio" name="tab" checked="checked" id="home"/>
       <section class="home" >
           
         <div class=my01>
            <table>
               <tr>
               <td>
                  <h2>마이페이지입니다</h2>
               </td>
            </tr>
            <tr>          
               <td>
                  <h2>${email} 님안녕하세요</h2>
               </td>     
               </tr>
            
            </table>
            
              
         </div>
         <div>
          <img class=image src="image/mypage01.jpg" >
         </div>
       
         <label for="home"></label>
        
      
        </section>
   
       <input type="radio" name="tab" id="about"/>
       <section class="about">
       <br>
         <h1 >일정 등록하기</h1>
         <label for="about"></label>
         <br><br>
          <div class=my02>
             <table id=place01>
             
                <tr>
                   <td>
                      <a href="calendar">내 달력으로 가기</a>
                   </td>
                </tr>
                <tr>
                   <td>
                      <a href="vaccine">예방접종하러가기</a>
                   </td>
                </tr>
                <tr>
                   <td>
                         <a href="/">홈으로</a>
                   </td>
                </tr>
             </table>
          </div>
          <div>
             <img class="image04" src="image/vaccine03.jpg">
          </div>
       </section>
       <input type="radio" name="tab" id="work"/>
       <section class="work">
       <br>
         <h1>My History</h1>
         <label for="work"></label>
         <br><br>
         <div class=my03>
            <table style="margin-left:3.5%; margin-bottom:2%;">
               <tr>
                  <td>
                     <a href="myjjim">내 활동목록</a>
                  </td>
               </tr>
               <tr>
                  <td>
                     <a href="/adrequest">광고 문의하기</a>
                  </td>
               </tr>
            </table>
         </div>
         <div >
            <img class="image02"  style="width: 30%;height:auto; display: flex; justify-content: center; align-items: center; margin-left:7%; margin-bottom: 10%;" src="image/thumb.jpg">
         </div>
       </section>
       <input type="radio" name="tab" id="contact"/>
       <section class="contact">
       <br>
         <h1>개인정보</h1>
         <label for="contact"></label>
         <div class=my04>
            <table id=tbl04>
               <tr>
                  <td>
                     개인정보입니다
                  </td>
               </tr>
            </table>
         </div>
       
         <div class="container01">
           <span class="lock"></span>
        </div>
        
         <div>
            <img class="image05" src="image/mypage05.jpg">
         </div>        
       
      
       </section>
   
       
     </div>
     <div class="menu">
       <div>
         <label for="menu"></label>
         <label for="home"></label>
       </div>
     </div>
</form>

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
//개인정보 수정하기 리스트
$(document)
.ready(function(){
   updateMy();
   $('#tbl04').hide();
   lock();
   
})
.on("click","#btnGo",function(){
   lock();
})






function updateMy(){
   $('#tbl04').empty();
   $.ajax({
      type:"get",
      url:"/updateMy",
      data:{id:$('#hemailId').val()},
      dataType:'json',
      success:function(data){
         let str="";
         for(let i=0;i<data.length;i++){
            let ob=data[i]
            console.log(ob)
            let kakao = ob['kakaoId'];
            let naver = ob['naverId'];
            console.log(kakao);
            console.log(naver);
            if(kakao==null){
               kakao="빈 값";
            }
            
            console.log(kakao);
            if(naver==null){
               naver="빈 값";
            }
            str+='<tr><td>아이디번호: '+ob['id']+'</td></tr><tr><td>이메일주소: '+ob['email']+'</td></tr>'
         }
         $('#tbl04').append(str)
      }
   })
};


function lock(){
   let flag="on";
   $( ".lock" ).click(function() {
      if(flag=='on'){
        $(this).toggleClass('unlocked');
           setTimeout(function() {
             $('#tbl04').show();
                }, 500); // 2000 밀리초 (2초) 후에 새 창을 엽니다.
            flag='off'    
      } else if(flag=='off'){
         $(this).toggleClass('unlocked');
          console.log('되냐');
          setTimeout(function(){
             $('#tbl04').hide();
          },500);
         flag='on';
         
      }
   });
   $(".lock").show();
}




</script>

</html>