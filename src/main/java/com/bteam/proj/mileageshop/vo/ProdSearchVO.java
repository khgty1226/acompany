package com.bteam.proj.mileageshop.vo;


public class ProdSearchVO extends ProdPagingVO{
	
	private String searchOrder;
	private String searchType;
	private String searchWord;
	private int searchCategory = 300;
	
	public ProdSearchVO() {}

	public String getSearchOrder() {
		return searchOrder;
	}

	public void setSearchOrder(String searchOrder) {
		this.searchOrder = searchOrder;
	}

	@Override
	public String toString() {
		return "ProdSearchVO [searchOrder=" + searchOrder + ", searchType=" + searchType + ", searchWord=" + searchWord
				+ ", searchCategory=" + searchCategory + "]";
	}



	public ProdSearchVO(String searchOrder, String searchType, String searchWord, int searchCategory) {
		super();
		this.searchOrder = searchOrder;
		this.searchType = searchType;
		this.searchWord = searchWord;
		this.searchCategory = searchCategory;
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

	public int getSearchCategory() {
		return searchCategory;
	}

	public void setSearchCategory(int searchCategory) {
		this.searchCategory = searchCategory;
	}

	
}
