package com.bteam.proj.mileageshop.vo;

public class OrderLogVO {
	private String orderNo;
	private String memNo;
	private String orderDate;
	private String orderState;
	private int disMileage;
	
	public OrderLogVO() {}
	
	public OrderLogVO(String orderNo, String memNo, String orderDate, String orderState, int disMileage) {
		super();
		this.orderNo = orderNo;
		this.memNo = memNo;
		this.orderDate = orderDate;
		this.orderState = orderState;
		this.disMileage = disMileage;
	}
	
	@Override
	public String toString() {
		return "OrderLogVO [orderNo=" + orderNo + ", memNo=" + memNo + ", orderDate=" + orderDate + ", orderState="
				+ orderState + ", disMileage=" + disMileage + "]";
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getOrderState() {
		return orderState;
	}
	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}
	public int getDisMileage() {
		return disMileage;
	}
	public void setDisMileage(int disMileage) {
		this.disMileage = disMileage;
	}
	
	
}
