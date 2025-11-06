package com.bteam.proj.chats.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bteam.proj.chats.vo.ChatroomsVO;

@Mapper
public interface IChatroomsDAO {
	
	
	//select
	//전체 채팅방 조회
	public List<ChatroomsVO> getAllChatrooms();
	//채팅방 ID를 이용한 채팅방 조회
	public ChatroomsVO getChatroom(String chatroomNo);
	//채팅방 이름을 이용한 채팅방 리스트 조회
	public List<ChatroomsVO> getChatrooms(String chatroomName);
	//채팅방 주인을 이용한 채팅방 리스트 조회
	public List<ChatroomsVO> getChatroomsOf(String chatroomOwner);
	public String getIsClosedOf(String chatroomNo);
	//채팅방 전체 갯수 these are conflicted with getChatroom - getChatroom contains all info
//	public int getChatroomsCount();
	//채팅방의 방장 확인
//	public String getChatroomOwner(String targetNo);
	
	//insert
	//채팅방 생성
	//id : 생성자+timestamp MD5함수
	public int newChatroom(ChatroomsVO newRoom);
	
	//update
	//채팅방 NO 수정
	public int changeChatroomNo(@Param("targetNo")String targetNo,@Param("newChatroomNo")String newChatroomNo);
	//채팅방 이름을 수정
	public int changeChatroomName(@Param("targetNo") String targetNo,@Param("newName") String newName);
	//채팅방 주인(방장) 변경
	public int changeChatroomOwner(@Param("targetNo") String targetNo,@Param("ownerNew") String ownerNew);
	//방 열림상태 설정
	public int setIsClosedChatroom(@Param("String") String targetNo,@Param("isClosed") boolean isClosed);
	//방 열림
	public int closeChatroom(@Param("targetNo") String targetNo);
	//방 닫힘
	public int openChatroom(@Param("targetNo") String targetNo);
	//delete
	//채팅방 id로 채팅방 제거
	public int removeChatroom(String targetNo);
	
	
	
}
