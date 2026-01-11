package com.bteam.proj.mileageshop.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bteam.proj.member.service.MemberService;
import com.bteam.proj.member.vo.MemberVO;
import com.bteam.proj.mileageshop.service.MileageShopService;
import com.bteam.proj.mileageshop.vo.OrderDetailVO;
import com.bteam.proj.mileageshop.vo.OrderLogVO;
import com.bteam.proj.mileageshop.vo.ProdCategoryVO;
import com.bteam.proj.mileageshop.vo.ProdLogSearchVO;
import com.bteam.proj.mileageshop.vo.ProdSearchVO;
import com.bteam.proj.mileageshop.vo.ProductVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MileageShopController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private MileageShopService shopService;

	@Autowired
	private MemberService memberService;

	@RequestMapping("/mileageShopView")
	public String mileageShopView( Model model, ProdSearchVO searchVO) {

		System.out.println("[MileageShop Controller mileageShopView]");
		System.out.println(searchVO);

		System.out.println("ProdsearchVO: "+ searchVO.getSearchCategory() );
		List<ProductVO> prodList = shopService.getProdList(searchVO);
		System.out.println("prodList:"+prodList);

		int totalRowCount = shopService.getTotalRowCount(searchVO);

		List<ProdCategoryVO> categoryLList = shopService.getCategoryLList();
		System.out.println("categoryLList:"+categoryLList);

		List<ProdCategoryVO> categoryMList = shopService.getCategoryMList();
		System.out.println("categoryMList:"+categoryMList);



		model.addAttribute("prodList", prodList);
		model.addAttribute("categoryLList", categoryLList);
		model.addAttribute("categoryMList", categoryMList);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("totalRowCount", totalRowCount);


		return "/mileageShop/mileageShopList";
	}

	@RequestMapping("/mileageShopDetailView")
	public String mileageShopDetailView(ProductVO product, Model model) {

		System.out.println("[MileageShop Controller mileageShopDetailView]");

		String prodNo = product.getProdNo();
		System.out.println("prodNo:" + prodNo);

		product = shopService.getProduct(prodNo);
		System.out.println("product:"+ product);

		model.addAttribute("product", product);

		return "/mileageShop/mileageShopDetail";
	}

	@RequestMapping("/mileageShopCartDo")
	@ResponseBody
	public String mileageShopCartDo(ProductVO product, HttpSession session){

		System.out.println("[MileageShop Controller mileageShopCartDo]");
		System.out.println("product:"+product);

		MemberVO member = (MemberVO)session.getAttribute("login");

		String memNo = member.getMemNo();

		try {
			shopService.addCart(product, memNo);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			if(e.getMessage().equals("장바구니 항복 중복")) {
				return "duplicate";
			}else {
				return "fail";
			}
		}
		return "success";
	}

	@RequestMapping("/mileageShopCartView")
	public String mileageShopCartView(HttpSession session, Model model, String msg) {
		System.out.println("[MileageShop Controller mileageShopCartView]");
		MemberVO member = (MemberVO)session.getAttribute("login");

		if(member != null) {
			String memNo = member.getMemNo();

			List<ProductVO> prodList = shopService.getCartProdList(memNo);
			System.out.println("cart prodList:" + prodList);

			model.addAttribute("prodList", prodList);
			model.addAttribute("msg", msg);

			return "/mileageShop/mileageShopCart";
		}else {
			return "redirect:/startView?msg=none";
		}
	}

	@RequestMapping("/changeCartProdCnt")
	@ResponseBody
	public boolean changeCartProdCnt(String cartNo, String prodCnt) {
		System.out.println("[MileageShop Controller changeCartProdCnt]");

		try {
			shopService.changeCartProdCnt(cartNo, prodCnt);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return false;
		}
		return true;
	}

	@RequestMapping("/mileageShopOrderView")
	public String mileageShopOrderView(String cartNoStr, Model model, HttpSession session, ProductVO product) {
		System.out.println("[MileageShop Controller mileageShopOrderView]");
		System.out.println("cartNoStr:"+ cartNoStr);
		System.out.println("product:"+ product);

		List<ProductVO> orderProdList = new ArrayList<>();
		MemberVO member = (MemberVO)session.getAttribute("login");

		if(member != null) {
			int cnt = product.getProdCnt();
			MemberVO memberVO = null;
			try {
				memberVO = memberService.getMember(member.getMemNo());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			if(product.getProdNo() == null) {
				ObjectMapper om = new ObjectMapper();
				String[] arr;
				List<String> cartNoArr = new ArrayList<>();

				try {
					arr = om.readValue(cartNoStr, String[].class);
					System.out.println(Arrays.toString(arr));

					for(int i = 0 ; i < arr.length; i ++) {
						cartNoArr.add(arr[i]);
					}
					System.out.println("cartNoArr:"+ cartNoArr.toString());

					try {
						orderProdList = shopService.getOrderProdList(cartNoArr);
						System.out.println("orderProdList:"+ orderProdList);
					} catch (Exception e) {
						System.out.println(e.getMessage());
						e.printStackTrace();
					}

				} catch (JsonMappingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (JsonProcessingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}



				model.addAttribute("prodList", orderProdList);
				model.addAttribute("member", memberVO);

				return "/mileageShop/mileageShopOrder";
			}else {
				product = shopService.getProduct(product.getProdNo());
				product.setProdCnt(cnt);
				orderProdList.add(product);


				model.addAttribute("prodList", orderProdList);
				model.addAttribute("member", memberVO);
				return "/mileageShop/mileageShopOrder";
			}
		}else {
			return "redirect:/startView?msg=none";
		}
	}

	/*
	 * @RequestMapping("/mileageShopOrderDo") public String
	 * mileageShopOrderDo(String cartNoStr, HttpSession session) {
	 * System.out.println("[MileageShop Controller mileageShopOrderDo]");
	 * System.out.println("cartNoStr:"+ cartNoStr);
	 *
	 * ObjectMapper om = new ObjectMapper(); String[] arr; List<String> cartNoArr =
	 * new ArrayList<>(); MemberVO member = (MemberVO)session.getAttribute("login");
	 * String memNo = member.getMemNo();
	 *
	 * try { arr = om.readValue(cartNoStr, String[].class);
	 * System.out.println(Arrays.toString(arr));
	 *
	 * for(int i = 0 ; i < arr.length; i ++) { cartNoArr.add(arr[i]); }
	 * System.out.println("cartNoArr:"+ cartNoArr.toString());
	 *
	 * try { shopService.mileageShopOrderDo(cartNoArr, memNo); } catch (Exception e)
	 * { // TODO Auto-generated catch block System.out.println(e.getMessage());
	 * e.printStackTrace(); return
	 * "redirect:/mileageShopOrderCompleteView?msg=oFail"; } } catch
	 * (JsonMappingException e) { // TODO Auto-generated catch block
	 * e.printStackTrace(); } catch (JsonProcessingException e) { // TODO
	 * Auto-generated catch block e.printStackTrace(); }
	 *
	 * return "redirect:/mileageShopOrderCompleteView?msg=oSuccess"; }
	 */
	@RequestMapping("/mileageShopDeleteDo")
	public String mileageShopDeleteDo(String cartNoStr, Model model) {
		System.out.println("[MileageShop Controller mileageShopDeleteDo]");
		System.out.println("cartNoStr:"+ cartNoStr);

		ObjectMapper om = new ObjectMapper();
		String[] arr;
		List<String> cartNoArr = new ArrayList<>();

		try {
			arr = om.readValue(cartNoStr, String[].class);
			System.out.println(Arrays.toString(arr));

			for(int i = 0 ; i < arr.length; i ++) {
				cartNoArr.add(arr[i]);
			}
			System.out.println("cartNoArr:"+ cartNoArr.toString());

			try {
				shopService.deleteCart(cartNoArr);
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
				return "redirect:/mileageShopCartView?msg=dFail";
			}

		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return "redirect:/mileageShopCartView?msg=dSuccess";
	}

	@RequestMapping("/mileageShopOrderCompleteView")
	public String mileageShopOrderCompleteView(String msg, Model model) {
		System.out.println("[MileageShop Controller mileageShopOrderCompleteView]");
		System.out.println("msg :" + msg);

		model.addAttribute("msg", msg);

		return "/mileageShop/orderComplete";
	}

	@RequestMapping("/mileageShopOrderLogView")
	public String mileageShopOrderLogView(ProdLogSearchVO searchVO, Model model, HttpSession session) {
		System.out.println("[MileageShop Controller mileageShopOrderLogView]");

		MemberVO member = (MemberVO)session.getAttribute("login");
		if(member != null) {
			String memNo = member.getMemNo();

			List<OrderLogVO> orderLogList = shopService.getOrderLogList(memNo, searchVO);
			List<OrderDetailVO> orderDetailList = shopService.getOrderDetailList(orderLogList);

			model.addAttribute("searchVO", searchVO);
			model.addAttribute("orderLogList", orderLogList);
			model.addAttribute("orderDetailList", orderDetailList);

			return "/mileageShop/mileageShopOrderLog";
		}else {
			return "redirect:/startView?msg=none";
		}
	}
}
