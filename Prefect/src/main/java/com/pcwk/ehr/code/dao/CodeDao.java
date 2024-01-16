package com.pcwk.ehr.code.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.code.domain.CodeVO;

public interface CodeDao extends WorkDiv<CodeVO> {
	public List<CodeVO> doRetrieve(Map<String,Object> map) throws SQLException ;
}
