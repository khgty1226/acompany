package com.bteam.proj.kakao.vo;

import java.util.List;

public class KakaoPayReadyVO {
	
	private String tid; 						// 결제 고유번호
	private String next_redirect_mobile_url; 	// 요청한 클라이언트가 모바일 웹
	private String next_redirect_pc_url; 		// 요청한 클라이언트가 PC 웹
	private String partner_order_id; 			// 가맹점 주문번호
	private String cartNoStr;
	private int memMileage;
	private String memNo;
	private String prodNo;
	private int prodCnt;

	
	
	

	public String getMemNo() {
		return memNo;
	}

	public void setMemNo(String memNo) {
		this.memNo = memNo;
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

	@Override
	public String toString() {
		return "KakaoPayReadyVO [tid=" + tid + ", next_redirect_mobile_url=" + next_redirect_mobile_url
				+ ", next_redirect_pc_url=" + next_redirect_pc_url + ", partner_order_id=" + partner_order_id
				+ ", cartNoStr=" + cartNoStr + ", memMileage=" + memMileage + ", memNo=" + memNo + ", prodNo=" + prodNo
				+ ", prodCnt=" + prodCnt + "]";
	}

	public int getMemMileage() {
		return memMileage;
	}

	public void setMemMileage(int memMileage) {
		this.memMileage = memMileage;
	}


	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getNext_redirect_mobile_url() {
		return next_redirect_mobile_url;
	}

	public void setNext_redirect_mobile_url(String next_redirect_mobile_url) {
		this.next_redirect_mobile_url = next_redirect_mobile_url;
	}

	public String getNext_redirect_pc_url() {
		return next_redirect_pc_url;
	}

	public void setNext_redirect_pc_url(String next_redirect_pc_url) {
		this.next_redirect_pc_url = next_redirect_pc_url;
	}

	public String getPartner_order_id() {
		return partner_order_id;
	}

	public void setPartner_order_id(String partner_order_id) {
		this.partner_order_id = partner_order_id;
	}

	public String getCartNoStr() {
		return cartNoStr;
	}

	public void setCartNoStr(String cartNoStr) {
		this.cartNoStr = cartNoStr;
	}
	
	
	
	
}
