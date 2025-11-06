package com.bteam.proj.chart.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bteam.proj.chart.dao.IChartDAO;
import com.bteam.proj.chart.vo.ChartVO;

@Service
public class ChartService {
	
	@Autowired
	IChartDAO chartDao;

	public List<ChartVO> getLikeRankList() {
		return chartDao.getLikeRankList();
	}
	
	public List<ChartVO> getCarPoolRankList() {
		return chartDao.getCarPoolRankList();
	}

	public List<ChartVO> getShareRankList() {
		return chartDao.getShareRankList();
	}
	
	public List<ChartVO> getSaleRankList() {
		return chartDao.getSaleRankList();
	}

	public ChartVO getLikeRanker() {
		return chartDao.getLikeRanker();
	}
	
	public ChartVO getSaleRanker() {
		return chartDao.getSaleRanker();
	}
	
	public ChartVO getCarpoolRanker() {
		return chartDao.getCarpoolRanker();
	}

	public ChartVO getShareRanker() {
		return chartDao.getShareRanker();
	}
	
}
