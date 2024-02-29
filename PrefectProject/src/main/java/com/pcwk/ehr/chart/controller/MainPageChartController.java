package com.pcwk.ehr.chart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.chart.domain.EduVO;
import com.pcwk.ehr.chart.service.ChartService;

@Controller
public class MainPageChartController {
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	ChartService chartService;
	
	@RequestMapping(value="main/GetData.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8"
			)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public Map<String, Object> mainChart(EduVO eduVO,Model model,HttpSession httpsession) throws Exception {
		//Map으로 보내서 Json으로 받는다
		//여기선 educationLevel(key) - userCount(value) 로 받는다.

		Map<String, Object> resultMap = new HashMap<>();
		
		List<EduVO> resultList = chartService.mainChartInfo(eduVO);
		
		
		resultMap.put("resultList", resultList);
		
		LOG.debug("resultList" + resultMap);
		
		
		return resultMap;
		
	}

}
