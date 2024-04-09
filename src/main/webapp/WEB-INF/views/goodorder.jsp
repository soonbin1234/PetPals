<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
<link rel="stylesheet" href="css/goodorder.css">

</head>
<body>
	
   <input type="hidden" id="id" value=${id }>
   <input type="hidden" id="userid" value=${email }>

   <div >
     <img class="itemImage"style="width: 280px; display: none;"  ><br>
   </div>
 
     <table>
       <tr><td colspan="2" class="itemName"></td></tr>
       <tr>
         <td>판매가</td>
         
         <td class="itemPrice"></td>

       </tr>
       <tr>
         <td>배송비</td>
         <td >2,500원</td>
       </tr>
       <tr>
         <td>수량</td>
         <td>
           <input type="text" id="result" readonly value="1" style="text-align: right;">
           <input type="button" onclick='count("plus")' value="+" class="int">
           <input type="button" onclick='count("minus")' value="-" class="int">
         </td>
       </tr>
       <tr>
        <td>총액</td>
         <td>
            <input type="text" id="sum" readonly>
         </td>
       </tr>
       <tr>
        <td>상세설명</td>
         <td >
            펫팔 미니샵의 상품입니다. 
         </td>
       </tr>
     </table>
                                                      
    <button id='basket'>장바구니/구매</button>


</body>

<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
   item();   
})
.on('click','#basket',function(){
	let orderid=$("#id").val();
	let userid=$("#userid").val();
    let title=$(".itemName").text();
    let price=$(".itemPrice").text();
    let img=$(".itemImage").attr("src");
    let count=$("#result").val();
    let amount = price * count;
    
    console.log("orderid: ",orderid)
    console.log("userid: ",userid)
    console.log("title: ",title)
    console.log("price: ",price)
    console.log("img: ",img)
    console.log("count: ",count)
    console.log("amount: ",amount)
    
    $.ajax({
        type: 'post', 
        url: '/basket', 
        data: {
        	orderid: orderid,
        	userid: userid,
            title: title,
            price: price,
            count: count,
            amount: amount,
            img: img
        }, 
        dataType:'text',
        success: function(data) {
            if(data==="1"){
            	alert("상품이 장바구니에 추가되었습니다.")
            	console.log('상품이 장바구니에 추가되었습니다.');
            	/* window.close(); */
            }
        }
	})
});

function item(){
   $.ajax({
      type: 'post', 
        url: '/itemLoad',
        data: {id:$('#id').val()}, 
        dataType: 'json',
        success: function(data) {
        	$('.itemImage').attr('src', data.img);
           	$('.itemName').text(data.title); // 이름
           	$('.itemPrice').text(data.price); //개별 아이디
           	$('#sum').val(data.price);
          
        }
   });
} 

function count(type){
	   let number=$('#result').val();
	    if(type === 'plus') {
	         number = parseInt(number) + 1;
	     }else if(type === 'minus')  {
	         number = parseInt(number) - 1;
	         if(number<1){
	            return false;
	         }
	   }
	    $('#result').val(number); // 수량
	    $('#sum').val(number*$('.itemPrice').text()); // 총 구매 가격 
	}

</script>
</html>
