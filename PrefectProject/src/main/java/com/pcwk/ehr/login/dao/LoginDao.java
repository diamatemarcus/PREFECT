package com.pcwk.ehr.login.dao;

import java.sql.SQLException;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.user.domain.UserVO;

public interface LoginDao extends WorkDiv<UserVO> {

	/**
	 * id존재 check
	 * @param inVO
	 * @return 1(id존재)/0(id없음)
	 * @throws SQLException
	 */
	int idCheck(UserVO inVO)throws SQLException;
	
	/**
	 * id와 비번 check
	 * @param inVO
	 * @return 1(id/비번 존재)/0(id/비번 없음)
	 * @throws SQLException
	 */
	int idPassCheck(UserVO inVO)throws SQLException;
	

	
}
