package com.pcwk.ehr.user.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.user.domain.UserVO;

public interface UserDao extends WorkDiv<UserVO> {
	
	List<UserVO> getAll(UserVO inVO) throws SQLException;

	int getCount(UserVO inVO) throws SQLException;
	
	int emailDuplicateCheck(UserVO inVO) throws SQLException;
	
	int doUpdatePassword(UserVO inVO) throws SQLException;
    
	int totalUsers() throws SQLException;
}