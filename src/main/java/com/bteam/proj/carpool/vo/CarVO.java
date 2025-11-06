package com.bteam.proj.carpool.vo;

public class CarVO {
	private String carNo;
	private String carModel;
	private String carColor;
	private String memNo;
	
	public CarVO() {};
	public CarVO(String carNo, String carModel, String carColor, String memNo) {
		super();
		this.carNo = carNo;
		this.carModel = carModel;
		this.carColor = carColor;
		this.memNo = memNo;
	}
	public String getCarNo() {
		return carNo;
	}
	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}
	public String getCarModel() {
		return carModel;
	}
	public void setCarModel(String carModel) {
		this.carModel = carModel;
	}
	public String getCarColor() {
		return carColor;
	}
	public void setCarColor(String carColor) {
		this.carColor = carColor;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	@Override
	public String toString() {
		return "carVO [carNo=" + carNo + ", carModel=" + carModel + ", carColor=" + carColor + ", memNo=" + memNo + "]";
	}
	
	
}
