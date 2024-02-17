package com.pcwk.ehr.reply.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.reply.dao.ReplyDao;
import com.pcwk.ehr.reply.domain.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService, PcwkLogger {

	@Autowired
	ReplyDao dao;
	
	public ReplyServiceImpl() {}
	
	@Override
	public int getReplySeq() throws SQLException {
		return dao.getReplySeq();
	}

	@Override
	public int doUpdate(ReplyVO inVO) throws SQLException {
		return dao.doUpdate(inVO);
	}

	@Override
	public int doDelete(ReplyVO inVO) throws SQLException {
		return dao.doDelete(inVO);
	}

	@Override
	public ReplyVO doSelectOne(ReplyVO inVO) throws SQLException, EmptyResultDataAccessException {
		return dao.doSelectOne(inVO);
	}

	@Override
	public int doSave(ReplyVO inVO) throws SQLException {
		return dao.doSave(inVO);
	}

	@Override
	public List<ReplyVO> doRetrieve(ReplyVO inVO) throws SQLException {
		return dao.doRetrieve(inVO);
	}

}
