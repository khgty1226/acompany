package com.bteam.proj.chats.web;

import com.bteam.proj.chats.vo.MessageVO;
import com.bteam.proj.chats.vo.MessageVO.CommandType;
import com.bteam.proj.chats.vo.MessageVO.DataType;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

public class WebSocketMessageProcessor {
	private static final Logger logger = LoggerFactory.getLogger(ChatsController.class);

	private static ChatRoomManager crm;
	private static WebSocketMessageProcessor instance;
	private final ConcurrentLinkedQueue<MessageVO> messageQueue;
	private final ExecutorService executorService;

	private WebSocketMessageProcessor() {
		messageQueue = new ConcurrentLinkedQueue<>();
		executorService = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());
		crm = ChatRoomManager.getInstance();
		ChatRoomManager.getInstance();
	}

	public static WebSocketMessageProcessor getInstance() {
		if (instance == null) {
			synchronized (WebSocketMessageProcessor.class) {
				if (instance == null) {
					instance = new WebSocketMessageProcessor();
				}
			}
		}
		return instance;
	}

	public void enqueueMessage(MessageVO message) {
		messageQueue.offer(message);
		logger.info("enquqed : " + message);
		executorService.submit(this::processMessages);
		executeQueue();
	}

	public void executeQueue() {
		while (!messageQueue.isEmpty()) {
			processMessages();
		}
	}

	private void processMessages() {
		while (!messageQueue.isEmpty()) {
			MessageVO message = messageQueue.poll();
			if (message == null) {
				logger.warn("Your Message is null!");
				continue; // Skip to the next iteration if message is null
			}

			DataType dataType = message.getDataType();
			CommandType commandType = message.getCommandType();

			if (dataType.equals(DataType.CHAT)) {
				processChatMessage(commandType, message);
			} else if (dataType.equals(DataType.ROOM)) {
				processRoomMessage(commandType, message);
			} else if (dataType.equals(DataType.MEMBER)) {
				processMemberMessage(commandType, message);
			} else if (dataType.equals(DataType.IMAGE)) {
				processImageMessage(commandType, message);
			}
		}
		// Handle other data types if needed
	}

	private void processChatMessage(CommandType commandType, MessageVO message) {
		switch (commandType) {
		case CREATE:
			MessageBuilder mb = new MessageBuilder();
			if (message.getData().get("ChatroomNo") != null) {
				ChatRoom targetRoom = null;
				try {
					targetRoom = crm.getChatroom(message.getData().get("ChatroomNo").get(0));
				} catch (NullPointerException ne) {
					logger.error("there is no such room {} in {}: ", message.getData().get("ChatroomNo"), message);
					logger.error("here is the existing chatrooms live", crm.toString());
					return;
				}
				ZonedDateTime zonedDateTime = ZonedDateTime.now(ZoneId.systemDefault());
				String zonedDateTimeString = zonedDateTime.toString();

				if (message.getData().get("Content") != null) {
					mb.addData("Content", message.getData().get("Content").get(0))
							.addData("ChatroomNo", message.getData().get("ChatroomNo").get(0))
							.addData("ChatDate", zonedDateTimeString).setSubject(message.getSubject())
							.setDataType(DataType.CHAT).setCommandType(CommandType.CREATE);
					if (message.getData().get("href") != null)
						mb.addData("href", message.getData().get("href").get(0));

					// build and send
					MessageVO messageOnPayLoad = mb.build();
					logger.info("From the Recieved Message {} , we have generated {} ", message, messageOnPayLoad);
					targetRoom.sendAll(messageOnPayLoad);
				} else {
					logger.error("Incomming message got missing 'Content' key in data");
					// when Content is not filled Up
				}
			} else {
				logger.error("Incomming message got missing 'ChatroomNo' key in data");
				// when ChatroomNo is not filled up
			}
			break;
		case RETRIEVE:
			break;
		case UPDATE:
			break;
		case DELETE:
			break;
		}
	}

	private void processRoomMessage(CommandType commandType, MessageVO message) {
		switch (commandType) {
		case CREATE:
			// here lines of codes will be used when room have been made.
			String owner, name, no;
			ZonedDateTime date;
			WebSocketSession ownerWss;
			try {
				owner = message.getSubject();
				date = ZonedDateTime.now();
				name = message.getData().get("ChatroomName").get(0);
				no = roomNoFrom(owner, name, date);
				ownerWss = crm.getSessionOf(no);

				ChatRoom newRoom = new ChatRoom(no, owner, owner, ownerWss, name);

				crm.addChatRoom(newRoom);
				//Build messge to send create room into the list
				MessageBuilder mb = new MessageBuilder();
				mb.setSubject(owner);
				mb.setDataType(DataType.ROOM);
				mb.setCommandType(CommandType.CREATE);
				mb.addData("ChatroomNo", no);
				mb.addData("ChatroomOwner", owner);
				mb.addData("ChatroomName", name);
				//send to the newly made chatroom
				newRoom.sendAll(mb.build());
				
			} catch (Exception e1) {
				logger.error("while System is adding works to cmr, failed to insert into the chatroom");
			}

			break;
		case RETRIEVE:
			// retriving the current List of Chatroom that subject : MemberNo is in // work
			// as update
			// this room could get participants
			// work to the single Member
			String memberNo = message.getSubject();

			MessageBuilder mb = new MessageBuilder();
			mb.setSubject(message.getSubject()).setCommandType(CommandType.UPDATE).setDataType(DataType.ROOM);

			for (String cr : crm.getChatroomsNoWith(memberNo)) {
				mb.clearData();
				mb.addData("ChatroomNo", crm.getChatroom(cr).getRoomNo())
						.addData("ChatroomName", crm.getChatroom(cr).getRoomName())
						.addData("ChatroomOwner", crm.getChatroom(cr).getOwner());
				// insert each members to the ChatRoom one by one
				for (String memNo : crm.getChatroom(cr).getAllMembers()) {
					mb.addData("Participants", memNo);
				}
				// swap it into MessageVO
				MessageVO messageOnPayLoad = mb.build();
				logger.info("From the Recieved Message {} , we have generated {} ", message, messageOnPayLoad);
				// send to the subject who asked to do so
				try {
					crm.getSessionOf(memberNo).sendMessage(new TextMessage(MessageBuilder.parseToJson(mb)));
				} catch (IOException e) {
					logger.error("while sending the message we mentioned above, we encoutner problem");
					e.printStackTrace();
				}
				;
			}

			break;
		case UPDATE:
			// this command is purposed to change the state of previous Chatroom's state
			// into the another
			// so the previous Chatroom state will be removed and replaced as this method's
			// values
			
			break;
		case DELETE:
			break;
		}
	}

	private void processMemberMessage(CommandType commandType, MessageVO data) {
		switch (commandType) {
		case CREATE:
			// when member is joined ( entered into website) this will ran
//			String memberNo = data.getSubject();
//			String chatroomNo = data.getData().get("ChatroomNo").get(0);			
//			try {
//				MemberVO member = 
//				
//				
//				
//				for(WebSocketSession wss : crm.getSessionToMember().keySet()) {
//					
//				}
//				
//			}catch{
//				
//			}
//			break;
		case RETRIEVE:
			// get the list of members who are in the member
			break;
		case UPDATE:
			// change in members , such as memebers logged in , members logged out ...etc
			break;
		case DELETE:
			break;
		}
	}

	private void processImageMessage(CommandType commandType, MessageVO data) {
		switch (commandType) {
		case CREATE:
			break;
		case RETRIEVE:
			break;
		case UPDATE:
			break;
		case DELETE:
			break;
		}
	}

	// since we cannot approach to chatroomsService this mehtod will proceed the
	// ChatroomNo Generation
	public String roomNoFrom(String memberNo, String roomName, ZonedDateTime dtWithZone) throws Exception {
		StringBuffer preinput = new StringBuffer();
		preinput.append(memberNo);
		preinput.append(roomName);
		preinput.append(dtWithZone.toString());

		String input = preinput.toString();
		MessageDigest md5Digest;
		md5Digest = MessageDigest.getInstance("MD5");
		byte[] hashBytes = md5Digest.digest(input.getBytes(StandardCharsets.UTF_8));

		StringBuilder hexString = new StringBuilder();
		for (byte b : hashBytes) {
			String hex = String.format("%02x", b);
			hexString.append(hex);
		}
		return hexString.toString();
	}
}
