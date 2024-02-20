package com.pcwk.ehr.dm.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.dm.domain.DmVO;

public interface DmDao {
	
	int getDmSeq()throws SQLException;
	
	int doSend(DmVO inVO) throws SQLException;
	
	int updateReadChk(DmVO inVO)throws SQLException;
	
	int doDelete(DmVO inVO)throws SQLException;
	
	DmVO recentMessage(DmVO inVO) throws SQLException, EmptyResultDataAccessException;
	
	List<DmVO> contentsList(DmVO inVO) throws SQLException;
	
	List<DmVO> receiverList(DmVO inVO) throws SQLException;
}
