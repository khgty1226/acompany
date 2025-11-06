package com.bteam.proj.chats.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.time.ZoneId;
import java.time.ZonedDateTime;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

import com.bteam.proj.chats.service.ChatroomsServiceImpl;

@Component
public class ChatRoomManager {
	private static ConcurrentMap<String, ChatRoom> chatRooms = new ConcurrentHashMap<>();
	private static ChatRoomManager crm = new ChatRoomManager();
	private static Map<WebSocketSession, String> sessionToMember = new HashMap<>();

	public static ChatRoomManager getInstance() {
		return crm;
	}

	private ChatroomsServiceImpl chatroomsService = new ChatroomsServiceImpl();

	public ChatRoomManager() {
	}

	public Map<WebSocketSession, String> getSessionToMember() {
		return sessionToMember;
	}

	public boolean defaultRooms(String memNo, WebSocketSession memSession) {
		try {
			ChatRoom systemRoom = new ChatRoom(memNo, memSession);
			chatRooms.put(systemRoom.getRoomNo(), systemRoom);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public ChatRoom getChatroom(String key) {
		try {
			return (chatRooms.containsKey(key)) ? chatRooms.get(key) : null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean setChatroom(String chatRoomNo, String chatroomCreator, WebSocketSession sessionOfCreator,
			String roomName) {
		if (chatRooms.get(chatRoomNo) == null) {
			try {
				chatRooms.put(chatRoomNo, new ChatRoom(chatRoomNo, chatroomCreator, sessionOfCreator, roomName));
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	public boolean addChatRoom(String chatroomCreator, String roomName, WebSocketSession chatroomCreatorSession) {
		try {
			String newChatroomNo = chatroomsService.roomNoFrom(chatroomCreator, roomName,
					ZonedDateTime.now(ZoneId.systemDefault()));
			ChatRoom newChatRoom = new ChatRoom(newChatroomNo, chatroomCreator, chatroomCreatorSession, roomName);
			chatRooms.put(newChatroomNo, newChatRoom);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean addChatRoom(ChatRoom newRoom) {
		try {
			chatRooms.put(newRoom.getRoomNo(), newRoom);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			;
		}
		return false;
	}

	public boolean isMemberExist(String key) {
		Iterator<Map.Entry<String, ChatRoom>> iter = chatRooms.entrySet().iterator();
		while (iter.hasNext()) {
			ChatRoom cur = iter.next().getValue();
			if (cur.isMemberIn(key))
				return true;
		}
		return false;
	}

	public boolean isSessionExists(WebSocketSession value) {
		Iterator<Map.Entry<String, ChatRoom>> iter = chatRooms.entrySet().iterator();
		while (iter.hasNext()) {
			ChatRoom cur = iter.next().getValue();
			if (cur.isSessionIn(value))
				return true;
		}
		return false;
	}

	public List<String> getChatroomsNoOf(String ownerNo) {
		Iterator<Map.Entry<String, ChatRoom>> iter = chatRooms.entrySet().iterator();
		List<String> chatroomList = new ArrayList<String>();
		while (iter.hasNext()) {
			ChatRoom cur = iter.next().getValue();
			if (cur.isOwner(ownerNo))
				chatroomList.add(cur.getRoomNo());

		}

		return chatroomList;
	}

	public List<String> getChatroomsNoWith(String memberNo) {
		System.out.println(this.getClass() + ": Getting the " + memberNo + "'s joined Chatroom");
		Iterator<Map.Entry<String, ChatRoom>> iter = chatRooms.entrySet().iterator();
		List<String> chatroomList = new ArrayList<String>();
		System.out.println(this.getClass() + ": CurrentChatrooms are :" + chatroomList);
		while (iter.hasNext()) {
			ChatRoom cur = iter.next().getValue();
			System.out.println(this.getClass() + "now inspecting " + cur + " if there is " + memberNo + " exist");
			if (cur.isMemberIn(memberNo))
				chatroomList.add(cur.getRoomNo());
		}
		return chatroomList;
	}

	public List<String> getChatroomsOfSesison(WebSocketSession session) {
		Iterator<Map.Entry<String, ChatRoom>> iter = chatRooms.entrySet().iterator();
		List<String> chatroomList = new ArrayList<String>();
		while (iter.hasNext()) {
			ChatRoom cur = iter.next().getValue();
			if (cur.isSessionIn(session))
				chatroomList = new ArrayList<String>();
		}
		return chatroomList;
	}

	public boolean removeMember(String where, String memberNo) {
		try {
			chatRooms.get(where).removeMember(memberNo);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public WebSocketSession getSessionOf(String memberNo) {
		try {
			if (sessionToMember.containsValue(memberNo)) {
				for (WebSocketSession key : sessionToMember.keySet()) {
					if (sessionToMember.get(key).equals(memberNo)) {
						return key;
					}
				}
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public String toString() {
		return chatRooms.toString();
	}

//	public boolean closeWebsocket(WebSocketSession wss) {
//		try {
//			Iterator<Map.Entry<String, ChatRoom>> iter = chatRooms.entrySet().iterator();
//			while(iter.hasNext()) {
//				ChatRoom cur = iter.next().getValue();
//				if(cur.isSessionIn(wss)) {
//					cur.removeMember(memNo);
//				}
//			}
//		}catch(Exception e) {
//			e.printStackTrace();
//			return false;
//		}
//	}

	/*
	 * public ChatRoomManager getCrm() { return crm; }
	 * 
	 * public void setCrm(ChatRoomManager crm) { ChatRoomManager.crm = crm; }
	 */
}
