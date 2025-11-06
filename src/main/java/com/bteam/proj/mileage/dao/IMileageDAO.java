package com.bteam.proj.mileage.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IMileageDAO {

	int mileageUp(@Param("memNo") String memNo, @Param("mileage") int mileage);

	int mileageUpByCpNo(@Param("cpNo") String cpNo, @Param("mileage") int mileage);
	
	int mileageDown(@Param("memNo") String memNo, @Param("mileage") int mileage);
	
}
