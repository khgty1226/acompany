package com.bteam.proj.attach.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bteam.proj.attach.vo.AttachVO;

@Mapper
public interface IAttachDAO {
	
	void insertAttach(AttachVO attch);
	
	List<AttachVO> getAttachList(@Param("atchParentNo")String boNo, @Param("atchCategory")String string);
	
	AttachVO getAttach(int atchNo);
	
	int increaseDownHit(int atchNo);
	
	void deleteAttaches(Map<String, Object> map);
	
	Integer getAttachNo(Map<String, Object> map);

}
