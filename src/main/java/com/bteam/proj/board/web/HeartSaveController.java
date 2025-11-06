package com.bteam.proj.board.web;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bteam.proj.board.service.HeartSaveService;
import com.bteam.proj.board.vo.HeartVO;
import com.bteam.proj.board.vo.SaveVO;

@Controller
@RequestMapping("/heartSave")
public class HeartSaveController {
	
	@Autowired
	HeartSaveService heartSaveService;
	
	@RequestMapping("/heartCheck")
	@ResponseBody
	public String heartCheck(@ModelAttribute HeartVO heartVO, Model model) {
		
		int result = heartSaveService.checkHeart(heartVO);
		
		if(result == 0) { // 둘다 데이터 없음
			heartSaveService.insertHeart(heartVO);
			HeartVO heart = heartSaveService.getHeart(heartVO);
			heartSaveService.plusHeart(heartVO);
			System.out.println("heartVO = " + heart);
			return "like";
		} else {
			heartSaveService.deleteHeart(heartVO);
			HeartVO heart = heartSaveService.getHeart(heartVO);
			heartSaveService.minusHeart(heartVO);
			System.out.println("heartVO = " + heart);
			return "delete";
		}
		// return "board/boardDetailView";
	}
	
	// 저장하기 체크
	@RequestMapping("/saveCheck")
	@ResponseBody
	public String saveCheck(@ModelAttribute SaveVO saveVO, Model model) {
		
		int result = heartSaveService.checkSave(saveVO);
		
		if(result == 0) {
			heartSaveService.insertSave(saveVO);
			System.out.println("저장하기 insert성공");
			SaveVO save = heartSaveService.getSave(saveVO);
			System.out.println("saveVO = " + save);
			return "save";
		} else {
			heartSaveService.deleteSave(saveVO);
			System.out.println("저장하기 delete성공");
			SaveVO save = heartSaveService.getSave(saveVO);
			System.out.println("saveVO = " + save);
			return "saveDelete";
		}
	}
	
	
}
