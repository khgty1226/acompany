package com.bteam.proj.chats.dao;

import java.time.ZonedDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param; // Add this import for @Param annotation

import com.bteam.proj.chats.vo.ChatLogsVO;
import com.bteam.proj.chats.vo.ChatroomMembersVO;
import com.bteam.proj.chats.vo.ChatroomsVO;
import com.bteam.proj.member.vo.MemberVO;

@Mapper
public interface IChatLogsDAO {
	// select
	// logs of specific Member
//    public List<ChatLogsVO> getLogsOfByVo(MemberVO targetMember);
	public List<ChatLogsVO> getLogsOfByNo(String targetMemberNo);

	// logs of specific chat room
//    public List<ChatLogsVO> getLogsInByVo(ChatroomsVO targetChatroom);
	public List<ChatLogsVO> getLogsInByNo(String targetChatroomNo);

	// logs of specific timerange
	public List<ChatLogsVO> getLogsBetweenByZonedDateTime(@Param("start") ZonedDateTime start, @Param("end") ZonedDateTime end);

	// logs of specific text contained.
	public List<ChatLogsVO> getLogsHaving(String content);
	// don't forget to add filtering in the service section business logic

	// update
	// update all the logs of specific user to another user's
//    public int updateMemberOfChatLogsByVo(@Param("fromMember") MemberVO fromMember, @Param("toMember") MemberVO toMember);
	public int updateMemberOfChatLogsByNo(@Param("fromMemberNo") String fromMemberNo,
			@Param("toMemberNo") String toMemberNo);

	// update all the logs in specific chatroom to another chatroom's
//    public int updateChatroomOfChatLogsByVo(@Param("fromChatroom") ChatroomsVO fromChatroom, @Param("toChatroom") ChatroomsVO toChatroom);
	public int updateChatroomOfChatLogsByNo(@Param("fromChatroomNo") String fromChatroomNo,
			@Param("toChatroomNo") String toChatroomNo);

	// update all the logs with specific time range by adding ZonedDateTime value
	public int updateZonedDateTimeOfChatLogsByVo(@Param("start") ZonedDateTime start, @Param("end") ZonedDateTime end,
			@Param("minute") int minute);

	// update content of specific log identified by (chatroomNo, memberNo) to
	// chatContent
	public int updateContentOfChatLogsByVo(@Param("fromChatLogs") ChatLogsVO fromChatLogs,
			@Param("toContent") String toContent);
	// indiv updating should be achieved in the Service rather than accomplished in
	// here

	// insert
	// insert chatlog
	public int insertChatLog(ChatLogsVO newLog);

	// delete
	// delete chatlogs in specific room
//    public int deleteChatLogsInByVo(ChatroomsVO chatroom);
	public int deleteChatLogsInByNo(String chatroomNo);

	// delete chatlogs of specific user
//    public int deleteChatLogsOfByVo(MemberVO targetMember);
	public int deleteChatLogsOfByNo(String targetMemberNo);

	// delete chatlogs in timerange
	public int deleteChatLogsBetween(@Param("start") ZonedDateTime start,@Param("end") ZonedDateTime end);

	// deleting the chatlogs in the room written by member
	public int deleteScentOfMemberFromChatroom(@Param("memNo") String memNo , @Param("chatroomNo") String chatroomNo);

	// deleting the chatlog in the room written by member in timerange
	public int deleteChatLogsSpecific(@Param("memNo") String memNo, @Param("chatroomNo") String chatroomNo,
			@Param("start") ZonedDateTime start, @Param("end") ZonedDateTime end);
	// delete chatlogs of specific user in specific room
	// upper service
	// public int deleteChatLogsOfMemberInChatRoom(ChatroomMembersVO
	// targetChatroomMembers);
	// delete chatlogs of specific user in specific room and timerange
//    public int deleteChatLogsOfMemberInChatRoomBetween(@Param("targetChatroomMembers") ChatroomMembersVO targetChatroomMembers, @Param("start") ZonedDateTime start, @Param("end") ZonedDateTime end);
}
