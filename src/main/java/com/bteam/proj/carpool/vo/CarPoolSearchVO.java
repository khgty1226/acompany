package com.bteam.proj.carpool.vo;

import com.bteam.proj.common.vo.PagingVO;

public class CarPoolSearchVO extends PagingVO{
	private String searchWord;
	private String searchCategory;
	private String startDate;
	private String endDate;
	private String cpGoOut;
	private String cpState;
	private String memNo;
	
	
	public String getCpState() {
		return cpState;
	}
	public void setCpState(String cpState) {
		this.cpState = cpState;
	}
	public CarPoolSearchVO(String searchWord, String searchCategory, String startDate, String endDate, String cpGoOut,
			String cpState, String memNo) {
		super();
		this.searchWord = searchWord;
		this.searchCategory = searchCategory;
		this.startDate = startDate;
		this.endDate = endDate;
		this.cpGoOut = cpGoOut;
		this.cpState = cpState;
		this.memNo = memNo;
	}
	@Override
	public String toString() {
		return "CarPoolSearchVO [searchWord=" + searchWord + ", searchCategory=" + searchCategory + ", startDate="
				+ startDate + ", endDate=" + endDate + ", cpGoOut=" + cpGoOut + ", cpState=" + cpState + ", memNo="
				+ memNo + "]";
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
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
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getCpGoOut() {
		return cpGoOut;
	}
	public void setCpGoOut(String cpGoOut) {
		this.cpGoOut = cpGoOut;
	}
	
	
}
