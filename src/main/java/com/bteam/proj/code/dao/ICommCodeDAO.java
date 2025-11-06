package com.bteam.proj.code.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bteam.proj.code.vo.CodeVO;

@Mapper
public interface ICommCodeDAO {
	
	List<CodeVO> getCodeListByParent(String commParent);

	List<CodeVO> getCodeListByParentTeam();
	
}
