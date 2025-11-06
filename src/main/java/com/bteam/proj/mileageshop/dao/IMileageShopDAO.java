package com.bteam.proj.mileageshop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bteam.proj.mileageshop.vo.OrderDetailVO;
import com.bteam.proj.mileageshop.vo.OrderLogVO;
import com.bteam.proj.mileageshop.vo.ProdCategoryVO;
import com.bteam.proj.mileageshop.vo.ProdLogSearchVO;
import com.bteam.proj.mileageshop.vo.ProdSearchVO;
import com.bteam.proj.mileageshop.vo.ProductVO;

@Mapper
public interface IMileageShopDAO {

	List<ProductVO> getProdList(ProdSearchVO searchVO);

	List<ProdCategoryVO> getCategoryLList();

	List<ProdCategoryVO> getCategoryMList();

	int getTotalRowCountProd(ProdSearchVO searchVO);

	ProductVO getProduct(String prodNo);

	int checkCart(@Param("product")ProductVO product, @Param("memNo")String memNo);

	int addCart(@Param("product")ProductVO product, @Param("memNo")String memNo);

	List<ProductVO> getCartProdList(String memNo);

	int changeCartProdCnt(@Param("cartNo") String cartNo, @Param("prodCnt") String prodCnt);

	List<ProductVO> getOrderProdList(@Param("cartNoArr") List<String> cartNoArr);

	int addOrderInfo(@Param("memNo") String memNo, @Param("mileage") int memMileage);

	String getCurOrderNo(String memNo);

	int addOrderDetail(@Param("orderProd")ProductVO orderProd, @Param("orderNo") String orderNo);

	int deleteCart(@Param("cartNoArr") List<String> cartNoArr);

	int prodSaleCountUp(ProductVO product);

	List<OrderLogVO> getOrderLogList(@Param("memNo") String memNo, @Param("searchVO") ProdLogSearchVO searchVO);

	List<OrderDetailVO> getOrderDetailList(@Param("orderLogList") List<OrderLogVO> orderLogList);

	String getProdImgUrl(String prodNo);

	String getProdName(String prodNo);

	int getOrderLogListCount(@Param("memNo")String memNo, @Param("searchVO") ProdLogSearchVO searchVO);





}
