package com.bteam.proj.mileageshop.vo;

import com.bteam.proj.common.vo.PagingVO;

public class ProdLogSearchVO extends PagingVO{
	private String startDate;
	private String endDate;
	private String searchState;
	
	public ProdLogSearchVO() {
		
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
	public ProdLogSearchVO(String startDate, String endDate, String searchState) {
		super();
		this.startDate = startDate;
		this.endDate = endDate;
		this.searchState = searchState;
	}
	@Override
	public String toString() {
		return "ProdLogSearchVO [startDate=" + startDate + ", endDate=" + endDate + ", searchState=" + searchState
				+ "]";
	}
	public String getSearchState() {
		return searchState;
	}
	public void setSearchState(String searchState) {
		this.searchState = searchState;
	}

	
	
	
}
