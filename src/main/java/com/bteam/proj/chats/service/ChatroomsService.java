package com.bteam.proj.chats.service;

import java.time.ZonedDateTime;
import java.util.List;

import com.bteam.proj.chats.vo.ChatroomsVO;

public interface ChatroomsService {
	public List<ChatroomsVO> getAllChatrooms();

	/**
	 * return the chatroom having ChatroomNo of param
	 * 
	 * @param chatRoomNo used to run the query
	 * @return ChatroomsVO of targeted by chatRoomNo
	 */
	public ChatroomsVO getChatroom(String chatroomNo);

	/**
	 * return the List of ChatroomsVO having ChatroomName of param
	 * 
	 * @param chatroomName which will be targeted
	 * @return List of ChatroomsVO which is matched with chatroomName
	 */
	public List<ChatroomsVO> getChatrooms(String chatroomName);

	/**
	 * return the List of ChatroomsVO having same ChatroomOwner of param
	 * 
	 * @param chatroomOwner who has the rooms
	 * @return List of ChatroomsVo which is controlled by the ChatroomOwner
	 */
	public List<ChatroomsVO> getChatroomsOf(String chatroomOwner);

	/**
	 * Checking the closed state of target
	 * 
	 * @param target primary key of the record in Rooms Table
	 * @return true if closed, false if not or error.
	 */
	public boolean getIsClosedof(String target);

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
	public int createChatroomBy(String chatroomMaker, String chatroomName, ZonedDateTime openDatetime) ;
	/**
	 * put the already made Vo int obj.
	 * @param obj the ChatroomsVO contains all the info already
	 * @return int of affected number, less or more than 1 give warning. 
	 */
	public int insertByVo(ChatroomsVO obj);

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
	public int destroyChatroom(String targetNo) ;
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
	public int changeChatroomName(String targetNo, String newName);

	/**
	 * Since it is manipulating the primary key In most cases , this method will not
	 * used stand-alone. upper service layer will check every dependency and change
	 * all they required
	 * 
	 * @param targetNo      is the original target ChatroomNo
	 * @param newChatroomNo will be new chatroomNo
	 * @return int number of records affected
	 */
	public int changeChatroomNo(String targetNo, String newChatroomNo);

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
	public int changeChatroomOwner(String targetNo, String ownerNew);
	
	/**
	 * mark 'closed' the room.
	 * @param targetNo the target ChatroomNo which will be closed
	 * @return number of affected records
	 */
	public int closeChatroomByNo(String targetNo);
	/**
	 * this converts the Member and the roomname into md5ed hash this hash will also
	 * used check if the user is owner or not.
	 * 
	 * @param String Memberinput
	 * @return String 32Byte MD5-hashed input
	 */
	public String roomNoFrom(String memberNo, String roomName, ZonedDateTime dtWithZone) throws Exception ;

	/**
	 * checking if there is chatroom already exists based on primary key
	 * 
	 * @return true if there is existance of chatrooms record with given record,
	 *         false if not.
	 */
	public boolean isChatroomExists(String targetNo) throws Exception ;
}
