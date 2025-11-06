package com.bteam.proj.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Service;

import com.bteam.proj.board.dao.IHeartSaveDAO;
import com.bteam.proj.board.vo.BoardVO;
import com.bteam.proj.board.vo.HeartVO;
import com.bteam.proj.board.vo.SaveVO;

@Service
public class HeartSaveService {
	
	@Autowired
	IHeartSaveDAO heartSaveDao;
	
	public int checkHeart(HeartVO heartVO) {
		return heartSaveDao.checkHeart(heartVO);
	}

	public void insertHeart(HeartVO heartVO) {
		heartSaveDao.insertHeart(heartVO);
	}

	public void deleteHeart(HeartVO heartVO) {
		heartSaveDao.deleteHeart(heartVO);
	}
	
	public int heartCnt(HeartVO heartVO) {
		return heartSaveDao.heartCnt(heartVO);
	}

	public int getTotalHeartCount(HeartVO heartVO) {
		return heartSaveDao.getTotalHeartCount(heartVO);
	}
	
	public HeartVO getHeart(HeartVO heartVO) {
		return heartSaveDao.getHeart(heartVO);
	}

	public SaveVO getSave(SaveVO saveVO) {
		return heartSaveDao.getSave(saveVO);
	}

	public int checkSave(SaveVO saveVO) {
		return heartSaveDao.checkSave(saveVO);
	}

	public void insertSave(SaveVO saveVO) {
		heartSaveDao.insertSave(saveVO);
	}

	public void deleteSave(SaveVO saveVO) {
		heartSaveDao.deleteSave(saveVO);
	}

	public void plusHeart(HeartVO heartVO) {
		heartSaveDao.plusHeart(heartVO);
	}
	
	public void minusHeart(HeartVO heartVO) {
		heartSaveDao.minusHeart(heartVO);
	}
	
}
