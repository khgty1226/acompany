package com.bteam.proj.board.vo;

public class BoardInfoVO {
	
	private String boardCode;
	private String boardCategoryName;
	
	public BoardInfoVO(String boardCode, String boardCategoryName) {
		super();
		this.boardCode = boardCode;
		this.boardCategoryName = boardCategoryName;
	}

	public String getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(String boardCode) {
		this.boardCode = boardCode;
	}

	public String getBoardCategoryName() {
		return boardCategoryName;
	}

	public void setBoardCategoryName(String boardCategoryName) {
		this.boardCategoryName = boardCategoryName;
	}

	@Override
	public String toString() {
		return "BoardInfoVO [boardCode=" + boardCode + ", boardCategoryName=" + boardCategoryName + "]";
	}
	
	
	
}
