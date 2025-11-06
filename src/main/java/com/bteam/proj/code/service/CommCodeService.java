package com.bteam.proj.code.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bteam.proj.code.dao.ICommCodeDAO;
import com.bteam.proj.code.vo.CodeVO;

@Service("codeService")
public class CommCodeService{

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ICommCodeDAO codeDAO;
	
	public List<CodeVO> getCodeListByParent(String commParent) {
		
		logger.debug("(logger.debug) {}"
				, (commParent == null) ? "commParent is null ": commParent);
		logger.info("(logger.info) {}"
				, (commParent == null) ? "commParent is null ": commParent);
		
		List<CodeVO> codeList = codeDAO.getCodeListByParent(commParent);
		return codeList;
		
	}

	public List<CodeVO> getCodeListByParentTeam() {
		List<CodeVO> codeList = codeDAO.getCodeListByParentTeam();
		
		return codeList;
	}

	
	
}
