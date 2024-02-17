package com.pcwk.ehr.reply.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.reply.domain.ReplyVO;

@Repository
public class ReplyDaoImpl implements ReplyDao,PcwkLogger {
	final String NAMESPACE = "com.pcwk.ehr.reply";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public ReplyDaoImpl() {}
	
	
	@Override
	public int doUpdate(ReplyVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doUpdate                          │");
		LOG.debug("│ ReplyVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doUpdate");
		LOG.debug("└───────────────────────────────────┘");		
		return sqlSessionTemplate.update(NAMESPACE+DOT+"doUpdate", inVO);
	}
	
	@Override
	public List<ReplyVO> doRetrieve(ReplyVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieve                        │");
		LOG.debug("│ ReplyVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doRetrieve");
		LOG.debug("└───────────────────────────────────┘");			
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"doRetrieve", inVO);
	}
	
	
	
	@Override
	public int doDelete(ReplyVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDelete                          │");
		LOG.debug("│ ReplyVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doDelete");
		LOG.debug("└───────────────────────────────────┘");		
		return sqlSessionTemplate.delete(NAMESPACE+DOT+"doDelete", inVO);
	}

	@Override
	public ReplyVO doSelectOne(ReplyVO inVO) throws SQLException, EmptyResultDataAccessException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSelectOne                       │");
		LOG.debug("│ ReplyVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doSelectOne");
		LOG.debug("└───────────────────────────────────┘");	
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"doSelectOne", inVO);
	}

	@Override
	public int doSave(ReplyVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSave                            │");
		LOG.debug("│ ReplyVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doSave");
		LOG.debug("└───────────────────────────────────┘");		
		return sqlSessionTemplate.insert(NAMESPACE+DOT+"doSave", inVO);
	}



	@Override
	public int getReplySeq() throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ getReplySeq                       │");
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"getReplySeq");
		LOG.debug("└───────────────────────────────────┘");	
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"getReplySeq");
	}

}
