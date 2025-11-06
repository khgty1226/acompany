package com.bteam.proj.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bteam.proj.board.vo.BoardVO;
import com.bteam.proj.board.vo.HeartVO;
import com.bteam.proj.board.vo.SaveVO;

@Mapper
public interface IHeartSaveDAO {
	
	public int checkHeart(HeartVO hearVO);

	public int insertHeart(HeartVO hearVO);

	public int deleteHeart(HeartVO hearVO);
	
	public int heartCnt(HeartVO hearVO);

	public int getTotalHeartCount(HeartVO hearVO);

	public List<HeartVO> getListLike(String userId);
	
	public HeartVO getHeart(HeartVO hearVO);

	public SaveVO getSave(SaveVO saveVO);

	public int checkSave(SaveVO saveVO);

	public int insertSave(SaveVO saveVO);

	public int deleteSave(SaveVO saveVO);

	public void plusHeart(HeartVO heartVO);
	
	public void minusHeart(HeartVO heartVO);
	
}
