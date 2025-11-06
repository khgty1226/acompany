package com.bteam.proj.board.vo;

public class SaveVO {
	
	private String memNo;			// 회원 아이디
	private String boardNo;			// 게시판 번호
	private String saveDelYn;		// 현재 저장 여부
	private String saveDate;		// 저장 날짜
	private int saveCnt;
	
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
	public String getSaveDelYn() {
		return saveDelYn;
	}
	public void setSaveDelYn(String saveDelYn) {
		this.saveDelYn = saveDelYn;
	}
	public String getSaveDate() {
		return saveDate;
	}
	public void setSaveDate(String saveDate) {
		this.saveDate = saveDate;
	}
	public int getSaveCnt() {
		return saveCnt;
	}
	public void setSaveCnt(int saveCnt) {
		this.saveCnt = saveCnt;
	}
	
	@Override
	public String toString() {
		return "SaveVO [memNo=" + memNo + ", boardNo=" + boardNo + ", saveDelYn=" + saveDelYn + ", saveDate=" + saveDate
				+ ", saveCnt=" + saveCnt + "]";
	}
	
	
	
}
