package com.pcwk.ehr.user.service;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.Level;
import com.pcwk.ehr.user.domain.UserVO;

@Service
public class UserServiceImpl implements UserService {
	final Logger LOG = LogManager.getLogger(getClass());

	public static final int MIN_LOGIN_COUNT_FOR_SILVER = 50;
	public static final int MIN_RECOMEND_COUNT_FOR_GOLD = 30;
    
	@Autowired
	private UserDao userDao;
	
	
	@Resource(name="dummyMailSender")
	private MailSender mailSender; 

	public UserServiceImpl() {}

	/**
	 * 업그레이드 가능 여부 확인
	 * 
	 * @param inVO
	 * @return true(등업 대상)/false
	 */
	private boolean canUpgradeLevel(UserVO inVO) {
		Level currentLevel = inVO.getLevel();

		switch (currentLevel) {
		case BASIC:
			return (inVO.getLogin() >= MIN_LOGIN_COUNT_FOR_SILVER);
		case SILVER:
			return (inVO.getRecommend() >= MIN_RECOMEND_COUNT_FOR_GOLD);
		case GOLD:
			return false;
		default:
			throw new IllegalArgumentException("Unknown Level:" + currentLevel);
		}
	}

	@Override
	public void upgradeLevels(UserVO inVO) throws Exception {

		try {

			List<UserVO> allUser = userDao.getAll(inVO);

			// 2.
			for (UserVO vo : allUser) {
				boolean changeLevel = false;// 등업 대상 선정

				// 등업 대상 선정
				if (canUpgradeLevel(vo) == true) {
					// 등업
					upgradeLevel(vo);
				}
			}

		} catch (Exception e) {
			LOG.debug("┌─────────────────────────────────────────────────────────┐");
			LOG.debug("│ upgradeAllOrNothing()                                   │"+e.getMessage());
			LOG.debug("└─────────────────────────────────────────────────────────┘");

			throw e;
		}

	}

	// 레벨 업그레이드
	protected void upgradeLevel(UserVO inVO) throws SQLException {
		if(inVO.getUserId().equals("p99-04")) {
			LOG.debug("┌─────────────────────────────────────────────────────────┐");
			LOG.debug("│ upgradeLevel                                      │"+inVO.getUserId());
			LOG.debug("└─────────────────────────────────────────────────────────┘");			
			throw new TestUserServiceException(inVO.getUserId()+"예외 발생!!!");
		}
		
		inVO.upgradeLevel();
		userDao.doUpdate(inVO);

		sendUpgradeEmail(inVO);
	}

	// 등업된 사용자에게 email전송
	private void sendUpgradeEmail(UserVO inVO) {
		LOG.debug("┌─────────────────────────────────────────────────────────┐");
		LOG.debug("│ sendUpgradeEmail()                                      │");
		LOG.debug("└─────────────────────────────────────────────────────────┘");

		try {

			SimpleMailMessage message = new SimpleMailMessage();
			// 보내는 사람
			message.setFrom("jamesol@naver.com");
			// 받는 사람
			message.setTo(inVO.getEmail());
			// 제목
			message.setSubject("등업 안내!");
			// 내용
			message.setText("사용자 등급이 " + inVO.getLevel().name() + "로 등업 되었습니다.");

			mailSender.send(message);
		} catch (Exception e) {
			LOG.debug("┌──────────────────────────────┐");
			LOG.debug("│MessagingException:           │" + e.getMessage());
			LOG.debug("└──────────────────────────────┘");
			e.printStackTrace();
		}

		if (mailSender instanceof JavaMailSenderImpl) {
			LOG.debug("┌─────────────────────────────────────────────────────────┐");
			LOG.debug("│ mail전송:OK                                              │" + inVO.getEmail());
			LOG.debug("└─────────────────────────────────────────────────────────┘");
		}
	}

	@Override
	public void add(UserVO inVO) throws SQLException {
		if (null == inVO.getLevel()) {
			inVO.setLevel(Level.BASIC);
		}

		userDao.doSave(inVO);

	}

	@Override
	public List<UserVO> getAll(UserVO inVO) throws SQLException {
		return userDao.getAll(inVO);
	}

	@Override
	public int doUpdate(UserVO inVO) throws SQLException {
		return userDao.doUpdate(inVO);
	}

	@Override
	public int getCount(UserVO inVO) throws SQLException {
		return userDao.getCount(inVO);
	}

	@Override
	public int doDelete(UserVO inVO) throws SQLException {
		return userDao.doDelete(inVO);
	}

	@Override
	public UserVO doSelectOne(UserVO inVO) throws SQLException, EmptyResultDataAccessException {
		return userDao.doSelectOne(inVO);
	}

	@Override
	public List<UserVO> doRetrieve(UserVO inVO) throws SQLException {
		return userDao.doRetrieve(inVO);
	}

	@Override
	public int doSave(UserVO inVO) throws SQLException {
		return userDao.doSave(inVO);
	}

	@Override
	public int idDuplicateCheck(UserVO inVO) throws SQLException {
		return userDao.idDuplicateCheck(inVO);
	}
}














