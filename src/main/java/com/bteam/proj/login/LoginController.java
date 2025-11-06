package com.bteam.proj.login;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bteam.proj.attach.vo.AttachVO;
import com.bteam.proj.chart.service.ChartService;
import com.bteam.proj.chart.vo.ChartVO;
import com.bteam.proj.chats.vo.MessageVO;
import com.bteam.proj.chats.vo.MessageVO.CommandType;
import com.bteam.proj.chats.vo.MessageVO.DataType;
import com.bteam.proj.chats.web.MessageBuilder;
import com.bteam.proj.chats.web.WebSocketMessageProcessor;
import com.bteam.proj.code.service.CommCodeService;
import com.bteam.proj.code.vo.CodeVO;
import com.bteam.proj.common.util.NextITFileUpload;
import com.bteam.proj.member.service.MailSendService;
import com.bteam.proj.member.service.MemberService;
import com.bteam.proj.member.vo.MailAuthVO;
import com.bteam.proj.member.vo.MemberVO;

@Controller
public class LoginController {
	
	WebSocketMessageProcessor wsmp = WebSocketMessageProcessor.getInstance();

	MessageBuilder mb = new MessageBuilder();
	
	@Autowired
	MemberService memberService; // (1) 메모리에 저장된 MemberService를 그대로 가져옴
	
	@Autowired
	private MailSendService mailSendService;
	
	@Autowired
	private NextITFileUpload nextITFileUpload;
	
	@Autowired
	private CommCodeService codeService;
	
	@Autowired
	private ChartService chartService;
	
	
	@ModelAttribute("deptList")
	public List<CodeVO> deptList(){
		return codeService.getCodeListByParent("DP00");
	}
	@ModelAttribute("teamList")
	public List<CodeVO> teamList(){
		return codeService.getCodeListByParent("TM00");
	}
	
	// 회원가입 화면 응답 메소드
	@RequestMapping("/joinView")
	public String joinView() {
		return "login/joinView";
	}
	
	// 아이디 체크 메소드
	@RequestMapping("/joinView/idCheck")
	@ResponseBody
	public boolean idCheck(@ModelAttribute("member") MemberVO member) {
		
		boolean result = memberService.joinCheck(member);
		
		return result;
	}
	
	// 이메일 중복 체크 메소드
	@RequestMapping("/joinView/emailCheck")
	@ResponseBody
	public boolean EmailCheck(@ModelAttribute("member") MemberVO member) {
		
		boolean result = memberService.joinEmailCheck(member);
		
		return result;
	}

	// 이메일 중복 체크 메소드(마이페이지 수정)
	@RequestMapping("/memberEdit/emailCheck")
	@ResponseBody
	public boolean editEmailCheck(@ModelAttribute("member") MemberVO member) {
		
		boolean result = memberService.editEmailCheck(member);
		
		return result;
	}
	
	// 회원가입 처리 메소드
	@RequestMapping(value = "/joinDo", method = RequestMethod.POST)
	public String joinDo(@ModelAttribute("member") MemberVO member
			, @RequestParam String memNo
			, @RequestParam(required = false)MultipartFile[] profilePhoto) {
		
		System.out.println("MemberController joinDo member.toString(): " + member.toString());
		
		if(profilePhoto != null) {
			 try {
				List<AttachVO> attachList = nextITFileUpload.fileUpload(profilePhoto, "PROFILEPHOTO", "profilePhoto");
				System.out.println("MemberController attachList : " + attachList);
				if(attachList.size() > 0) {
					member.setAttachList(attachList);
					System.out.println("MemberController member.getAttachList() : " + member.getAttachList());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		memberService.joinMemberInsert(member);
		
		
		/* 회원가입 완료 알림(관리자) */
		MemberVO getMember = null;
		try {
			getMember = memberService.getMember(memNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mb.setSubject("SYSTEM");
		mb.setDataType(DataType.CHAT);
		mb.setCommandType(CommandType.CREATE);
		mb.addData("ChatroomNo", "SYSTEM_2023-00-0000");
		mb.addData("Content", getMember.getMemName() + "님이 회원가입하였습니다.");
		//mb.addData("href", "/memberList");
		
		MessageVO message = mb.build();
		wsmp.enqueueMessage(message);
		mb.clearData();
		
		return "redirect:/loginView?msg=success";
	}
	
	@RequestMapping("/joinView/mailAuth")
	@ResponseBody
	public boolean mailAuth(@RequestParam(required = true) String mail) {
		
		 String authKey = mailSendService.sendAuthMail(mail);
		 
		 boolean result = false;

		 if(!authKey.equals("false")) {
			 memberService.registerMailAut(mail, authKey);
			 result = true;
		 }
		
		return result;
	}
	
	@RequestMapping("/joinView/mailWindow")
	public String mailWindow() {
		return "/login/mailWindow";
	}
	
	@RequestMapping("/joinView/authKeyCompare")
	@ResponseBody
	public boolean authKeyCompare(@ModelAttribute MailAuthVO mailAuthVO) {
		boolean result = memberService.authKeyCompare(mailAuthVO);
		return result; 
	}
	
	// 회원가입 메일 인증 여부
	@RequestMapping("/joinView/checkMailAuth")
	@ResponseBody
	public boolean checkMailAuth(HttpServletRequest request) {
		
		String email = request.getParameter("memEmail"); // joinView.jsp 에서 input 속 name 값
		
		boolean result = memberService.checkMailAuth(email);
		
		return result;
	}
	
	// 로그인 화면 응답 메소드
	@RequestMapping("/loginView")
	public String loginView(HttpServletRequest request, Model model, String msg) {
		
		String fromUrl = request.getHeader("Referer");
		
		model.addAttribute("fromUrl", fromUrl);
		model.addAttribute("msg", msg);
		
		return "login/loginView";
	}
	
	// 로그인 처리 메소드
	@PostMapping("/loginDo")
	public String loginDo(MemberVO member, Model model
			, HttpSession session, boolean rememberId
			, HttpServletResponse response, String fromUrl) {
		
		System.out.println(member);
		System.out.println("rememberId = " + rememberId);
		System.out.println("fromUrl = " + fromUrl);
		
		try {
			MemberVO login = memberService.loginMember(member);
			System.out.println("로그인 성공");
			System.out.println("memNo : " + login.getMemNo());
			System.out.println("memPass : " + login.getMemPass());
			System.out.println("memName : " + login.getMemName());
			
			// 로그인 시간 기록
			String memNo = login.getMemNo();
			memberService.loginTime(memNo);
			
			// 세션 객체에 로그인 정보 담기
			session.setAttribute("login", login);
			System.out.println("login : " + login);
			
			// 로그인시 무한유지, 로그아웃시 삭제
			Cookie memberNo = new Cookie("memberNo", login.getMemNo());
			memberNo.setMaxAge(60 * 60 * 24 * 365 * 10);
			response.addCookie(memberNo);
			
			// 아이디 기억하기 체크했다.
			// 쿠키에 아이디 저장
			if(rememberId == true) {
				
				// 쿠키 객체 생성
				Cookie cookie = new Cookie("rememberId", login.getMemNo());
				
				// response 객체에 쿠키를 담아서 전달
				response.addCookie(cookie);
				
			}else {
				// 아이디 기억하기 체크하지 않음
				
				// rememberId 키값을 가지는 쿠키를 삭제시켜주기
				// = rememberId 키값을 가지는 쿠키를 생성하고
				// 유통기한을 0으로 설정해서 전달한다.
				Cookie cookie = new Cookie("rememberId", "삭제");
				cookie.setMaxAge(0);  // 이 쿠키가 브라우저로 저장된 후 0초 후 소멸
				
				response.addCookie(cookie);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("로그인 실패: " + e.getMessage());
			
			model.addAttribute("errMsg", e.getMessage());
			
			return "login/loginView";
		}
		
		return "redirect:/welcomeView";
	}
	
	// 로그인 체크 메소드
	@RequestMapping("/loginView/loginCheck")
	@ResponseBody
	public boolean loginCheck(@ModelAttribute("member") MemberVO member) {
		
		boolean result = memberService.loginCheck(member);
		
		return result;
	}
	
	// 탈퇴처리한 회원 체크 메소드
	@RequestMapping("/loginView/delEmailCheck")
	@ResponseBody
	public boolean delEmailCheck(@RequestParam("memNo") String memNo) {
		
		boolean result = memberService.loginDelMember(memNo);
		
		return result;
		
	}
	
	// 로그아웃 처리 메소드
	@RequestMapping("/logout")
	public String logoutDo(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
	    // 쿠키 가져오기
	    Cookie[] cookies = request.getCookies();
	    String memNo = null;
	    
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("memberNo".equals(cookie.getName())) {
	                memNo = cookie.getValue();
	                break;
	            }
	        }
	    }
	    
	    System.out.println("memberNo cookie value: " + memNo);
		
		// 해당 클라이언트에 대한 세션객체 제거
		session.invalidate();
		Cookie memberNo = new Cookie("memberNo", "");
		memberNo.setMaxAge(0);
		// 현재 /logoutDo를 요청한 URL 링크  
		response.addCookie(memberNo);
		String fromUrl = request.getHeader("Referer");
		System.out.println(fromUrl);
		
		memberService.logoutTime(memNo);
		
		return "login/startView";
	}
	
	// 메인화면 응답 메소드
	@RequestMapping("/welcomeView")
	public String welcomeView(Model model) {
		
		ChartVO likeRanker = chartService.getLikeRanker();
		ChartVO saleRanker = chartService.getSaleRanker();
		ChartVO carpoolRanker = chartService.getCarpoolRanker();
		ChartVO shareRanker = chartService.getShareRanker();
		
		System.out.println("likeRanker= "+ likeRanker.getAtchNo());
		System.out.println("saleRanker= "+ saleRanker.getAtchNo());
		System.out.println("carpoolRanker= "+ carpoolRanker.getAtchNo());
		System.out.println("shareRanker= "+ shareRanker.getAtchNo());
		
		model.addAttribute("likeRanker", likeRanker);
		model.addAttribute("saleRanker", saleRanker);
		model.addAttribute("carpoolRanker", carpoolRanker);
		model.addAttribute("shareRanker", shareRanker);
		
		
		return "welcomeView";
	}
	
}
