package com.pcwk.ehr.chart.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.chart.domain.ScoreVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.subject.domain.SubjectVO;

@Repository
public class ChartDaoImpl implements ChartDao, PcwkLogger {
	final String NAMESPACE = "com.pcwk.ehr.chart";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;


	@Override
	public List<ScoreVO> getWorkChartInfo(ScoreVO scoreVO) {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ mpChart                           │");
		LOG.debug("│ ScoreVO                           │"+scoreVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doRetrieve");
		LOG.debug("└───────────────────────────────────┘");			
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"getWorkChartInfo", scoreVO);
	
	}


	@Override
	public int doUpdate(SubjectVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public int doDelete(SubjectVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public SubjectVO doSelectOne(SubjectVO inVO) throws SQLException, EmptyResultDataAccessException {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public int doSave(SubjectVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public List<SubjectVO> doRetrieve(SubjectVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
}
