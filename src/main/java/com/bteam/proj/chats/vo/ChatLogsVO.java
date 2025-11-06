package com.bteam.proj.chats.vo;

import java.time.ZonedDateTime;

public class ChatLogsVO {
	private String chatroomNo;
	private String memNo;
	private String chatContent;
	private ZonedDateTime chatTime;
	
	public ChatLogsVO() {}

	public ChatLogsVO(String chatroomNo, String memNo, String chatContent, ZonedDateTime chatTime) {
		super();
		this.chatroomNo = chatroomNo;
		this.memNo = memNo;
		this.chatContent = chatContent;
		this.chatTime = chatTime;
	}

	public String getChatroomNo() {
		return chatroomNo;
	}

	public void setChatroomNo(String chatroomNo) {
		this.chatroomNo = chatroomNo;
	}

	public String getMemNo() {
		return memNo;
	}

	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}

	public String getChatContent() {
		return chatContent;
	}

	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}

	public ZonedDateTime getChatTime() {
		return chatTime;
	}

	public void setChatTime(ZonedDateTime chatTime) {
		this.chatTime = chatTime;
	}

	@Override
	public String toString() {
		return "ChatLogsVO [chatroomNo=" + chatroomNo + ", memNo=" + memNo + ", chatContent=" + chatContent
				+ ", chatTime=" + chatTime + "]";
	}
	

	
}
