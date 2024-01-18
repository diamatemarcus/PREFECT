package com.pcwk.ehr.board.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.board.dao.BoardDao;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;

@Service
public class BoardServiceImpl implements BoardService,PcwkLogger {

	@Autowired
	BoardDao dao;
	
	public BoardServiceImpl() {}
	
	@Override
	public int doUpdate(BoardVO inVO) throws SQLException {
		return dao.doUpdate(inVO);
	}

	@Override
	public int doDelete(BoardVO inVO) throws SQLException {
		return dao.doDelete(inVO);
	}

	@Override
	public BoardVO doSelectOne(BoardVO inVO) throws SQLException, EmptyResultDataAccessException {
		//1. 단건조회
		//2. 조회count증가
		BoardVO outVO = dao.doSelectOne(inVO);
		
		if(null != outVO) {
			int updateReadCnt = dao.updateReadCnt(inVO);
			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ updateReadCnt                     │"+updateReadCnt);
			LOG.debug("└───────────────────────────────────┘");				
		}
		
		
		return outVO;
	}

	@Override
	public int doSave(BoardVO inVO) throws SQLException {
		return dao.doSave(inVO);
	}

	@Override
	public List<BoardVO> doRetrieve(BoardVO inVO) throws SQLException {
		return dao.doRetrieve(inVO);
	}

	@Override
	public int getBoardSeq() throws SQLException {
		return dao.getBoardSeq();
	}

}
