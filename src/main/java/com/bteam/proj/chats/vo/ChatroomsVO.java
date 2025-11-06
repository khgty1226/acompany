package com.bteam.proj.chats.vo;

import java.time.ZonedDateTime;

public class ChatroomsVO {
	private String chatroomNo;
	private String chatroomName;
	private String chatroomOwner;
	private boolean isClosed;
	private ZonedDateTime openDatetime;
	
	public String getChatroomNo() {
		return chatroomNo;
	}
	public void setChatroomNo(String chatroomNo) {
		this.chatroomNo = chatroomNo;
	}
	public String getChatroomName() {
		return chatroomName;
	}
	public void setChatroomName(String chatroomName) {
		this.chatroomName = chatroomName;
	}
	public String getChatroomOwner() {
		return chatroomOwner;
	}
	public void setChatroomOwner(String chatroomOwner) {
		this.chatroomOwner = chatroomOwner;
	}
	public boolean isClosed() {
		return isClosed;
	}
	public void setClosed(boolean isClosed) {
		this.isClosed = isClosed;
	}
	public ZonedDateTime getOpenDatetime() {
		return openDatetime;
	}
	public void setOpenDatetime(ZonedDateTime openDatetime) {
		this.openDatetime = openDatetime;
	}
	@Override
	public String toString() {
		return "ChatroomsVO [chatroomNo=" + chatroomNo + ", chatroomName=" + chatroomName + ", chatroomOwner="
				+ chatroomOwner + ", isClosed=" + isClosed + ", openDatetime=" + openDatetime + "]";
	}



}
