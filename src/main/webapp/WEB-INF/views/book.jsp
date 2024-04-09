<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservation</title>
   <link rel="stylesheet" href="css/book.css" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
</head>
<style>
#data_write{
   display: none;
}
.cid{
   display: none;
}

 h1{ 
    text-align:center;
 }

  input[type="date"],
  input[type="number"],
  input[type="text"],
  select {
    width: calc(100% - 12px);
    padding: 8px;
    margin: 4px 0;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
  }

  input[type="button"] {
    padding: 10px 20px;
    background-color: #634522;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  input[type="button"]:hover {
    background-color: #b29079;
  }

  input[type="button"]:active {
    background-color: #004080;
  }
</style>


<body>
<input type=hidden id=admin value=${admin } >
<input type=hidden id=hpage value=${page } >
<input type=hidden id=hlastpage value=${lastpage }>
<input type=hidden id=userid value=${email }>
<input id=pid value=${id }>
<input type="hidden" id=loginid >

<div >
   <table style="height:50px">
      <tr ><th style="background-color:  #c1b6a4; height:150px; font-size:30px; color:#634522;">예약하기 입니다 <a href="/">홈으로</a></th></tr>
   </table>
</div>

<div >
   <table >
      <tr><th class="myjjim" id="myreview" style="cursor: pointer"><input type=hidden id=hreview value="1"><input type=hidden name=flag value=false>예약보기</th><th class="myjjim" id="myqna" style="cursor: pointer"><input type=hidden id=hqna value=2><input type=hidden name=flag value=false>예약취소</th><th class="myjjim" id="myjjim" style="cursor: pointer"><input type=hidden id=hjjim value=3><input type=hidden name=flag value=false>예약안내</th></tr>
   </table>
      <div>
         <table class="my_List" id=tblreview>
            <tr>
               <td style="width: 33%; font-size=10; text-align:center;"> 예약가능목록 </td>
            </tr>
            <tr>
               <td>숙박기간<input style="width:200px" type="date" id="start"><br>~&nbsp&nbsp&nbsp<br><input style="width:200px" type="date" id="end"></td>
            </tr>
            <tr>
               <td>숙박인원<input type="number" id="int" style="width: 80px;" min="0" ></input>명</td>
            </tr>
            <tr>
               <td> <select size ="10" style="width: 100%;" id="roomList"></select></td>
            </tr>
            <tr>
               <td align="center"><input type="button" value="찾기" id="roomselect">
               <input type="button" value="다음 단계로" id="roomNext"></td>
            </tr>    
      </table>
   </div>
   
   <div>   
      <table  class="my_List"  id=tblqna>
         <tr style=display:none >
            <td style="width: 33%; display:none"></td>
            <td style=display:none ></td><td><input id="id" readonly> </td>
         </tr>
         <tr>
            <td colspan='2' style="text-align:center">세부내역</td>
         </tr>
         <tr>
            <td >객실번호</td><td><input type="text"  id="roomNum" readonly > </td>
         </tr>
         <tr>
            <td>객실종류</td><td><input type="text"  id="roomType" readonly> </td>
         </tr>
         <tr>
            <td>객실명</td><td><input type="text" id="rooms" readonly> </td>
         </tr>
         <tr>
            <td>숙박예정인원</td><td><input type="text"id="roomint" readonly> </td>
         </tr>
         <tr>
            <td>숙박기간</td><td><input type="date" id="rStart">~<input type="date" id="rEnd" readonly></td>
         </tr>
         <tr>
            <td>총비용</td><td><input type="text" id="rPrice" readonly></td>                  
         </tr>
         <tr>
            <td>예약자명</td><td><input type="text"  id="rName"> </td>                  
         </tr>
         <tr>
            <td>모바일번호</td><td><input type="text"  id="rMobile"> </td>                  
         </tr>
         <tr>
            <td colspan="2" align="center" ><input type="button" value="예약등록" id="finish">
            <input type="button" value="비우기" id="clear2"> 
            <input type="button" value="예약취소" id='checkclear'>
         </tr>
      </table>
   </div>
   
   <div>
      <table  class="my_List"  id=tbljjim>
         <tr>
            <td colspan=5 style="width:5%; text-align:center;">결재대기</td>
         </tr> 
          <tr>
              <th>객실명</th>
              <th>객실종류명</th>
              <th>최소인원(명)</th>
              <th>가격(원)</th>
              <th></th>
          </tr>                           

      </table>
   </div>
</div>



<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>
$(document)
.ready(function(){
   //이메일 쪼개기 writer 로 통일해서 review,qna,찜 목록 불러오기   
      let userid=$('#userid').val();
      console.log(userid);
      let logid=userid.split("@");
      console.log(logid)
      $('#loginid').val(logid[0]);

      $('#tblreview').hide();
      $('#tblqna').hide();
      $('#tbljjim').hide();
      
      getRoomlist();
      $('#roomNum,#rooms,#roomType,#roomint,#rPrice,#rStart,#rEnd,#rName,#rMobile').val('');
      $('#tbljjim').hide();
})

//아쟉스 틀만들기 먼저 쓰기

.on('click', '.myjjim', function() {
   let ndx = $(this).index();
   if(ndx==0){
      if($('#tblreview').is(':visible')) $('#tblreview').hide();
      else $('#tblreview').show();
        $('#tblqna').hide();
        $('#tbljjim').hide();
      
   } else if(ndx==1){
      $('#tblreview').hide();
        if($('#tblqna').is(':visible')) $('#tblqna').hide();
        else $('#tblqna').show();
        $('#tbljjim').hide();
      
   }else if(ndx==2){
      $('#tblreview').hide();
        $('#tblqna').hide();
        if($('#tbljjim').is(':visible')){
           $('#tbljjim').hide();
           $('#rlist').hide();
        } 
        else {
           $('#tbljjim').show();
           $('#rlist').show();
        }
   }
})   
// 다음 단계로 버튼 만들기
.on('click','#roomNext',function(){
   $('#tblreview').hide();
   $('#tblqna').show();
})


//호텔예약하기 룸부르기
.on('click','#roomList',function(){
   $('#roomNum,#rooms,#roomType,#roomint,#rPrice,#rStart,#rEnd,#rName,#rMobile').val('');
   let sel=$('#roomList option:selected').text();
   let dsel=sel.split(',');
   
   let start = new Date($('#start').val());
   let end = new Date($('#end').val());
   let diffDate=end.getTime() - start.getTime();
   let diff=Math.abs(diffDate/(1000 * 60 * 60 * 24));
   let day=dsel[4]*diff
   
   $('#roomNum').val(dsel[0]); 
   $('#rooms').val(dsel[1]);
   $('#roomType').val(dsel[2]);
   $('#roomint').val($('#int').val());
   $('#rPrice').val(day);
   $('#rStart').val($('#start').val());
   $('#rEnd').val($('#end').val())
})

.on('click', '#tbljjim tr', function(){
    $('#roomNum,#rooms,#roomType,#roomint,#rPrice,#rStart,#rEnd,#rName,#rMobile').val('');
    var cells = $(this).find('td');
    
    $('#id').val( $(cells[0]).text() );
    $('#rooms').val( $(cells[1]).text() );
    $('#roomType').val( $(cells[2]).text() );
    $('#rStart').val( $(cells[5]).text() );
    $('#rEnd').val( $(cells[6]).text() );
    $('#rName').val( $(cells[7]).text() );
    $('#rMobile').val( $(cells[8]).text() );
    $('#roomNum').val( $(cells[9]).text() );
    $('#roomint').val( $(cells[3]).text() );
    $('#rPrice').val( $(cells[4]).text() );
    $('#tblqna').show();
    $('#tbljjim').hide();
   
})

.on('click','#finish',function(){

   $.ajax({
      type:'post', url:'/finish', 
      data:{id:$('#id').val(),room_id:$('#roomNum').val(),
         howmany:$('#roomint').val(),howmuch:$('#rPrice').val(),
         checkin:$('#rStart').val(),checkout:$('#rEnd').val(),
         name:$('#rName').val(),mobile:$('#rMobile').val(),
         userid:$('#userid').val()}, 
      dataType:'text',
      success:function(data){
          if(data==1){
             alert("예약 완료!")
             $('#tbljjim').empty();
             $('#roomList').empty();
             getRoomlist();
             $('#roomNum,#rooms,#roomType,#roomint,#rPrice,#rStart,#rEnd,#rName,#rMobile').val('');
             $('#tblqna').hide();
             $('#tbljjim').show();
            /*  $('#rlist').show(); */
          }
      }
   })
})

.on('click','#clear2',function(){
   $('#roomNum,#rooms,#roomType,#roomint,#rPrice,#rStart,#rEnd,#rName,#rMobile').val('');
})

.on('click','#checkclear',function(){
   $.ajax({
      type:'post', url:'/remove2', 
      data:{id:$('#id').val()}, 
      dataType:'text',
      success:function(data){
          if(data==1){
             alert("예약이 취소되었습니다.")
             $('#tbljjim').empty();
             $('#roomList').empty();
             $('#roomNum,#rooms,#roomType,#roomint,#rPrice,#rStart,#rEnd,#rName,#rMobile').val('');
             getRoomad()
             getRoomlist()
          }
      }
   })
})

.on('click','#roomselect',function(){
    $('#roomList').empty();
   $.ajax({
      type:'post', url:'/select', 
      data:{start:$('#start').val(),end:$('#end').val(),ints:$('#int').val()}, 
      dataType:'json',
      success:function(data){
         for(let i=0; i<data.length; i++){
            let ob=data[i];
            let str='<option>'+ob['id']+','+ob['name']+','+ob['typename']+','+ob['personnel']+','+ob['price']+','+'</option>';    
            $('#roomList').append(str);
          }
      }
   })
}) 
.on('click', '#tbljjim #btnPay', function() {
     var id = $(this).closest('tr').find('td:first').text();
     location.href ="/booking?id="+id
});
function getRoomad(){
   $.ajax({
      type:'post', url:'/List', data:{}, dataType:'json',
      success:function(data){
         for(let i=0; i<data.length; i++){
            let ob=data[i];
            let str='<option>'+ob['id']+','+ob['name']+','+ob['typename']+','+ob['personnel']+','+ob['price']+'</option>';      
            $('#roomList').append(str); 

         }
      }
   })
}

function getRoomlist(){
   $.ajax({
      type:'post', url:'/rList', data:{}, dataType:'json',
      success:function(data){
         for(let i=0; i<data.length; i++){
            let ob=data[i];
            let str = '<tr><td style="display:none;">' + ob['id'] + '</td><td>' + ob['rname'] + '</td><td>' + ob['typename'] + '</td><td>' + 
                    ob['howmany']+ '</td><td>'+ ob['howmuch']+'</td><td style="display:none;">' + ob['checkin'] + '</td><td style="display:none;">' + ob['checkout'] + '</td>'+
                    '<td style="display:none;">' + ob['name'] + '</td><td style="display:none;">' + ob['mobile'] + '</td><td style="display:none;">' + ob['room_id'] + '</td>'+
                    '</td><td><input type=button id=btnPay value="결제하기"></input></td></tr>';
            $('#tbljjim').append(str);

            
         }
 
      }
   })
}


</script>
</body>
</html>