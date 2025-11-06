package com.bteam.proj.chart.web;

import java.util.List;

import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bteam.proj.chart.service.ChartService;
import com.bteam.proj.chart.vo.ChartVO;

@Controller
public class ChartController {
	
	@Autowired
	ChartService chartService;
	
	@RequestMapping("/likeChart")
	@ResponseBody
	public List<ChartVO> getLikeRankList() {
		List<ChartVO> result = chartService.getLikeRankList();
		return result;
	}
	
	@RequestMapping("/carPoolChart")
	@ResponseBody
	public List<ChartVO> getCarPoolRankList() {
		List<ChartVO> result = chartService.getCarPoolRankList();
		return result;
	}
	
	@RequestMapping("/shareChart")
	@ResponseBody
	public List<ChartVO> getShareRankList() {
		List<ChartVO> result = chartService.getShareRankList();
		return result;
	}
	
	@RequestMapping("/saleChart")
	@ResponseBody
	public List<ChartVO> getSaleRankList() {
		List<ChartVO> result = chartService.getSaleRankList();
		return result;
	}
}
