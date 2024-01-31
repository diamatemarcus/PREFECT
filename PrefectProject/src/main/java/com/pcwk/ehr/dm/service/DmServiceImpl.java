package com.pcwk.ehr.dm.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.dm.dao.DmDao;
import com.pcwk.ehr.dm.domain.DmVO;

@Service
public class DmServiceImpl implements DmService, PcwkLogger {
	
	@Autowired
	DmDao dao;
	
	public DmServiceImpl () {}
	
	@Override
	public int doSend(DmVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return dao.doSend(inVO);
	}

	@Override
	public int updateReadChk(DmVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return dao.updateReadChk(inVO);
	}

	@Override
	public int doDelete(DmVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return dao.doDelete(inVO);
	}

	@Override
	public DmVO recentMessage(DmVO inVO) throws SQLException, EmptyResultDataAccessException {
		// TODO Auto-generated method stub
		return dao.recentMessage(inVO);
	}

	@Override
	public List<DmVO> contentsList(DmVO inVO) throws SQLException {
		List list =  dao.contentsList(inVO);
		
		if(null != list) {
			int updateReadChk = dao.updateReadChk(inVO);
			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ updateReadCnt                     │"+updateReadChk);
			LOG.debug("└───────────────────────────────────┘");				
		}
		
		
		return list;
	}

}
