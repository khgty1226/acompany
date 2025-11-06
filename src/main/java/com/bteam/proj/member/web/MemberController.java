package com.bteam.proj.member.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bteam.proj.attach.vo.AttachVO;
import com.bteam.proj.chats.web.MessageBuilder;
import com.bteam.proj.chats.web.WebSocketMessageProcessor;
import com.bteam.proj.code.service.CommCodeService;
import com.bteam.proj.code.vo.CodeVO;
import com.bteam.proj.common.util.NextITFileUpload;
import com.bteam.proj.common.vo.RoleInfoVO;
import com.bteam.proj.member.service.MemberService;
import com.bteam.proj.member.vo.MemberSearchVO;
import com.bteam.proj.member.vo.MemberVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

@Controller
public class MemberController {
	
	WebSocketMessageProcessor wsmp = WebSocketMessageProcessor.getInstance();

	MessageBuilder mb = new MessageBuilder();

	@Autowired
	MemberService memberService; // (1) 메모리에 저장된 MemberService를 그대로 가져옴

	@Autowired
	private NextITFileUpload nextITFileUpload;

	@Autowired
	private CommCodeService codeService;

	@ModelAttribute("deptList")
	public List<CodeVO> deptList() {
		return codeService.getCodeListByParent("DP00");
	}

	@ModelAttribute("teamList")
	public List<CodeVO> teamList() {
		return codeService.getCodeListByParentTeam();
	}

	// 회원 목록 조회(관리자)
	@RequestMapping("/memberList")
	public String memberList(@ModelAttribute("searchVO") MemberSearchVO searchVO, Model model, String msg) {
		System.out.println("MemberController memberList searchVO : " + searchVO);

		try {
			List<MemberVO> memberList = memberService.getMemberList(searchVO);
			System.out.println("MemberController memberList memberList : " + memberList);
			model.addAttribute("memberList", memberList);
			model.addAttribute("msg", msg);
		} catch (Exception e) {
			model.addAttribute("e", e);
			e.printStackTrace();
		}
		return "member/memberList";
	}

	// 직급 설정 페이지 조회(관리자)
	@RequestMapping("/memberRole")
	public String memberRole(@RequestParam String memNo, Model model) {
		System.out.println("MemberController memberRole memNo :" + memNo);

		try {
			MemberVO member = null;
			if (memNo != null && !memNo.equals("")) {
				member = memberService.getMember(memNo);
			} else {
				throw new Exception();
			}
			model.addAttribute("member", member);
			List<RoleInfoVO> roleInfoList = memberService.getRoleInfo();
			System.out.println("MemberController memberRole roleInfoList : " + roleInfoList);
			model.addAttribute("roleInfoList", roleInfoList);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("e", e);
		}
		return "member/memberRole";
	}

	// 직급 수정(관리자)
	@RequestMapping(value = "/memberRoleUpdate", method = RequestMethod.POST)
	public String memberRoleUpdate(@RequestParam String memNo,
			@RequestParam(required = false, name = "userRole") String role, Model model) {
		System.out.println("MemberController memberRoleUpdate memNo : " + memNo + ", role : " + role);
		try {
			if (memNo != null && !memNo.equals("") && role != null && !role.equals("")) {
				memberService.updateUserRole(memNo, role);
			} else {
				throw new Exception();
			}
			return "redirect:/memberList?msg=success";

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("e", e);
		}

		return "redirect:/memberList?msg=fail";
	}

	// 회원목록에서 부서/팀 수정(관리자)
	@RequestMapping(value = "/memberListUpdate", method = RequestMethod.POST)
	public String memberListUpdate(@RequestParam String memberJson, Model model) {
		System.out.println("MemberController memberListUpdate memberJson : " + memberJson);

		ObjectMapper objectMapper = new ObjectMapper();

		try {
			List<MemberVO> list = objectMapper.readValue(memberJson, new TypeReference<List<MemberVO>>() {
			});
			System.out.println("MemberController memberListUpdate list : " + list);

			if (list != null && !list.equals("")) {
				memberService.updateUserList(list);
			} else {
				throw new Exception();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "member/memberList";
	}

	// 회원 삭제(관리자)
	@RequestMapping(value = "/memberMultiDelete", method = RequestMethod.POST)
	public String memberMultiDelete(@RequestParam String memMultiId, Model model) {
		System.out.println("MemberController memberMultiDelete memMultiId: " + memMultiId);
		try {
			if (memMultiId != null && memMultiId.length() >= 1) {
				memberService.removeMultiMember(memMultiId);
			} else {
				throw new Exception();
			}
			return "redirect:/memberList?msg=successDel";

		} catch (Exception e) {
			e.printStackTrace();
			// model.addAttribute("e", e);
			return "redirect:/memberList?msg=failDel";
		}
	}

	// 마이페이지 조회
	@RequestMapping("/memberView")
	public String memberView(@RequestParam String memNo, Model model, String msg) {
		System.out.println("MemberController memberView memNo : " + memNo);
		try {
			MemberVO member = memberService.getMember(memNo);
			model.addAttribute("member", member);

			List<RoleInfoVO> roleInfoList = memberService.getRoleInfo();
			System.out.println("MemberController memberView roleInfoList : " + roleInfoList);
			model.addAttribute("roleInfoList", roleInfoList);
			model.addAttribute("msg", msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "member/memberView";
	}

	// 마이페이지 수정
	@RequestMapping("/memberEdit")
	public String memberEdit(@RequestParam String memNo, Model model) {
		System.out.println("MemberController memberEdit memNo : " + memNo);
		try {
			MemberVO member = memberService.getMember(memNo);
			model.addAttribute("member", member);

			List<RoleInfoVO> roleInfoList = memberService.getRoleInfo();
			System.out.println("MemberController memberEdit roleInfoList : " + roleInfoList);
			model.addAttribute("roleInfoList", roleInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "member/memberEdit";
	}

	@RequestMapping(value = "/memberModify", method = RequestMethod.POST)
	public String memberModify(@ModelAttribute("member") MemberVO member
			, @RequestParam String memPhone1
			, @RequestParam String memPhone2
			, @RequestParam String memPhone3
			, BindingResult error
			, Model model,
			@RequestParam(required = false) MultipartFile[] profilePhoto) {
		
		System.out.println(memPhone1 + memPhone2 + memPhone3);
		member.setMemPhone(memPhone1 + memPhone2 + memPhone3);
		
		System.out.println("MemberController memberModify member.toStirng(): " + member.toString());
		
		if (error.hasErrors()) {
			return "member/memberEdit";
		}
		
		boolean fileUploadflag = true;
		if (profilePhoto != null) {
			try {
				List<AttachVO> attachList = nextITFileUpload.fileUpload(profilePhoto, "PROFILEPHOTO", "profilePhoto");
				member.setAttachList(attachList);
			} catch (Exception e) {
				fileUploadflag = false;
				e.printStackTrace();
			}
		}
		
		try {
			if (member.getMemNo() != null && !member.getMemNo().equals("")) {
				memberService.modifyMember(member);
			} else {
				throw new Exception();
			}
			
			if (fileUploadflag) {
				return "redirect:/memberView?memNo=" + member.getMemNo() + "&msg=success";
			} else {
				throw new Exception();
				// resultMessageVO.failSetting(false, "파일 업로드 실패", "회원정보는 수정되었으나 파일이 업로드 되지
				// 못하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/memberView?memNo=" + member.getMemNo() + "&msg=fail";
	}

	// 비밀번호 변경
	@RequestMapping("/memberEditPass")
	public String memberEditPass(@RequestParam String memNo, Model model) {
		System.out.println("MemberController memberEdit memNo : " + memNo);
		try {
			MemberVO member = memberService.getMember(memNo);
			model.addAttribute("member", member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "member/memberEditPass";
	}

	// 비밀번호 변경 저장
	@RequestMapping(value = "/memberModifyPass", method = RequestMethod.POST)
	public String memberModifyPass(@ModelAttribute("member") MemberVO member, BindingResult error, Model model) {
		System.out.println("MemberController memberModify member.toStirng(): " + member.toString());

		if (error.hasErrors()) {
			return "member/memberModifyPass";
		}

		try {
			if (member.getMemNo() != null && !member.getMemNo().equals("")) {
				memberService.modifyPass(member);
			} else {
				throw new Exception();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/loginView?msg=passchange";
	}

	// 기존 비밀번호 체크
	@RequestMapping(value = "/memberEdit/passCheck", method = RequestMethod.POST)
	@ResponseBody
	public boolean passCheck(@ModelAttribute("member") MemberVO member, Model model) throws Exception {

		System.out.println("MemberController memberModify member.toStirng(): " + member.toString());

		boolean result = false;
		if (member.getMemNo() != null && !member.getMemNo().equals("")) {
			result = memberService.passCheck(member);

		} else {
			throw new Exception();
		}

		return result;
	}

}
