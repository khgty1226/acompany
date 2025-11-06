package com.bteam.proj.chart.vo;

public class ChartVO {
	
	private String rnum;
	private String memNo;
	private String memName;
	private String boardDate;
	private int boardLike;
	private int cpCnt;
	private int shCnt;
	private int saleCnt;
	private int atchNo;
	
	
	
	@Override
	public String toString() {
		return "ChartVO [rnum=" + rnum + ", memNo=" + memNo + ", memName=" + memName + ", boardDate=" + boardDate
				+ ", boardLike=" + boardLike + ", cpCnt=" + cpCnt + ", shCnt=" + shCnt + ", saleCnt=" + saleCnt
				+ ", atchNo=" + atchNo + "]";
	}
	public int getAtchNo() {
		return atchNo;
	}
	public void setAtchNo(int atchNo) {
		this.atchNo = atchNo;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public int getSaleCnt() {
		return saleCnt;
	}
	public void setSaleCnt(int saleCnt) {
		this.saleCnt = saleCnt;
	}
	public int getShCnt() {
		return shCnt;
	}
	public void setShCnt(int shCnt) {
		this.shCnt = shCnt;
	}
	public String getRnum() {
		return rnum;
	}
	public int getCpCnt() {
		return cpCnt;
	}
	public void setCpCnt(int cpCnt) {
		this.cpCnt = cpCnt;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
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
	public int getBoardLike() {
		return boardLike;
	}
	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}
	
	
	
}
