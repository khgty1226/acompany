package com.bteam.proj.mileageshop.vo;

public class OrderDetailVO {
	private String orderDetailNo;
	private String orderNo;
	private String prodNo;
	private String prodName;
	private int prodCnt;
	private int prodPrice;
	private String prodImgUrl;
	
	
	public OrderDetailVO() {}
	
	public String getProdImgUrl() {
		return prodImgUrl;
	}

	public void setProdImgUrl(String prodImgUrl) {
		this.prodImgUrl = prodImgUrl;
	}



	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	@Override
	public String toString() {
		return "OrderDetailVO [orderDetailNo=" + orderDetailNo + ", orderNo=" + orderNo + ", prodNo=" + prodNo
				+ ", prodName=" + prodName + ", prodCnt=" + prodCnt + ", prodPrice=" + prodPrice + ", prodImgUrl="
				+ prodImgUrl + "]";
	}

	public OrderDetailVO(String orderDetailNo, String orderNo, String prodNo, String prodName, int prodCnt,
			int prodPrice, String prodImgUrl) {
		super();
		this.orderDetailNo = orderDetailNo;
		this.orderNo = orderNo;
		this.prodNo = prodNo;
		this.prodName = prodName;
		this.prodCnt = prodCnt;
		this.prodPrice = prodPrice;
		this.prodImgUrl = prodImgUrl;
	}

	public String getOrderDetailNo() {
		return orderDetailNo;
	}
	public void setOrderDetailNo(String orderDetailNo) {
		this.orderDetailNo = orderDetailNo;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getProdNo() {
		return prodNo;
	}
	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}
	public int getProdCnt() {
		return prodCnt;
	}
	public void setProdCnt(int prodCnt) {
		this.prodCnt = prodCnt;
	}
	public int getProdPrice() {
		return prodPrice;
	}
	public void setProdPrice(int prodPrice) {
		this.prodPrice = prodPrice;
	}
	
	
}
