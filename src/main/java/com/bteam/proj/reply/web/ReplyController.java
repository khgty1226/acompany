package com.bteam.proj.reply.web;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bteam.proj.member.vo.MemberVO;
import com.bteam.proj.reply.service.ReplyService;
import com.bteam.proj.reply.vo.ReplyVO;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	
	@Autowired
	ReplyService replyService;
	
	
	// 댓글 등록 
	@RequestMapping("/replyRegister")
	public String replyRegister(@ModelAttribute ReplyVO reply) {
		
		System.out.println("ReplyController reply.toString = " + reply.toString());
		try {
			replyService.replyRegister(reply);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/board/boardDetailView";
	}
	
	// 댓글 리스트
	@RequestMapping("/replyList")
	public String replyList(ReplyVO replyVO, Model model) {
		// System.out.println("ReplyVO = " + replyVO.toString());
		
		List<ReplyVO> replyList = replyService.getReplyListByParent(replyVO);
		model.addAttribute("replyList", replyList);
		
		// System.out.println("replyList = " + replyList);
		
		return "/board/part/reply";
	}
	
	// 댓글 수정
	@RequestMapping("/replyUpdate")
	@ResponseBody
	public Map<String, Object> replyUpdate(@ModelAttribute ReplyVO replyVO, HttpServletRequest request){
		
		replyVO.setReIp(request.getRemoteAddr());
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			replyService.replyUpdate(replyVO);
			map.put("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", false);
		}
		
		return map;
	}
	
	// 댓글 삭제
	@RequestMapping("/replyDelete")
	@ResponseBody
	public Map<String, Object> replyDelete(@ModelAttribute ReplyVO replyVO, HttpSession session){
		
		System.out.println("reply Delete ReplyVO = " + replyVO);
		
		MemberVO login = (MemberVO) session.getAttribute("login");
		
		System.out.println("reply Delete member.getMemNo() = " + login.getMemNo());
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(replyVO.getMemNo() != null && replyVO.getMemNo().equals(login.getMemNo())) {
			try {
				replyService.replyDelete(replyVO);
				map.put("result", true);
			} catch (Exception e) {
				e.printStackTrace();
				map.put("result", false);
			}
		}
		return map;
	}
	
}
