package com.bteam.proj.chats.service;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.WebSocketSession;

import com.bteam.proj.chats.vo.ChatLogsVO;
import com.bteam.proj.chats.vo.ChatroomMembersVO;
import com.bteam.proj.chats.vo.MessageVO;
import com.bteam.proj.member.vo.MemberVO;

public class ChatDBManager {
    private static final Logger logger = LoggerFactory.getLogger(ChatDBManager.class);
    
    private static ChatDBManager instance;

    @Autowired
    private ChatLogsServiceImpl chatLogsService;
    @Autowired
    private ChatroomsServiceImpl chatroomsService;
    @Autowired
    private ChatroomMembersServiceImpl chatroomMembersService;

    // Private constructor to prevent instantiation from outside
    private ChatDBManager() {
        // Initialize any necessary state or resources here
    }

    // Singleton instance getter
    public static ChatDBManager getInstance() {
        if (instance == null) {
            instance = new ChatDBManager();
        }
        return instance;
    }

	private MessageVO command;

	public void cmdListener(MessageVO cmdRecieved) {
		this.command = cmdRecieved;
		if (cmdRecieved.getDataType() == MessageVO.DataType.ROOM) {
			memberProcessor();
		} else if (cmdRecieved.getDataType() == MessageVO.DataType.MEMBER) {
			roomProcessor();
		} else if (cmdRecieved.getDataType() == MessageVO.DataType.CHAT) {
			chatProcessor();
		}
	}

	private void memberProcessor() {
		logger.info("your recieved message is " + MessageVO.DataType.ROOM);
	}

	private void roomProcessor() {
		logger.info("your recieved message is " + MessageVO.DataType.MEMBER);
	}

	private void chatProcessor() {
		logger.info("your recieved message is " + MessageVO.DataType.CHAT);
		String subject = command.getSubject();
		switch (command.getCommandType()) {
		// subject 가 chat 을 create
		// 구조 : data{ ChatroomNo:[ChatroomNo],DateTime:[timezoneInfo,"YYYY...."]}
		case CREATE:
			try {
				//checking the data Structrue
				if(keyChecker("DateTime","ChatroomNo","Content")) {
					logger.info("your recieved message is " + MessageVO.CommandType.CREATE);
					String targetRoomNo = null, inCommand = command.getData().get("ChatroomNo").get(0);
					//memberCheck
					if (!memberContainsCheck(subject, inCommand)) {
						logger.error("we cannot find any chatroom {} that member{} joined",inCommand,subject);
					} else {
						ChatLogsVO newLog = new ChatLogsVO();
						newLog.setMemNo(subject);
						newLog.setChatroomNo(targetRoomNo);
						newLog.setChatContent(command.getData().get("Content").get(0));
						List<String> timeInfo = command.getData().get("DateTime");
						
						//find timezone from the data.DateTime:[timezoneinfo,formattedDateTime];
						ZonedDateTime currentTimeInZoned = null;
						if(timeInfo.size()>2||timeInfo.size()<1){
						currentTimeInZoned = ZonedDateTime.now(ZoneId.systemDefault());
						} else if (timeInfo.size() == 1) {
							currentTimeInZoned = ZonedDateTime.now(ZoneId.of(timeInfo.get(0)));
						} else if (timeInfo.size() == 2) {
							String receivedDateTimeString = timeInfo.get(1),timeZoneId=timeInfo.get(0);
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy, hh:mm:ss a");
							currentTimeInZoned = ZonedDateTime.parse(receivedDateTimeString + " " + timeZoneId, formatter.withZone(ZoneId.of(timeZoneId)));
						} else {
							currentTimeInZoned = ZonedDateTime.now(ZoneId.systemDefault());
						}
						newLog.setChatTime(currentTimeInZoned);
						chatLogsService.insertChatLog(newLog);
					}
				}else {
					logger.warn("Some of the data is missing! the data must contain Content, DateTime and ChatroomNo key");
				}
			} catch (Exception e) {
				logger.error("error happened while processing chat-create command");
				e.printStackTrace();
			}
			break;

		// subject 에게 돌아가야 할 Retrieve - 채팅 취득
		// 구조 : data{ ChatroomNo:[ChatroomNo],DateTime:[timezoneInfo,"YYYY-..." start, "YYYY...." end]
		case RETRIEVE:
			logger.info("your recieved message is " + MessageVO.CommandType.RETRIEVE);
			break;
		// subject 의 소유 채팅에 적용될 Update - 채팅 수정
		case UPDATE:
			logger.info("your recieved message is " + MessageVO.CommandType.UPDATE);
			break;
		// subject 의 소유 채팅을 delete - 채팅 삭제
		case DELETE:
			logger.info("your recieved message is " + MessageVO.CommandType.DELETE);
			break;
		default:
			;

		}
	}

	private void imageProcessor() {

	}
	
	private boolean keyChecker(String... listOfKeys) {
	    try {
	        for (String key : listOfKeys) {
	            if (!command.getData().containsKey(key)) {
	                logger.info("Key {} is missing in the data", key);
	                return false;
	            }

	            // Check if the value associated with the key is a List
	            Object value = command.getData().get(key);
	            if (!(value instanceof List)) {
	                logger.info("Value associated with key {} is not a List", key);
	                return false;
	            }
	        }
	        logger.info("Keys are all matched!");
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        logger.error("Something went wrong while checking keys in data");
	        return false;
	    }
	}


	private boolean memberContainsCheck(String targetId, String roomId) {
		logger.info("started Checking {} is in {}", new String[] { targetId, roomId });
		try {
			List<ChatroomMembersVO> listOfJoinedRooms = chatroomMembersService.getChatroomMembersByMemberNo(targetId);
			if (listOfJoinedRooms==null) {

				// if not , print error log
				logger.warn("no rooms are found");
			} else {
				logger.info("there is a rooms of which member{} joined  : {} : ",
						new String[] { targetId, listOfJoinedRooms.toString() });

				// check which room is the member's room
				String targetRoomNo = null;

				for (ChatroomMembersVO joinedRoom : listOfJoinedRooms) {
					String joinedRoomNo = joinedRoom.getChatroomNo();
					if (joinedRoomNo.equals(roomId)) {
						targetRoomNo = joinedRoomNo;
						break;
					}
				}
				// if not exist, print error log
				if (targetRoomNo == null) {
					logger.error("there is no such room of {} for member {} : ", new String[] { roomId, targetId });
					return false;
				} else {
					// if exist return true
					return true;
				}
			}
		} catch (Exception e) {
			logger.error("error happened while finding if member {} is in {} ", new String[] { targetId, roomId });
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * getting the memberNo and chatroomNo to create map for the handler
	 * 
	 */
//	public Map<String,Object> 

}