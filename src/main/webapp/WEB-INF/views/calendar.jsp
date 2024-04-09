<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
  
  <!-- Bootstrap CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <link href="css/calendar.css" rel="stylesheet">
  
  <!-- fullcalendar CDN -->
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
  <link rel="shortcut icon" type="image/x-icon" href="image/favicon.ico">
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
  <!-- fullcalendar 언어 CDN -->
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
</head>
<body>
<input type=hidden id=userid value=${email }>
<input type=hidden id=hid value=${id }>
<header id="herder">
     <%@ include file="/WEB-INF/views/include/header.jsp" %>
</header>
<div id='calendar-container' style="margin-top: 20px;">    
    <div id='calendar' id=calList></div>  
</div>
<div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">일정 추가하기</h5>
            <button
              type="button"
              class="btn-close"
              data-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            일정이름 : <input type="text" id="title" /><br />
            시작시간 : <input type="datetime-local" id="start" /><br />
            종료시간 : <input type="datetime-local" id="end" /><br />
            배경색상 :
            <select id="color">
              <option value="red">빨강색</option>
              <option value="orange">주황색</option>
              <option value="yellow">노랑색</option>
              <option value="green">초록색</option>
              <option value="blue">파랑색</option>
              <option value="indigo">남색</option>
              <option value="purple">보라색</option>
            </select>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-dismiss="modal"
            >취소</button>
            <button type="button" class="btn btn-primary" id="saveChanges">
              추가
            </button>
          </div>
          
        </div>
      </div>
    </div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
var eventId; // eventId 변수를 전역으로 선언하여 모든 함수에서 접근 가능하도록 합니다.

$(document).ready(function(){
   $('#calList').empty();
   let userName = $("#userid").val();
   console.log(userName);
   console.log($('#hid').val())

   // calendar element 취득    
    var calendarEl = $('#calendar')[0];      
    // full-calendar 생성하기      
    var calendar = new FullCalendar.Calendar(calendarEl, {   
       googleCalendarApiKey: "<api>",
        height: '700px',        
        expandRows: true, // 화면에 맞게 높이 재설정        
        slotMinTime: '08:00', // Day 캘린더에서 시작 시간        
        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간        
        // 해더에 표시할 툴바        
        headerToolbar: {          
            left: 'prev,next today myCustomButton',          
            center: 'title',          
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'        
        },
        customButtons: {
            myCustomButton: {
                text: '새로운 이벤트',
                click: function() {
                    $("#exampleModal").modal("show");
                }
            }
        },
        
        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)        
        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크        
        editable: true, // 수정 가능?        
        selectable: true, // 달력 일자 드래그 설정가능        
        nowIndicator: true, // 현재 시간 마크        
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)        
        locale: 'ko', // 한국어 설정  
        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트          
            eventId = obj.event._def.defId; // eventId를 obj로 수정
        },        
        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트          
            console.log(obj);        
        },        
        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트          
            console.log(obj);        
        },           
        eventDrop : function(info) {
            alert(info.event.title + " was dropped on "
                    + info.event.start.toISOString());

            if (!confirm("Are you sure about this change?")) {
                info.revert();
            }
        },
        eventSources: [
           {
              googleCalendarId : 'ko.south_korea#holiday@group.v.calendar.google.com'
                    , color: 'white'   // an option!
                    , textColor: 'red' // an option!
           }
        ],
        eventClick: function(info) {
           let calId = info.event._def.defId;
           let title = info.event._def.title;
           console.log(calId);
           console.log('이게누르면 삭제냐?');
           console.log($('#title').val());
           console.log(title);
           
           $.ajax({
              type:"POST",
              url: "/calRemove",
              dataType:"text",
              data:{title:title}
           })
           if (confirm("이 일정을 삭제하시겠습니까?")) {
                let eventId = info.event._def.defId;
                console.log("삭제할 이벤트의 ID:", eventId);
               info.event.remove();
               alert("삭제완료");
            }
        }
    }); 

      // 캘린더 랜더링      
    calendar.render(); 
    console.log(calendar.getEvents());
    CalendarList(calendar);
   
    $("#exampleModal").on("hidden.bs.modal", function () {
        // 모달이 숨겨질 때 입력된 내용 초기화
        $("#title").val("");
        $("#start").val("");
        $("#end").val("");
        $("#color").val("red"); // 배경색을 기본값으로 설정해도 됩니다.
    });
    
    //모달창 이벤트
      $("#saveChanges").on("click", function () {
         var eventData = {
                title: $("#title").val(),
                start: $("#start").val(),
                end: $("#end").val(),
                backgroundColor: $("#color").val()
         };
       
       let title = eventData.title;
       let start = eventData.start;
       let end = eventData.end;
       let backgroundColor = eventData.backgroundColor;
       
       console.log("userName",userName);
       console.log("title:",title);
       console.log("start:",start);
       console.log("end",end);
       console.log("backgroundColor:",backgroundColor);
      
       if($('#userid').val() == "" || $('#userid').val() ==null){
           alert('로그인페이지로 이동합니다');
           location.href="/login";
           return false
       }
       
       if (eventData.title == "" || eventData.start == "" || eventData.end == "") {
           alert("입력하지 않은 값이 있습니다.");
       } else if ($("#start").val() > $("#end").val()) {
           alert("시간을 잘못입력 하셨습니다.");
       } else {
           calendar.addEvent({
               title: title,
               start: start,
               end: end,
               backgroundColor: backgroundColor
           });
           $("#exampleModal").modal("hide");

           $.ajax({
               type: "POST",
               url: "/calendar",
               dataType: "text",
               data: { userName: userName,
                     title: $("#title").val(),
                       start: $("#start").val(),
                       end: $("#end").val(),
                       backgroundColor: $("#color").val() },
               success: function(data) {
                   if (data === "1") {
                      
                       alert("등록되었습니다!!");
                   }
               }
           });
       }
   });
});

function CalendarList(calendar){
   console.log($('#userid').val())
   $.ajax({
      type:"POST",
      url: "/CalendarList",
      dataType: "JSON",
      data: {userName:$('#userid').val()},
      success: function(data){
         console.log(data)
         data.forEach(function(eventData) {
                calendar.addEvent({
                    title: eventData.title,
                    start: eventData.start,
                    end: eventData.end,
                    backgroundColor: eventData.backgroundColor
                });
            });
        }
    });
}



</script>

</html>