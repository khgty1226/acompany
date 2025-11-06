package com.bteam.proj.mileageshop.vo;

public class ProdCategoryVO {
	private String cateName;
	private int cateCode;
	private Integer parentCode;
	
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public int getCateCode() {
		return cateCode;
	}
	public void setCateCode(int cateCode) {
		this.cateCode = cateCode;
	}
	public ProdCategoryVO(String cateName, int cateCode, Integer parentCode) {
		super();
		this.cateName = cateName;
		this.cateCode = cateCode;
		this.parentCode = parentCode;
	}
	@Override
	public String toString() {
		return "ProdCategoryVO [cateName=" + cateName + ", cateCode=" + cateCode + ", parentCode=" + parentCode + "]";
	}
	public Integer getParentCode() {
		return parentCode;
	}
	public void setParentCode(Integer parentCode) {
		this.parentCode = parentCode;
	}
	
	
	
	
}
