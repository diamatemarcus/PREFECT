package com.pcwk.ehr.search.service;

import java.sql.SQLException;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.user.domain.UserVO;

public interface SearchEmailService {

	/**
	 * 데이터 베이스 이름,전화번호 체크 
	 * @param inVO
	 * @return
	 * @throws SQLException
	 */
	int searchEmailCheck(UserVO inVO)throws SQLException;
	

	/**
	 * 단건조회
	 * @param inVO
	 * @return UserVO
	 * @throws SQLException
	 * @throws EmptyResultDataAccessException
	 */
	UserVO findEmail(UserVO inVO) throws SQLException, EmptyResultDataAccessException;
	
}
