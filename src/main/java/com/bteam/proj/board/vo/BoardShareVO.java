package com.bteam.proj.board.vo;

public class BoardShareVO {
	
	private String memNo;
	private String boardNo;
	private String shState;
	
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
	public String getShState() {
		return shState;
	}
	public void setShState(String shState) {
		this.shState = shState;
	}
	
	@Override
	public String toString() {
		return "BoardShareVO [memNo=" + memNo + ", boardNo=" + boardNo + ", shState=" + shState + "]";
	}
	
	
}
