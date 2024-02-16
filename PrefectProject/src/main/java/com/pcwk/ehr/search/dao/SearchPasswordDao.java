package com.pcwk.ehr.search.dao;

import com.pcwk.ehr.user.domain.UserVO;

public interface SearchPasswordDao {

	int updatePw(UserVO inVO) throws Exception;
	
	int emailCheck(UserVO inVO) throws Exception;
	
	UserVO readMember(UserVO inVO) throws Exception;
}
