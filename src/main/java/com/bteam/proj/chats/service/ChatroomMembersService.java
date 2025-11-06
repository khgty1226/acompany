package com.bteam.proj.chats.service;

import java.util.List;

import com.bteam.proj.chats.vo.ChatroomMembersVO;

public interface ChatroomMembersService {
	/**
	 * simply, returns all Chatroom-Members connections
	 * 
	 * @return List<ChatroomMembers> which contains all the information in the
	 *         database of ChatroomMembers
	 */
	public List<ChatroomMembersVO> getChatroomMembers();
	/**
	 *  returns ChatroomMembers where a specific Member is in
	 * @param targetMemberNo the filter
	 * @return List<ChatroomMembersVO> the relations of Chatroom and Member where the targetMembers are in
	 */
	public List<ChatroomMembersVO> getChatroomMembersByMemberNo(String targetMemberNo);
	
	/**
	 *  returns ChatroomMembers where a specific chatroom is related with 
	 * @param targetChatroomNo the filter
	 * @return List<ChatroomMembersVO> the filtered relations of Chatroom and Member WHere the targetChatroomNo is located.
	 */
	public List<ChatroomMembersVO> getChatroomMembersByChatroomNo(String targetChatroomNo);

	/**
	 * change the Member in everywhere from fromMember of FromMemberNo's to toMember of toMemberNo's
	 * 
	 * @param fromMemberNo the original Member's memNo
	 * @param toMemberNo the replaceMental Member's memNo
	 * @return the number of affections
	 */
	public int updateMemersByNo(String fromMemberNo, String toMemberNo) ;
	/**
	 * move A Member with targetMemberNo from fromChatroomNo to toChatroomNo
	 * 
	 * @param targetMemberNo the target would be moved
	 * @param fromChatroomNo where is the target Member is originated
	 * @param toChatroomNo where is the target Member is headed
	 * @return the number of Affected
	 */
	public int moveMemberByNo(String targetMemberNo, String fromChatroomNo, String toChatroomNo) ;
	/**
	 * Inserting the member of TargetmemberNo to ChatroomNo
	 * 
	 * @param targetMemberNo the target Member's memNo
	 * @param toChatroomNo the destination's  Chatroomno
	 * @return int the number of affcetion
	 */
	public int insertMemberByNo(String targetMemberNo,String toChatroomNo) ;
	/**
	 * removing targeted member from the room specified by fromChatroomNo 
	 * 
	 * @param targetMemberNo the target Member's memNo
	 * @param fromChatroomNo where the member would be removed
	 * @return int number of removed member by action
	 */
	public int removeMemberByNo(String targetMemberNo, String fromChatroomNo) ;
	/**
	 * Checking if the Member is in the Chatroom 
	 * @param chatroomNo
	 * @param memberNo
	 * @return
	 * @throws Exception
	 */
	public boolean isMembersExistsInChatroom(String chatroomNo, String memberNo) throws Exception ;
}
