package com.pcwk.ehr.login.service;

import java.sql.SQLException;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.user.domain.UserVO;

public interface LoginService {
	
	/**
	 * 데이터 베이스 ID비번 체크 
	 * @param inVO
	 * @return
	 * @throws SQLException
	 */
	int loginCheck(UserVO inVO)throws SQLException;
	

	/**
	 * 단건조회
	 * @param inVO
	 * @return UserVO
	 * @throws SQLException
	 * @throws EmptyResultDataAccessException
	 */
	UserVO doSelectOne(UserVO inVO) throws SQLException, EmptyResultDataAccessException;
	
}
