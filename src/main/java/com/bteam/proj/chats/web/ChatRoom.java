package com.bteam.proj.chats.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.bteam.proj.chats.vo.MessageVO;

public class ChatRoom {
	private static final Logger logger = LoggerFactory.getLogger(ChatRoom.class);
	private String roomNo;
	private ConcurrentMap<String, WebSocketSession> memNoSession = new ConcurrentHashMap<String, WebSocketSession>();
	private String ownerNo;
	private String roomName;

	public ChatRoom() {
	}

	/**
	 * creating New Chatroom with ownership
	 * 
	 * @param roomNo       Room number pre-set, usually generated via
	 *                     ChatRoomManager
	 * @param ownerNo      Owner's MemNo
	 * @param ownerSession Owner's Session
	 * @param roomName     RoomName
	 */
	public ChatRoom(String roomNo, String ownerNo, WebSocketSession ownerSession, String roomName) {
		this.roomNo = roomNo;
		this.memNoSession.put(ownerNo, ownerSession);
		this.ownerNo = ownerNo;
		this.roomName = roomName;
	}

	/**
	 * creating New Chatroom without ownership
	 * It means the Chatroom constructor is The first one who joiend the chatroom
	 * 
	 * @param roomNo     Room number pre-set, usually generated via ChatRoomManager
	 * @param ownerNo    Owner's MemNo
	 * @param memNo      Member's No
	 * @param memSession Member's Session
	 * @param roomName   RoomName
	 */
	public ChatRoom(String roomNo, String ownerNo, String memNo, WebSocketSession memSession, String roomName) {
		this.roomNo = roomNo;
		this.memNoSession.put(memNo, memSession);
		this.ownerNo = ownerNo;
		this.roomName = roomName;
	}

	/**
	 * only used for the Serverside alerting system
	 * 
	 * @param roomNo
	 * @param onwerNo
	 * @param roomName
	 */
	public ChatRoom(String memberNo, WebSocketSession memberSession) {
		this.roomNo = "SYSTEM_" + memberNo;
		this.ownerNo = "SYSTEM";
		this.roomName = "SYSTEM";
		this.memNoSession.put(memberNo, memberSession);
	}

	public List<String> getAllMembers() {
		List<String> keys = new ArrayList<>();
		for (String key : memNoSession.keySet()) {
			keys.add(key);
		}
		return keys;
	}

	public void sendAll(MessageVO messageGiven) {
		// per room identifier
		for (String eachKey : memNoSession.keySet()) {
			WebSocketSession eachSession = memNoSession.get(eachKey);
			// convert the message to movable form using the Messagebuilder
			MessageBuilder built = new MessageBuilder();
			built.setFromMessageVO(messageGiven);
			String shipment = MessageBuilder.parseToJson(built);
			// check if any error occurs
			try {
				if (eachSession.isOpen()) {
					eachSession.sendMessage(new TextMessage(shipment));
				} // Send the JSON message as a TextMessage
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

	public void sendAll(String messageGiven) {
		for (String eachKey : memNoSession.keySet()) {
			WebSocketSession eachSession = memNoSession.get(eachKey);
			try {
				if (eachSession.isOpen()) {
					eachSession.sendMessage(new TextMessage(messageGiven));
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public void removeMember(String memNo) {
		synchronized (this) {
			// check if there is member is in the room
			if (!memNoSession.containsKey(memNo)) {
				logger.warn("there is no such member {} in {}", new String[] { roomNo, memNo });
				return;
			}
			// removing a member from the room
			try {
				WebSocketSession target = memNoSession.get(memNo);
				logger.info("successfully close the target");
				memNoSession.remove(memNo);
				logger.info("new member {} is removed from the room {}", new String[] { memNo, roomNo });
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void addMember(WebSocketSession session, String memNo) throws IOException {
		// if memNo exists return without any change
		synchronized (this) {
			if (memNoSession.containsKey(memNo)) {
				if (!memNoSession.get(memNo).equals(session)) {
					logger.warn(
							"There is already member Numbered {}, in session {} removing it and renew into your new session {} ",
							new Object[] { memNo, memNoSession.get(memNo), session });
					memNoSession.get(memNo).close();
					removeMember(memNo);
					memNoSession.put(memNo, session);
					return;
				}
			} else {
				try {
					memNoSession.put(memNo, session);
					logger.info("new member {} is join to the room {}", new String[] { memNo, roomNo });
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	public boolean isOwner(String ownerCheck) {
		return this.ownerNo.equalsIgnoreCase(ownerCheck);
	}

	public String getOwner() {
		return ownerNo;
	}

	public int changeOwner(String newOwner) {
		synchronized (this) {
			try {
				if (isMemberIn(newOwner)) {
					logger.info("swapping the owner in the {} from {} to {}",
							new String[] { this.toString(), this.ownerNo, newOwner });
					this.ownerNo = newOwner;
					return 1;
				} else {
					return 0;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return -1;
			}
		}
	}

	public String getRoomNo() {
		return this.roomNo;
	}

	public void setRoomNo(String newRoomNo) {
		this.roomNo = newRoomNo;
	}

	public String getRoomName() {
		return this.roomName;
	}

	public WebSocketSession getSessionOf(String memberNo) {
		return memNoSession.get(memberNo);
	}

	public void setRoomName(String newRoomName) {
		this.roomName = newRoomName;
	}

	public boolean isMemberIn(String key) {
		return memNoSession.containsKey(key);
	}

	public boolean isSessionIn(WebSocketSession value) {
		return memNoSession.containsValue(value);
	}

	public int countIn(String memberNo) {
		return memNoSession.size();
	}

	@Override
	public String toString() {
		return "ChatRoom [roomNo=" + roomNo + ", memNoSession=" + memNoSession + ", ownerNo=" + ownerNo + "]";
	}

}
