package com.bteam.proj.board.vo;

public class HeartVO {
	
	private String memNo;			// 회원 아이디
	private String boardNo;			// 게시판 번호
	private String heartDelYn;		// 현재 좋아요 여부
	private String heartDate;		// 좋아요 날짜
	private int heartCnt;
	
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}
	public String getHeartDelYn() {
		return heartDelYn;
	}
	public void setHeartDelYn(String heartDelYn) {
		this.heartDelYn = heartDelYn;
	}
	public String getHeartDate() {
		return heartDate;
	}
	public void setHeartDate(String heartDate) {
		this.heartDate = heartDate;
	}
	public int getHeartCnt() {
		return heartCnt;
	}
	public void setHeartCnt(int heartCnt) {
		this.heartCnt = heartCnt;
	}
	
	@Override
	public String toString() {
		return "HeartSaveVO [memNo=" + memNo + ", boardNo=" + boardNo + ", heartDelYn=" + heartDelYn + ", heartDate="
				+ heartDate + ", heartCnt=" + heartCnt + "]";
	}
	
	
	
	
	
	
	
}
