<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my jjim</title>
   <link rel="stylesheet" href="css/store.css" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">


<style>
#data_write{
   display: none;
}
.cid{
   display: none;
}

tr, th, td{
   text-align:center; margin:auto;
   
}
div,table{
  text-align:center; margin:auto;
  border: 3px solid var(--locked-color);
  border-radius: 50px;

}
.pet01{
   width:45%;
   height:auto;
   transform: translate(57ch,50mm);
   position:relative;

}
</style>

</head>
<body>
<br>
<input type=hidden id=admin value=${admin } >
<input type=hidden id=hpage value=${page } >
<input type=hidden id=hlastpage value=${lastpage }>
<input type=hidden id=userid value=${email }>
<input type="hidden" id=loginid >
<div >
   <table style="height:50px">
      <tr ><th style="background-color:  #c1b6a4; height:150px; font-size:30px; color:#634522;">My History <a href="/">홈으로</a></th></tr>
   
   </table>
</div>
<div >
   <table >
      <tr><th class="myjjim" id="myreview" style="cursor: pointer"><input type=hidden id=hreview value="1"><input type=hidden name=flag value=false>리뷰</th><th class="myjjim" id="myqna" style="cursor: pointer"><input type=hidden id=hqna value=2><input type=hidden name=flag value=false>QNA</th><th class="myjjim" id="myjjim" style="cursor: pointer"><input type=hidden id=hjjim value=3><input type=hidden name=flag value=false>찜목록</th><th class="myjjim" id="mybook" style="cursor: pointer"><input type=hidden id="hbook" value="4">예약목록</th><th class="myjjim" id="mypayment" style="cursor: pointer"><input type=hidden id=hpayment value="5"><input type=hidden name=flag value=false>결제내역</th></tr>
   </table>
   <div>
         <table class="my_List" id=tblreview></table>
   </div>
   <div>   
         <table  class="my_List"  id=tblqna></table>
   </div>
   <div>
         <table  class="my_List"  id=tbljjim></table>
   </div>
     <div>
         <table  class="my_List"  id=tblbook></table>
   </div>
   <div>
         <table  class="my_List"  id=tblpayment></table>
   </div>
</div>
   

   <img src="image/pet01.jpg" class="pet01">
   
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
   
//이메일 쪼개기 writer 로 통일해서 review,qna,찜 목록 불러오기   
   let userid=$('#userid').val();
   console.log(userid)
   let logid=userid.split("@");
   console.log(logid)
   $('#loginid').val(logid[0]);
   showreview();
   showqna();
   showjjim();
   showbook();
   showpayment();
   $('#tblreview').hide();
   $('#tblqna').hide();
   $('#tbljjim').hide();
   $('#tblbook').hide();
   $('#tblpayment').hide();
})

.on('click', '.myjjim', function() {
   console.log($('#tblbook').val())
   let ndx = $(this).index();
   console.log(ndx)
   if(ndx==0){
      if($('#tblreview').is(':visible')) $('#tblreview').hide();
      else $('#tblreview').show();
        $('#tblqna').hide();
        $('#tbljjim').hide();
        $('#tblbook').hide();
        $('#tblpayment').hide();
   } else if(ndx==1){
        $('#tblreview').hide();
        if($('#tblqna').is(':visible')) $('#tblqna').hide();
        else $('#tblqna').show();
        $('#tbljjim').hide();
        $('#tblbook').hide();
        $('#tblpayment').hide();
   }else if(ndx==2){
        $('#tblreview').hide();
        $('#tblqna').hide();
        $('#tblbook').hide();
        $('#tblpayment').hide();
        if($('#tbljjim').is(':visible')) $('#tbljjim').hide();
        else $('#tbljjim').show();
   }else if(ndx==3){
      $('#tblreview').hide();
       $('#tblqna').hide();
       $('#tbljjim').hide();
       $('#tblpayment').hide();
       if($('#tblbook').is(':visible')){
          $('#tblbook').hide();
       }else {
          $('#tblbook').show();
       }
   }else if(ndx==4){
      $('#tblreview').hide();
       $('#tblqna').hide();
       $('#tbljjim').hide();
       $('#tblbook').hide();
       if($('#tblpayment').is(':visible')){
          $('#tblpayment').hide();
       }else {
          $('#tblpayment').show();
       }
   }
     else {
       return  
         
      }
})   




function showjjim(){
   $('#tbljjim').empty();
   $.ajax({
      type:"get",
      url:"/myList",
      data:{userid:$('#userid').val(),data:$('#hjjim').val()},
      dataType:"json",
      success:function(data){
         let str="";
         str+="<tr><td>이름</td><td>전화번호</td><td>주소</td></tr>"
         for(let i=0;i<data.length;i++){
            let ob=data[i]
            str+="<tr class='brown'><input type=hidden id=jjimId value="+ob['id']+"><td><a href='/page?id="+ob['id']+"'>"+ob['name']+"</a></td><td>"+ob['number']+"</td><td>"+ob['loadAddress']+"</td></tr>"
         }
         $('#tbljjim').append(str)
      }
   })
}

function showreview(){
   $('#tblreview').empty();
   console.log("!");
   $.ajax({
      type:"get",
      url:"/myList",
      data:{userid:$('#userid').val(),data:$('#hreview').val()},
      dataType:"json",
      success:function(data){
         let str="";
        
            str+="<tr class='brown'><td>제목</td><td>별점</td><td>작성자</td></tr>"
         for(let i=0;i<data.length;i++){
            let ob=data[i]
             let userid=ob.email.split("@");
             
            str+="<tr><input type=hidden id=reviewId value="+ob['id']+"><td><a href='/page?id="+ob['id']+"'>"+ob['content']+"</a></td><td>"+ob['rating']+"</td><td>"+userid[0]+"</td></tr>"
         }
         $('#tblreview').append(str)
      }
   })
}

function showqna(){

//    $('#loginid').val(logid[0]);
   $('#tblqna').empty();
   console.log("!");
   $.ajax({
      type:"get",
      url:"/myList",
      data:{userid:$('#userid').val(),data:$('#hqna').val()},
      dataType:"json",
      success:function(data){
         let str="";
         str+="<tr class='brown'><td>제목</td><td>내용</td><td>작성자</td></tr>"
         for(let i=0;i<data.length;i++){
            let ob=data[i]
             let userid=ob['email'];
            console.log('userid는'+userid);
             let logid=userid.split("@");
            str+="<tr><input type=hidden id=qnaId value="+ob['id']+"><td><a href='/Qna'>"+ob['title']+"</a></td><td>"+ob['content']+"</td><td>"+logid[0]+"</td></tr>"
         }
         $('#tblqna').append(str)
      }
   })
}
function showbook(){

//  $('#loginid').val(logid[0]);
 $('#tblbook').empty();
 console.log("!");
 $.ajax({
    type:"get",
    url:"/myList",
    data:{userid:$('#userid').val(),data:$('#hbook').val()},
    dataType:"json",
    success:function(data){
       let str="";
       str+="<tr class='brown'><td>이름</td><td>숙소명</td><td>숙박비</td><td>번호</td></tr>"
       for(let i=0;i<data.length;i++){
          let ob=data[i]
          console.log(ob)
//            let userid=ob['email'];
//           console.log('userid는'+userid);
//            let logid=userid.split("@");
          str+="<tr><td><a href='/book?id="+ob['id']+"'>"+ob['name']+"</a></td><td>"+ob['rname']+"</td><td>"+ob['howmuch']+"</td><td>"+ob['mobile']+"</td></tr>"
       }
       $('#tblbook').append(str)
    }
 })
}
function showpayment(){

//  $('#loginid').val(logid[0]);
 $('#tblpayment').empty();
 console.log("!");
 $.ajax({
    type:"get",
    url:"/myList",
    data:{userid:$('#userid').val(),data:$('#hpayment').val()},
    dataType:"json",
    success:function(data){
       //장바구니 결제리스트
       console.log($('#hpayment').val())
       let str="";
       str+="<tr class='brown'><td>구매사이트 </td><td>아이디</td><td>상품명</td><td>가격</td><td>결제시간</td></tr>"
       for(let i=0;i<data.length;i++){
          let ob=data[i]
          console.log(ob)

          str+="<tr><td>PetPals hub</td><td><a href='/book?id="+ob['id']+"'>"+ob['email']+"</a></td><td>"+ob['orderName']+"</td><td>"+ob['amount']+"</td><td>"+ob['order_time']+"</td></tr>"
       }
       $('#tblpayment').append(str)
    }
 })
}

</script>
</html>