package com.pcwk.ehr.search.dao;

import java.sql.SQLException;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.user.domain.UserVO;

public interface SearchEmailDao {

	/**
	 * 이름 확인
	 * @param inVO
	 * @return 1(이름 있음)/0(이름 없음)
	 * @throws SQLException
	 */
	int nameCheck(UserVO inVO) throws SQLException;
	
	/**
	 * 전화번호 확인
	 * @param inVO
	 * @return 1(이름,전화번호 있음)/0(이름,전화번호 없음)
	 * @throws SQLException
	 */
	int nameTelCheck(UserVO inVO) throws SQLException;
	
}
