package com.pcwk.ehr.licenses.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.licenses.domain.LicensesVO;

public interface LicensesDao extends WorkDiv<LicensesVO>, PcwkLogger {
	
	public int getLicensesSeq()throws SQLException;
	
	public List<LicensesVO> getLicensesName() throws SQLException;
	
}
