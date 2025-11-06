package com.bteam.proj.board.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bteam.proj.board.dao.IBoardDAO;
import com.bteam.proj.board.dao.IHeartSaveDAO;
import com.bteam.proj.board.vo.BoardInfoVO;
import com.bteam.proj.board.vo.BoardSearchVO;
import com.bteam.proj.board.vo.BoardShareVO;
import com.bteam.proj.board.vo.BoardVO;
import com.bteam.proj.board.vo.HeartVO;

@Service
public class BoardService {

	@Autowired
	IBoardDAO boardDao;
	
	@Autowired
	IHeartSaveDAO heartSaveDao;
	
	// 게시글 목록 조회 처리 메소드(SELECT)
	public List<BoardVO> getBoardList(BoardSearchVO searchVO){
		
		int totalRowCount = boardDao.getTotalRowCount(searchVO);
		
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
//		System.out.println("searchVO.toString = " + searchVO.toString());
		
		return boardDao.getBoardList(searchVO);
	}
	
	public List<BoardVO> getBoardHeartList(BoardSearchVO searchVO){
		
		int totalRowCount = boardDao.getTotalRowCount(searchVO);
		
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
//		System.out.println("searchVO.toString = " + searchVO.toString());
		
		return boardDao.getBoardHeartList(searchVO);
	}
	
	// 게시글 등록 처리 메소드
	public void writeBoard(BoardVO board) {
		boardDao.writeBoard(board);
	}
	
	// 게시글 1개 조회(SELECT)
	public BoardVO getBoard(String boardNo) throws Exception {
		// 사용자가 게시판에 없는 번호를 입력했을 때 
		// 조회 안되게 조건 체크를 해줘야한다.
		
		BoardVO result = boardDao.getBoard(boardNo);
		
		if(result == null) {
			throw new Exception("존재하지 않는 게시글입니다.");
		}
		
		return result;
	}
	
	// 게시글 수정(UPDATE)
	public void editBoard(BoardVO board) {
		boardDao.editBoard(board);
	}
	
	// 게시글 삭제(UPDATE)
	public void delBoard(String boardNo) {
		boardDao.delBoard(boardNo);
	}

	// 게시판 카테고리(SELECT)
	public List<BoardInfoVO> getBoardInfo() {
		return boardDao.getBoardInfo();
	}
	
	// 게시판 카테고리별 게시글 목록 조회 메스도(SELECT)
	public List<BoardVO> getBoardCategoryList(BoardSearchVO searchVO){
		
		int totalRowCount = boardDao.getTotalRowCount(searchVO);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		
		return boardDao.getBoardCategoryList(searchVO);
	}
	
	// 게시글 조회수 증가 메소드(UPDATE)
	public void increaseHit(String boardNo) {
		boardDao.increaseHit(boardNo);
	}
	
	public HeartVO getHeart(HeartVO heartSaveVO) {
		return heartSaveDao.getHeart(heartSaveVO);
	}

	public void updateState(String memNo, String boardNo) {
		boardDao.updateState(memNo, boardNo);
		
	}

	public void insertState(String selectMemNo, String boardNo) {
		boardDao.insertState(selectMemNo, boardNo);
	}
	
	public BoardShareVO getBoardState(String memNo, String boardNo) {
		return boardDao.getBoardState(memNo, boardNo);
	}

	public BoardShareVO getSelectList(String memNo, String boardNo) {
		return boardDao.getSelectList(memNo, boardNo);
	}

	public void updateIngTitle(String boardNo) {
		boardDao.updateIngTitle(boardNo);
	}
	
	public void updateSuccessTitle(String boardNo) {
		boardDao.updateSuccessTitle(boardNo);
	}
	
	public void updateBoardMileage(String boardNo) {
		boardDao.updateBoardMileage(boardNo);
	}

	public List<BoardVO> getMyWriteList(BoardSearchVO searchVO) {
		int totalRowCount = boardDao.getMyWriteTotalRowCount(searchVO);
		
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		// System.out.println("searchVO.toString = " + searchVO.toString());
		
		return boardDao.getMyWriteList(searchVO);
	}

	public List<BoardVO> getMySaveList(BoardSearchVO searchVO) {
		int totalRowCount = boardDao.getMySaveTotalRowCount(searchVO);
		
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		
		return boardDao.getMySaveList(searchVO);
	}

	public String getBoardWriter(String boardNo) {
		return boardDao.getBoardWriter(boardNo);
	}

}
