package com.pcwk.ehr.licenses.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.licenses.dao.LicensesDao;
import com.pcwk.ehr.licenses.domain.LicensesVO;
import com.pcwk.ehr.user.domain.UserVO;

@Service
public class LicensesServiceImpl implements LicensesService, PcwkLogger {

	@Autowired
	LicensesDao dao;
	
	public LicensesServiceImpl() {}
	
	@Override
	public int doUpdate(LicensesVO inVO) throws SQLException {
		return dao.doUpdate(inVO);
	}

	@Override
	public int doDelete(LicensesVO inVO) throws SQLException {
		return dao.doDelete(inVO);
	}

	@Override
	public LicensesVO doSelectOne(LicensesVO inVO) throws SQLException, EmptyResultDataAccessException {
		return dao.doSelectOne(inVO);
	}

	@Override
	public int doSave(LicensesVO inVO) throws SQLException {
		return dao.doSave(inVO);
	}

	@Override
	public List<LicensesVO> doRetrieve(LicensesVO inVO) throws SQLException {
		return dao.doRetrieve(inVO);
	}

	@Override
	public int getLicensesSeq() throws SQLException {
		
		return dao.getLicensesSeq();
	}

	@Override
	public List<LicensesVO> getLicensesName() throws SQLException {
		
		return dao.getLicensesName();
	}

	@Override
	public List<LicensesVO> getUserLicenses(UserVO inVO) throws SQLException {
		
		return dao.getUserLicenses(inVO);
	}

}
