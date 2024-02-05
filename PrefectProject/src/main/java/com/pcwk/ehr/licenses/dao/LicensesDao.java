package com.pcwk.ehr.licenses.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.licenses.domain.LicensesVO;

@Repository
public class LicensesDao implements PcwkLogger{
	final String NAMESPACE = "com.pcwk.ehr.licenses";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<LicensesVO> doSelectAll(LicensesVO inVO) throws SQLException, EmptyResultDataAccessException {
		
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSelectOne                       │");
		LOG.debug("│ LicensesVO                        │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doSelectAll");
		LOG.debug("└───────────────────────────────────┘");	
		
		return sqlSessionTemplate.selectList(NAMESPACE + DOT + "doSelectAll",inVO);
	}

}
