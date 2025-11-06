package com.bteam.proj.chats.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.time.ZonedDateTime;
import java.util.List;
import java.security.MessageDigest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bteam.proj.chats.vo.ChatroomsVO;
import com.bteam.proj.chats.dao.IChatroomsDAO;

@Service
public class ChatroomsServiceImpl implements ChatroomsService {
	private static final Logger logger = LoggerFactory.getLogger(ChatroomsServiceImpl.class);

	@Autowired
	private IChatroomsDAO dao;

	private MessageDigest md5Digest;

	/**
	 * Constructor of ChatromService is used for initiating MessageDigest with MD5.
	 * If something gets wrong with md5 Instance, It will generate error and shut
	 * down.
	 */
	@Autowired
	public ChatroomsServiceImpl() {
		try {
			this.md5Digest = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException NSAExcpetion) {
			System.err.println("there is no such alorithm for Chatroomservice's md5Digest");
		}
	}

	/**
	 * simple, return all Chatrooms saved in the db.
	 * 
	 * @return List of ChatroomsVO which is saved in the db.
	 */
	public List<ChatroomsVO> getAllChatrooms() {
		try {
			return dao.getAllChatrooms();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * return the chatroom having ChatroomNo of param
	 * 
	 * @param chatRoomNo used to run the query
	 * @return ChatroomsVO of targeted by chatRoomNo
	 */
	public ChatroomsVO getChatroom(String chatroomNo) {
		try {
			return dao.getChatroom(chatroomNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * return the List of ChatroomsVO having ChatroomName of param
	 * 
	 * @param chatroomName which will be targeted
	 * @return List of ChatroomsVO which is matched with chatroomName
	 */
	public List<ChatroomsVO> getChatrooms(String chatroomName) {
		try {
			return dao.getChatrooms(chatroomName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * return the List of ChatroomsVO having same ChatroomOwner of param
	 * 
	 * @param chatroomOwner who has the rooms
	 * @return List of ChatroomsVo which is controlled by the ChatroomOwner
	 */
	public List<ChatroomsVO> getChatroomsOf(String chatroomOwner) {
		try {
			return dao.getChatroomsOf(chatroomOwner);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Checking the closed state of target
	 * 
	 * @param target primary key of the record in Rooms Table
	 * @return true if closed, false if not or error.
	 */
	public boolean getIsClosedof(String target) {
		try {
			return "Y".equals(dao.getIsClosedOf(target));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * ChatroomNo will be set as MD5 Hashed of ChatrooMaker ChatroomName. Here
	 * doesn't have any exception handling in this section. this only handles
	 * creation. more higher logic will be set in another service layer
	 * 
	 * @param chatroomMaker A.K.A memNo of members table
	 * @param chatroomName  the user-input would be set as the name of the new chat
	 *                      room
	 * @return int number of affection, 1 means works right 0 means there is some
	 *         problem.
	 */
	public int createChatroomBy(String chatroomMaker, String chatroomName, ZonedDateTime openDatetime) {
		try {
			String chatroomNo = roomNoFrom(chatroomMaker, chatroomName, openDatetime);
			logger.info("ChatNumber {} is made from ChatroomsService.roomNoFrom({},{})",
					new String[] { chatroomNo, chatroomMaker, chatroomName });
			int result = 0;
			logger.info("Checking if there is same ChatroomNo is exists");
			boolean existance = isChatroomExists(chatroomNo);
			// checking
			if (existance) {
				return result;
			}
			logger.info("Creating room of ({}{})", new String[] { chatroomNo, chatroomName });
			ChatroomsVO nCR = new ChatroomsVO();
			nCR.setChatroomNo(chatroomNo);
			nCR.setChatroomName(chatroomName);
			nCR.setChatroomOwner(chatroomMaker);
			nCR.setClosed(true);
			nCR.setOpenDatetime(openDatetime);
			logger.info("inserting {} into database", nCR);
			result = dao.newChatroom(nCR);
			logger.info((result) == 0 ? "no change" : "{} number of things are affected", result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	/**
	 * put the already made Vo int obj.
	 * @param obj the ChatroomsVO contains all the info already
	 * @return int of affected number, less or more than 1 give warning. 
	 */
	public int insertByVo(ChatroomsVO obj) {
		try {
			int result = 0;
			logger.info("putting a {} object into db", obj);
			result = dao.newChatroom(obj);
			if (result != 1) {
				logger.warn("something got wrong, nothing, or one more object is inserted");
			} else {
				logger.info("successfully inserted one object to database");
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("Something got wrong while inserting {} into DB", obj);
		return -1;
	}

	/**
	 * this method is used to destoryChatroom mostly done by the owner of the room
	 * some conditions and post-actions(effects) must be checked and done in upper
	 * service layer 1.is the one who gives command to break the chatroom is the
	 * owner of the chatroom? 2.once it is broken, there should be chatlogs and
	 * chatroom_member connections archieved and removed from db
	 * 
	 * @param targetNo is the ChatroomNo of the target
	 * @return int count of affected
	 */
	public int destroyChatroom(String targetNo) {
		try {
			int result = 0;
			boolean existance = isChatroomExists(targetNo);
			logger.info("checking if there is room of {}", targetNo);
			if (existance == false) {
				return 0;
			}
			logger.info("A room is found! chatroom with {} is being deleted from DB by", targetNo);
			result = dao.removeChatroom(targetNo);
			logger.info((result) == 0 ? "no change" : "{} number of things are affected");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * this methods will change the name of the room previous steps are needed in
	 * regular use 1.checking if the owner is changing the name(*for the
	 * common(non-admin) user service layer). 2.checking the chatroomNo - check if
	 * there is hashed String of newName and roomOwner already in other records'
	 * 3.if both conditions are good, change the chatroomNo.
	 * 
	 * @param targetNo is the targetChatroom's number.
	 * @param newName  is the name will be changed into.
	 * @return int number of records affected.
	 */
	public int changeChatroomName(String targetNo, String newName) {
		try {
			int result = 0;
			// check if the room is exists
			logger.info("checking if there is room of {}", targetNo);
			if (isChatroomExists(targetNo) == false) {
				return 0;
			}
			logger.info("ChatroomName of {} is going to be changed ", targetNo);
			result = dao.changeChatroomName(targetNo, newName);
			logger.info((result) == 0 ? "no change" : "{} number of things are affected", result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * Since it is manipulating the primary key In most cases , this method will not
	 * used stand-alone. upper service layer will check every dependency and change
	 * all they required
	 * 
	 * @param targetNo      is the original target ChatroomNo
	 * @param newChatroomNo will be new chatroomNo
	 * @return int number of records affected
	 */
	public int changeChatroomNo(String targetNo, String newChatroomNo) {
		try {
			int result = 0;
			logger.info("checking if there is room of {} and room of {} is already there ",
					new String[] { targetNo, newChatroomNo });
			if (isChatroomExists(targetNo) == false || isChatroomExists(newChatroomNo) == true) {
				return 0;
			}
			logger.info("ChatroomNo of {} is going to be changed ", targetNo);
			result = dao.changeChatroomNo(targetNo, newChatroomNo);
			logger.info((result) == 0 ? "no change" : "{} number of things are affected", result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;

	}

	/**
	 * this methods will change the owner who have right to control the room.
	 * previous steps are needed in regular use 1.checking if the owner is
	 * transferring its ownership itself(*for the common(non-admin) user service
	 * layer). 2.checking if the ownerNew is in the room ( using ChatroomMember
	 * table) 3.checking the chatroomNo - check if there is hashed String of
	 * roomName and ownerNew already in other records'
	 * 
	 * @param targetNo
	 * @param ownerNew
	 * @return int number of records affected
	 */
	public int changeChatroomOwner(String targetNo, String ownerNew) {
		try {
			int result = 0;
			logger.info("checking if there is room of {} ", targetNo);
			if (isChatroomExists(targetNo) == false) {
				return 0;
			}
			logger.info("ChatroomOwner of {} is going to be changed ", targetNo);
			result = dao.changeChatroomOwner(targetNo, ownerNew);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/**
	 * mark 'closed' the room.
	 * @param targetNo the target ChatroomNo which will be closed
	 * @return number of affected records
	 */
	public int closeChatroomByNo(String targetNo) {
		try {
			int result = 0;
			logger.info("try to close the room");
			result = dao.closeChatroom(targetNo);
			if(result!=1) {
				logger.warn("Something gots wrong, less or more than one record is affected : {}",result);
			}else {
				logger.info("the record which got {} as its ChatroomNo is closed",targetNo );
			}
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * this converts the Member and the roomname into md5ed hash this hash will also
	 * used check if the user is owner or not.
	 * 
	 * @param String Memberinput
	 * @return String 32Byte MD5-hashed input
	 */
	public String roomNoFrom(String memberNo, String roomName, ZonedDateTime dtWithZone) throws Exception {
		StringBuffer preinput = new StringBuffer();
		preinput.append(memberNo);
		preinput.append(roomName);
		preinput.append(dtWithZone.toString());

		String input = preinput.toString();
		byte[] hashBytes = md5Digest.digest(input.getBytes(StandardCharsets.UTF_8));

		StringBuilder hexString = new StringBuilder();
		for (byte b : hashBytes) {
			String hex = String.format("%02x", b);
			hexString.append(hex);
		}
		return hexString.toString();
	}

	/**
	 * checking if there is chatroom already exists based on primary key
	 * 
	 * @return true if there is existance of chatrooms record with given record,
	 *         false if not.
	 */
	public boolean isChatroomExists(String targetNo) throws Exception {
		logger.info("checking if there is room with chatroomNo {}", targetNo);
		ChatroomsVO roomOfTargetNo = dao.getChatroom(targetNo);
		if (roomOfTargetNo != null) {
			logger.info("{} with {} exist", new String[] { roomOfTargetNo.toString(), targetNo });
			return true;
		} else {
			logger.info("chatroom with {} doesn't exit ", targetNo);
			return false;
		}
	}

}
