package com.bteam.proj.carpool.vo;

import java.util.List;

import com.bteam.proj.common.vo.PagingVO;
import com.bteam.proj.member.vo.MemberVO;

public class CarPoolVO extends PagingVO{
	private int cpRNum;
	private String cpNo;
	private int cpTotalPass;
	private int cpTakePass=1;
	private String cpRunDate;
	private String cpRunTime;
	private String cpArrTime;
	private String carNo;
	private String cpLoc;
	private String cpRoadLoc;
	private String cpLocLat;
	private String cpLocLng;
	private String cpDistance;
	private String driver;
	private String memNo;
	private String cpRegDate;
	private String cpState;
	private String cpStatePass;
	private CarVO carVO;
	private String cpGoOut;
	private List<MemberVO> passList;
	
	
	public CarPoolVO() {
			
	}


	
	public String getCpRoadLoc() {
		return cpRoadLoc;
	}



	public void setCpRoadLoc(String cpRoadLoc) {
		this.cpRoadLoc = cpRoadLoc;
	}



	




	public String getCpArrTime() {
		return cpArrTime;
	}



	public void setCpArrTime(String cpArrTime) {
		this.cpArrTime = cpArrTime;
	}



	public String getCpDistance() {
		return cpDistance;
	}



	public void setCpDistance(String cpDistance) {
		this.cpDistance = cpDistance;
	}



	


	public String getCpGoOut() {
		return cpGoOut;
	}



	public void setCpGoOut(String cpGoOut) {
		this.cpGoOut = cpGoOut;
	}



	public CarVO getCarVO() {
		return carVO;
	}

	public void setCarVO(CarVO carVO) {
		this.carVO = carVO;
	}

	public List<MemberVO> getPassList() {
		return passList;
	}

	public void setPassList(List<MemberVO> passList) {
		this.passList = passList;
	}

	public String getCpNo() {
		return cpNo;
	}
	public void setCpNo(String cpNo) {
		this.cpNo = cpNo;
	}
	public int getCpTotalPass() {
		return cpTotalPass;
	}
	public void setCpTotalPass(int cpTotalPass) {
		this.cpTotalPass = cpTotalPass;
	}
	public int getCpTakePass() {
		return cpTakePass;
	}
	public void setCpTakePass(int cpTakePass) {
		this.cpTakePass = cpTakePass;
	}
	public String getCpRunDate() {
		return cpRunDate;
	}
	public void setCpRunDate(String cpRunDate) {
		this.cpRunDate = cpRunDate;
	}
	public String getCarNo() {
		return carNo;
	}
	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}
	public String getCpLoc() {
		return cpLoc;
	}
	public void setCpLoc(String cpLoc) {
		this.cpLoc = cpLoc;
	}
	public String getCpLocLat() {
		return cpLocLat;
	}
	public void setCpLocLat(String cpLocLat) {
		this.cpLocLat = cpLocLat;
	}
	public String getCpLocLng() {
		return cpLocLng;
	}
	public void setCpLocLng(String cpLocLng) {
		this.cpLocLng = cpLocLng;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getCpRegDate() {
		return cpRegDate;
	}
	public void setCpRegDate(String cpRegDate) {
		this.cpRegDate = cpRegDate;
	}
	public String getCpState() {
		return cpState;
	}
	public void setCpState(String cpState) {
		this.cpState = cpState;
	}

	public String getCpRunTime() {
		return cpRunTime;
	}



	public void setCpRunTime(String cpRunTime) {
		this.cpRunTime = cpRunTime;
	}





	public String getCpStatePass() {
		return cpStatePass;
	}



	public void setCpStatePass(String cpStatePass) {
		this.cpStatePass = cpStatePass;
	}


	public String getDriver() {
		return driver;
	}



	public void setDriver(String driver) {
		this.driver = driver;
	}



	public CarPoolVO(int cpRNum, String cpNo, int cpTotalPass, int cpTakePass, String cpRunDate, String cpRunTime,
			String cpArrTime, String carNo, String cpLoc, String cpRoadLoc, String cpLocLat, String cpLocLng,
			String cpDistance, String driver, String memNo, String cpRegDate, String cpState, String cpStatePass,
			CarVO carVO, String cpGoOut, List<MemberVO> passList) {
		super();
		this.cpRNum = cpRNum;
		this.cpNo = cpNo;
		this.cpTotalPass = cpTotalPass;
		this.cpTakePass = cpTakePass;
		this.cpRunDate = cpRunDate;
		this.cpRunTime = cpRunTime;
		this.cpArrTime = cpArrTime;
		this.carNo = carNo;
		this.cpLoc = cpLoc;
		this.cpRoadLoc = cpRoadLoc;
		this.cpLocLat = cpLocLat;
		this.cpLocLng = cpLocLng;
		this.cpDistance = cpDistance;
		this.driver = driver;
		this.memNo = memNo;
		this.cpRegDate = cpRegDate;
		this.cpState = cpState;
		this.cpStatePass = cpStatePass;
		this.carVO = carVO;
		this.cpGoOut = cpGoOut;
		this.passList = passList;
	}



	@Override
	public String toString() {
		return "CarPoolVO [cpRNum=" + cpRNum + ", cpNo=" + cpNo + ", cpTotalPass=" + cpTotalPass + ", cpTakePass="
				+ cpTakePass + ", cpRunDate=" + cpRunDate + ", cpRunTime=" + cpRunTime + ", cpArrTime=" + cpArrTime
				+ ", carNo=" + carNo + ", cpLoc=" + cpLoc + ", cpRoadLoc=" + cpRoadLoc + ", cpLocLat=" + cpLocLat
				+ ", cpLocLng=" + cpLocLng + ", cpDistance=" + cpDistance + ", driver=" + driver + ", memNo=" + memNo
				+ ", cpRegDate=" + cpRegDate + ", cpState=" + cpState + ", cpStatePass=" + cpStatePass + ", carVO="
				+ carVO + ", cpGoOut=" + cpGoOut + ", passList=" + passList + "]";
	}



	public int getCpRNum() {
		return cpRNum;
	}



	public void setCpRNum(int cpRNum) {
		this.cpRNum = cpRNum;
	}



	

	
}
