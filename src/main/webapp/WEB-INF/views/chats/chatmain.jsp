<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>ChattingApp</title>

<!-- jquery -->
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<style>
#UIbox {
	position: relative;
	right: 5%;
	margin: 10vh;
	padding: 10px;
	overflow: visible;
	display: flex;
	flex-direction: column;
	flex-wrap: nowrap;
	justify-content: flex-end;
	align-items: stretch;
	z-index: 0;
}

.CHAT {
	flex-basis: auto;
	border: 2px solid #0077B5;
	border-radius: 10px;
	background-color: white;
	list-style: none;
	padding: 1rem;
	margin: 2vh;
	box-shadow: 0 2px 4px rgba(0, 160, 220, 0.25);
	transition: opacity 0.3s;
	z-index: 20;
	display: flex;
	flex-direction: column-reverse;
}

.CHAT ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.CHAT_DATE {
	float: right;
	color: lightgray;
}

.CHAT:hover {
	opacity: 0.5; /* Set the opacity to 50% when hovering */
}

.CHAT_NAME {
	font-size: 0.6em;
}
</style>
<body>
	<!-- UI BOX -->
	<div id="UIbox" class="Container ALL">
		<!-- TOP AREA-->
		<div id="topbarArea" class="Container TOP"></div>
		<!-- MID AREA-->
		<!-- 	<div id="messageArea" class="Container MID ROOM"></div>

	<div id="chatroomArea" class="Container MID LOBBY">
		<ul id="roomNo">
		<li class = "Room_Name">roomName </li>
		<li class = "Room_Owner">roomOwner </li>
		<li class = "Room_Participants>participants </li>
		</ul>
	</div> -->
		<!-- BOTTOM AREA-->
		<!-- 	<div id="commandArea" class="Container BOT">
		<div id="textPanel" class="Container Item BOT ROOM">
			<label>sendMesage</label> <input type="text" id="messageContent"
				class="Item inputBox" />
			<button class="sns-button" onclick="sendMessage()" id="messageButton"
				class="Item inputButton">전송</button>
		</div>
		<div id="invitePanel" class="Container Item BOT ROOM">
			<label>invite Member</label> <input type="text" id="invite" class="Item inputbox" />
		</div>
		<div id="returnPanel" class="Container Item BOT ROOM">
			<label>return to Room</label> <input type='button' id='gotoLobby' class='Item inputButton'/>
		</div>
		<div id="invitePanel" class="Container Item BOT LOBBY">
			<label>CreateRoom</label> <input type="text" id="" class=" LOBBY" />
			<input type="text" id="" class=" LOBBY" /> <input type="text" id=""
				class=" LOBBY" />
		</div> -->
	</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/resources/js/ChatMessage.js"></script>
	<script>
	
	
	//Variables for containing chatrooms and chats
	const currentMember = extractCookie("memberNo");
	//set of {ChatroomNo:String,ChatroomName:String,ChatroomOwner:String,ChatLogs[{}],Unread:Number,ChatroomMembers:[string:memberNo],Participants:[string:memberNo]} 
	const chatRoomsOfCurrentMember = new Map();
	//pointer in the set, so user can get the information more easier by putting chatRoomsOfCurrentMember.get(currentChatroom);
	let curentChatroom;
	//Members currently logged in {MemberNo, MemberName,Chatroom: ...};
	const membersOnline = new Map(); 
	//Members whether logged in or not 
	const membersAll = new Map();
	//Request base url
	//const baseUrl="http://localhost:8081/proj"
	const baseUrl="http://192.168.1.65:8080"
	
		//set the Chatroom Hidden at the first phase
 		function enterRoom(chatroomNo){
			//close all lobby
			elements_LOBBY= document.getElementsByClassName("LOBBY");
			for (var i = 0; i < elements_LOBBY.length; i++) {
			    var element = elements_LOBBY[i];
			    element.style.display = "none";
			} 
			//1.calling all the info saved inthe currentChatRoom
				//reading all values
			
				
				//drawing
			//2.inserting the chatmessages was saved from the websocket
			
		}
		
		function enterLobby(){
			elements_ROOM= document.getElementsByClassName("ROOM");
			for (var i = 0; i < elements_ROOM.length; i++) {
			    var element = elements_ROOM[i];
			    element.style.display = "none";
			}
			elements_LOBBY= document.getElementsByClassName("LOBBY");
			for (var i = 0; i < elements_LOBBY.length; i++) {
			    var element = elements_LOBBY[i];
			    element.style.display = "flex";
			} 
			
			chatRoomsOfCurrentMember.forEach((element)=>{
				chatroomName = element.ChatroomName;
				chatroomOwner = element.get
			});
		}

		//test request

		//
		const init = () => {
		    //getting all the chatrooms of the members
		    let data = {"MemberNo": [currentMember]};
		    const requestData = new ChatMessage(currentMember, DATATYPE.ROOM, COMMANDTYPE.RETRIEVE, data);
			//TODO
			ajaxSend('/chats/init',requestData)		
		    // then get all the chatLogs inside the room
		    chatRoomsOfCurrentMember.forEach((chatroom) => {
		        const chatroomNo = chatroom.ChatroomNo;
		        data = {"MemberNo": currentMember, "ChatroomNo": chatroomNo};
		        requestData = new ChatMessage(extractCookie("memberNo"), DATATYPE.CHAT, COMMANDTYPE.RETRIEVE, data);
				ajaxSend('/retrieve/chat',requestData,()=>enterLobby(),failureCode);
		    });
			
		};

		
		
		/*WebSocket setup*/
		let webSocket = null;
		//const url = "ws://localhost:8081/proj/chat";
		const url = "ws://192.168.1.65:8080/chat";
		
		/*sending function headed to server*/
		function sendMessage() {
			if (webSocket && webSocket.readyState === WebSocket.OPEN) {
				let message = document.getElementById("messageContent").value;
				target=currentChatroom;
				let content = {"data":{"Content":[message],"ChatroomNo":[currentChatroom],"ChatDate":[new Date().toISOString()]}};
				wsSend(content);
				//ajax message to add chatting to the database
				const savingData = {"subject":currentUser,"dataType":DATATYPE.CHAT,"commandType":COMMANDTYPE.CREATE}
				savingData.set("data",content);
				ajaxSend("/chats/create/chatLogs",savingData,successCode,failureCode);
			}

		}
			/*sending function headed to server*/
		
		const connectWebSocket = function(webUrl) {
			webSocket = new WebSocket(webUrl);
	
			webSocket.onopen = function(event) {
				//db로부터 data를 받아 유저 참여 채팅방 렌더링 하기 필요
				console.log("WebSocket 연결이 열렸습니다.");
/* 				const titleElement = document.getElementById("title");
				const userNameTextNode = document.createTextNode(extractCookie("memberNo"));
				titleElement.appendChild(userNameTextNode); */
				init();
			};
	
			webSocket.onmessage = function(event) {
			    console.log("서버에서 받은 메시지: " + event.data);
				
				try {
			        const chatMessage = parseChatMessage(event.data);
			        // Now you can work with the parsed ChatMessage object
					process(chatMessage);
			    } catch (error) {
			        console.error("Error parsing ChatMessage:", error);
			    }
			};
	
			webSocket.onclose = function(event) {
				console.log("WebSocket 연결이 닫혔습니다.");
			};
		};
		const storedWebSocketUrl = localStorage.getItem("webSocketUrl");
	
		if (storedWebSocketUrl) {
			connectWebSocket(storedWebSocketUrl);
		} else {
			connectWebSocket(url);
		}
		/*WebSocket setup*/
	
		    // start of processing
   function process(chatMessage){
    	let output;
        console.log("processing : ",chatMessage);
    	const dataType = chatMessage.dataType;
    	const commandType = chatMessage.commandType;
    	// check what dataType is processing in the object
    	switch(dataType){
    		// if it is chat.
    		case DATATYPE.CHAT:
    			switch(commandType){

	    			case COMMANDTYPE.CREATE:	
							/*
								structure of Each Chat From Server
							{
								"subject":"SYSTEM",
								"dataType":"CHAT",
								"commandType":"CREATE",
								"data":
								{
									"Content":["hello"],
									"ChatroomNo":["SYSTEM_2023-00-0000"],
									"ChatDate":["2023-08-25T14:38:41.779+09:00[Asia/Seoul]"]
									//optional
									"href":["url to be added into baseURL"]
								}
							}
							
							 
							*/
							const subject = chatMessage.subject;

						    // Check if 'Content' exists and is an array with at least one element
						    const content = chatMessage.data.Content && chatMessage.data.Content[0];
						    // Check if 'ChatroomNo' exists and is an array with at least one element
						    const chatroomNo = chatMessage.data.ChatroomNo && chatMessage.data.ChatroomNo[0];
						    // Check if 'ChatDate' exists and is an array with at least one element
						    const chatDate = chatMessage.data.ChatDate && chatMessage.data.ChatDate[0];
							// Check if 'href' exists and is an array with at least one element
							const href = chatMessage.data.href && chatMessage.data.href[0];

						    //insert {"MemberNo":subject, "Content":content,"ChatroomNo":ChatroomNo...} into set of {ChatroomNo:String,ChatroomName:String,ChatroomOwner:String,ChatLogs[{ <this side>}]} 
							const newChat = {"ChatroomNo":chatroomNo,"MemberNo":subject,"Content":content,"ChatDate":chatDate};
							//insert href if there is
							if(href)newChat.set("href",href);
							
							//insert the chatlog into corresponding chatroom in chatRoomsOfCurrentMember
							chatRoomsOfCurrentMember.get(chatroomNo).ChatLogs.push(newChat);
							console.log('a chatlog',newChat,' is added',chatRoomsOfCurrentMember);
							
							//if user is not in the room(currentroom != message.roomNo) add one Unread
							if(curentChatroom !== chatroomNo){
								chatRoomsOfCurrentMember.get(chatroomNo).Unread += 1;
							}
							
							//wrapper <ul id="subject_chatroomNo_dateTime" class="Item Container MID CHAT" key=id>
							wrapper1 = generateDom("ul","","","CHAT Item Container MID ROOM","");
							// <li class="CHAT_NAME ITEM MID"> name </li>
							subject1 = generateDom("li",subject,"","CHAT_NAME Item MID");
							// <li class="CHAT_CONTENT ITEM MID"> content</li>
							content1 = generateDom("li",content,"","CHAT_CONTENT Item MID");
							// <li class="CHAT_DATE ITEM MID"> DATE-DATETIME</li>
							dategap1 = generateDom("li",zonedTimeConversion(chatDate),"","CHAT_DATE Item MID");
							wrapper1.setAttribute("date",chatDate);
							
							wrapper1.appendChild(subject1);
							wrapper1.appendChild(content1);
							wrapper1.appendChild(dategap1);
							
							wrapper1.addEventListener("click", function(e) {
							    wrapper1.remove();
							});
							console.log("chat log is like : ",wrapper1);							
							let div = document.getElementById("UIbox");
							div.appendChild(wrapper1);
							//run updateFunction
							//ongoing...
						 break;
	    			case COMMANDTYPE.RETRIEVE:
	    				break;
	    			case COMMANDTYPE.UPDATE:
	    				break;
	    			case COMMANDTYPE.DELETE:
	    				break;
    		}
    		break;
    		case DATATYPE.ROOM:
    			switch(commandType){
    			case COMMANDTYPE.CREATE:
					/*
					//{ChatroomName:chatroomName, 
						ChatroomNo: chatroomNo, 
						ChatroomOwner:chatroomOwner
						}; into set of {ChatroomNo: <> , ChatroomName, <> , ChatroomOwner: String ChatLogs:Array}
					*/
					
					console.log("ROOM>CREATE, the object would be processed is : ",chatMessage)
					const chatroomNo = chatMessage.data.ChatroomNo && chatMessage.data.ChatroomNo[0];
				    const chatroomName = chatMessage.data.ChatroomName && chatMessage.data.ChatroomName[0];
				    const chatroomOwner = chatMessage.data.ChatroomOwner && chatMessage.data.ChatroomOwner[0];
					const chatroomMembers = chatMessage.data.ChatroomMembers && chatMessage.data.ChatroomMembers;
					//perhaps there should be somewhat functionalities to add members and participants handling in the update
					createChatroom(chatroomNo,chatroomName,chatroomOwner,chatroomMembers);	
					break;
    			case COMMANDTYPE.RETRIEVE:
    					break;
    			case COMMANDTYPE.UPDATE:
        			/*
    				server asked members to update the member in the Room by kicking out or log-off functionality
    				it might affect to the set which contain current members
    			*/
						
						const subject = chatMessage.subject;
						const memberNO = chatMessage.data.ChatroomNo && chatMessage.data.ChatroomNo[0];
						chatroomNo = chatMessage.data.MemberNo && chatMessage.data.MemberNo[0];
						const type= chatMessage.data.UpdateType && chatMessage.data.UpdateType[0];
						


						handleChatroomUpdate(type,subject,ChatroomNo,memberNo);
    					break;
    			case COMMANDTYPE.DELETE:
    					break;
			}
    		break;
    		case DATATYPE.MEMBER:
    			switch(commandType){
    			case COMMANDTYPE.CREATE:
    				
    				const target = 'all';
    				
					const chatroomNo = chatMessage.data.ChatroomNo && chatMessage.data.ChatroomNo[0];
					const memberNo = chatMessage.data.MemberNo && chatMessage.data.MemberNo[0];
					const memberName = chatMessage.data.MemberName && chatMessage.data.MemberName[0];
					const memberTeam = chatMessage.data.MemberTeam && chatMessage.data.MemberTeam[0];
					const memberDept = chatMessage.data.MemberDept &&chatMessage.data.MemberDept[0];
					const memberPhone = chatMessage.data.MemberPhone && chatMessage.data.MemberPhone[0];
					const memberEmail = chatMessage.data.MemberEmail && chatMessage.data.MemberEmail[0];
					
					handleMembers(
							target,
							memberNo,
							memberName, 
							memberTeam,
							memberDept, 
							memberPhone,
							memberEmail);
					break;
    			case COMMANDTYPE.RETRIEVE:
    					break;
    			case COMMANDTYPE.UPDATE:
					/*
						when an member is logging in , insert them into memberOnline 
						** memberOnline and memberAll must Contain all of the information 
						so it could help to be drawn
					*/
					chatroomNo = chatMessage.data.ChatroomNo && chatMessage.data.ChatroomNo[0];
					 memberNo = chatMessage.data.MemberNo && chatMessage.data.MemberNo[0];
					 memberName = chatMessage.data.MemberName && chatMessage.data.MemberName[0];
					 memberTeam = chatMessage.data.MemberTeam && chatMessage.data.MemberTeam[0];
					 memberDept = chatMessage.data.MemberDept &&chatMessage.data.MemberDept[0];
					 memberPhone = chatMessage.data.MemberPhone && chatMessage.data.MemberPhone[0];
					 memberEmail = chatMessage.data.MemberEmail && chatMessage.data.MemberEmail[0];
					
					handleMembers(
							target,
							memberNo,
							memberName, 
							memberTeam,
							memberDept, 
							memberPhone,
							memberEmail);
					
    					break;
    			case COMMANDTYPE.DELETE:
    					break;
			}
    		break;
    		case DATATYPE.IMAGE:
    			switch(commandType){
    			case COMMANDTYPE.CREATE:
    					break;
    			case COMMANDTYPE.RETRIEVE:
    					break;
    			case COMMANDTYPE.UPDATE:
    					break;
    			case COMMANDTYPE.DELETE:
    					break;
			}
    		break;
    	}

    	return output;
    }
    // end of processing
    
	/*handling the vars
		- CreateChatroom
		prerequired : 1.the ajax communication for creating room OR 2.the init() initiation for loading all rooms OR 3.inivitation of another member.
		1. createChatRoom : created room on the field ,after ajax create request 
			- after above, the WebsocketmessageProcessor will make some change on crm
			- so the crm will send it to the CREATE>>ROOM things so the process functino will handle it 
		!caution : the chatroom object must follows next structrue for further functional chagnes : 			        
			
		{}'ChatroomName','ChatroomNo', 'ChatroomOwner', 'ChatLogs':, 'Patricipants','Unread'}
	*/
	function createChatroom(no,name,owner,members){
		const chatroomNo = no;
	    const chatroomName = name;
	    const chatroomOwner = owner;
	    const chatroomMembers = members;
	    
	    const chatLogs = [];
	    
/* 	    for(member of chatroomMembers){
		    const message = {
		    	    	chatroomNo,
		    	    	member,
		    	    }
		    //this would be get from the ajax later, after the room is generated 
			ajaxSend("/retrieve/chat",message);
	    }; */
	    //TODO modify above to adapt all the chatrooms
	    

		const participants = [];

		const unread = 0;
	    console.log("we have ditributed into several variables , chatroomNo ",chatroomNo," chatroomName ",chatroomName," chatroomowner ",chatroomOwner," participants : ",participants);

		chatRoomsOfCurrentMember.set(chatroomNo, {
	        'ChatroomName': chatroomName,
	        'ChatroomNo': chatroomNo,
	        'ChatroomOwner': chatroomOwner,
	        'ChatLogs': chatLogs,
	        'ChatroomMembers' : members,
	        'Participants' : participants,
	        'Unread' : unread
	    });
		chatRoomsOfCurrentMember.get(chatroomNo).Participants.push(chatroomOwner);
		console.log('a chatroom is added',chatRoomsOfCurrentMember.get(chatroomNo));
		console.log("the state of the chatRoomsOfCurrentMember right now is : ", chatRoomsOfCurrentMember);
		
		//sending required info for setting up the participants
/* 		for(cm of chatroomMembers){
			wsSend();
		} */
	}
	//-creatingMembersAll
	/* create members whether they are logg-ed in or log-offed.
	*/
	function handleMembers(target,no,name,team,dept,phone,email){
		//if the target is 'all'
		if(target&&target === 'all'){
			
			// insert them into set of membersAll first(create process)
			membersAll.set(no, {
			    "ChatroomNo": [],
			    "MemberNo": no,
			    "MemberName": name,
			    "MemberTeam": team,
			    "MemberDept": dept,
			    "MemberPhone": phone,
			    "MemberEmail": email
			});
			// link if their room is the room where currentuser is in  
			membersAll.forEach( (member)=>{
				//check if the currently opened Chatroom contains certain userNo
				//this will help the linking of chatroom
				for(cr of chatRoomsOfCurrentMember){
					if(cr.data.ChatroomMembers.some((cm_cr)=>cm_cr==member)){
						member.ChatroomNo.push(cr);
					}
				}
			});
		}else{	
			// if target is not all, just put them in the the Online(update process)
			membersAll.set(no, {
			    "ChatroomNo": [],
			    "MemberNo": no,
			    "MemberName": name,
			    "MemberTeam": team,
			    "MemberDept": dept,
			    "MemberPhone": phone,
			    "MemberEmail": email
			});
			// link if their room is the room where currentuser is in  
			membersOnline.forEach( (member)=>{
				//check if the currently opened Chatroom contains certain userNo
				//this will help the linking of chatroom
				for(cr of chatRoomsOfCurrentMember){
					if(cr.data.ChatroomMembers.some((cm_cr)=>cm_cr==member)){
						member.ChatroomNo.push(cr);
					}
				}
			});
		}
	}


	
	/*component creators -- would be co-orperate with ChatMessage.js*/
	/**
	 * takes the data: In the Data Followings should be existed
	 * 1.Target(roomNo) String<List> 2.Content String 3.Date
	 * ZonedDateTime
	 * 
	 * And this will generate and run -DIV tag which could be
	 * chat box on the Chat Container -alarm function which will
	 * be toasted on the top -
	 */
    function chatGenerator(chatObject){
/* 		chatroomNo = chatObject.data.ChatroomNo[0];
 */		content = chatObject.data.Content[0];
		dateTime = chatObject.data.ChatDate[0];
		subject = chatObject.subject;
		//wrapper <ul id="subject_chatroomNo_dateTime" class="Item Container MID CHAT" key=id>
		wrapper = generateDom("ul","","","CHAT Item Container MID ROOM","");
		// <li class="CHAT_NAME ITEM MID"> name </li>
		subject = generateDom("li",subject,"","CHAT_NAME Item MID");
		// <li class="CHAT_CONTENT ITEM MID"> content</li>
		content = generateDom("li",content,"","CHAT_CONTENT Item MID");
		// <li class="CHAT_DATE ITEM MID"> DATE-DATETIME</li>
		dategap = generateDom("li",zonedTimeConversion(dateTime),"","CHAT_DATE Item MID");
		wrapper.setAttribute("date",dateTime);
		wrapper.setAttribute("chatroomNo",chatroomNo);
		
		wrapper.appendChild(subject);
		wrapper.appendChild(content);
		wrapper.appendChild(dategap);
		console.log("chat log is like : ",wrapper);
		document.getElementById("messageArea").appendChild(wrapper);
		
		let div = document.getElementById("UIbox");
		div.appendChild(Wrapper);
	 
    }
	 
	 
	function roomGenerator(){
		console.log("when generating rooms crocm : ", chatRoomsOfCurrentMember);
		chatRoomsOfCurrentMember.forEach((cr)=>{
			console.log("approaching to "+cr);
			/*each chatroom is 
				{
					ChatroomNo:String,
					ChatroomName:String,
					ChatroomOwner:String,
					ChatLogs[{}],
					Unread:Number,
					ChatroomMembers:[string:memberNo],
					Participants:[string:memberNo]
				} 
			*/
			let chatroomName = cr.ChatroomName;
			let chatroomNo = cr.ChatroomNo;
			let chatroomOwner = cr.ChatroomOwner;
			let participants = cr.Participants;
			let chatroomMembers = cr.ChatroomMembers;
			let chatlogs = cr.ChatLogs;

			/*
			from message = {}
			<!--<ul id="roomNo" class="Item Container MID ROOM">-->
			<!-- <li class = "Room_Name Item MID">roomName </li> -->
			<!-- <li class = "Room_Owner Item MID">roomOwner </li> -->
			<!-- <li class = "Room_Participants Item MID">participants 
					<ul class= "Room_Participants Container Item MID">
						<li id="memberNo" class="Room_Participants Item MID"> memberName</li>
						<li id="memberNo" class="Room_Participants Item MID"> memberName</li>
						<li id="memberNo" class="Room_Participants Item MID"> memberName</li>
						<li id="memberNo" class="Room_Participants Item MID"> memberName</li>
					<ul>
				</li> -->
			<!-- </ul> -->
			*/
			// let roomMems = []
			// for(roomMem of chatroomMembers){
			// 	let memli = generateDom('li',roomMem,roomMem,"ROOM ITEM MID",roomMem);
			// 	roomMems.push(memli);
			// }
			
			let roomWrapper = generateDom("ul","room",chatroomNo,"ROOM Item Container MID",chatroomNo);
			let roomName = generateDom("li",chatroomName,"","Room_Name Item MID");
			let roomOwner = generateDom("li",chatroomOwner,"","Room_Owner Item MID");
			// let roomParticipants = generateDom("li","praticipants list","","Room_Participants Item Container MID");
			//roomJoin = document.Create
			/*	TODO
				iterate n times for send message that retrieves list of Chatroom members
				in  the data must contain ParticipantId and ParticipantName
				it must combining the ajax communication and websocket Communication to identify who is log-in and log-out
			*/
			
			//combining the element into wrapper
			roomWrapper.appendChild(roomName);
			roomWrapper.appendChild(roomOwner);
			// particies.forEach((part)=>appendChild(part));
			// roomWrapper.appendChild(roomParticipants);
			// roomWrapper.appendChild(roomMems);
			roomWrapper.addEventListener("click", () => {
				console.log("you are joined into ", chatroomNo);
				enterRoom(chatroomNo);
			});	

			document.getElementById("chatroomArea").appendChild(roomWrapper);
		});
		
	}
   /**
   	*generateDom
    * this method is mainly aimed to convert the incomming Message into DOM containing information of the Chatlogs
    * 1.TagName : tag name
    * 2.Content : innerHtml    
    * 3.id : retrieved chatlogs from data which is usually order by ZonedDatetime ascending order
    * 4.key : unique identifier for option
    */
   function generateDom(tagName, content, id, classes,key,type) {
       const dom = document.createElement(tagName);
       dom.textContent = content;
       if (id) dom.id = id;
       if (classes) dom.className = classes;
       if (key) dom.setAttribute('key',key);
       
       const deleteButton = document.createElement("button");
       if (key){
    	   deleteButton.addEventListener("click",()=>handleDelete(key,type));
           dom.appendChild(deleteButton,url);
       }
       
       return dom;
   };

   function handleDelete(key,type) {    
	   const requestData = {
               subject: extractCookie("memberNo"),
               dataType: DATATYPE.ROOM,
               commandType: COMMANDTYPE.DELETE,
               data: {
               }
           };
	   const element = document.getElementById(key);
	   // doing different ajax communication per type of element which will be deleted
		if (element) {
		    switch (type) {
		        case 'Chatroom':
		            chatRoomsOfCurrentMember.delete(key);
		            requestData.data.set('ChatroomNo', ChatroomNo);
		            requestData.dataType = DATATYPE.ROOM;  // Use '=' instead of ':'
		            requestData.commandType = COMMANDTYPE.DELETE;  // Use '=' instead of ':'
		            // TODO - make controller that can control chatroomMembers
		            ajaxSend('/chats/delete/chatroomMembers',
		                requestData, () => element.remove());
		            // Send the requestData to the server using your preferred method
		    }
		}
   }
	
   function extractCookie(name) {
	    const cookies = document.cookie.split(';');
	    for (const cookie of cookies) {
	        const [cookieName, cookieValue] = cookie.trim().split('=');
	        if (cookieName === name) {
	            return cookieValue;
	        }
	    }
	    return null; // Cookie not found
	}


	function generateMessageBox(member, content) {
		//check if new message is mine or not
		const whoseText = member === extractCookie(member) ? "mine"
				: "others";
		const div_text = generateDom("div", "", "", "Container Item MID "
				+whoseText);

		const span_text_member = generateDom("span", member, "", "Item MID");
		const span_text_content = generateDom("span", content, "",
				"Item MID");
		const span_text_date = generateDom("span", content, Date.now()
				- new Date());
		div_text.appendChild(span_text_member);
		div_text.appendChild(span_text_content);
		div_text.appendChild(span_text_date);
		
		div_text.addEventListener("click", function(e) {
		    e.target.remove();
		});
		return div_text;
	}

	function extractJsonToElement(recieved) {
		const extracted = JSON.parse(recieved);
		console.log(extracted);
	}

	// Define the timeConversion function
	function timeConversion(timeGap) {
		if (timeGap < 1000 * 60) {
			return "최근";
		} else if (timeGap < 1000 * 60 * 60) {
			return parseInt(timeGap / (1000 * 60)) + "분 전";
		} else if (timeGap < 1000 * 60 * 60 * 24) {
			return parseInt(timeGap / (1000 * 60 * 60)) + "시간 전";
		} else if (timeGap < 1000 * 60 * 60 * 24 * 30) {
			return parseInt(timeGap / (1000 * 60 * 60 * 24)) + "일 전";
		} else {
			return new Date(timeGap).toLocaleDateString();
		}
	}
	function zonedTimeConversion(serverZonedDateTime) {
		const serverTimeParts = serverZonedDateTime.split("[");
	    if (serverTimeParts.length !== 2) {
	        return "Invalid ZonedDateTime format";
	    }

	    const datePart = serverTimeParts[0].trim();
	    const timezonePart = serverTimeParts[1].replace("]", "").trim();

	    const date = new Date(datePart);

	    const timeGap = Date.now() - date;
		console.log(timezonePart,",",date,",",timeGap);
	    if (timeGap < (1000 * 60)) {
	        return "최근";
	    } else if (timeGap < (1000 * 60 * 60)) {
	        return parseInt(timeGap / (1000 * 60)) + "분 전";
	    } else if (timeGap < (1000 * 60 * 60 * 24)) {
	        return parseInt(timeGap / (1000 * 60 * 60)) + "시간 전";
	    } else if (timeGap < (1000 * 60 * 60 * 24 * 30)) {
	        return parseInt(timeGap / (1000 * 60 * 60 * 24)) + "일 전";
	    } else {
	        return serverTime.toLocaleDateString();
	    }
	}

	//update per 1 mins
	// Update UI function
	function updateUI() {
	    const chatTimes = document.getElementsByClassName("CHAT_DATE");
	    for (chatTime of chatTimes) {
	        dateTime = chatTime.parentNode.getAttribute("date");
	        chatTime.textContent = zonedTimeConversion(dateTime);
	    }
	}
	/*component creators*/


	/*eventListners*/
	window.addEventListener("beforeunload", function() {
		if (webSocket) {
			localStorage.setItem("webSocketUrl", webSocket.url);
			webSocket.close();
		}
	});
	setInterval(() => {
	    updateUI();
	}, 60000); // 60000 milliseconds = 1 minute
	/*eventListners*/
	
	/*ajax format
		* ONLY use this when there is need to gather certain data from the database
	*/
	function ajaxSend(url,message,successCode,failureCode){
	   		$.ajax({	
   		        url: baseUrl + url,
   		        type: 'POST',
   		        contentType: 'application/json',
   		        data: JSON.stringify(message),
   		        success: function(response) {
   		        	if (response === 1) {
   		                console.log(JSON.stringify(message)+" is successfully affected");
   		                console.log("here is updated ChatroomsOfCurrentMember", chatRoomsOfCurrentMember);
   		              	if(successCode)successCode();
   		        	} else {
   		                console.log(message+' is failed to affected');
   		                if(failureCode)failureCode();
   		            }
   		        },
   		        error: function(xhr, status, error) {
   		            console.error('Request failed:', status, error);
   		        }
			});
	}
	/*websockcetSend(message) format 
		*
	*/
	function wsSend(chatroomMessage) {
		if (webSocket && webSocket.readyState === WebSocket.OPEN) {
			let converted = new ChatMessage(chatroomMessage);
			webSocket.send(JSON.stringify(converted));
			console.log("메시지 전송: " + JSON.stringify(converted));
		}
		//ajax message to add chatting to the database
	}
	
	</script>
</body>
</html>
