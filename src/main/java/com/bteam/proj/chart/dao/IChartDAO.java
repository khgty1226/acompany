package com.bteam.proj.chart.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bteam.proj.chart.vo.ChartVO;

@Mapper
public interface IChartDAO {

	public List<ChartVO> getLikeRankList();
	
	public List<ChartVO> getCarPoolRankList();

	public List<ChartVO> getShareRankList();
	
	public List<ChartVO> getSaleRankList();

	public ChartVO getLikeRanker();
	
	public ChartVO getSaleRanker();
	
	public ChartVO getCarpoolRanker();

	public ChartVO getShareRanker();
}
