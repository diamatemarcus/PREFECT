package com.pcwk.ehr.search.service;

import javax.servlet.http.HttpServletResponse;

import com.pcwk.ehr.user.domain.UserVO;

public interface SearchPasswordService {

	//이메일발송
	public void sendEmail(UserVO inVO, String div) throws Exception;
	
	//비밀번호찾기
	public void findPw(HttpServletResponse response, UserVO inVO) throws Exception;
}
