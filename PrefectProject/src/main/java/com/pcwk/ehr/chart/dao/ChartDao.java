package com.pcwk.ehr.chart.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.chart.domain.EduVO;
import com.pcwk.ehr.chart.domain.ScoreVO;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.subject.domain.SubjectVO;

public interface ChartDao extends WorkDiv<SubjectVO> {
	public List<ScoreVO> getWorkChartInfo(ScoreVO scoreVO)  throws SQLException ; 
	public List<EduVO> mainChartInfo(EduVO eduVO)  throws SQLException ; 

}
