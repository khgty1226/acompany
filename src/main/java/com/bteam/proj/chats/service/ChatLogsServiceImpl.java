package com.bteam.proj.chats.service;

import java.time.ZonedDateTime;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bteam.proj.chats.dao.IChatLogsDAO;
import com.bteam.proj.chats.vo.ChatLogsVO;

@Service
public class ChatLogsServiceImpl implements ChatLogsService {
	private static final Logger logger = LoggerFactory.getLogger(ChatLogsServiceImpl.class);

	@Autowired
	private IChatLogsDAO dao;
	
	// select
	/**
	 * retrieve the Chat Logs that were written by the targetMember
	 * 
	 * @param targetMemberNo is the one we are looking for whom write the logs
	 * @return list of ChatLogsVO which contains the logs written by targetmemberNo
	 *         return null when error occurs
	 */
	public List<ChatLogsVO> getLogsOfByNo(String targetMemberNo) {
		logger.info("getting the list of Chatlogs written by " + targetMemberNo);
		try {
			return dao.getLogsOfByNo(targetMemberNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * retrieve the Chat logs that were written in certain room targetChatroom
	 * 
	 * @param targetChatroomNo is where the chat log is written in.
	 * @return list of Chat logs in which the room possess. return null when error
	 *         occurs
	 */
	public List<ChatLogsVO> getLogsInByNo(String targetChatroomNo) {
		logger.info("getting the list of Chatlogs in the Chatroom" + targetChatroomNo);
		try {
			return dao.getLogsInByNo(targetChatroomNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 
	 * retrieve the chat logs was written in certain time range
	 * 
	 * @param start the time of searching standard will start to check out
	 * @param end   the time of searching standard will end to check out
	 * @return the list of chat logs written between the time of start and end
	 *         return null when error occurs
	 */
	public List<ChatLogsVO> getLogsBetweenByZonedDateTime(ZonedDateTime start, ZonedDateTime end) {
		logger.info("getting the list of Chatlogs between the ZonedDateTimes {} and {}", new ZonedDateTime[] { start, end });
		try {
			List<ChatLogsVO> result =dao.getLogsBetweenByZonedDateTime(start, end);
			logger.info("the taken Chatlogs : {}", result.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * retrieve the chat logs which contains certain string
	 * 
	 * @param content of which are looked for in the Chatroom
	 * @return list of chat logs that contains parameter String return null when
	 *         error occurs
	 */
	public List<ChatLogsVO> getLogsHaving(String content) {
		logger.info("getting the Chatlogs contains following string : " + content);
		try {
			return dao.getLogsHaving(content);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// update
	/**
	 * change the ownership of the chatlogs from fromMember to tomember
	 * 
	 * @param fromMemberNo original member who own thier chat logs
	 * @param toMemberNo   new Owner of chat logs
	 * @return number of affected. -1: error, 0: nothing , 1+: affected
	 */
	public int updateMemberOfChatlogsByNo(String fromMemberNo, String toMemberNo) {
		logger.info("updating the Ownership of chatlogs written by {} to {} ",
				new String[] { fromMemberNo, toMemberNo });
		try {
			int result = 0;
			result = dao.updateMemberOfChatLogsByNo(fromMemberNo, toMemberNo);
			logger.info((result) == 0 ? "nothing have been affected" : result + " number of Chatlogs are affected");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * change the Chatroom of certain chat logs into new one
	 * 
	 * @param fromChatroomNo the original chatroom which contains the chatlogs
	 * @param toChatroomNo   new chatroom which will get all chat logs of original
	 *                       chatroom
	 * @return number of affected chatlogs -1 :error , 0 : nothing , 1+ : affected
	 */
	public int updateChatroomOfChatLogsByNo(String fromChatroomNo, String toChatroomNo) {
		logger.info("updating the Chatroom of where the Chatlogs were included from {} to {}",
				new String[] { fromChatroomNo, toChatroomNo });
		try {
			int result = 0;
			result = dao.updateChatroomOfChatLogsByNo(fromChatroomNo, toChatroomNo);
			logger.info((result) == 0 ? "nothing have been affected" : result + " number of Chatlogs are affected ");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * change the ZonedDateTime of certain ranged Chatlogs by adding minutes
	 * 
	 * @param start  starting ZonedDateTime where the addition would be affected.
	 * @param end    ending ZonedDateTime where the addition would be affected
	 * @param minute amount of time will be added to the ZonedDateTime
	 * @return number of affected -1 : error 0: nothing 1+: affected
	 */
	public int updateZonedDateTimeOfChatLogsByVo(ZonedDateTime start, ZonedDateTime end, int minute) {
		logger.info("updating the Timerange of Chatlogs from {} to {} by adding {} minutes",
				new Object[] { start, end, minute });
		try {
			int result = 0;
			result = dao.updateZonedDateTimeOfChatLogsByVo(start, end, minute);
			logger.info((result) == 0 ? "nothing have been affected" : result + "number of Chatlogs are affected");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int updateContentOfChatLogsByVo(ChatLogsVO fromChatLogs, String toContent) {
		logger.info("updating the content of {} from {} to {}",
				new String[] { fromChatLogs.toString(), fromChatLogs.getChatContent(), toContent });
		try {
			int result = 0;
			result = dao.updateContentOfChatLogsByVo(fromChatLogs, toContent);
			logger.info((result) == 0 ? "nothing have been affected ":result +"number of Chatlogs are affected");
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// insert
	/**
	 * inserting new chatlogs into database.
	 * 
	 * @param newLog the chat log bean will be insert into database
	 * @return int the number of affected -1: error , 0: failed, 1: success, 1+ :
	 *         something went wrong
	 */
	public int insertChatLog(ChatLogsVO newLog) {
		logger.info("inserting the Chatlogs " + newLog);
		try {
			int result = 0;
			result = dao.insertChatLog(newLog);
			logger.info((result) == 0 ? "no Logs are entered"
					: result + ": number of Chatlog is entered, check the code if this goes over 1");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// delete
	/**
	 * deleting the Chat logs in certain room
	 * 
	 * @param chatroomNo the standard of where target Chatlogs are stays in
	 * @return the number affected logs -1: error , 0: failed, 1+: success something
	 *         went wrong
	 */
	public int deleteChatLogsInByNo(String chatroomNo) {
		logger.info("deleting Chatlogs in the room of " + chatroomNo);
		try {
			int result = 0;
			result = dao.deleteChatLogsInByNo(chatroomNo);
			logger.info((result) == 0 ? "nothing have been affected" : result + "number of Chatlogs are affected");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1;
	}

	/**
	 * deleting the chat logs owned by specific user
	 * 
	 * @param targetMemberNo who write chat logs
	 * @return number of affected -1: error , 0: failed, 1+: success
	 */
	public int deleteChatLogsOfByNo(String targetMemberNo) {
		logger.info("deleting Chatlogs written by the targetNo " + targetMemberNo);
		try {
			int result = 0;
			result = dao.deleteChatLogsOfByNo(targetMemberNo);
			logger.info((result) == 0 ? "nothing have been affected" : result + "number of Chatlogs are affected");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * deleting the chat logs in specific timerange
	 * 
	 * @param start the standard of when the chat logs are wiped out.
	 * @param end   the standard of when the chat logs are wiped out.
	 * @return -1: error , 0: failed, 1+: success
	 */
	public int deleteChatLogsBetween(ZonedDateTime start, ZonedDateTime end) {
		logger.info("deleting Chatlogs between timerange {} and {} ", new ZonedDateTime[] { start, end });
		try {
			int result = 0;
			result = dao.deleteChatLogsBetween(start, end);
			logger.info((result) == 0 ? "nothing have been affected" : result + "nubmer of Chatlogs are affected");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	/**
	 * combination of the two deleting condition : specific member and chatroom
	 * 
	 * @param memNo      the member whose chatlogs would be deleted
	 * @param chatroomNo room of where the chatlogs would be deleted;
	 * @return number of deleted Chatlogs
	 */
	public int deleteScentOfMemberFromChatroom(String memNo, String chatroomNo) {
		logger.info("deleting Chatlogs from {} owned by {}", new String[] { chatroomNo,memNo });
		try {
			int result = 0;
			result = dao.deleteScentOfMemberFromChatroom(memNo, chatroomNo);
			logger.info((result) == 0 ? "nothing have been affected" : result + "number of Chatlogs are affected");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1;
	}

	/**
	 * very specified deleting condition : specific chatroom's member's chatlogs
	 * from start time to end time
	 * 
	 * @param memNo
	 * @param chatroomNo
	 * @param start
	 * @param end
	 * @return
	 */
	public int deleteChatLogsSpecific(String memNo, String chatroomNo, ZonedDateTime start, ZonedDateTime end) {
		logger.info("deleting some specific chatlog in {} written by {} from {} to {} ",
				new Object[] { memNo, chatroomNo, start, end });
		try {
			int result = 0;
			result = dao.deleteChatLogsSpecific(memNo, chatroomNo, start, end);
			logger.info((result) == 0 ? "nothing have been affected" : result + "number of changes are affected");
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}
