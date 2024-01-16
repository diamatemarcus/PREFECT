package com.pcwk.ehr.board.dao;

import java.sql.SQLException;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;
@Repository
public class BoardDaoImpl implements BoardDao,PcwkLogger {
	final String NAMESPACE = "com.pcwk.ehr.board";
	final String DOT       = ".";
	 
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public int doUpdate(BoardVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDelete                          │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doUpdate");
		LOG.debug("└───────────────────────────────────┘");		
		return sqlSessionTemplate.update(NAMESPACE+DOT+"doUpdate", inVO);
	}

	@Override
	public int doDelete(BoardVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDelete                          │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doDelete");
		LOG.debug("└───────────────────────────────────┘");		
		
		return sqlSessionTemplate.delete(NAMESPACE+DOT+"doDelete", inVO);
	}

	@Override
	public BoardVO doSelectOne(BoardVO inVO) throws SQLException, EmptyResultDataAccessException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSelectOne                       │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doSelectOne");
		LOG.debug("└───────────────────────────────────┘");	
		
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"doSelectOne", inVO);
	}

	@Override
	public int doSave(BoardVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSave                            │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doSave");
		//com.pcwk.ehr.board.doSave
		LOG.debug("└───────────────────────────────────┘");	
		return sqlSessionTemplate.insert(NAMESPACE+DOT+"doSave", inVO);
	}

	@Override
	public List<BoardVO> doRetrieve(BoardVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieve                        │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doRetrieve");
		LOG.debug("└───────────────────────────────────┘");			
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"doRetrieve", inVO);
	}

	@Override
	public int getBoardSeq() throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ getBoardSeq                       │");
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"getBoardSeq");
		LOG.debug("└───────────────────────────────────┘");	
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"getBoardSeq");
	}

	@Override
	public int doDeleteAll(BoardVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDeleteAll                       │");
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doDeleteAll");
		LOG.debug("└───────────────────────────────────┘");	
		return sqlSessionTemplate.delete(NAMESPACE+DOT+"doDeleteAll", inVO);
	}

	@Override
	public int updateReadCnt(BoardVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ updateReadCnt                     │");
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"updateReadCnt");
		LOG.debug("└───────────────────────────────────┘");	
		return sqlSessionTemplate.update(NAMESPACE+DOT+"updateReadCnt", inVO);
	}

}
