package com.pcwk.ehr.search.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.search.dao.SearchEmailDao;
import com.pcwk.ehr.user.domain.UserVO;

@Service
public class SearchEmailServiceImpl implements PcwkLogger, SearchEmailService {
	
	@Autowired
	SearchEmailDao searchEmailDao;

	@Override
	public int searchEmailCheck(UserVO inVO) throws SQLException {
		//10:ID 없음
		//20:비번이상
		//30:로그인
		int checkStatus = 0;
		
		//이름 Check
		int status = searchEmailDao.nameCheck(inVO);
		
		if(status==0) {
			checkStatus = 10;
			LOG.debug("10 nameCheck checkStatus:"+checkStatus);
			return checkStatus;
		}
		
		//아름,전화번호 Check
		status = searchEmailDao.nameTelCheck(inVO);
		if(status==0) {
			checkStatus = 20;
			LOG.debug("20 nameTelCheck checkStatus:"+checkStatus);
			return checkStatus;
		}
		
		checkStatus = 30;//id/비번 정상 로그인 
		LOG.debug("30 idPassCheck pass checkStatus:"+checkStatus);
		return checkStatus;
	}

	@Override
	public UserVO doSelectOne(UserVO inVO) throws SQLException, EmptyResultDataAccessException {
		return searchEmailDao.doSelectOne(inVO);
	
	}

}
