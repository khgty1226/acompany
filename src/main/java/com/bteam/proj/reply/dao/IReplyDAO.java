package com.bteam.proj.reply.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bteam.proj.board.vo.BoardVO;
import com.bteam.proj.reply.vo.ReplyVO;

@Mapper
public interface IReplyDAO {

	public int replyRegister(ReplyVO reply);

	public List<ReplyVO> getReplyListByParent(ReplyVO replyVO);

	public int replyUpdate(ReplyVO replyVO);

	public int replyDelete(ReplyVO replyVO);

	public List<BoardVO> getReplySelectList(String boardNo);

	
	
}
