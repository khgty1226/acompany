package com.bteam.proj.kakao.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.bteam.proj.kakao.vo.KakaoPayApproveVO;
import com.bteam.proj.kakao.vo.KakaoPayReadyVO;

@Service
public class KakaoPayService {
	
	static final String cid = "TC0ONETIME"; // 가맹점 테스트 코드 1bf31f9c3f591f545bfd04a9bad63a99
    static final String admin_Key = "2dae9eb5149e53cd3addf689878706dc";
    static  String tid = "";
    static  String cartNoStr = "";
    static  String prodNo = "";
    static  int prodCnt = 0;
   static int memMileage = 0;
   static String memNo;
	private KakaoPayReadyVO kakaoPayReadyVO;
	private KakaoPayApproveVO kakaoPayApproveVO;
	
	// 결제 요청 준비 메소드
	public KakaoPayReadyVO kakaoPay(Map<String,Object> params) {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK 2dae9eb5149e53cd3addf689878706dc"); // 발급받은 adminKey
		
		/**
		 * 결제 번호는 고유한 결제번호로 생성해줘야 한다.
		 * 여기서는 임시로 KA020230318001
		 * local test url 값
		 * payParams.add("approval_url", "http://localhost:8080/proj/paySuccess");		// 결제 승인시 넘어갈 url
		 *  서버 사용시 url 값
		 *  payParams.add("approval_url", "http://192.168.1.65:8080/paySuccess");		// 결제 승인시 넘어갈 url
		 */
		
		MultiValueMap<String, Object> payParams = new LinkedMultiValueMap<String, Object>();
																					// tid 는 결제 고유 번호
		payParams.add("cid", "TC0ONETIME");											// 가맹점 코드 TC0ONETIME은 TEST용
		payParams.add("partner_order_id", "KA020230318001");						// 가맹점 주문 번호
		payParams.add("partner_user_id", "kakaopayTest");							// 가맹점 회원 아이디
		payParams.add("item_name", params.get("item_name"));						// 상품 이름
		payParams.add("quantity", params.get("quantity"));							// 상품 수량
		payParams.add("total_amount", params.get("total_amount"));					// 상품 총 금액
		payParams.add("cartNoStr", params.get("cartNoStr"));					// cart 번호들
		payParams.add("memMileage", params.get("memMileage"));					// 마일리지
		payParams.add("memNo", params.get("memNo"));					// 마일리지
		payParams.add("tax_free_amount", params.get("tax_free_amount"));			// 상품 비과세 금액
		payParams.add("approval_url", "http://192.168.1.65:8080/paySuccess");		// 결제 승인시 넘어갈 url
		payParams.add("cancel_url", "http://192.168.1.65:8080/payCancel");		// 결제 취소시 넘어갈 url
		payParams.add("fail_url", "http://192.168.1.65:8080/payFail");			// 결제 실패시 넘어갈 url
		
		// 카카오페이 결제준비 api 요청
		HttpEntity<Map> request = new HttpEntity<>(payParams, headers);
		
		RestTemplate template = new RestTemplate();
		String url = "https://kapi.kakao.com/v1/payment/ready";
		
		// 요청 결과
		KakaoPayReadyVO res = template.postForObject(url, request, KakaoPayReadyVO.class);
		cartNoStr = (String) params.get("cartNoStr");
		memNo = (String) params.get("memNo");
		memMileage = Integer.parseInt((String)params.get("memMileage"));
		
		
		res.setCartNoStr(cartNoStr);
		res.setMemMileage(memMileage);
		res.setMemNo(memNo);
		tid = res.getTid();
		
		System.out.println("kakaoPayReady_cartNoStr=" + cartNoStr);
		System.out.println("kakaoPayReady_memMailage= " + memMileage);
		System.out.println("kakaoPayReady_memNo= " + memNo);
		/**
		 * 요청결과에서 응답받은 tid 값을 데이터베이스에 저장하는 로직 추가
		 * 주문번호랑 -tid랑 연결하여 결제이력 테이블로 관리
		 */
		
		return res;
	}
	
	// 결제 요청 준비 메소드 (다이렉트)
		public KakaoPayReadyVO kakaoPayD(Map<String,Object> params) {
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", "KakaoAK 2dae9eb5149e53cd3addf689878706dc"); // 발급받은 adminKey
			
			/**
			 * 결제 번호는 고유한 결제번호로 생성해줘야 한다.
			 * 여기서는 임시로 KA020230318001
			 */
			
			MultiValueMap<String, Object> payParams = new LinkedMultiValueMap<String, Object>();
																						// tid 는 결제 고유 번호
			payParams.add("cid", "TC0ONETIME");											// 가맹점 코드 TC0ONETIME은 TEST용
			payParams.add("partner_order_id", "KA020230318001");						// 가맹점 주문 번호
			payParams.add("partner_user_id", "kakaopayTest");							// 가맹점 회원 아이디
			payParams.add("item_name", params.get("item_name"));						// 상품 이름
			payParams.add("quantity", params.get("quantity"));							// 상품 수량
			payParams.add("total_amount", params.get("total_amount"));					// 상품 총 금액
			payParams.add("prodNo", params.get("prodNo"));					// cart 번호들
			payParams.add("prodCnt", params.get("prodCnt"));					// cart 번호들
			payParams.add("memMileage", params.get("memMileage"));					// 마일리지
			payParams.add("memNo", params.get("memNo"));					// 마일리지
			payParams.add("tax_free_amount", params.get("tax_free_amount"));			// 상품 비과세 금액
			payParams.add("approval_url", "http://192.168.1.65:8080/paySuccessD");		// 결제 승인시 넘어갈 url
			payParams.add("cancel_url", "http://192.168.1.65:8080/payCancel");		// 결제 취소시 넘어갈 url
			payParams.add("fail_url", "http://192.168.1.65:8080/payFail");			// 결제 실패시 넘어갈 url
			
			// 카카오페이 결제준비 api 요청
			HttpEntity<Map> request = new HttpEntity<>(payParams, headers);
			
			RestTemplate template = new RestTemplate();
			String url = "https://kapi.kakao.com/v1/payment/ready";
			
			// 요청 결과
			KakaoPayReadyVO res = template.postForObject(url, request, KakaoPayReadyVO.class);
			prodNo = (String) params.get("prodNo");
			prodCnt = Integer.parseInt((String)params.get("prodCnt"));
			memNo = (String) params.get("memNo");
			memMileage = Integer.parseInt((String)params.get("memMileage"));
			
			
			res.setProdNo(prodNo);
			res.setProdCnt(prodCnt);
			res.setMemMileage(memMileage);
			res.setMemNo(memNo);
			tid = res.getTid();
			
			System.out.println("kakaoPayReady_memMailage= " + memMileage);
			System.out.println("kakaoPayReady_memNo= " + memNo);
			System.out.println("kakaoPayReady_prodNo= " + prodNo);
			/**
			 * 요청결과에서 응답받은 tid 값을 데이터베이스에 저장하는 로직 추가
			 * 주문번호랑 -tid랑 연결하여 결제이력 테이블로 관리
			 */
			
			return res;
		}
	
	
		// 결제 승인 요청 메소드
		public KakaoPayApproveVO kakaoPayApproveInfo(String pgToken) {
			
			System.out.println("kakaoApproveInfo............................");
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", "KakaoAK 2dae9eb5149e53cd3addf689878706dc"); 			// 발급받은 adminKey
			headers.set("Content-type", "application/x-www-form-urlencoded; charset=UTF-8");
			
			MultiValueMap<String, Object> payParams = new LinkedMultiValueMap<String, Object>();
			/**
			 * 결제번호는 결제준비 api와 일치 하여야 한다.
			 * tid 불러오는 로직 추가
			 */
			
			payParams.add("cid", "TC0ONETIME");							// 가맹점 코드 TC0ONETIME은 TEST용
			payParams.add("tid", tid);				// tid 는 결제 고유 번호
			payParams.add("cartNoStr", cartNoStr);				// tid 는 결제 고유 번호
			payParams.add("memMileage", memMileage);				// tid 는 결제 고유 번호
			payParams.add("memNo", memNo);				// tid 는 결제 고유 번호
			payParams.add("partner_order_id", "KA020230318001");		// 가맹점 주문 번호
			payParams.add("partner_user_id", "kakaopayTest");			// 가맹점 회원 아이디
			payParams.add("pg_token", pgToken);							// 
			
			// 카카오페이 결제요청 api 요청
			HttpEntity<Map> request = new HttpEntity<Map>(payParams, headers);
			System.out.println("kakaoPaySuccess request=" + request.toString());
			
			RestTemplate template = new RestTemplate();
			String url = "https://kapi.kakao.com/v1/payment/approve";
			
			// 요청 결과
			KakaoPayApproveVO res = template.postForObject(url, request, KakaoPayApproveVO.class);
			res.setCartNoStr(cartNoStr);
			res.setMemMileage(memMileage);
			res.setMemNo(memNo);
			
			System.out.println("33333kakaoPayReady_memMailage= " + memMileage);
			System.out.println("33333kakaoPayReady_memMailage= " + memNo);
			
			return res;
		}
		
		// 결제 승인 요청 메소드 (Direct)
		public KakaoPayApproveVO kakaoPayApproveInfoD(String pgToken) {
			
			System.out.println("kakaoApproveInfo............................");
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", "KakaoAK 2dae9eb5149e53cd3addf689878706dc"); 			// 발급받은 adminKey
			headers.set("Content-type", "application/x-www-form-urlencoded; charset=UTF-8");
			
			MultiValueMap<String, Object> payParams = new LinkedMultiValueMap<String, Object>();
			/**
			 * 결제번호는 결제준비 api와 일치 하여야 한다.
			 * tid 불러오는 로직 추가
			 */
			
			payParams.add("cid", "TC0ONETIME");							// 가맹점 코드 TC0ONETIME은 TEST용
			payParams.add("tid", tid);				// tid 는 결제 고유 번호
			payParams.add("memMileage", memMileage);				// tid 는 결제 고유 번호
			payParams.add("memNo", memNo);				// tid 는 결제 고유 번호
			payParams.add("prodNo", prodNo);				// tid 는 결제 고유 번호
			payParams.add("prodCnt", prodCnt);				// tid 는 결제 고유 번호
			payParams.add("partner_order_id", "KA020230318001");		// 가맹점 주문 번호
			payParams.add("partner_user_id", "kakaopayTest");			// 가맹점 회원 아이디
			payParams.add("pg_token", pgToken);							// 
			
			// 카카오페이 결제요청 api 요청
			HttpEntity<Map> request = new HttpEntity<Map>(payParams, headers);
			System.out.println("kakaoPaySuccess request=" + request.toString());
			
			RestTemplate template = new RestTemplate();
			String url = "https://kapi.kakao.com/v1/payment/approve";
			
			// 요청 결과
			KakaoPayApproveVO res = template.postForObject(url, request, KakaoPayApproveVO.class);
			res.setMemMileage(memMileage);
			res.setMemNo(memNo);
			res.setProdNo(prodNo);
			res.setProdCnt(prodCnt);
			
			System.out.println("33333kakaoPayReady_memMailage= " + memMileage);
			System.out.println("33333kakaoPayReady_memNo= " + memNo);
			System.out.println("33333kakaoPayReady_prodNo= " + prodNo);
			System.out.println("33333kakaoPayReady_prodCnt= " + prodCnt);
			
			return res;
		}
}
