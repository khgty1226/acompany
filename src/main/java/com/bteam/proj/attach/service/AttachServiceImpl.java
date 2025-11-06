package com.bteam.proj.attach.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bteam.proj.attach.dao.IAttachDAO;

import com.bteam.proj.attach.vo.AttachVO;

@Service
public class AttachServiceImpl{

	@Autowired
	private IAttachDAO attachDAO;
	
	public AttachVO getAttach(int atchNo) throws Exception {
		// TODO Auto-generated method stub
		
		AttachVO attach = attachDAO.getAttach(atchNo);
		if(attach == null) {
			throw new Exception();
		}
		
		return attach;
	}
	
	public void increaseDownHit(int atchNo) throws Exception {
		// TODO Auto-generated method stub
	
		int cnt = attachDAO.increaseDownHit(atchNo);
		if(cnt == 0) {
			throw new Exception();
		}
	}

}
