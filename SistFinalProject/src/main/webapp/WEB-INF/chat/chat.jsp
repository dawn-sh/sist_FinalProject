<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>Chating</title>
    <style>
        *{
            margin:0;
            padding:0;
        }
        .container{
            width: 500px;
            margin: 0 auto;
            padding: 25px
        }
        .container h1{
            text-align: left;
            padding: 5px 5px 5px 15px;
            color: #FFBB00;
            border-left: 3px solid #FFBB00;
            margin-bottom: 20px;
        }
        .chating{
            background-color: #000;
            width: 500px;
            height: 500px;
            overflow: auto;
        }
        .chating .me{
            color: #F6F6F6;
            text-align: right;
        }
        .chating .others{
            color: #FFE400;
            text-align: left;
        }
        input{
            width: 330px;
            height: 25px;
        }
        #yourMsg{
            display: none;
        }
        .msgImg{
            width: 200px;
            height: 125px;
        }
        .clearBoth{
            clear: both;
        }
        .img{
            float: right;
        }
    </style>
</head>

<script type="text/javascript">
    var ws;

    function wsOpen(){ // 웹 소켓을 연결하고, 연결이 열릴 때와 메시지를 수신할 때의 이벤트 핸들러를 정의합니다.
        //웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
        // 웹 소켓 연결 URL을 생성합니다. 현재 방의 번호를 포함하여 서버에 연결합니다.
        ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val()); // 현재 호스트와 채팅 방 번호를 포함한 웹 소켓 연결 URL 을 나타냅니다.

        // 웹 소켓 이벤트 핸들러를 설정하는 함수를 호출합니다.
        wsEvt(); // 함수 내부에서는 서버로부터 받은 메시지를 파싱하여 메시지 유형에 따라 다른 동작을 수행합니다.
    }

    function wsEvt() {
        ws.onopen = function(data){
            //소켓이 열리면 동작
        }

        ws.onmessage = function(data) {
            //메시지를 받으면 동작
            var msg = data.data;
            if(msg != null && msg.trim() != ''){
                // 파일 업로드가 아닌 경우 메시지를 뿌려준다.
                var d = JSON.parse(msg);
                if(d.type == "getId"){
                    var si = d.sessionId != null ? d.sessionId : "";
                    if(si != ''){
                        $("#sessionId").val(si);
                    }
                }else if(d.type == "message"){
                    if(d.sessionId == $("#sessionId").val()){
                        $("#chating").append("<p class='me'>나 :" + d.msg + "</p>");
                    }else{
                        $("#chating").append("<p class='others'>" + d.userName + " :" + d.msg + "</p>");
                    }
                }else{
                    console.warn("unknown type!")
                }
            }else {
                // 파일 업로드한 경우 업로드한 파일을 채팅방에 뿌려준다.
                var url=URL.createObjectURL(new Blob([msg]));
                $("#chating").append("<div class='img'><img class='msgImg' src="+url+"></div><div class='clearBoth'></div>");
            }
        }

        document.addEventListener("keypress", function(e){
            if(e.keyCode == 13){ //enter press
                send();
            }
        });
    }

    function chatName(){ // 사용자 이름을 입력하고, 웹 소켓을 열어 채팅에 참가합니다.
        var userName = $("#userName").val();
        if(userName == null || userName.trim() == ""){
            alert("사용자 이름을 입력해주세요.");
            $("#userName").focus();
        }else{
            wsOpen();
            $("#yourName").hide();
            $("#yourMsg").show();
        }
    }

    function send() { // 채팅 메시지를 서버로 전송합니다.
        var option ={
            type: "message",
            roomNumber: $("#roomNumber").val(),
            sessionId : $("#sessionId").val(),
            userName : $("#userName").val(),
            msg : $("#chatting").val()
        }
        ws.send(JSON.stringify(option))
        $('#chatting').val("");
    }

    function fileSend(){
        var file=document.querySelector("#fileUpload").files[0];
        var fileReader=new FileReader();
        fileReader.onload=function (){
            var param={
                type: "fileUpload",
                file:file,
                roomNumber: $("#roomNumber").val(),
                sessionId: $("#sessionId").val(),
                msg: $("#chatting").val(),
                userName: $("#userName").val()
            }
            ws.send(JSON.stringify(param)); // 파일 보내기전 메시지를 보내서 파일을 보냄을 명시한다.
            arrayBuffer=this.result;
            ws.send(arrayBuffer); // 파일 소켓 전용
        }
        fileReader.readAsArrayBuffer(file);
    }
</script>
<body>
<div id="container" class="container">
    <h1>${roomName}의 채팅방</h1>
    <input type="hidden" id="sessionId" value="">
    <input type="hidden" id="roomNumber" value="${roomNumber}">

    <div id="chating" class="chating">
    </div>

    <div id="yourName">
        <table class="inputTable">
            <tr>
                <th>사용자명</th>
                <th><input type="text" name="userName" id="userName"></th>
                <th><button onclick="chatName()" id="startBtn">이름 등록</button></th>
            </tr>
        </table>
    </div>
    <div id="yourMsg">
        <table class="inputTable">
            <tr>
                <th>메시지</th>
                <th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
                <th><button onclick="send()" id="sendBtn">보내기</button></th>
            </tr>
            <tr>
                <th>파일업로드</th>
                <th><input type="file" id="fileUpload"></th>
                <th><button onclick="fileSend()" id="sendFileBtn">파일업로드</button></th>
            </tr>
        </table>
    </div>
</div>
</body>
</html>