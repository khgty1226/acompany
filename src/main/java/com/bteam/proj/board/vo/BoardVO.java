package com.bteam.proj.board.vo;

public class BoardVO {
	private int boardNo;
	private String boardCategory;
	private String boardTitle;
	private String boardContent;
	private String memNo;
	private String boardDate;
	private int boardHit;
	private int boardLike;
	private String boardImgUrl;
	private String boardDelYn;

	public BoardVO(int boardNo, String boardCategory, String boardTitle, String boardContent, String memNo,
			String boardDate, int boardHit, int boardLike, String boardImgUrl, String boardDelYn) {
		this.boardNo = boardNo;
		this.boardCategory = boardCategory;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.memNo = memNo;
		this.boardDate = boardDate;
		this.boardHit = boardHit;
		this.boardLike = boardLike;
		this.boardImgUrl = boardImgUrl;
		this.boardDelYn = boardDelYn;
	}

	public BoardVO() {
	}

	@Override
	public String toString() {
		return "BoardVO [boardNo=" + boardNo + ", boardCategory=" + boardCategory + ", boardTitle=" + boardTitle
				+ ", boardContent=" + boardContent + ", memNo=" + memNo + ", boardDate=" + boardDate + ", boardHit="
				+ boardHit + ", boardLike=" + boardLike + ", boardImgUrl=" + boardImgUrl + ", boardDelYn=" + boardDelYn
				+ "]";
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getBoardCategory() {
		return boardCategory;
	}

	public void setBoardCategory(String boardCategory) {
		this.boardCategory = boardCategory;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public String getMemNo() {
		return memNo;
	}

	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}

	public String getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(String boardDate) {
		this.boardDate = boardDate;
	}

	public int getBoardHit() {
		return boardHit;
	}

	public void setBoardHit(int boardHit) {
		this.boardHit = boardHit;
	}

	public int getBoardLike() {
		return boardLike;
	}

	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}

	public String getBoardImgUrl() {
		return boardImgUrl;
	}

	public void setBoardImgUrl(String boardImgUrl) {
		this.boardImgUrl = boardImgUrl;
	}

	public String getBoardDelYn() {
		return boardDelYn;
	}

	public void setBoardDelYn(String boardDelYn) {
		this.boardDelYn = boardDelYn;
	}
	
	
}

