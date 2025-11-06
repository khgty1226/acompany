package com.bteam.proj.chats.vo;

public class ChatroomMembersVO {

	public ChatroomMembersVO() {
	}
	
	public ChatroomMembersVO(String chatroomNo, String memberNo) {
		super();
		this.chatroomNo = chatroomNo;
		this.memberNo = memberNo;
	}

	private String chatroomNo;
	
	public String getChatroomNo() {
		return chatroomNo;
	}
	
	public void setChatroomNo(String chatroomNo) {
		this.chatroomNo = chatroomNo;
	}
	
	private String memberNo;
	
	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}

	@Override
	public String toString() {
		return "ChatroomMembersVO [chatroomNo=" + chatroomNo + ", memberNo=" + memberNo + "]";
	}
	
	
}
