package com.bteam.proj.kakao.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bteam.proj.kakao.service.KakaoPayService;
import com.bteam.proj.kakao.vo.KakaoPayApproveVO;
import com.bteam.proj.kakao.vo.KakaoPayReadyVO;
import com.bteam.proj.member.vo.MemberVO;
import com.bteam.proj.mileageshop.service.MileageShopService;
import com.bteam.proj.mileageshop.vo.ProductVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class KaKaoPayController {
	
	@Autowired
	KakaoPayService kakaoPayService;
	
	@Autowired
	MileageShopService shopService;
	 
	@RequestMapping("/kakaoPay/ready")
	@ResponseBody
	public KakaoPayReadyVO kakaoPay(@RequestParam Map<String, Object> params) {
		KakaoPayReadyVO res = kakaoPayService.kakaoPay(params);
		System.out.println("kakaoPay/ready="+res.toString());
		return res;
	}
	
	@RequestMapping("/kakaoPay/readyD")
	@ResponseBody
	public KakaoPayReadyVO kakaoPayD(@RequestParam Map<String, Object> params) {
		KakaoPayReadyVO res = kakaoPayService.kakaoPayD(params);
		System.out.println("kakaoPay/ready="+res.toString());
		return res;
	}
	
	@RequestMapping("/paySuccess")
	public String Success(@RequestParam("pg_token") String pgToken, HttpSession session) {
		KakaoPayApproveVO res = kakaoPayService.kakaoPayApproveInfo(pgToken);
		System.out.println("res"+res);
		
		/**
		 * 결제 승인 요청 결과에 대해서 데이터 베이스에 저장 또는 업데이트 할 로직 추가
		 */
		System.out.println("paySuccessRes.getCartNoStr=" + res.getCartNoStr());
		System.out.println("[MileageShop Controller mileageShopOrderDo]");
		
		ObjectMapper om = new ObjectMapper();
		String[] arr;
		List<String> cartNoArr = new ArrayList<>();
		String cartNoStr = res.getCartNoStr();
		int memMileage = res.getMemMileage();		
		String memNo = res.getMemNo();
		
		try {
			arr = om.readValue(cartNoStr, String[].class);
			System.out.println(Arrays.toString(arr));
			
			for(int i = 0 ; i < arr.length; i ++) {
				cartNoArr.add(arr[i]);
			}
			System.out.println("cartNoArr:"+ cartNoArr.toString());
			System.out.println("memMileage:"+ memMileage);
			
			try {
				shopService.mileageShopOrderDo(cartNoArr, memNo, memMileage);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println(e.getMessage());
				e.printStackTrace();
				return "redirect:/mileageShopOrderCompleteView?msg=oFail";
			}
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/mileageShopOrderCompleteView?msg=oSuccess";
		
		
	}
	
	// 다이렉트
	@RequestMapping("/paySuccessD")
	public String SuccessD(@RequestParam("pg_token") String pgToken, HttpSession session) {
		KakaoPayApproveVO res = kakaoPayService.kakaoPayApproveInfoD(pgToken);
		System.out.println("res"+res);
		
		/**
		 * 결제 승인 요청 결과에 대해서 데이터 베이스에 저장 또는 업데이트 할 로직 추가
		 */
		System.out.println("paySuccessRes.getProdNo=" + res.getProdNo());
		System.out.println("[MileageShop Controller mileageShopOrderDo]");
		
		ObjectMapper om = new ObjectMapper();
		int memMileage = res.getMemMileage();		
		String memNo = res.getMemNo();
		String prodNo = res.getProdNo();
		int prodCnt = res.getProdCnt();
		ProductVO product = new ProductVO();
		
			System.out.println("memMileage:"+ memMileage);
			System.out.println("prodNo:"+ prodNo);
			System.out.println("prodCnt:"+ prodCnt);
			product.setProdNo(prodNo);
			product.setProdCnt(prodCnt);
			try {
				shopService.mileageShopOrderDo(product, memNo, memMileage);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println(e.getMessage());
				e.printStackTrace();
				return "redirect:/mileageShopOrderCompleteView?msg=oFail";
			}
		
		return "redirect:/mileageShopOrderCompleteView?msg=oSuccess";
		
		
	}
	
}
