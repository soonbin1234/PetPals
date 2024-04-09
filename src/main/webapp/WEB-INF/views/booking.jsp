<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://js.tosspayments.com/v1"></script>
</head>
 <style>
        /* 스타일링 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
        }

        form {
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="date"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }


    </style>
<body>
<input id=userid value=${email }>
<input id=id value=${id }>
<input id=rid >
 <div class="container">
        <h1>숙소 예약 요청 페이지</h1>
           <label for="숙소">숙소:</label>
            <input type="text" id="room" >
        
            <label for="예약자">예약자:</label>
            <input type="text" id="name" >

            <label for="전화번호">전화번호:</label>
            <input type="tel" id="mobile">

            <label for="체크인">체크인 날짜:</label>
            <input type="date" id="checkin" >

            <label for="체크아웃">체크아웃 날짜:</label>
            <input type="date" id="checkout" >

            <label for="게스트">게스트:</label>
            <input type="number" id="people">
            
            <label for="게스트">금액:</label>
            <input type="text" id="price">
            
             <label for="반려동물">반려동물:</label>
            <input type="number" id="pet">
            
            <label for="요청사항">요청사항:</label>
            <input type="text" id="request">

            <button id=session onclick="pay();">결제하기</button>
 </div>
  

</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
   bookingload()
   
})
.on('click', '#session', function(){
   let session= $('#id').val();
     
    $.ajax({
      type: 'post',
      url: '/doSession3',
      data: {session:session},
      dataType: 'text',
      success: function(data){
          if(data == "1"){
             console.log(data);
          }
      }
  })
  pay();
})   
function bookingload(){
   $.ajax({
         type:'Post',
         url:'/bookload',
         data:{id:$('#id').val()},
         dataType:'json',
         success:function(data){
            
              $('#rid').val(data.rid);
               $('#name').val(data.name);
               $('#mobile').val(data.mobile);
               $('#checkin').val(data.start);
               $('#checkout').val(data.end);
               $('#people').val(data.people);
               $('#price').val(data.price);
               $('#room').val(data.room);
           
            
           
         }
      }) 
   
}
/* ------------------------------------------------------------------------------------------------- */

//테스트 API키

let tossPayments = TossPayments("<api 키>");

function pay() {
    let orderName = $('#name').val();// 펜션이름  
 /*    let userid = $('#name').val();// 펜션이름  */
    let orderQuantity = $('#people').val();
    let orderid = $('#rid').val();
    let amount = $('#price').val();
    console.log(amount);
    console.log(orderName);
    console.log(orderQuantity);
    console.log(orderid);

    const method="카드";
    const requestJson= {
        "amount": amount,
        "orderId": "sample-" + orderId,
       "orderName": orderName, 
        "orderid": orderid,
       /*  "userid": userid, */
        "orderQuantity": orderQuantity,
        "successUrl": successUrl,
        "failUrl": failUrl
    }
    console.log("---------------------")
    console.log("orderName:", orderName);
    console.log("amount:",amount);
    console.log("orderQuantity:",orderQuantity);
    console.log("orderId:",orderId);
    console.log("orderid: ",orderid);

    tossPayments.requestPayment(method, requestJson)
        .catch(function (error) {

            if (error.code === "USER_CANCEL") {
                alert('유저가 취소했습니다.');
            } else {
                alert(error.message);
            }
        });
    
}


let path = "/booking2/";
let successUrl = window.location.origin + path + "success3";
let failUrl = window.location.origin + path + "fail";
let orderId = new Date().getTime();

</script>
</html>