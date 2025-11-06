package com.bteam.proj.board.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;
import javax.swing.MutableComboBoxModel;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.bteam.proj.board.service.BoardService;
import com.bteam.proj.board.service.HeartSaveService;
import com.bteam.proj.board.vo.BoardInfoVO;
import com.bteam.proj.board.vo.BoardSearchVO;
import com.bteam.proj.board.vo.BoardShareVO;
import com.bteam.proj.board.vo.BoardVO;
import com.bteam.proj.board.vo.HeartVO;
import com.bteam.proj.board.vo.SaveVO;
import com.bteam.proj.chats.vo.MessageVO;
import com.bteam.proj.chats.vo.MessageVO.CommandType;
import com.bteam.proj.chats.vo.MessageVO.DataType;
import com.bteam.proj.chats.web.ChatRoomManager;
import com.bteam.proj.chats.web.MessageBuilder;
import com.bteam.proj.chats.web.WebSocketMessageProcessor;
import com.bteam.proj.member.vo.MemberVO;
import com.bteam.proj.reply.service.ReplyService;
import com.bteam.proj.reply.vo.ReplyVO;
import com.google.gson.JsonObject;
import com.sun.mail.handlers.image_gif;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	HeartSaveService heartSaveService;
	
	@Autowired
	ReplyService replyService;
	
	WebSocketMessageProcessor wsmp = WebSocketMessageProcessor.getInstance();
	ChatRoomManager crm = ChatRoomManager.getInstance();
	MessageBuilder mb = new MessageBuilder();

	// 게시판 화면응답 처리 메소드
	@RequestMapping("/boardView")
	public String boardView(@ModelAttribute("searchVO") BoardSearchVO searchVO, HeartVO heartVO, String boardNo, Model model) {

		List<BoardInfoVO> boardInfoList = boardService.getBoardInfo();
		List<BoardVO> boardList = boardService.getBoardList(searchVO);
		List<BoardVO> boardHeartList = boardService.getBoardHeartList(searchVO);
		model.addAttribute("boardHeartList", boardHeartList);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardInfoList", boardInfoList);

		return "board/boardView";
	}

	// 게시판 글작성 화면 응답 메소드
	@RequestMapping("/boardWriteView")
	public String boardWriteView(HttpSession session, HttpServletRequest request, Model model) {

		MemberVO login = (MemberVO) session.getAttribute("login");
		List<BoardInfoVO> boardInfoList = boardService.getBoardInfo();
		model.addAttribute("boardInfoList", boardInfoList);

		if (login == null) {
			String fromUrl = request.getHeader("Referer");
			model.addAttribute("fromUrl", fromUrl);
			return "member/loginView";
		}
		return "board/boardWriteView";
	}

	// 게시판 글작성 처리 메소드
	@PostMapping("/boardWriteDo")
	public String boardWriteDo(BoardVO board, HttpSession session) {

		MemberVO login = (MemberVO) session.getAttribute("login");
		
		if(login == null) {
			return "redirect:/startView";
		} else {
			board.setMemNo(login.getMemNo());
			boardService.writeBoard(board);
			return "redirect:/boardView";
		}
		
	}

	@RequestMapping(value = "/upload", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {
		
		JsonObject jsonObject = new JsonObject();
		// request.getServletContext().getRealPath("/");
		// 내부 경로로 저장
		// 이미지를 현재 경로와 연관된 파일에 저장하기 위해 현재 경로를 알아냄
//		String contextRoot = request.getSession().getServletContext().getRealPath("/");
//		System.out.println("contextRoot= "+ contextRoot);
//		String fileRoot = contextRoot + "resources/fileupload/";
//		System.out.println("fileRoot = "+ fileRoot);
		
		// AttachController에서 변경 해줘야함
		// 개발용
		//String fileRoot = "/home/pc03/uploads/summernote_image/";
		// 서버용
		String fileRoot = "/home/pc222/uploads/summernote_image/";
		
		// 오리지날 파일명
		String originalFileName = multipartFile.getOriginalFilename();

		// 파일 확장자
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));

		// 저장될 파일 명
		String savedFileName = UUID.randomUUID() + extension;

		File targetFile = new File(fileRoot + savedFileName);
		if(!targetFile.getParentFile().exists()) {
			targetFile.getParentFile().mkdirs();//해당 폴더가 없으면 폴더 만들기
		}
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
			
			//화면에 넘겨줄 이미지 정보 url
			jsonObject.addProperty("url", "/uploads/summernote_image/" + savedFileName);
			// 1. 개발용 : jsonObject.addProperty("url", "/proj/uploads/summernote_image/" + savedFileName);
			// 2. 서버배포용 : jsonObject.addProperty("url", "/uploads/summernote_image/" + savedFileName);
			jsonObject.addProperty("responseCode", "success");
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String jsonString = jsonObject.toString();
		return jsonString;
	}
	
	// 글 상세 페이지 응답 메소드
	@RequestMapping("/boardDetailView")
	public String boardDetailView(HeartVO heartVO, SaveVO saveVO, String memNo, String boardNo, Model model, HttpSession session) {
		
		MemberVO login = (MemberVO) session.getAttribute("login");
		
		if(login == null) {
			return "redirect:/startView";
		} else {
			heartVO.setMemNo(login.getMemNo());
			saveVO.setMemNo(login.getMemNo());
			memNo = login.getMemNo();
		}
		
		List<BoardVO> replySelectList = replyService.getReplySelectList(boardNo);
		BoardShareVO stateList = boardService.getBoardState(memNo, boardNo);
		BoardShareVO selectList = boardService.getSelectList(memNo, boardNo);
		
		if(stateList != null) {
			model.addAttribute("stateList", stateList);
		}
		if(selectList != null) {
			model.addAttribute("selectList", selectList);
		}
		int getTotalHeartCount = heartSaveService.getTotalHeartCount(heartVO);
		
		try {
			BoardVO board = boardService.getBoard(boardNo);
			boardService.increaseHit(boardNo);
			HeartVO heart = heartSaveService.getHeart(heartVO);
			SaveVO save = heartSaveService.getSave(saveVO);
			model.addAttribute("save", save);
			model.addAttribute("heart", heart);
			model.addAttribute("heartCnt", getTotalHeartCount);
			model.addAttribute("board", board);
			model.addAttribute("replySelectList", replySelectList);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			e.getMessage();
			model.addAttribute("errMsg", e.getMessage());
			return "errView";
		}
		return "board/boardDetailView";
	}

	// 카테고리별 목록 페이지 응답 메소드
	@RequestMapping("/boardNoticeView")
	public String boardNoticeView(@ModelAttribute("searchVO") BoardSearchVO searchVO, @RequestParam String boardCode,
			Model model) {
		
		if(boardCode == null) {
			
		}
		
		List<BoardInfoVO> boardInfoList = boardService.getBoardInfo();
		List<BoardVO> boardHeartList = boardService.getBoardHeartList(searchVO);
		model.addAttribute("boardHeartList", boardHeartList);
		model.addAttribute("boardInfoList", boardInfoList);
		return "board/boardNoticeView";
	}

	// 글 수정 화면 응답
	@RequestMapping("/boardEditView")
	public String boardEditView(String boardNo, Model model) {
		try {
			BoardVO board = boardService.getBoard(boardNo);
			model.addAttribute("board", board);
		} catch (Exception e) {
			return "redirect:/startView";
		}
		return "board/boardEditView";
	}

	// 글 수정 처리 메소드
	@PostMapping("/boardEditDo")
	public String boardEditDo(BoardVO board) {
		boardService.editBoard(board);
		return "redirect:/boardDetailView?boardNo=" + board.getBoardNo();
	}

	// 게시글 삭제
	@PostMapping("/boardDelDo")
	public String boardDelDo(String boardNo) {
		boardService.delBoard(boardNo);
		return "redirect:/boardView";
	}

	// 나눔 메소드
	@RequestMapping("/boardShareDo")
	public String boardShareDo(@ModelAttribute("selectMemNo")String selectMemNo, String memNo, String boardNo, Model model) {
		
		System.out.println("boardShareDo selectMemNo=" + selectMemNo);
		
		try {
			boardService.updateState(memNo, boardNo);
			boardService.insertState(selectMemNo, boardNo);
			boardService.updateIngTitle(boardNo);
			model.addAttribute("selectMemNo", selectMemNo);
			
			mb.setSubject("SYSTEM");
			mb.setDataType(DataType.CHAT);
			mb.setCommandType(CommandType.CREATE);
			mb.addData("ChatroomNo", "SYSTEM_"+selectMemNo);
			mb.addData("Content", memNo+" 님이 "+boardNo +"번 게시글의 나눔완료를 하였습니다. "
					+ "\n 나눔을 받으셨다면 최종적으로 게시글에서 나눔완료 버튼을 눌러주세요.");
			
			MessageVO message = mb.build();
			wsmp.enqueueMessage(message);
			mb.clearData();
			
			return "redirect:/boardView?boardNo=" + boardNo;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/boardDetailView?boardNo=" + boardNo;
	}
	
	@RequestMapping("/boardStateUpdate")
	public String boardStateUpdate(String memNo, String boardNo) {
		
		String sharer = boardService.getBoardWriter(boardNo);
		System.out.println("boardStateUpdate sharer=" + sharer);
		System.out.println("boardStateUpdate memNo="+ memNo);
		
		try {
			boardService.updateState(memNo, boardNo);
			boardService.updateSuccessTitle(boardNo);
			boardService.updateBoardMileage(boardNo);
		
			mb.setSubject("SYSTEM");
			mb.setDataType(DataType.CHAT);
			mb.setCommandType(CommandType.CREATE);
			mb.addData("ChatroomNo", "SYSTEM_"+ sharer);
			mb.addData("Content", memNo+" 님이 "+boardNo +"번 게시글의 나눔완료를 하여 최종 나눔완료 되었습니다.");
			
			MessageVO message = mb.build();
			wsmp.enqueueMessage(message);
			mb.clearData();
			
			return "redirect:/boardDetailView?boardNo=" + boardNo;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "/board/boardDetailView";
	}
	
	@RequestMapping("/myWriteList")
	public String myWriteListView(@ModelAttribute("searchVO") BoardSearchVO searchVO, String boardCode
			, HttpSession session, Model model) {
		
		MemberVO login = (MemberVO) session.getAttribute("login");
		
		if(login == null) {
			return "redirect:/startView";
		} else {
			searchVO.setMemNo(login.getMemNo());
		}
		
		List<BoardInfoVO> boardInfoList = boardService.getBoardInfo();
		List<BoardVO> myWriteList = boardService.getMyWriteList(searchVO);
		model.addAttribute("boardInfoList", boardInfoList);
		model.addAttribute("myWriteList", myWriteList);
		
		return "board/part/myWriteListView";
	}
	
	@RequestMapping("/mySaveList")
	public String mySaveListView(@ModelAttribute("searchVO") BoardSearchVO searchVO, String boardCode
			, HttpSession session, Model model) {
		
		MemberVO login = (MemberVO) session.getAttribute("login");
		
		if(login == null) {
			return "redirect:/startView";
		} else {
			searchVO.setMemNo(login.getMemNo());
		}
		
		List<BoardInfoVO> boardInfoList = boardService.getBoardInfo();
		List<BoardVO> mySaveList = boardService.getMySaveList(searchVO);
		model.addAttribute("boardInfoList", boardInfoList);
		model.addAttribute("mySaveList", mySaveList);
		
		return "board/part/mySaveListView";
	}
	
}
