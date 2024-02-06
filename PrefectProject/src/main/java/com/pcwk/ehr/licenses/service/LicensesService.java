package com.pcwk.ehr.licenses.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.licenses.domain.LicensesVO;

public interface LicensesService {

	public int doUpdate(LicensesVO inVO) throws SQLException;
	
	public int doDelete(LicensesVO inVO) throws SQLException;
	
	public LicensesVO doSelectOne(LicensesVO inVO) throws SQLException, EmptyResultDataAccessException;
	
	public int doSave(LicensesVO inVO) throws SQLException;
	
	public List<LicensesVO> doRetrieve(LicensesVO inVO) throws SQLException;
}
