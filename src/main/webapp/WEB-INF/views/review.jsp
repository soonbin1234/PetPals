<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/css/write.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
<link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
<title>작성하기</title>
</head>
<style>
.rate { display: inline-block;border: 0;margin-right: 15px;}
.rate > input {display: none;}
.rate > label {float: right;color: #ddd}
.rate > label:before {display: inline-block;font-size: 1rem;padding: .3rem .2rem;margin: 0;cursor: pointer;font-family: FontAwesome;content: "\f005 ";}
.rate .half:before {content: "\f089 "; position: absolute;padding-right: 0;}
.rate input:checked ~ label, 
.rate label:hover,.rate label:hover ~ label { color: #f73c32 !important;  } 
.rate input:checked + .rate label:hover,
.rate input input:checked ~ label:hover,
.rate input:checked ~ .rate label:hover ~ label,  
.rate label:hover ~ input:checked ~ label { color: #f73c32 !important;  } 
</style>

<body>
<input type=hidden id=userid value=${email }>
<input type=hidden id=loginid >
<div id="container">

    <main id="main">
     <div id="mainContent"> 
     
 
<div class="layout" id='data_div'>
      <label>작성하기</label>
      <input  id="pet_id" value=${pid }>
      <input  id="idDisplay"> <!-- 작성id -->
    <input type="text" id="writer"  placeholder="작성자" readonly>
    <textarea id="content" placeholder="내용"></textarea>
    
    <fieldset class="rate">
        <input type="radio" id="rating10"name="rating"value="5"><label for="rating10" title="5점"></label>
        <input type="radio" id="rating9" name="rating" value="4.5"><label class="half" for="rating9" title="4.5점"></label>
        <input type="radio" id="rating8" name="rating" value="4"><label for="rating8" title="4점"></label>
        <input type="radio" id="rating7" name="rating" value="3.5"><label class="half" for="rating7" title="3.5점"></label>
        <input type="radio" id="rating6" name="rating" value="3"><label for="rating6" title="3점"></label>
        <input type="radio" id="rating5" name="rating" value="2.5"><label class="half" for="rating5" title="2.5점"></label>
      <input type="radio" id="rating4" name="rating" value="2"><label for="rating4" title="2점"></label>
      <input type="radio" id="rating3" name="rating" value="1.5"><label class="half" for="rating3" title="1.5점"></label>
      <input type="radio" id="rating2" name="rating" value="1"><label for="rating2" title="1점"></label>
      <input type="radio" id="rating1" name="rating" value="0.5"><label class="half" for="rating1" title="0.5점"></label>
   </fieldset>
   <br>
    
    <button id="do_write" >작성하기</button>
    <button id="clear" >취소하기</button>
</div>
</div>

 
</body>



<script src='http://code.jquery.com/jquery-latest.js'></script>
<script>
$(document).ready(function(){
    getIdFromURL();
    displayId();
    
    if($('#idDisplay').val() !== ''){
        roda();
        
    }
    

    let userid = $('#userid').val();
    let id = userid.split("@");
    $('#writer').val(id[0]);
    idload();
});

$("#do_write").on('click', function(){
    if($('#writer').val() === "" || $('#content').val() === "" || $('input[name=rating]:checked').val() === ""){
        alert("빈 칸에 값을 입력해주세요.");
    } else {
       let writer = $('#writer').val();
        let content = $('#content').val();
        let rating = $('input[name=rating]:checked').val();
        
        let message = "작성자: " + writer + "\n내용: " + content + "\n평점: " + rating;
        alert(message);
        $.ajax({
            type: 'post', 
            url: '/doWrite',
            data: {
                pName: $('#pet_id').val(),
               /*  writer: $('#writer').val(),  */
                content: $('#content').val(),
                rating: $('input[name=rating]:checked').val(),
                idDisplay: $('#idDisplay').val(),
                userId: $('#loginid').val()
                
            }, 
            dataType: 'json',
            success: function(data) {
               console.log(data)
                if(data == 1){
                    alert('성공');
                    $('#content').val('');
                    window.close();
                    window.opener.showList();
                    window.opener.showpage();
                }
            }
        });
    }
});

$("#clear").on('click', function(){
   $('#content').val('');
})
function getIdFromURL() { // URL에서 id 값을 가져오는 함수
   const urlParams = new URLSearchParams(window.location.search);
   return urlParams.get('id');
}

function displayId() {
   const id = getIdFromURL();
   $('#idDisplay').val(id);
}
function roda(){
   $.ajax({
      type: 'post', 
        url: '/reLoad',
        data: {idDisplay:$('#idDisplay').val()}, 
        dataType: 'json',
        success: function(data) {
           console.log(data);
           $('#content').val(data.content);
           
           if (data.rating !== undefined) {
               let rating = parseFloat(data.rating);
               let ratingRadioId = "rating" + Math.round(rating * 2); 
               $("#" + ratingRadioId).prop("checked", true);
                 
           }
           
        }
   });
} 
function idload(){ // 로그인아이디 가져오기
      $.ajax({
         type:'post',
         url:'idload',
         data:{loginid:$('#userid').val()},
         dataType:'json',
         success:function(data){
            console.log(data.id);
            $("#loginid").val(data.id);
         }
      })
               
   }


</script>
</body>
</html>