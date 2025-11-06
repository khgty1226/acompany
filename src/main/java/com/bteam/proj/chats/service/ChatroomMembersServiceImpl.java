package com.bteam.proj.chats.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bteam.proj.chats.dao.IChatroomMembersDAO;
import com.bteam.proj.chats.vo.*;

@Service
public class ChatroomMembersServiceImpl implements ChatroomMembersService {
	private static final Logger logger = LoggerFactory.getLogger(ChatroomMembersServiceImpl.class);

	@Autowired
	private IChatroomMembersDAO dao;
	

	/**
	 * simply, returns all Chatroom-Members connections
	 * 
	 * @return List<ChatroomMembers> which contains all the information in the
	 *         database of ChatroomMembers
	 */
	public List<ChatroomMembersVO> getChatroomMembers() {
		try {
			logger.info("Returning all the ChatroomMembers");
			return dao.getChatroomMembers();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 *  returns ChatroomMembers where a specific Member is in
	 * @param targetMemberNo the filter
	 * @return List<ChatroomMembersVO> the relations of Chatroom and Member where the targetMembers are in
	 */
	public List<ChatroomMembersVO> getChatroomMembersByMemberNo(String targetMemberNo) {
		try {
			logger.info("Returning the chatroomMembers with MemberNo {}", targetMemberNo);
			return dao.getChatroomMembersByMemberNo(targetMemberNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 *  returns ChatroomMembers where a specific chatroom is related with 
	 * @param targetChatroomNo the filter
	 * @return List<ChatroomMembersVO> the filtered relations of Chatroom and Member WHere the targetChatroomNo is located.
	 */
	public List<ChatroomMembersVO> getChatroomMembersByChatroomNo(String targetChatroomNo) {
		try {
			logger.info("Returning the chatroomMembers with ChatroomNo {}", targetChatroomNo);
			return dao.getChatroomMembersByChatroomNo(targetChatroomNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
//	/** should be in upper layer - dealock and loop?
//	 * changing ChatroomNo of certain room's chatroomMembers from fromChatroomNo to toChatroomNo
//	 * 
//	 * @param fromChatroomNo the room where is the origin
//	 * @param toChatroomNo the room where is the destination
//	 * @return int number of records affected
//	 */
//	public int swapMembersByNo(String fromChatroomNo, String toChatroomNo) {
//		try {
//			int result = 0;
//			logger.info("moving all the members {} to {} , who is not in there",
//					new String[] { fromChatroomNo, toChatroomNo });
//			result = dao.swapMembersInByNo(fromChatroomNo, toChatroomNo);
//			logger.info((result) == 0 ? "nothing affected" : result + " number of members were swapped");
//			return result;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return -1;
//	}
	/**
	 * change the Member in everywhere from fromMember of FromMemberNo's to toMember of toMemberNo's
	 * 
	 * @param fromMemberNo the original Member's memNo
	 * @param toMemberNo the replaceMental Member's memNo
	 * @return the number of affections
	 */
	public int updateMemersByNo(String fromMemberNo, String toMemberNo) {
		try {
			int result = 0;
			logger.info("changing the member {} in everywhere to {}", new String[] { fromMemberNo, toMemberNo });
			result = dao.updateMemberByNo(fromMemberNo, toMemberNo);
			logger.info((result) == 0 ? "nothing affected"
					: "member " + fromMemberNo + " is swapped to " + toMemberNo + " in " + result + " room(s) ");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	/**
	 * move A Member with targetMemberNo from fromChatroomNo to toChatroomNo
	 * 
	 * @param targetMemberNo the target would be moved
	 * @param fromChatroomNo where is the target Member is originated
	 * @param toChatroomNo where is the target Member is headed
	 * @return the number of Affected
	 */
	public int moveMemberByNo(String targetMemberNo, String fromChatroomNo, String toChatroomNo) {
		try {
			int result = 0;
			logger.info("moving member {} from {} to {}",
					new String[] { targetMemberNo, fromChatroomNo, toChatroomNo });
			result = dao.moveMemberByNo(targetMemberNo, fromChatroomNo, toChatroomNo);
			logger.info((result) == 0 ? "nothing affected"
					: "member " + targetMemberNo + "is moved to " + toChatroomNo + " from " + toChatroomNo);
			if(result ==0) {
				System.out.println("move result : "+result+" , perhaps the user is not in the room");
			}else if(result != 1)logger.info("something went wrong the result must be 1 or 0 but "+result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	/**
	 * Inserting the member of TargetmemberNo to ChatroomNo
	 * 
	 * @param targetMemberNo the target Member's memNo
	 * @param toChatroomNo the destination's  Chatroomno
	 * @return int the number of affcetion
	 */
	public int insertMemberByNo(String targetMemberNo,String toChatroomNo) {
		try {
			int result = 0;
			logger.info("inserting member {} to {} ",targetMemberNo,toChatroomNo);
			result = dao.insertMemberByNo(targetMemberNo, toChatroomNo);
			logger.info((result) == 0 ? "nothing affected"
					: "member " + targetMemberNo + "is inserted to " + toChatroomNo);
			if(result != 1)logger.info("number of inserted Member:"+result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	/**
	 * removing targeted member from the room specified by fromChatroomNo 
	 * 
	 * @param targetMemberNo the target Member's memNo
	 * @param fromChatroomNo where the member would be removed
	 * @return int number of removed member by action
	 */
	public int removeMemberByNo(String targetMemberNo, String fromChatroomNo) {
		try {
			int result = 0;
			logger.info("removing member {} from {}",targetMemberNo,fromChatroomNo);
			result = dao.removeMemberByNo(targetMemberNo, fromChatroomNo);
			logger.info((result) == 0 ? "nothing affected"
					: "member " + targetMemberNo + "is removed from" +fromChatroomNo);
			if(result != 1)logger.info("something went wrong the result must be 1 but "+result);			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	/**
	 * Checking if the Member is in the Chatroom 
	 * @param chatroomNo
	 * @param memberNo
	 * @return
	 * @throws Exception
	 */
	public boolean isMembersExistsInChatroom(String chatroomNo, String memberNo) throws Exception {
		List<ChatroomMembersVO> temps = dao.getChatroomMembers();
		for (ChatroomMembersVO temp : temps) {
			if (temp.getChatroomNo().equals("chatroom") && temp.getMemberNo().equals("memberNo")) {
				return true;
			}
		}
		return false;
	}

}
