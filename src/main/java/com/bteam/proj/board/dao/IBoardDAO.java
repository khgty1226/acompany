package com.bteam.proj.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bteam.proj.board.vo.BoardInfoVO;
import com.bteam.proj.board.vo.BoardSearchVO;
import com.bteam.proj.board.vo.BoardShareVO;
import com.bteam.proj.board.vo.BoardVO;
import com.bteam.proj.board.vo.HeartVO;

@Mapper
public interface IBoardDAO {
	
	// 게시글 목록 조회(SELECT)
	List<BoardVO> getBoardList(BoardSearchVO searchVO); 
	
	List<BoardVO> getBoardHeartList(BoardSearchVO searchVO);
	
	// 게시글 등록 메소드(INSERT)
	int writeBoard(BoardVO board);
	
	// 게시글 1개 조회(SELETE)
	BoardVO getBoard(String boardNo);
	
	// 게시글 수정 메소드(UPDATE)
	int editBoard(BoardVO board);
	
	// 게시글 삭제(UPDATE)
	int delBoard(String boardNo);
	
	// 게시판 카테고리 목록 조회(SELECT)
	List<BoardInfoVO> getBoardInfo();
	
	// 게시판 카테고리별 게시글 목록 조회(SELECT)
	List<BoardVO> getBoardCategoryList(BoardSearchVO searchVO);
	
	// 게시글 조회수 증가 메소드(UPDATE)
	int increaseHit(String boardNo);
	
	// 게시글 페이징처리(카운트)
	int getTotalRowCount(BoardSearchVO searchVO);
	
	int getMyWriteTotalRowCount(BoardSearchVO searchVO);
	
	int getMySaveTotalRowCount(BoardSearchVO searchVO);
	
//	@Param(value = "searchVO")BoardSearchVO searchVO, @Param(value = "boardCode")String boardCode
	
	HeartVO getHeart(HeartVO heartSaveVO);

	int updateState(@Param("memNo")String memNo, @Param("boardNo")String boardNo);

	int insertState(@Param("selectMemNo")String selectMemNo, @Param("boardNo")String boardNo);
	
	BoardShareVO getBoardState(@Param("memNo")String memNo, @Param("boardNo")String boardNo);

	BoardShareVO getSelectList(@Param("memNo")String memNo, @Param("boardNo")String boardNo);

	int updateIngTitle(String boardNo);
	
	int updateSuccessTitle(String boardNo);
	
	int updateBoardMileage(String boardNo);

	List<BoardVO> getMyWriteList(BoardSearchVO searchVO);

	List<BoardVO> getMySaveList(BoardSearchVO searchVO);

	String getBoardWriter(String boardNo);

	

}
