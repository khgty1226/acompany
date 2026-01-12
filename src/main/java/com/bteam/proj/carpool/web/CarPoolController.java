package com.bteam.proj.carpool.web;

import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bteam.proj.carpool.service.CarPoolService;
import com.bteam.proj.carpool.vo.CarPoolSearchVO;
import com.bteam.proj.carpool.vo.CarPoolVO;
import com.bteam.proj.carpool.vo.CarVO;
import com.bteam.proj.chats.web.MessageBuilder;
import com.bteam.proj.chats.web.WebSocketMessageProcessor;
import com.bteam.proj.chats.vo.MessageVO;
import com.bteam.proj.chats.vo.MessageVO.CommandType;
import com.bteam.proj.chats.vo.MessageVO.DataType;
import com.bteam.proj.chats.web.ChatRoomManager;
import com.bteam.proj.common.vo.PagingVO;
import com.bteam.proj.member.vo.MemberVO;

@Controller
public class CarPoolController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CarPoolService carPoolService;
	
	WebSocketMessageProcessor wsmp = WebSocketMessageProcessor.getInstance();

	MessageBuilder mb = new MessageBuilder();
	
	@RequestMapping("/carPoolView")
	public String carPoolView(Model model, HttpSession session, String msg) {

		System.out.println("[CarPoolContoller carPoolView]");
		List<CarPoolVO> carPoolList = carPoolService.getCarPoolList();
		System.out.println("carPoolList :" + carPoolList);
		
		MemberVO loginMember = (MemberVO)session.getAttribute("login");
		if(loginMember != null) {
			MemberVO member = carPoolService.getAdminMember(loginMember.getMemNo());
			
			
			model.addAttribute("member", member);
			model.addAttribute("carPoolList", carPoolList);
			model.addAttribute("msg", msg);
			
			return "/carpool/carPoolView";
		}else {
			return "redirect:/startView?msg=none";
		}
	}
	
	@PostMapping("/carPoolDetail")
	@ResponseBody
	public CarPoolVO carPoolDetail(String cpNo) {
		System.out.println("CarPoolController carPoolDetail cpNo:"+ cpNo);
		
		CarPoolVO carPool = carPoolService.getCarPool(cpNo);
		System.out.println("carPool" +carPool);
		
		
		return carPool;
	}
	
	@PostMapping("/carPoolModal")
	@ResponseBody
	public CarPoolVO carPoolModal(String cpNo) {
		System.out.println("CarPoolController carPoolModal cpNo:"+ cpNo);
		
		CarPoolVO carPool = carPoolService.getCarPoolModal(cpNo);
		System.out.println("carPool" +carPool);
		
		
		return carPool;
	}
	
	@PostMapping("/carPoolApply")
	public String carPoolApply(CarPoolVO carpool, Model model, HttpSession session) {
		
		System.out.println("CarPoolController carPoolApply:"+ carpool);
		String cpNo = carpool.getCpNo();
		String driver = carpool.getDriver();
		
		MemberVO loginMember = (MemberVO)session.getAttribute("login");
		if(loginMember != null) {
			String memNo = loginMember.getMemNo();
			String memName = loginMember.getMemName();
			
			try {
				carPoolService.carPoolFullCheck(cpNo);
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
				return "redirect:/carPoolView?msg=full";
			}
	
			try {
				carPoolService.carPoolApply(cpNo, memNo);
			}catch(Exception e){
				System.out.println(e.getMessage());
				e.printStackTrace();
				return "redirect:/carPoolView?msg=fail";
			}
			mb.setSubject("SYSTEM");
			mb.setDataType(DataType.CHAT);
			mb.setCommandType(CommandType.CREATE);
			mb.addData("ChatroomNo", "SYSTEM_"+driver);
			mb.addData("Content", memName+" 님이 "+cpNo +" 카풀을 신청했습니다.");
			//mb.addData("href", "/myCarPoolView");
			mb.addData("ChatDate", ZonedDateTime.now().toString());
			
			MessageVO message = mb.build();
//			wsmp.enqueueMessage(message);
			mb.clearData();
			
			return "redirect:/carPoolView?msg=apply";
		}else {
			return "redirect:/startView?msg=none";
		}
	}
	
	@PostMapping("/getMyApplyList")
	@ResponseBody
	public List<String> getMyApplyList(String memNo){
		System.out.println("[CarPoolController getMyApplyList] memNo:"+ memNo);
		
		List<String> myApplyList = carPoolService.getmyApplyList(memNo);
		System.out.println("myApplyList:"+myApplyList);
		
		return myApplyList;
	}
	
	@PostMapping("/carPoolCancel")
	public String carPoolCancel(CarPoolVO carPool, Model model, HttpSession session, String location) {
		
		System.out.println("CarPoolController carPoolCancel carpool:"+ carPool);
		String cpNo = carPool.getCpNo();
		String driver = carPool.getDriver();
		
		MemberVO loginMember = (MemberVO)session.getAttribute("login");
		if(loginMember != null) {
			String memNo = loginMember.getMemNo();
			String memName = loginMember.getMemName();
			
			try {
				carPoolService.carPoolCancel(cpNo, memNo);
			}catch(Exception e){
				System.out.println(e.getMessage());
				e.printStackTrace();
				if(location.equals("my")) {
					return "redirect:/myCarPoolView?msg=cfail";
				}else {
					return "redirect:/carPoolView?msg=cfail";
				}
			}
			
			mb.setSubject("SYSTEM");
			mb.setDataType(DataType.CHAT);
			mb.setCommandType(CommandType.CREATE);
			mb.addData("ChatroomNo", "SYSTEM_"+driver);
			mb.addData("Content", memName+" 님이 "+cpNo +" 카풀을 취소했습니다.");
			//mb.addData("href", "/myCarPoolView");
			mb.addData("ChatDate", ZonedDateTime.now().toString());
			
			MessageVO message = mb.build();
//			wsmp.enqueueMessage(message);
			mb.clearData();
			
			if(location.equals("my")) {
				return "redirect:/myCarPoolView?msg=cancel";
			}else {
				return "redirect:/carPoolView?msg=cancel";
			}
		}else {
			return "redirect:/startView?msg=none";
		}
	}
	
	@PostMapping("/carPoolDelete")
	public String carPoolDelete(CarPoolVO carpool, Model model, HttpSession session, String location) {
		System.out.println("CarPoolController carPoolDelete carpool:"+ carpool);
		
		String cpNo = carpool.getCpNo();
		String driver = carpool.getDriver();
		
		MemberVO loginMember = (MemberVO)session.getAttribute("login");
		if(loginMember != null) {
			String memNo = loginMember.getMemNo();
			
			try {
				List<MemberVO> passList = carPoolService.getPassList(cpNo);
				System.out.println("CarPoolController carPoolDelete passList:"+ passList);

				carPoolService.carPoolDelete(cpNo, memNo);
			
				for(int i = 0 ; i < passList.size(); i++) {
					MemberVO pass = passList.get(i);
					if(!pass.getMemNo().equals(memNo)) {
						mb.setSubject("SYSTEM");
						mb.setDataType(DataType.CHAT);
						mb.setCommandType(CommandType.CREATE);
						mb.addData("ChatroomNo", "SYSTEM_"+ pass.getMemNo());
						mb.addData("Content", cpNo +" 카풀이 삭제되었습니다.");
						//mb.addData("href", "/myCarPoolView");
						mb.addData("ChatDate", ZonedDateTime.now().toString());
						
						MessageVO message = mb.build();
//						wsmp.enqueueMessage(message);
						mb.clearData();
					}
				}
			
				if(location.equals("my")) {
					return "redirect:/myCarPoolView?msg=delete";
				}else {
					return "redirect:/carPoolView?msg=delete";
				}

			}catch(Exception e){
				System.out.println(e.getMessage());
				e.printStackTrace();
				if(location.equals("my")) {
					return "redirect:/myCarPoolView?msg=dfail";
				}else {
					return "redirect:/carPoolView?msg=dfail";
				}
			}
		}else {
			return "redirect:/startView?msg=none";
		}
	}
	
	@PostMapping("/carPoolDeleteAdmin")
	public String carPoolDeleteAdmin(CarPoolVO carpool, Model model, HttpSession session, String location) {
		
		System.out.println("CarPoolController carPoolDelete carpool:"+ carpool);
		String cpNo = carpool.getCpNo();
		
		MemberVO loginMember = (MemberVO)session.getAttribute("login");
		if(loginMember != null) {
			String memNo = loginMember.getMemNo();
			
			try {
				carPoolService.carPoolDelete(cpNo, memNo);
				List<MemberVO> passList = carPoolService.getPassList(cpNo);
				
				for(int i = 0 ; i < passList.size(); i++) {
					MemberVO pass = passList.get(i);
					if(!pass.getMemNo().equals(memNo)) {
						mb.setSubject("SYSTEM");
						mb.setDataType(DataType.CHAT);
						mb.setCommandType(CommandType.CREATE);
						mb.addData("ChatroomNo", "SYSTEM_"+ pass.getMemNo());
						mb.addData("Content", cpNo +" 카풀이 삭제되었습니다.");
						//mb.addData("href", "/myCarPoolView");
						mb.addData("ChatDate", ZonedDateTime.now().toString());
						
						MessageVO message = mb.build();
						wsmp.enqueueMessage(message);
						mb.clearData();
					}
				}
				
				return "redirect:/carPoolAdminView?msg=delete";
			}catch(Exception e){
				System.out.println(e.getMessage());
				e.printStackTrace();
				return "redirect:/carPoolAdminView?msg=dfail";
			}
		}else {
			return "redirect:/startView?msg=none";
		}
	}
	
	@RequestMapping("/carPoolSearch")
	@ResponseBody
	public List<CarPoolVO> carPoolSearch(String word, String cpGoOut){
		System.out.println("CarPoolController carPoolSearch word:"+ word);
		
		List<CarPoolVO> carPoolList = carPoolService.getCarPoolListSearch(word);
		
		return carPoolList;
	}
	
	@RequestMapping("/carPoolCreateView")
	public String carPoolCreateView(HttpSession session, Model model, String msg) {
		System.out.println("[CarPoolContoller carPoolCreateView]");
		
		MemberVO loginMember = (MemberVO)session.getAttribute("login");
		if(loginMember != null) {
			MemberVO member = carPoolService.getAdminMember(loginMember.getMemNo());
			
			List<CarVO> carList = carPoolService.getCarList(loginMember.getMemNo());
			member.setCarList(carList);
			
			model.addAttribute("member", member);
			model.addAttribute("msg", msg);
	
			return "/carpool/carPoolCreateView";
		}else {
			return "redirect:/startView?msg=none";
		}
	}
	
	@RequestMapping("/carPoolCarInfo")
	@ResponseBody
	public CarVO carPoolCarInfo(String carNo) {
		System.out.println("[CarPoolContoller carPoolCarInfo]");
		
		CarVO carVO = carPoolService.getCarInfo(carNo);
		
		return carVO;
	}
	
	@RequestMapping("/carPoolCreate")
	public String carPoolCreate(CarPoolVO carPool) {
		System.out.println("[CarPoolContoller carPoolCreate]");
		carPool.setCpDistance(carPool.getCpDistance().split(" ")[0]); // 0.0 km -> 0.0
		System.out.println("carPool:"+ carPool);
		
		try {
			carPoolService.carPoolCreate(carPool);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return "redirect:/carPoolCreateView?msg=cfail";
		}
		return "redirect:/carPoolCreateView?msg=create";
	}
	
	@RequestMapping("/myCarPoolView")
	public String myCarPoolView(HttpSession session, Model model, String msg, @ModelAttribute("searchVO") CarPoolSearchVO searchVO) {
		System.out.println("[CarPoolContoller myCarPoolView]");
		
		
		MemberVO loginMember = (MemberVO)session.getAttribute("login");
		if(loginMember != null) {
			String memNo = loginMember.getMemNo();
			MemberVO member = carPoolService.getAdminMember(memNo);
			
			List<CarPoolVO> carPoolList = carPoolService.getMyCarPoolList(memNo);
			List<CarPoolVO> carPoolLogList = carPoolService.getMyCarPoolLogList(memNo, searchVO);
			System.out.println("carPoolList :" + carPoolList);
			System.out.println("carPoolLogList :" + carPoolLogList);
			
			model.addAttribute("member", member);
			model.addAttribute("carPoolList", carPoolList);
			model.addAttribute("carPoolLogList", carPoolLogList);
			model.addAttribute("msg", msg);
			
			return "/carpool/myCarPoolView";
		}else {
			return "redirect:/startView?msg=none";
		}
		
	}
	
	@RequestMapping("/carPoolAdminView")
	public String carPoolAdminView(HttpSession session, Model model, String msg, @ModelAttribute("searchVO") CarPoolSearchVO searchVO) {
		System.out.println("[CarPoolContoller carPoolAdminView]");
		
		
		MemberVO loginMember = (MemberVO)session.getAttribute("login");
		if(loginMember != null) {
			String memNo = loginMember.getMemNo();
			MemberVO member = carPoolService.getAdminMember(memNo);
			
			List<CarPoolVO> carPoolList = carPoolService.getCarPoolListAdmin();
			List<CarPoolVO> carPoolLogList = carPoolService.getCarPoolLogListAdmin(searchVO);
			System.out.println("carPoolList :" + carPoolList);
			System.out.println("carPoolLogList :" + carPoolLogList);
			
			model.addAttribute("member", member);
			model.addAttribute("carPoolList", carPoolList);
			model.addAttribute("carPoolLogList", carPoolLogList);
			model.addAttribute("msg", msg);
			
			return "/carpool/carPoolAdminView";
		}else {
			return "redirect:/startView?msg=none";
		}
		
	}
	
	
	@RequestMapping("/carPoolStateChange")
	public String carPoolStateChange(String cpNo, String cpState, String memNo) {
		System.out.println("[CarPoolContoller carPoolStateChange]");
		System.out.println("cpNo:"+ cpNo);
		System.out.println("cpState:"+ cpState);
		System.out.println("memNo:"+ memNo);
		
		try {
			carPoolService.carPoolStateChange(cpNo, cpState, memNo);
		
			List<MemberVO> passList = carPoolService.getPassList(cpNo);
			
			for(int i = 0 ; i < passList.size(); i++) {
				MemberVO pass = passList.get(i);
				if(!pass.getMemNo().equals(memNo)) {
					mb.setSubject("SYSTEM");
					mb.setDataType(DataType.CHAT);
					mb.setCommandType(CommandType.CREATE);
					mb.addData("ChatroomNo", "SYSTEM_"+ pass.getMemNo());
					if(cpState.equals("C")) {
						mb.addData("Content", cpNo +" 카풀이 운행완료 대기중입니다. 나의 카풀에서 운행 완료 혹은 실패를 선택해주세요.");
					}else if(cpState.equals("F")){
						mb.addData("Content", cpNo +" 카풀이 운행실패 처리되었습니다.");
					}
					//mb.addData("href", "/myCarPoolView");
					mb.addData("ChatDate", ZonedDateTime.now().toString());
					
					MessageVO message = mb.build();
//					wsmp.enqueueMessage(message);
					mb.clearData();
				}
			}
			
			return "redirect:/myCarPoolView?msg=cSuccess";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e.getMessage());
			return "redirect:/myCarPoolView?msg=cFail";
		}
		
	}
	
	@RequestMapping("/carPoolStateChangePass")
	public String carPoolStateChangePass(CarPoolVO carpool, String cpState, String memNo, HttpSession session) {
		System.out.println("[CarPoolContoller carPoolStateChangePass]");
		String cpNo = carpool.getCpNo();
		String driver = carpool.getDriver();
		
		System.out.println("memNo:"+ memNo);
		System.out.println("cpNo:"+ cpNo);
		System.out.println("cpState:"+ cpState);
		System.out.println("driver:"+ driver);
		
		MemberVO member = (MemberVO)session.getAttribute("login");
		if(member != null) {
			String memName = member.getMemName();
			try {
				carPoolService.carPoolStateChangePass(cpNo, cpState, memNo);
				
				mb.setSubject("SYSTEM");
				mb.setDataType(DataType.CHAT);
				mb.setCommandType(CommandType.CREATE);
				mb.addData("ChatroomNo", "SYSTEM_"+ driver);
				if(cpState.equals("S")) {
					mb.addData("Content", memName+" 님이 "+cpNo +" 카풀을 운행완료 처리하였습니다.");
				}else if(cpState.equals("F")){
					mb.addData("Content", memName+" 님이 "+cpNo +" 카풀을 운행실패 처리하였습니다.");
				}
				//mb.addData("href", "/myCarPoolView");
				mb.addData("ChatDate", ZonedDateTime.now().toString());
				
				MessageVO message = mb.build();
//				wsmp.enqueueMessage(message);
				mb.clearData();
				
				return "redirect:/myCarPoolView?msg=cSuccess";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println(e.getMessage());
				return "redirect:/myCarPoolView?msg=cFail";
			}
		}else {
			return "redirect:/startView?msg=none";
		}
		
	}
	
}
