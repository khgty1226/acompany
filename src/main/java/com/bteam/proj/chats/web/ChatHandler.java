package com.bteam.proj.chats.web;

import java.time.ZoneId;
import java.time.ZonedDateTime;

import javax.servlet.http.Cookie;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.bteam.proj.chats.service.ChatroomsService;
import com.bteam.proj.chats.vo.MessageVO;
import com.bteam.proj.chats.vo.MessageVO.CommandType;
import com.bteam.proj.chats.vo.MessageVO.DataType;

public class ChatHandler extends TextWebSocketHandler {
	// Logger
	private static final Logger logger = LoggerFactory.getLogger(ChatsController.class);

	// Chatrooms with users
	private static ChatRoomManager crm = ChatRoomManager.getInstance();
	
	//Message Processor
	private static WebSocketMessageProcessor wsmp = WebSocketMessageProcessor.getInstance();

	
//	= ChatRoomManager.getInstance();
	/* private static final ChatRoomManager crm = ChatRoomManager.getInstance(); */
	/* private ChatDBManager chatDBManager = ChatDBManager.getInstance(); */

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		logger.info("WebSocket Connection established.");
		// check if there is session already set up
		logger.info("Getting the HTTPSESSION FROM THE WebsocketSession");

		Cookie[] cookies = null;
		cookies = (Cookie[]) session.getAttributes().get("COOKIES");

		logger.info("Getting the cookies list to find memberNo");
		// cookies must be found before next process
		String memberNo = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("memberNo".equals(cookie.getName())) {
					memberNo = cookie.getValue();
					logger.info("memberNo is found! :{} ", memberNo);
					break;
				}
			}
		}else {
			logger.info("from session : "+session+" don't have any member information");
		}

		// just finish the connection if the connection is invalid
		if (cookies == null || memberNo == null) {
			logger.warn("there's no Cookie {} or MemberNo {} is not exist! connection seemed invalid from session :{}",
					new Object[] { cookies, memberNo, session });
			session.close();
			return;
		}
		// save current session with its memNo - for ease of searching 
		// and setup default room- system, giving the alert into this chatroom, department and team the last two is not yet deployed
		// room taking and other things must be done in the chatsController sectinon - access to db.
		crm.getSessionToMember().put(session, memberNo);
		crm.defaultRooms(memberNo, session);

		MessageBuilder mb = new MessageBuilder();
		ZonedDateTime zonedDateTime = ZonedDateTime.now(ZoneId.systemDefault());
		String zonedDateTimeString = zonedDateTime.toString();
		ChatRoom systemRoom = crm.getChatroom("SYSTEM_" + memberNo.toString());
		crm.getChatroom(systemRoom.getRoomNo()).addMember(session, memberNo);
		
		mb.clearData().setSubject("SYSTEM").setCommandType(CommandType.CREATE).setDataType(DataType.ROOM)
		.addData("ChatroomName",systemRoom.getRoomName())
		.addData("ChatroomNo",systemRoom.getRoomNo())
		.addData("ChatroomOwner",systemRoom.getOwner())
		.addData("ChatroomMembers","SYSTEM")
		.addData("ChatroomMembers",crm.getSessionToMember().get(session));
		for(String mem : systemRoom.getAllMembers()) {
			mb.addData("Participants",mem);
		}
		
		System.out.println(mb);
		
		String systemRoomDataString = MessageBuilder.parseToJson(mb);
		crm.getChatroom(systemRoom.getRoomNo()).sendAll(systemRoomDataString);
		System.out.println(crm.toString());
		
		mb.clearData().setSubject("SYSTEM").setDataType(DataType.CHAT).setCommandType(CommandType.CREATE)
				.addData("Content", "알림 시스템에 연결되었습니다").addData("ChatroomNo", "SYSTEM_" + memberNo.toString())
				.addData("ChatDate", zonedDateTimeString);
		String stingified = MessageBuilder.parseToJson(mb);
		System.out.println("we have stringified as : "+stingified);
		crm.getChatroom("SYSTEM_" + memberNo.toString()).sendAll(stingified);

	
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("getting the memberNo from Message : {}, which is taken from the WebsocketSession : {} ",
				new Object[] { message, session });
		// Get the text content of the received message
		logger.info("Received JSON payload: {}", message);

		String receivedMessage = message.getPayload();
		MessageBuilder extractedPayload = new MessageBuilder();
		extractedPayload.setFromPayLoad(receivedMessage);
		MessageVO convertedMessage = extractedPayload.build();
		
//		// for guarantee, try to get the current sending session and compare the
//		// message's
//		String memNo = crm.getSessionToMember().get(session);
//		logger.info(
//				"memberNo : {}  is found from that session, we will compare the key-value paire of the session-Member Map :{}",
//				convertedMessage.getSubject(),memNo);
//		if (convertedMessage.getSubject().equals(memNo)) {
//			logger.info("they are matched");
//		}else {
//			logger.info("it is not matched!");
//		}
		
		wsmp.enqueueMessage(convertedMessage);
		

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		crm.getSessionToMember().remove(session);
		logger.info("WebSocket connection closed. Close Status: " + status);
	}
}
