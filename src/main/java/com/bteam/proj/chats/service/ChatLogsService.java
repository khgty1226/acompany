package com.bteam.proj.chats.service;

import java.time.ZonedDateTime;
import java.util.List;

import com.bteam.proj.chats.vo.ChatLogsVO;

public interface ChatLogsService {
	// select
		/**
		 * retrieve the Chat Logs that were written by the targetMember
		 * 
		 * @param targetMemberNo is the one we are looking for whom write the logs
		 * @return list of ChatLogsVO which contains the logs written by targetmemberNo
		 *         return null when error occurs
		 */
		public List<ChatLogsVO> getLogsOfByNo(String targetMemberNo) ;

		/**
		 * retrieve the Chat logs that were written in certain room targetChatroom
		 * 
		 * @param targetChatroomNo is where the chat log is written in.
		 * @return list of Chat logs in which the room possess. return null when error
		 *         occurs
		 */
		public List<ChatLogsVO> getLogsInByNo(String targetChatroomNo) ;

		/**
		 * 
		 * retrieve the chat logs was written in certain time range
		 * 
		 * @param start the time of searching standard will start to check out
		 * @param end   the time of searching standard will end to check out
		 * @return the list of chat logs written between the time of start and end
		 *         return null when error occurs
		 */
		public List<ChatLogsVO> getLogsBetweenByZonedDateTime(ZonedDateTime start, ZonedDateTime end) ;

		/**
		 * retrieve the chat logs which contains certain string
		 * 
		 * @param content of which are looked for in the Chatroom
		 * @return list of chat logs that contains parameter String return null when
		 *         error occurs
		 */
		public List<ChatLogsVO> getLogsHaving(String content) ;

		// update
		/**
		 * change the ownership of the chatlogs from fromMember to tomember
		 * 
		 * @param fromMemberNo original member who own thier chat logs
		 * @param toMemberNo   new Owner of chat logs
		 * @return number of affected. -1: error, 0: nothing , 1+: affected
		 */
		public int updateMemberOfChatlogsByNo(String fromMemberNo, String toMemberNo) ;

		/**
		 * change the Chatroom of certain chat logs into new one
		 * 
		 * @param fromChatroomNo the original chatroom which contains the chatlogs
		 * @param toChatroomNo   new chatroom which will get all chat logs of original
		 *                       chatroom
		 * @return number of affected chatlogs -1 :error , 0 : nothing , 1+ : affected
		 */
		public int updateChatroomOfChatLogsByNo(String fromChatroomNo, String toChatroomNo) ;

		/**
		 * change the ZonedDateTime of certain ranged Chatlogs by adding minutes
		 * 
		 * @param start  starting ZonedDateTime where the addition would be affected.
		 * @param end    ending ZonedDateTime where the addition would be affected
		 * @param minute amount of time will be added to the ZonedDateTime
		 * @return number of affected -1 : error 0: nothing 1+: affected
		 */
		public int updateZonedDateTimeOfChatLogsByVo(ZonedDateTime start, ZonedDateTime end, int minute) ;

		public int updateContentOfChatLogsByVo(ChatLogsVO fromChatLogs, String toContent);

		// insert
		/**
		 * inserting new chatlogs into database.
		 * 
		 * @param newLog the chat log bean will be insert into database
		 * @return int the number of affected -1: error , 0: failed, 1: success, 1+ :
		 *         something went wrong
		 */
		public int insertChatLog(ChatLogsVO newLog);
		// delete
		/**
		 * deleting the Chat logs in certain room
		 * 
		 * @param chatroomNo the standard of where target Chatlogs are stays in
		 * @return the number affected logs -1: error , 0: failed, 1+: success something
		 *         went wrong
		 */
		public int deleteChatLogsInByNo(String chatroomNo);

		/**
		 * deleting the chat logs owned by specific user
		 * 
		 * @param targetMemberNo who write chat logs
		 * @return number of affected -1: error , 0: failed, 1+: success
		 */
		public int deleteChatLogsOfByNo(String targetMemberNo);

		/**
		 * deleting the chat logs in specific timerange
		 * 
		 * @param start the standard of when the chat logs are wiped out.
		 * @param end   the standard of when the chat logs are wiped out.
		 * @return -1: error , 0: failed, 1+: success
		 */
		public int deleteChatLogsBetween(ZonedDateTime start, ZonedDateTime end);

		/**
		 * combination of the two deleting condition : specific member and chatroom
		 * 
		 * @param memNo      the member whose chatlogs would be deleted
		 * @param chatroomNo room of where the chatlogs would be deleted;
		 * @return number of deleted Chatlogs
		 */
		public int deleteScentOfMemberFromChatroom(String memNo, String chatroomNo);

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
		public int deleteChatLogsSpecific(String memNo, String chatroomNo, ZonedDateTime start, ZonedDateTime end);

}
