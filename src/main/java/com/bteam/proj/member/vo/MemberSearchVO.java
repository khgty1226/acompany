package com.bteam.proj.member.vo;

import com.bteam.proj.common.vo.PagingVO;

public class MemberSearchVO extends PagingVO{

	private String searchType;
	private String searchWord;
	private String searchDept;
	private String searchTeam;
	
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


	public String getSearchDept() {
		return searchDept;
	}


	public void setSearchDept(String searchDept) {
		this.searchDept = searchDept;
	}


	public String getSearchTeam() {
		return searchTeam;
	}


	public void setSearchTeam(String searchTeam) {
		this.searchTeam = searchTeam;
	}

	@Override
	public String toString() {
		return "MemberSearchVO [searchType=" + searchType + ", searchWord=" + searchWord + ", searchDept=" + searchDept
				+ ", searchTeam=" + searchTeam + "]";
	}
	
	
}
