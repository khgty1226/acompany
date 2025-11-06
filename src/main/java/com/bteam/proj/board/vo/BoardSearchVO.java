package com.bteam.proj.board.vo;

import com.bteam.proj.common.vo.PagingVO;

public class BoardSearchVO extends PagingVO{
	
	private String boardCode;
	private String memNo;
	private String searchType;
	private String searchWord;
	private String searchCategory;
	
	public String getBoardCode() {
		return boardCode;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public void setBoardCode(String boardCode) {
		this.boardCode = boardCode;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public String getSearchCategory() {
		return searchCategory;
	}
	public void setSearchCategory(String searchCategory) {
		this.searchCategory = searchCategory;
	}
	
	@Override
	public String toString() {
		return "BoardSearchVO [boardCode=" + boardCode + ", memNo=" + memNo + ", searchType=" + searchType
				+ ", searchWord=" + searchWord + ", searchCategory=" + searchCategory + "]";
	}
	
	
	
	
	
	
	
}