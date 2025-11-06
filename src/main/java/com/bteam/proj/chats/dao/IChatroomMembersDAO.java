package com.bteam.proj.chats.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bteam.proj.chats.vo.ChatroomMembersVO;
import com.bteam.proj.chats.vo.ChatroomsVO;
import com.bteam.proj.member.vo.MemberVO;
@Mapper
public interface IChatroomMembersDAO {

    // 모든 채팅방에 참여한 모든 멤버 조회
    public List<ChatroomMembersVO> getChatroomMembers();

    // 특정 멤버가 존재하는 모든 채팅방-멤버 조회
//    public List<ChatroomMembersVO> getChatroomMembersByMemberVo(MemberVO targetMember);

    public List<ChatroomMembersVO> getChatroomMembersByMemberNo(String targetMemberNo);

    // 특정 채팅방에 참여한 모든 채팅방-멤버 조회
//    public List<ChatroomMembersVO> getChatroomMembersByChatroomsVo(ChatroomsVO targetChatroom);

    public List<ChatroomMembersVO> getChatroomMembersByChatroomNo(String targetChatroomNo);

    // update
    // 특정 채팅방에 있는 멤버 전부를 다른 채팅방으로 이동 - upper layer : 느리고 데드락 발
//    public int swapMembersByVo(@Param("fromChatroom") ChatroomsVO fromChatroom, @Param("toChatroom") ChatroomsVO toChatroom);

 //   public int swapMembersInByNo(@Param("fromChatroomNo") String fromChatroomNo, @Param("toChatroomNo") String toChatroomNo);

    // 전체 채팅방의 특정 멤버를 다른 멤버로 변경
//    public int updateMemberByVo(@Param("fromMember") MemberVO fromMember, @Param("toMember") MemberVO toMember);

    public int updateMemberByNo(@Param("fromMemberNo") String fromMemberNo, @Param("toMemberNo") String toMemberNo);

    // 특정 채팅방에 있는 특정 멤버를 다른 채팅방으로 이동
//    public int moveMemberByVo(@Param("targetMember") MemberVO targetMember, @Param("fromChatroom") ChatroomsVO fromChatroom, @Param("toChatroom") ChatroomsVO toChatroom);

    public int moveMemberByNo(@Param("targetMemberNo") String targetMemberNo, @Param("fromChatroomNo") String fromChatroomNo, @Param("toChatroomNo") String toChatroomNo);

    // insert
    // 특정 멤버의 특정 채팅방 참여
//    public int insertMemberByVo(@Param("targetMember") MemberVO targetMember, @Param("toChatroom") ChatroomsVO toChatroom);

    public int insertMemberByNo(@Param("targetMemberNo") String targetMemberNo, @Param("toChatroomNo") String toChatroomNo);

    // delete
    // 특정 멤버와 특정 채팅방의 연결 삭제
//    public int removeMemberByVo(@Param("targetMember") MemberVO targetMember, @Param("fromChatroom") ChatroomsVO fromChatroom);

    public int removeMemberByNo(@Param("targetMemberNo") String targetMemberNo, @Param("fromChatroomNo") String fromChatroomNo);
}
