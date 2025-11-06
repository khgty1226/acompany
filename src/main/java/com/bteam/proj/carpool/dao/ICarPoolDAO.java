package com.bteam.proj.carpool.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bteam.proj.carpool.vo.CarPoolSearchVO;
import com.bteam.proj.carpool.vo.CarPoolVO;
import com.bteam.proj.carpool.vo.CarVO;
import com.bteam.proj.member.vo.MemberVO;

@Mapper
public interface ICarPoolDAO {

	List<CarPoolVO> getCarPoolList();

	CarVO getCarInfo(String carNo);

	MemberVO getAdminMember(String memNo);

	CarPoolVO getCarPool(String cpNo);

	List<MemberVO> getPassList(String cpNo);

	int carPoolApply(@Param("cpNo") String cpNo, @Param("memNo")String memNo);

	int takePassPlus(String cpNo);

	List<String> myApplyList(String memNo);

	int carPoolCancel(@Param("cpNo") String cpNo, @Param("memNo")String memNo);

	int takePassMinus(String cpNo);

	int carPoolAllCancel(String cpNo);

	int carPoolDelete(String cpNo);

	List<CarPoolVO> getCarPoolListSearch(String word);

	List<CarVO> getCarList(String memNo);

	int carPoolCreate(CarPoolVO carPool);

	int carPoolCreatePass(@Param("cpNo")String cpNo, @Param("memNo")String memNo);

	String getCurCpNo(String memNo);

	List<CarPoolVO> getMyCarPoolList(String memNo);

	CarPoolVO getCarPoolLog(String cpNo);

	String getDriver(String memNo);

	int carPoolStateChange(@Param("cpNo") String cpNo, @Param("cpState") String cpState);

	int carPoolStateChangePass(@Param("cpNo") String cpNo, @Param("cpState") String cpState, @Param("memNo") String memNo);

	String getCarPoolStatePass(@Param("cpNo") String cpNo, @Param("memNo") String memNo);

	int carPoolPassCountS(String cpNo);

	int carPoolGetTakePass(String cpNo);

	List<CarPoolVO> getCarPoolLogList(CarPoolSearchVO searchVO);

	int getTotalCarPoolRowCount(CarPoolSearchVO searchVO);

	CarPoolVO getCarPoolModal(String cpNo);

	List<CarPoolVO> getCarPoolListAdmin();

	int getTotalCarPoolRowCountAdmin(CarPoolSearchVO searchVO);

	List<CarPoolVO> getCarPoolLogListAdmin(CarPoolSearchVO searchVO);



}
