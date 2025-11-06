package com.bteam.proj.carpool.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bteam.proj.carpool.dao.ICarPoolDAO;
import com.bteam.proj.carpool.vo.CarPoolSearchVO;
import com.bteam.proj.carpool.vo.CarPoolVO;
import com.bteam.proj.carpool.vo.CarVO;
import com.bteam.proj.mileage.dao.IMileageDAO;
import com.bteam.proj.common.vo.PagingVO;
import com.bteam.proj.member.vo.MemberVO;

@Service
public class CarPoolService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ICarPoolDAO carPoolDao;
	
	@Autowired
	private IMileageDAO mileageDao;
	
	public List<CarPoolVO> getCarPoolList() {
		System.out.println("[CarPoolService getCarPoolList]");
		
		List<CarPoolVO> carPoolList = carPoolDao.getCarPoolList();
		
		for(CarPoolVO carPool : carPoolList) {
			String carNo = carPool.getCarNo();
			CarVO carVO= carPoolDao.getCarInfo(carNo);
			carPool.setCarVO(carVO);
		}
		
		return carPoolList;
	}

	public MemberVO getAdminMember(String memNo) {
		System.out.println("[CarPoolService getAdminMember]");
		
		MemberVO member = carPoolDao.getAdminMember(memNo);
		
		return member;
	}

	public CarPoolVO getCarPool(String cpNo) {
		System.out.println("[CarPoolService getCarPool]");
		
		CarPoolVO carPool = carPoolDao.getCarPool(cpNo);
		System.out.println("carPool:"+carPool);
		CarVO carVO = carPoolDao.getCarInfo(carPool.getCarNo());
		List<MemberVO> passList = carPoolDao.getPassList(cpNo);
		carPool.setCarVO(carVO);
		carPool.setPassList(passList);
		
		return carPool;
	}
	
	public CarPoolVO getCarPoolModal(String cpNo) {
		System.out.println("[CarPoolService getCarPoolModal]");
		
		CarPoolVO carPool = carPoolDao.getCarPoolModal(cpNo);
		CarVO carVO = carPoolDao.getCarInfo(carPool.getCarNo());
		List<MemberVO> passList = carPoolDao.getPassList(cpNo);
		carPool.setCarVO(carVO);
		carPool.setPassList(passList);
		
		return carPool;
	}


	public void carPoolApply(String cpNo, String memNo) throws Exception {
		System.out.println("[CarPoolService carPoolApply]");
		
		int resultCnt1 = carPoolDao.carPoolApply(cpNo, memNo);
		if(resultCnt1 != 1) throw new Exception("carPoolApply 실패");
		
		int resultCnt2 = carPoolDao.takePassPlus(cpNo);
		if(resultCnt2 != 1) throw new Exception("takePassPlus 실패");
		
	}

	public List<String> getmyApplyList(String memNo) {
		System.out.println("[CarPoolService getMyApplyList]");

		List<String> myApplyList = carPoolDao.myApplyList(memNo);
		
		return myApplyList;
	}

	public void carPoolCancel(String cpNo, String memNo) throws Exception {
		System.out.println("[CarPoolService carPoolCancel]");
		
		int resultCnt1 = carPoolDao.carPoolCancel(cpNo, memNo);
		if(resultCnt1 != 1) throw new Exception("carPoolCancel 실패");
		
		int resultCnt2 = carPoolDao.takePassMinus(cpNo);
		if(resultCnt2 != 1) throw new Exception("takePassMinus 실패");
		
	}

	public void carPoolDelete(String cpNo, String memNo) throws Exception {
		System.out.println("[CarPoolService carPoolDelete]");
		
		int resultCnt1 = carPoolDao.carPoolAllCancel(cpNo);
		if(resultCnt1 == -1) throw new Exception("carPoolAllCancel 실패");
		
		int resultCnt2 = carPoolDao.carPoolDelete(cpNo);
		if(resultCnt2 != 1) throw new Exception("carPoolDelete 실패");
		
	}

	public void carPoolFullCheck(String cpNo) throws Exception {
		System.out.println("[CarPoolService carPoolFullCheck]");
		
		CarPoolVO carPool = carPoolDao.getCarPool(cpNo);
		List<MemberVO> passList = carPoolDao.getPassList(cpNo);
		
		if(carPool.getCpTotalPass() <= passList.size()) {
			throw new Exception("carPoolFullCheck 만원");
		}
	}

	public List<CarPoolVO> getCarPoolListSearch(String word) {
		System.out.println("[CarPoolService getCarPoolListSearch]");
		
		List<CarPoolVO> carPoolList = carPoolDao.getCarPoolListSearch(word);
		System.out.println("searchCarPoolList:"+carPoolList);
		return carPoolList;
	}

	public List<CarVO> getCarList(String memNo) {
		System.out.println("[CarPoolService getCarList]");
		
		List<CarVO> carList = carPoolDao.getCarList(memNo);

		return carList;
	}

	public CarVO getCarInfo(String carNo) {
		System.out.println("[CarPoolService getCarInfo]");
		
		CarVO carVO = carPoolDao.getCarInfo(carNo);
		
		return carVO;
	}

	public void carPoolCreate(CarPoolVO carPool) throws Exception {
		System.out.println("[CarPoolService carPoolCreate]");

		String memNo = carPool.getMemNo();
		
		String carNo = carPool.getCarNo();
		CarVO carVO = carPoolDao.getCarInfo(carNo);
		carPool.setCarVO(carVO);
		
		int resultCnt1 = carPoolDao.carPoolCreate(carPool);
		if(resultCnt1 != 1) throw new Exception("carPoolCreate 실패");

		String cpNo = carPoolDao.getCurCpNo(memNo);

		int resultCnt2 = carPoolDao.carPoolCreatePass(cpNo, memNo);
		if(resultCnt2 != 1) throw new Exception("carPoolCreatePass 실패");
	}

	public List<CarPoolVO> getMyCarPoolList(String memNo) {
		System.out.println("[CarPoolService getMyCarPoolList]");
		
		List<String> myApplyList = carPoolDao.myApplyList(memNo);
		System.out.println("myApplyList:"+ myApplyList);
		
		List<CarPoolVO> carPoolList = new ArrayList<>();
		for(int i = 0 ; i < myApplyList.size(); i ++) {
			if(carPoolDao.getCarPool(myApplyList.get(i)) != null) {
				carPoolList.add(carPoolDao.getCarPool(myApplyList.get(i)));
			}
		}
		
		System.out.println("myCarPoolList:"+ carPoolList);
		
		for(CarPoolVO carPool : carPoolList) {
			String carNo = carPool.getCarNo();
			CarVO carVO= carPoolDao.getCarInfo(carNo);
			carPool.setCarVO(carVO);
		}
		
		return carPoolList;
	}

	public List<CarPoolVO> getMyCarPoolLogList(String memNo, CarPoolSearchVO searchVO) {
		System.out.println("[CarPoolService getMyCarPoolLogList]");
		
		List<String> myApplyList = carPoolDao.myApplyList(memNo);
		System.out.println("myApplyList:"+ myApplyList);

		searchVO.setMemNo(memNo);
		
		int totalRowCount = carPoolDao.getTotalCarPoolRowCount(searchVO);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		
		List<CarPoolVO> carPoolLogList = carPoolDao.getCarPoolLogList(searchVO);
		/*
		 * List<CarPoolVO> carPoolLogListP = new ArrayList<>(); for(int i = 0 ; i <
		 * myApplyList.size(); i ++) { CarPoolVO carPoolVO =
		 * carPoolDao.getCarPoolLog(myApplyList.get(i));
		 * 
		 * if(carPoolVO != null) { String cpStatePass =
		 * carPoolDao.getCarPoolStatePass(carPoolVO.getCpNo(), memNo);
		 * carPoolVO.setCpStatePass(cpStatePass);
		 * carPoolVO.setCpRNum(myApplyList.size()-i);
		 * 
		 * carPoolLogList.add(carPoolVO); }
		 * 
		 * }
		
		

		
		for(int i = 0 ; i < carPoolLogList.size(); i++) {
			int rNum = carPoolLogList.get(i).getCpRNum();
			if (rNum >= searchVO.getLastRow() && rNum <= searchVO.getFirstRow()) {
				carPoolLogListP.add(carPoolLogList.get(i));
			}
		}
		
		 */
		
		System.out.println("myCarPoolLogList:"+ carPoolLogList);
		
		for(CarPoolVO carPool : carPoolLogList) {
			String carNo = carPool.getCarNo();
			
			CarVO carVO= carPoolDao.getCarInfo(carNo);
			carPool.setCarVO(carVO);
			
		}
		
		return carPoolLogList;
	}

	public void carPoolStateChange(String cpNo, String cpState, String memNo) throws Exception {
		System.out.println("[CarPoolService carPoolStateChange]");
		
		int resultCnt1 = carPoolDao.carPoolStateChange(cpNo, cpState);
		if(resultCnt1 != 1) throw new Exception("carPoolStateChange 실패");
		
		cpState = "S";
		int resultCnt2 = carPoolDao.carPoolStateChangePass(cpNo, cpState, memNo);
		if(resultCnt2 != 1) throw new Exception("carPoolStateChangePass 실패");
		
		// 
	}

	public void carPoolStateChangePass(String cpNo, String cpState, String memNo) throws Exception {
		System.out.println("[CarPoolService carPoolStateChangePass]");
		
		int resultCnt1 = carPoolDao.carPoolStateChangePass(cpNo, cpState, memNo);
		if(resultCnt1 != 1) throw new Exception("carPoolStateChangePass 실패");
		
		if(cpState.equals("F")) {
			int resultCnt2 = carPoolDao.carPoolStateChange(cpNo, cpState);
			if(resultCnt2 != 1) throw new Exception("carPoolStateChange 실패");
		}		
		
		// 만약 carpool_passenger에 해당 cpNo에 해당하는 passenger들의 cp_state가 모두 S일 경우 carPoolStateChange -> S
		int passCountS = carPoolDao.carPoolPassCountS(cpNo);
		int cpTakePass = carPoolDao.carPoolGetTakePass(cpNo);
		
		if(passCountS == cpTakePass) {
			int resultCnt2 = carPoolDao.carPoolStateChange(cpNo, cpState);
			if(resultCnt2 != 1) throw new Exception("carPoolStateChange 실패");
			
			int mileage = 2000;
			int resultCnt3 = mileageDao.mileageUpByCpNo(cpNo, mileage);
			if(resultCnt3 != 1) throw new Exception("mileageUp 실패");
			
		}
	}

	public List<CarPoolVO> getCarPoolListAdmin() {
		System.out.println("[CarPoolService getCarPoolListAdmin]");
		
		List<CarPoolVO> carPoolList = carPoolDao.getCarPoolListAdmin();
		
		System.out.println("CarPoolListAdmin:"+ carPoolList);
		
		for(CarPoolVO carPool : carPoolList) {
			String carNo = carPool.getCarNo();
			CarVO carVO= carPoolDao.getCarInfo(carNo);
			carPool.setCarVO(carVO);
		}
		
		return carPoolList;
	}

	public List<CarPoolVO> getCarPoolLogListAdmin(CarPoolSearchVO searchVO) {
		System.out.println("[CarPoolService getCarPoolLogListAdmin]");
		
		
		int totalRowCount = carPoolDao.getTotalCarPoolRowCountAdmin(searchVO);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		
		List<CarPoolVO> carPoolLogList = carPoolDao.getCarPoolLogListAdmin(searchVO);
		
		System.out.println("myCarPoolLogList:"+ carPoolLogList);
		
		for(CarPoolVO carPool : carPoolLogList) {
			String carNo = carPool.getCarNo();
			
			CarVO carVO= carPoolDao.getCarInfo(carNo);
			carPool.setCarVO(carVO);
		}
		
		return carPoolLogList;
	}

	public List<MemberVO> getPassList(String cpNo) {
		System.out.println("[CarPoolService getPassList]");
		
		List<MemberVO> passList = carPoolDao.getPassList(cpNo);
		
		return passList;
	}


	


}
