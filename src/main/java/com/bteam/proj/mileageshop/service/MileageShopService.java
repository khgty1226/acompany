package com.bteam.proj.mileageshop.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bteam.proj.mileage.dao.IMileageDAO;
import com.bteam.proj.mileageshop.dao.IMileageShopDAO;
import com.bteam.proj.mileageshop.vo.OrderDetailVO;
import com.bteam.proj.mileageshop.vo.OrderLogVO;
import com.bteam.proj.mileageshop.vo.ProdCategoryVO;
import com.bteam.proj.mileageshop.vo.ProdLogSearchVO;
import com.bteam.proj.mileageshop.vo.ProdSearchVO;
import com.bteam.proj.mileageshop.vo.ProductVO;

@Service
public class MileageShopService {
	
	@Autowired
	private IMileageShopDAO dao;
	
	@Autowired
	private IMileageDAO mileageDao;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	public List<ProductVO> getProdList(ProdSearchVO searchVO) {
		System.out.println("[MileageShop Service getProdList]");

		int totalRowCount = dao.getTotalRowCountProd(searchVO);

		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		
		List<ProductVO> prodList = dao.getProdList(searchVO);
		
		return prodList;
	}

	public List<ProdCategoryVO> getCategoryLList() {
		System.out.println("[MileageShop Service getCategoryLList]");
		
		List<ProdCategoryVO> categoryLList = dao.getCategoryLList();
		
		return categoryLList;
	}

	public List<ProdCategoryVO> getCategoryMList() {
		System.out.println("[MileageShop Service getCategoryMList]");
		
		List<ProdCategoryVO> categoryMList = dao.getCategoryMList();
		
		return categoryMList;
	}

	public int getTotalRowCount(ProdSearchVO searchVO) {
		System.out.println("[MileageShop Service getTotalRowCount]");
		
		int totalRowCount = dao.getTotalRowCountProd(searchVO);

		return totalRowCount;
	}

	public ProductVO getProduct(String prodNo) {
		System.out.println("[MileageShop Service getProduct]");
		
		ProductVO product = dao.getProduct(prodNo);
		
		return product;
	}

	public void addCart(ProductVO product, String memNo) throws Exception {
		System.out.println("[MileageShop Service addCart]");

		int resultCnt1 = dao.checkCart(product, memNo);
		if(resultCnt1 != 0) {
			throw new Exception("장바구니 항복 중복");
		}
		
		int resultCnt2 = dao.addCart(product, memNo);
		if(resultCnt2 != 1) {
			throw new Exception("장바구니 추가 실패");
		}
		
	}

	public List<ProductVO> getCartProdList(String memNo) {
		System.out.println("[MileageShop Service getCartProdList]");
		
		List<ProductVO> prodList = dao.getCartProdList(memNo);
		
		return prodList;
	}

	public void changeCartProdCnt(String cartNo, String prodCnt) throws Exception {
		System.out.println("[MileageShop Service getCartProdList]");
		
		int resultCnt = dao.changeCartProdCnt(cartNo, prodCnt);
		if(resultCnt != 1) {
			throw new Exception("changeCartProdCnt 실패");
		}
	}
	
	public void mileageShopOrderDo(List<String> cartNoArr, String memNo, int memMileage) throws Exception {
		System.out.println("[MileageShop Service mileageShopOrderDo]");
		
		List<ProductVO> orderProdList = dao.getOrderProdList(cartNoArr);
		if(orderProdList.size() < 1) {
			throw new Exception("getOrderProdList 실패");
		}
		
		int resultCnt1 = dao.addOrderInfo(memNo, memMileage);
		if(resultCnt1 < 1) {
			throw new Exception("addOrderInfo 실패");
		}
		
		String orderNo = dao.getCurOrderNo(memNo);
		if(orderNo == null || orderNo.equals("")) {
			throw new Exception("getCurOrderNo 실패");
		}
		
		int resultCnt2 = 0;
		for(int i = 0 ; i < orderProdList.size(); i ++) {
			ProductVO orderProd = orderProdList.get(i);
			resultCnt2 += dao.addOrderDetail(orderProd, orderNo);
			
		}
		if(resultCnt2 < orderProdList.size()) {
			throw new Exception("addOrderDetail 실패");
		}
		// cart 삭제 !!
		
		int resultCnt3 = dao.deleteCart(cartNoArr);
		if(resultCnt3 < cartNoArr.size()) {
			throw new Exception("deleteCart 실패");
		}
		
		int resultCnt4 = mileageDao.mileageDown(memNo, memMileage);
		if(resultCnt4 < 1) {
			throw new Exception("mileageDown 실패");
		}
		
		int resultCnt5 = 0;
		for(int i = 0 ; i < orderProdList.size(); i ++) {
			ProductVO orderProd = orderProdList.get(i);
			resultCnt5 += dao.prodSaleCountUp(orderProd);
		}
		if(resultCnt5 < orderProdList.size()) {
			throw new Exception("prodSaleCountUp 실패");
		}
	}

	public List<ProductVO> getOrderProdList(List<String> cartNoArr) throws Exception {
		System.out.println("[MileageShop Service getOrderProdList]");
		
		List<ProductVO> orderProdList = dao.getOrderProdList(cartNoArr);
		if(orderProdList.size() < 1) {
			throw new Exception("getOrderProdList 실패");
		}
		return orderProdList;
	}

	public void deleteCart(List<String> cartNoArr) throws Exception {
		System.out.println("[MileageShop Service deleteCart]");
		
		int resultCnt = dao.deleteCart(cartNoArr);
		if(resultCnt < cartNoArr.size()) {
			throw new Exception("deleteCart 실패");
		}
	}

	public void mileageShopOrderDo(ProductVO product, String memNo, int memMileage) throws Exception {
		System.out.println("[MileageShop Service mileageShopOrderDo]");
		int cnt = product.getProdCnt();

		ProductVO orderProd = dao.getProduct(product.getProdNo());
		orderProd.setProdCnt(cnt);
		
		int resultCnt1 = dao.addOrderInfo(memNo, memMileage);
		if(resultCnt1 < 1) {
			throw new Exception("addOrderInfo 실패");
		}
		
		String orderNo = dao.getCurOrderNo(memNo);
		if(orderNo == null || orderNo.equals("")) {
			throw new Exception("getCurOrderNo 실패");
		}
		
		int resultCnt2 = dao.addOrderDetail(orderProd, orderNo);
			
		if(resultCnt2 < 1) {
			throw new Exception("addOrderDetail 실패");
		}
		
		int resultCnt4 = mileageDao.mileageDown(memNo, memMileage);
		if(resultCnt4 < 1) {
			throw new Exception("mileageDown 실패");
		}
		
		int resultCnt5 = dao.prodSaleCountUp(product);
		if(resultCnt5 < 1) {
			throw new Exception("prodSaleCountUp 실패");
		}
	}

	public List<OrderLogVO> getOrderLogList(String memNo, ProdLogSearchVO searchVO) {
		System.out.println("[MileageShop Service getOrderLogList]");
		
		System.out.println("searchVO:"+searchVO);

		int totalRowCount = dao.getOrderLogListCount(memNo, searchVO);
		System.out.println("totalRowCount:" + totalRowCount);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();

		List<OrderLogVO> orderLogList = dao.getOrderLogList(memNo, searchVO);
		
		return orderLogList;
	}

	public List<OrderDetailVO> getOrderDetailList(List<OrderLogVO> orderLogList) {
		System.out.println("[MileageShop Service getOrderDetailList]");
		
		List<OrderDetailVO> orderDetailList = null;
		if(orderLogList.size() > 0) {
			orderDetailList = dao.getOrderDetailList(orderLogList);
			
			for(int i = 0 ; i < orderDetailList.size(); i ++) {
				String prodNo = orderDetailList.get(i).getProdNo();
				String prodImgUrl = dao.getProdImgUrl(prodNo);
				String prodName = dao.getProdName(prodNo);
				orderDetailList.get(i).setProdImgUrl(prodImgUrl);
				orderDetailList.get(i).setProdName(prodName);
			}
		}
		
		return orderDetailList;
	}
	
}
