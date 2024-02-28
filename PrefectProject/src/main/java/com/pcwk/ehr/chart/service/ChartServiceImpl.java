package com.pcwk.ehr.chart.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.chart.dao.ChartDao;
import com.pcwk.ehr.chart.domain.ScoreVO;
import com.pcwk.ehr.cmn.PcwkLogger;

@Service
public class ChartServiceImpl implements PcwkLogger, ChartService {
	
	@Autowired
	private ChartDao chartDao;

	@Override
	public List<ScoreVO> getWorkChartInfo(ScoreVO searchVO) throws SQLException {
		
		List<ScoreVO> scoreList = chartDao.getWorkChartInfo(searchVO);
		
		return scoreList;
	}

}
