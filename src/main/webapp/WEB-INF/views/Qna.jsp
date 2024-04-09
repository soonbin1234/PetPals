<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<style>
#data_write{
   display: none;
}
.cid{
   display: none;
}
</style>
<head>
<meta charset="UTF-8">
<title>QnA</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/bootstrap.css">
<link rel="stylesheet" href="css/board.css" />
<link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
</head>

<body data-spy="scroll" data-target=".navbar" data-offset="70">
 
 <header id="herder">
     <%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>

 <h1 class="middle_top_title">QnA</h1>
 <hr class="middle_top_hr">   

<input type=hidden id=admin value=${admin } >
<input type=hidden id=hpage value=${page } >
<input type=hidden id=hlastpage value=${lastpage }>
<input type=hidden id=userid value=${email }>
<input type="hidden" id=loginid >



 <button id="new_write" placeholder="작성하려면 로그인이 필요합니다" disable = "true">Q&A작성</button>
  <br> <br>
  <div id="review" style="cursor: pointer;">
    
  </div>
 <br>
<table id=showpage></table>  



            
</body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document)
.ready(function(){
   showList(); 
   showpage();
   let userid=$('#userid').val();
   let logid=userid.split("@");
   $('#loginid').val(logid[0]);
   
})
//Qna 작성
.on('click','#new_write',function(){
    let userid = $('#userid').val();
    console.log("userid"+userid)
    if(userid == "" || userid ==null){
        alert('로그인페이지로 이동합니다');
        location.href="/login";
        return false
    } else {
       
        $('#new_write').disable = false;
        openPop()
        return true

    }
})
.on('click', '#data_list', function() {        
    let dataList = $(this); // 클릭된 요소를 변수에 저장
    let dataWrite = dataList.next('#data_write'); // 클릭된 요소의 다음 #data_write를 변수에 저장
    dataWrite.slideToggle(300); 
    $('#review').find('.announcement').not(dataList).next('#data_write').slideUp(300);
    // 클릭된 #data_list가 아닌 다른 모든 #data_list 요소의 다음 #data_write를 닫습니다.
    commentLoad(this); // 클릭된 qna에 답글 표시
})

.on('click','#pagenum',function(){
   let a=$(this).text()
   a=a.replace(/(\s*)/g, "")
   $('#hpage').val(a)
   console.log($('#hpage').val()+'s')
   showList()
   showpage()
})
.on('click','#prev',function(){
   let num=$('#hpage').val()-1
   $('#hpage').val(num)
   showList()
   showpage()
})
.on('click','#next',function(){
   let num=parseInt($('#hpage').val())+1
   $('#hpage').val(num)
   showList();
   showpage();
})
.on('click','#first',function(){
   let num=1
   $('#hpage').val(num)
   showList()
   showpage()
})
.on('click','#last',function(){
   let num=parseInt($('#hlastpage').val())
   $('#hpage').val(num)
   showList()
   showpage()
})
//Qna수정
.on('click','#btnbModify',function(){
   let title=$(this).parent().find('input#title').val();
   let content=$(this).parent().find('textarea#content').val();
   let id=$(this).parent().find('input#uniq').val();
   if(title=='' || content==''){
      alert("빈 값을 입력하시요.")
   } else {
      $.ajax({
         type:'post', url:'/QnaModify',
         data:{title:title,content:content,uniq:id},//$('#uniq').val()}, 
         dataType:'text',
         success:function(data){
            if(data==1){
               alert('성공하였습니다');
               showList();
               showpage();
            } else{
               alert('실패하였습니다')
            }
         }
      }) 
   }
})  
//Qna삭제
.on('click','#btnbDelete',function(){
   let id=$(this).parent().find('input#uniq').val();
   if(confirm('삭제하시겠습니까')){
   
      $.ajax({
         type:'post', url:'/QnaDelete',
         data:{uniq:id},
         dataType:'text',
         success:function(data){
            if(data==1){
               alert("삭제완료")
               showList();
              showpage();   
           } 
         }

        }) 
   }    else {
              alert('실패하였습니다')
              location.reload();
              return;
           }  
})
//답변 작성
.on('click','#btnComment',function(){
   let id=$(this).parent().find('input#uniq').val(); 
   let comment=$(this).parent().find('textarea#comment').val();
   let comment_id=$(this).parent().find('input#comment_id').val();
   
   if(comment==''){
      alert("빈 값을 입력하시요.")
   } else {
       $.ajax({
        type:'post', url:'/doComment', 
        data:{uniq:id,login:$('#userid').val(),comment:comment,comment_id:comment_id}, 
        dataType:'text',
        success:function(data){        
           if(data==1){
            alert('성공하였습니다');
            showList();
            showpage();
           } else if(data==2){
            alert('수정하였습니다');
            showList();
            showpage();
           }    
       }   
   });
  }
}) 
//답변 삭제
.on('click','#btnDelete_coment',function(){
   let comment_id=$(this).parent().find('input#comment_id').val();
   
   $.ajax({
      type:'post', url:'/comment_delete',
      data:{comment_id:comment_id},
      dataType:'text',
      success:function(data){
         if(data==1){
            alert('성공하였습니다')
            showList();
            showpage();
         } else{
            alert('실패하였습니다')
         }
      }
   })   
})
//Qna(내용도)+comment(틀만) 띄우기
 function showList(){
   $.ajax({
      type:'post',
      url:'/doQna',
      data:{page:$('#hpage').val()},
      dataType:'json',
      success:function(data){
         $('#review').empty();
           for(let i=0; i< data.length; i++){
              let ob=data[i];
              let logid=ob.email.split("@");
              let str='<div class="announcement" id="data_list" style="cursor: pointer;">' +
                '<span>제목:'+ob.title+'</span>' +
               '<div><span>작성자: '+logid[0]+'</span>' +
                '<span>작성시각: '+ob.time+'</span>' +
               '</div>' +
               '</div>' +
               '<div class="announcement" id="data_write">' +
                   '<input type="text" id="uniq" value="' + ob['id'] + '" class="cid">' +
                    '<label>제목</label><input type="text" id="title" value="' + ob.title + '">' +
                    '<label>작성자</label><input type="text" id="writer" value="' + logid[0] + '" readonly>' +
                    '<label>내용</label><textarea id="content">' + ob.content + '</textarea>';
              
                    if ($('#loginid').val()==logid[0]) {
                        str += '<button id="btnbModify" >수정하기</button>&nbsp'+
                        '<button id="btnbDelete" >삭제하기</button>';
                    }
                    str += '<br><br>';
                    str += '<input type="hidden" id="comment_id" >'+
                    '<label class="cid">답변</label>'+'<textarea id="comment2" class="cid" readonly></textarea>'+
                    '<label class="cid">답변자</label>'+'<input type="text" id="awriter"  class="cid" readonly>';

                    if ($('#admin').val() == 1) {     
                        str += '<label>답변달기</label>'+'<textarea id="comment"></textarea>'+
                        '<button id="btnComment" >답변하기</button>&nbsp'+
                        '<button id="btnDelete_coment" >답변삭제하기</button>';
                    }

                    str += '</div>';
            $('#review').append(str);         
           } 
      }
   })
}   


function showpage(){
   $.ajax({
      type:'get',
      url:'/Qnapage',
      data:{page:$('#hpage').val()},
      dataType:'text',
      success:function(data){
         $('#showpage').empty()
          $('#showpage').show()
            if(data==""){
               $('#showpage').hide()
            }
     
         let b=data.slice(1,-1)
         b=b.replace(/(\s*)/g, "")
         /* console.log(b) */
         let a=b.split(',')
         /* console.log(a) */
         let str='<tr><td>&nbsp;&nbsp;&nbsp;<button id=first>맨처음</button><button id=prev>이전</button>'
         for(let i=0;i<a.length;i++){
            str+='<a href="#" id=pagenum value='+a[i]+'>'+a[i]+'&nbsp;</a>'
         }
         str+='<button id=next>다음</button><button id=last>마지막</button></td></tr>'
         $('#showpage').append(str)
         if($('#hpage').val() ==1){
            $('#prev').hide()
         }
         if($('#hpage').val() ==$('#hlastpage').val()){
            $('#next').hide()
         }
      }
   })
}


/*  function showList(){
   $.ajax({
      type:'post',
      url:'/doQna',
      data:{},
      dataType:'json',
      success:function(data){
         $('#tbl_review').empty();
           for(let i=0; i< data.length; i++){
              let ob=data[i];
              let str='<tr><td>'+ob.content+'</td><td>'+ob.writer+'</td><td>'+ob.time+'</td><td>' + ob['id'] +
                '</td><td>'+'<a href="#" onclick="modiPop(' + ob.id + ')">수정</a><a href="#" id="delete">삭제</a></td></tr>';
            $('#tbl_review').append(str);         
           } 
         
      }
   })
}    */

function openPop(){
     var popup = window.open('http://localhost:8081/write', 'Qna작성', 'width=700px,height=800px,scrollbars=yes'); 
} 
// qna에 맞는 comment넣기
function commentLoad(click) {
    let uniq = $(click).next().find('input#uniq').val(); 
    let comment2 = $(click).closest('.announcement').next().find('textarea#comment2');
    let comment = $(click).closest('.announcement').next().find('textarea#comment');
    let id = $(click).closest('.announcement').next().find('input#comment_id');
    let awriter = $(click).closest('.announcement').next().find('input#awriter');

    $.ajax({
        type: 'POST',
        url: '/commentLoad',
        data: {uniq: uniq}, 
        dataType: 'json',
        success: function(data) {
            $('.cid').hide();
            var found = false; // 응답 데이터에 있는지 여부를 추적
            for (let i = 0; i < data.length; i++) {
               
                if (data[i]['question_id'] == uniq) {
                    found = true;  // id가 일치하는 경우 found를 true로 설정
                    let logid=data[i]['email'].split("@")
                    id.val(data[i]['id']);
                    comment2.val(data[i]['content']); 
                    comment.val(data[i]['content']); 
                       if(data[i]['content']!=''){ //조건식.
                          $('.cid').show();
                       }
                    awriter.val(logid[0]);
                    break;
            }
         }
        }
   });
}


</script>
</html>