package com.pcwk.ehr.calendar.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.calendar.domain.WeekVO;
import com.pcwk.ehr.cmn.PcwkLogger;

@Repository
public class CalendarDaoImpl implements CalendarDao, PcwkLogger{
	
	final String NAMESPACE = "com.pcwk.ehr.calendar";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public CalendarDaoImpl() {}
	

	@Override
	public List<WeekVO> doRetrieveMonth(CalendarVO inVO) throws SQLException, EmptyResultDataAccessException {
		List<WeekVO> outVO = null;
		
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"doSelectMonth";
		LOG.debug("2.statement \n" + statement);
		
		outVO= this.sqlSessionTemplate.selectList(statement, inVO);
		for(WeekVO vo :outVO) {
			LOG.debug(vo);
		}		
		return outVO;
	}

}

