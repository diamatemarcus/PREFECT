package com.pcwk.ehr.dm.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.dm.domain.DmVO;

public interface DmService {
	
	public int getDmSeq()throws SQLException;
	
	public int doSend(DmVO inVO) throws SQLException;
	 
	public int updateReadChk(DmVO inVO)throws SQLException;
	 
	public int doDelete(DmVO inVO)throws SQLException;
	 
	public DmVO recentMessage(DmVO inVO) throws SQLException, EmptyResultDataAccessException;
	 
	public List<DmVO> contentsList(DmVO inVO) throws SQLException;

}
