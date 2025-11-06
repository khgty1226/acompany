<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- jquery -->
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
</head>
<style>
</style>
<body>
	<div id="UIbox" class="Container ALL"></div>
	<div id="topbarArea" class="Container TOP">
		<h4 id="title" class="item">chatroomtest</h4>
	</div>

	<div id="messageArea" class="Container MID">
		
	</div>
	
	<div id="chatroomArea" class="Container MID">
	</div>

	<div id="commandArea" class="Container BOT">
		<div id="textPanel" class="Item BOT">
			<label>sendMesage</label> <input type="text" id="messageContainer" class="inputBox" />
			<button class="sns-button" onclick="sendMessage()" id="messageButton" class="inputButton">전송</button>
		</div>
		<div id="invitePanel">
			<label>invite Member</label> <input type="text" id="invite" class=" " />
		</div>


	</div>

	<script>
	//component creators
	function generateDom(tagName = "p", content, id, classes) {
	  const dom = document.createElement(tagName);
	  dom.textContent = content;
	
	  if (id) {
	    dom.id = id;
	  }
	
	  if (classes) {
	    dom.className = classes;
	  }
	
	  return dom;
	}

	
	//WebSocket setup
	let webSocket = null;
	const url = "ws://localhost:8080/proj/chat";

	const connectWebSocket = function (webUrl) {
	    webSocket = new WebSocket(webUrl);

	    webSocket.onopen = function (event) {
	        console.log("WebSocket 연결이 열렸습니다.");
	    };

	    webSocket.onmessage = function (event) {
	        console.log("서버에서 받은 메시지: " + event.data);
	        var messageArea = document.getElementById("messageContainer");
	        messageArea.appendChild(generateDom('p','message',''));
	    };

	    webSocket.onclose = function (event) {
	        console.log("WebSocket 연결이 닫혔습니다.");
	    };
	};
	const storedWebSocketUrl = localStorage.getItem("webSocketUrl");

	if (storedWebSocketUrl) {
	    connectWebSocket(storedWebSocketUrl);
	} else {
	    connectWebSocket(url);
	}
	//WebSocket setup
	

	//communication function with server
	function sendMessage() {
	    if (webSocket && webSocket.readyState === WebSocket.OPEN) {
	        var message = document.getElementById("message").value;
	        webSocket.send(message);
	        console.log("메시지 전송: " + message);
	    }
	}

	//eventListners
	window.addEventListener("beforeunload", function () {
	    if (webSocket) {
	        localStorage.setItem("webSocketUrl", webSocket.url);
	        webSocket.close();
	    }
	});
	
	
	</script>
</body>

</html>