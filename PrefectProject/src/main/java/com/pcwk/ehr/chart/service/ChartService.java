package com.pcwk.ehr.chart.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.chart.domain.ScoreVO;

public interface ChartService {
	List<ScoreVO> getWorkChartInfo(ScoreVO searchVO) throws Exception; 
}
