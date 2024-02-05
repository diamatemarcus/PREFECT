package com.pcwk.ehr.licenses.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.licenses.domain.LicensesVO;

@Repository
public class LicensesDaoImpl implements LicensesDao, PcwkLogger{
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

	@Override
	public int doUpdate(BoardVO inVO) throws SQLException {
		
		return 0;
	}

	@Override
	public int doDelete(BoardVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public BoardVO doSelectOne(BoardVO inVO) throws SQLException, EmptyResultDataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int doSave(BoardVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSave                            │");
		LOG.debug("│ LicensesVO                        │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doSave");
		LOG.debug("└───────────────────────────────────┘");	
		return sqlSessionTemplate.insert(NAMESPACE+DOT+"doSave",inVO);
	}

	@Override
	public List<BoardVO> doRetrieve(BoardVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
