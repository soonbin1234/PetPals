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
<input type=hidden id=userid value="${email }">
<input type=hidden id=advertiser value="${advertiser }">
<div class="board_wrap" >
        <div class="board_title">
            <strong>광고문의</strong>
            <p>우리 홈페이지는 사진 광고만을 사용하고 있습니다</p>
        </div>
        <div class="board_write_wrap">
            <div class="board_write">

                <div class="info">
                    <dl>
                        <dt>주의사항</dt>
                    </dl>
                    <dl>
                        <dt ><button class=mybtn disabled id=btngo>광고 등록하기</button></dt>
                    </dl>
                </div>
                <div class="cont">
               <ul style="font-size:20px;">
                  <li>1.사진의 크기는 모두 자동적으로 가로 200px 세로 300px로 변환되어 사이트에 나타나게됩니다. </li>
                  <li>2.결제는 최소 1달단위부터 시작되며 결제한 기간내에서는 광고 이미지를 변경이 가능하나 추가비용이 들수도 있습니다 </li>
                  <li>3.가격은 1달당 10만원입니다 </li>
               </ul>
                </div>
                <div class="pay">
                   <dl>
                      <dt>결제기간</dt>
                   </dl>
                   <dl>
                      <dt>
                         <input type="radio" name="months" value="1" class="month">1개월
                         <input type="radio" name="months" value="3" class="month">3개월
                         <input type="radio" name="months" value="6" class="month">6개월
                         <input type="radio" name="months" value="9" class="month">9개월
                         <input type="radio" name="months" value="12" class="month">1년
                         
                      </dt>
                      
                   </dl>   
                </div>
                <div class="money">
                   <dl>
                      <dt>총금액</dt>
                   </dl>
                   <dl>
                      <dt><input id="money" readonly>원   </dt>
                   </dl>
                </div>
            </div>
            <div class="bt_wrap">
               <button class="on1" id=payment>결제하기</button>
                <a href="/notice">취소</a>
            </div>
        </div>
    </div>

</body>
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script> 
$(document).ready(function(){
      let userid = $("#userid").val();
     let ad=$('#advertiser').val();
     console.log("ad="+ad)
     if(ad==1){
        $('#btngo').prop("disabled", false)
     }
     
 })
 .on('click','#btngo',function(){
   location.href="/adregistration" 
 })
.on('click','.month',function(){

   let money=$(this).val()*100000
   $('#money').val(money)
   $('#etc').hide()
})

   //세션 정의
    $(document).on('click', '#payment', function(){
     pay();
  })
   
   //가격 표시
   function totalPrice() {
       $('#selectedPrice').text($('#money').val());

       window.amount = $('#money').val();
   }
   
   //제품 이름
   function TitleName(){
       let productNames = $('input[name=months]:checked').val();
      
       return productNames;
   }
   
   
   // 유저id
   function useridName() {
    
       return $('#userid').val(); 
   }
   
   
   /* ------------------------------------------------------------------------------------------------- */
   
   //테스트 API키
   
   let tossPayments = TossPayments("test..api키 설정");
   
   function pay() {
      let orderName = TitleName();
      let userid = useridName();
      totalPrice();
      const method="카드";
      const requestJson= {
            "amount": window.amount,
               "orderId": "sample-" + orderId,
               "orderName": orderName,
               "userid": userid,
               "customerName": userid,
               "successUrl": successUrl,
               "failUrl": failUrl
               
      }
      console.log("---------------------")
      console.log("orderName:", orderName);
      console.log("amount:",amount);
      console.log("orderId:",orderId);
      console.log("userid: ",userid);
       tossPayments.requestPayment(method, requestJson)
           .catch(function (error) {
   
               if (error.code === "USER_CANCEL") {
                   alert('유저가 취소했습니다.');
               } else {
                   alert(error.message);
               }
           });
   }
   
   
   let path = "/order2/";
   let successUrl = window.location.origin + path + "success2";
    let failUrl = window.location.origin + path + "fail";
    let orderId = new Date().getTime()

   
</script>
</html>