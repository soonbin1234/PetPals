<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Room</title>
<link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
<link rel="stylesheet" href="css/room.css" />
</head>
<h1 >호텔방 관리</h1>
<style>
  
</style>
<a href='/book'>예약관리</a>
<br><br>
<body>
<table id=tblRoom>
<tr>
<td></td><td>객실번호</td><td><input type=text id='roomNum' name='roomNum' readonly></td>
</tr>
<tr>
<td rowspan=5 style="text-align:center;">객실목록<select size="10" id='selRoom' style="width: 100%; height :80% "></select></td><td>객실종류명</td><td><select id=roomtype name=roomtype></select></td>
</tr>
<tr>
<td>객실명</td><td><input type=text id='roomName' name='roomName'></td>
</tr>
<tr>
<td>숙박가능인원</td><td><input type=number id='howmany' name='howmany'>명</td>
</tr>
<tr>
<td>1박요금</td><td><input type=number id='howmuch' name='howmuch'></td>
</tr>
<tr>
<td colspan=2 style align="center"><input type=button id='btnAddRoom' value='등록' style="width: 50%; height :80% "> <br><input type=button id='btnDelRoom' value='삭제' style="width: 50%; height :80% "></td>
</tr>
</table>
<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>

$(document)
.ready(function(){
   getRoomtype();
   getRoomad();
})
.on('click','#btnAddRoom',function(){
   if($('#roomName').val()==''||$('#howmany').val()==''||$('#howmuch').val()==''){
      alert("빈값을 허용하지 않습니다");
      return false;
   } 
   $.ajax({
      type:'post', url:'/Add', 
      data:{id:$('#roomNum').val(),type:$('#roomtype').val(),name:$('#roomName').val(),howmany:$('#howmany').val(),howmuch:$('#howmuch').val()}, 
      dataType:'text',
      success:function(data){
         if(data=='1'){
            $('#roomNum,#roomName,#howmany,#howmuch').val('');
            $('#selRoom').empty();
            getRoomad();
         } else {
            $('#roomNum,#roomName,#howmany,#howmuch').val('');
            console.log($('#roomName').val());
         }
      }
   })   
})

.on('click','#selRoom',function(){
   let ar=$('#selRoom option:selected').text();
   let ar1=ar.split(',');
   $('#roomNum').val(ar1[0]);
   $('#roomName').val(ar1[1]);
   $('#howmuch').val(ar1[3]);
   
   ars=ar1[2];
   let ars1=ars.split('X');
   $('#howmany').val(ars1[1]); 
   
   $('#roomtype option').each(function(){
      if($(this).text()==ars1[0]){
         $(this).prop('selected',true)  
         return false;
         
      }
   })

}) 
.on('click','#btnDelRoom',function(){
   $.ajax({
      type:'post', url:'/remove', data:{id:$('#roomNum').val()}, dataType:'text',
      success:function(data){
         if(data=='1') {
            $('#roomNum,#roomName,#howmany,#howmuch').val('');
            $('#selRoom').empty();
            getRoomad();
         }else{
            alert('실패');
         }
      }   
   })
})

function getRoomtype(){
   $.ajax({
      type:'post', url:'/room01', data:{}, dataType:'json',
      success:function(data){
         for(let i=0; i<data.length; i++){
            let ob=data[i];
            let str='<option value='+ob['id']+'>'+ ob['typename'] + '</option>';
            $('#roomtype').append(str);
         }         
      } 
   })
}
function getRoomad(){
   $.ajax({
      type:'post', url:'/List', data:{}, dataType:'json',
      success:function(data){
         for(let i=0; i<data.length; i++){
            let ob=data[i];
            let str='<option>'+ob['id']+','+ob['name']+','+ob['typename']+'X'+ob['personnel']+','+ob['price']+'</option>';      
            $('#selRoom').append(str);
         }
      }
   })
}
</script>
</body>
</html>