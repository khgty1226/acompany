package com.bteam.proj.mileageshop.vo;

public class ProductVO {
	
	private int prodRNum;
	private String prodNo;
	private String prodName;
	private int prodPrice;
	private String prodContentUrl;
	private String prodImgUrl;
	private int cateCode;
	private String cateName;
	private int parentCateCode;
	private String parentCateName;
	private String prodUnit;
	private String prodSaleCount;
	private int prodCnt;
	private int prodTotalPrice;
	private String cartNo;

	public ProductVO(){}

	

	public String getCartNo() {
		return cartNo;
	}



	public void setCartNo(String cartNo) {
		this.cartNo = cartNo;
	}



	@Override
	public String toString() {
		return "ProductVO [prodRNum=" + prodRNum + ", prodNo=" + prodNo + ", prodName=" + prodName + ", prodPrice="
				+ prodPrice + ", prodContentUrl=" + prodContentUrl + ", prodImgUrl=" + prodImgUrl + ", cateCode="
				+ cateCode + ", cateName=" + cateName + ", parentCateCode=" + parentCateCode + ", parentCateName="
				+ parentCateName + ", prodUnit=" + prodUnit + ", prodSaleCount=" + prodSaleCount + ", prodCnt="
				+ prodCnt + ", prodTotalPrice=" + prodTotalPrice + ", cartNo=" + cartNo + "]";
	}



	public ProductVO(int prodRNum, String prodNo, String prodName, int prodPrice, String prodContentUrl,
			String prodImgUrl, int cateCode, String cateName, int parentCateCode, String parentCateName,
			String prodUnit, String prodSaleCount, int prodCnt, int prodTotalPrice, String cartNo) {
		super();
		this.prodRNum = prodRNum;
		this.prodNo = prodNo;
		this.prodName = prodName;
		this.prodPrice = prodPrice;
		this.prodContentUrl = prodContentUrl;
		this.prodImgUrl = prodImgUrl;
		this.cateCode = cateCode;
		this.cateName = cateName;
		this.parentCateCode = parentCateCode;
		this.parentCateName = parentCateName;
		this.prodUnit = prodUnit;
		this.prodSaleCount = prodSaleCount;
		this.prodCnt = prodCnt;
		this.prodTotalPrice = prodTotalPrice;
		this.cartNo = cartNo;
	}



	public int getProdCnt() {
		return prodCnt;
	}




	public void setProdCnt(int prodCnt) {
		this.prodCnt = prodCnt;
	}




	public int getProdTotalPrice() {
		return prodTotalPrice;
	}




	public void setProdTotalPrice(int prodTotalPrice) {
		this.prodTotalPrice = prodTotalPrice;
	}




	public String getCateName() {
		return cateName;
	}



	public void setCateName(String cateName) {
		this.cateName = cateName;
	}



	public int getParentCateCode() {
		return parentCateCode;
	}



	public void setParentCateCode(int parentCateCode) {
		this.parentCateCode = parentCateCode;
	}



	public String getParentCateName() {
		return parentCateName;
	}



	public void setParentCateName(String parentCateName) {
		this.parentCateName = parentCateName;
	}



	public String getProdSaleCount() {
		return prodSaleCount;
	}



	public void setProdSaleCount(String prodSaleCount) {
		this.prodSaleCount = prodSaleCount;
	}



	public String getProdNo() {
		return prodNo;
	}

	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public int getProdPrice() {
		return prodPrice;
	}

	public void setProdPrice(int prodPrice) {
		this.prodPrice = prodPrice;
	}

	public String getProdContentUrl() {
		return prodContentUrl;
	}

	public void setProdContentUrl(String prodContentUrl) {
		this.prodContentUrl = prodContentUrl;
	}

	public String getProdImgUrl() {
		return prodImgUrl;
	}

	public void setProdImgUrl(String prodImgUrl) {
		this.prodImgUrl = prodImgUrl;
	}

	public int getCateCode() {
		return cateCode;
	}

	public void setCateCode(int cateCode) {
		this.cateCode = cateCode;
	}

	public String getProdUnit() {
		return prodUnit;
	}

	public void setProdUnit(String prodUnit) {
		this.prodUnit = prodUnit;
	}
	public int getProdRNum() {
		return prodRNum;
	}

	public void setProdRNum(int prodRNum) {
		this.prodRNum = prodRNum;
	}
	
}
