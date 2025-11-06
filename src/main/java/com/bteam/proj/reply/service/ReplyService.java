package com.bteam.proj.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Service;

import com.bteam.proj.board.vo.BoardVO;
import com.bteam.proj.reply.dao.IReplyDAO;
import com.bteam.proj.reply.vo.ReplyVO;

@Service
public class ReplyService {
	
	@Autowired
	IReplyDAO replyDao;
	
	public void replyRegister(ReplyVO reply) {
		replyDao.replyRegister(reply);
	}

	public List<ReplyVO> getReplyListByParent(ReplyVO replyVO) {
		return replyDao.getReplyListByParent(replyVO);
	}

	public void replyUpdate(ReplyVO replyVO) {
		replyDao.replyUpdate(replyVO);
	}

	public void replyDelete(ReplyVO replyVO) {
		replyDao.replyDelete(replyVO);
	}

	public List<BoardVO> getReplySelectList(String boardNo) {
		return replyDao.getReplySelectList(boardNo);
	}

}
