package com.pcwk.ehr.code.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.code.dao.CodeDao;
import com.pcwk.ehr.code.domain.CodeVO;

@Service
public class CodeServiceImpl implements CodeService,PcwkLogger {

	@Autowired
	CodeDao dao;
	
	public CodeServiceImpl() {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ CodeServiceImpl()                 │");
		LOG.debug("└───────────────────────────────────┘");				
	}
	
	@Override
	public List<CodeVO> doRetrieve(Map<String, Object> map) throws SQLException {
		return dao.doRetrieve(map);
	}

}
