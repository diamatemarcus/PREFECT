package com.pcwk.ehr.login.service;

import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.login.dao.LoginDao;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.util.ShaUtil;

@Service
public class LoginServiceImpl implements LoginService, PcwkLogger {

	@Autowired
	LoginDao loginDao;

	public LoginServiceImpl() {
	}

	@Override
	public UserVO doSelectOne(UserVO inVO) throws SQLException, EmptyResultDataAccessException {
		return loginDao.doSelectOne(inVO);
	}

	@Override
	public int loginCheck(UserVO inVO) throws SQLException {
		// 10:ID 없음
		// 20:비번이상
		// 30:로그인
		int checkStatus = 0;

		// idCheck
		int status = loginDao.idCheck(inVO);

		if (status == 0) {
			checkStatus = 10;
			LOG.debug("10 idCheck checkStatus:" + checkStatus);
			return checkStatus;
		}
																			 // 비밀번호 검사		2024/3/4	
		UserVO user = loginDao.getUserEmail(inVO.getEmail());                // 입력된 아이디에 대한 정보들 user객체에 저장
		LOG.debug("inVO.getPassword():" + inVO.getPassword()); 	             // View에 입력된 비밀번호 값
		LOG.debug("user.getSalt():" + user.getSalt());                       // 저장된 salt 값
		String hexPw = ShaUtil.hash(inVO.getPassword() + user.getSalt());    // 입력된 비밀번호와 저장되어있던 솔트값을 가져와 해시
		LOG.debug("hexPw :"+ hexPw);
		LOG.debug("user.getPassword():"+user.getPassword());
		if (hexPw.contentEquals(user.getPassword())) {						 // DB에 저장된 해시비밀번호와 입력받은 비밀번호 + 솔트 값을 해시한 것과 같은지 비교
			status = 1;														 // 같으면 status = 1 을 반환
		} else {
			status = 0;
		}
		if (status == 0) {
			checkStatus = 20;
			LOG.debug("20 idPassCheck checkStatus:" + checkStatus);
			return checkStatus;
		}

		checkStatus = 30;// id/비번 정상 로그인
		LOG.debug("30 idPassCheck pass checkStatus:" + checkStatus);
		return checkStatus;
	}
	
	@Override
	public String login(String email, String password) throws SQLException {   //이건 만들어 두고 안쓴 것 2024/3/4
		UserVO user = loginDao.getUserEmail(email); 
		LOG.debug(password);
		LOG.debug(user.getSalt());
		String hexPw = ShaUtil.hash(password + user.getSalt()); 
		LOG.debug(user.getPassword());
		LOG.debug(hexPw);
		if (hexPw.equals(user.getPassword())) { //
			return user.getEmail();
		}
		return null;

	}
}
