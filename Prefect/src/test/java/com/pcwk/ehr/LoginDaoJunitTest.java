package com.pcwk.ehr;

import static org.junit.Assert.*;

import java.sql.SQLException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.login.dao.LoginDao;
import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.Level;
import com.pcwk.ehr.user.domain.UserVO;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class LoginDaoJunitTest {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired  //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;
	
	@Autowired
	LoginDao  loginDao;
	
	@Autowired
	UserDao   dao;
	
	// 등록
	UserVO userVO01;
	UserVO userVO02;
	UserVO userVO03;

	// getCount에 사용
	UserVO searchVO;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("====================");
		LOG.debug("=setUp=" );		
		LOG.debug("====================");
		// 등록
		userVO01 = new UserVO("p99-01", "이상무99_01", "4321_1",Level.BASIC,1,0,"jamesol@paran.com","사용하지 않음");
		userVO02 = new UserVO("p99-02", "이상무99_02", "4321_2",Level.SILVER,50,2,"jamesol@paran.com","사용하지 않음");
		userVO03 = new UserVO("p99-03", "이상무99_03", "4321_3",Level.GOLD,100,31,"jamesol@paran.com","사용하지 않음");
 
		// getCount에 사용
		searchVO = new UserVO();
		searchVO.setUserId("p99");
	}
	
	@Test
	public void doLogin()throws SQLException {
		//1. 데이터 삭제
		//2. 데이터 입력
		//3. login
		dao.doDelete(userVO01);
		dao.doDelete(userVO02);
		dao.doDelete(userVO03);
		
		assertEquals(0,dao.getCount(searchVO));
		//2.
		int flag = dao.doSave(userVO01);
		//3
		assertEquals(1, flag);
		assertEquals(1,dao.getCount(searchVO));
		
		flag = dao.doSave(userVO02);
		assertEquals(1, flag);
		assertEquals(2,dao.getCount(searchVO));
		
		flag = dao.doSave(userVO03);
		assertEquals(1, flag);
		assertEquals(3,dao.getCount(searchVO));
	
		//3.1 idCheck
		int cnt = loginDao.idCheck(userVO01);
		assertEquals(1, cnt);
		
		//3.2 idPassCheck
		cnt = loginDao.idPassCheck(userVO01);
		assertEquals(1, cnt);
		
		//3.3. 단건조회
		UserVO outVO = loginDao.doSelectOne(userVO01);
	    isSameUser(outVO, userVO01);	
		
	}
	private void isSameUser(UserVO userVO, UserVO outVO) {
		assertEquals(userVO.getUserId(), outVO.getUserId());
		assertEquals(userVO.getName(), outVO.getName());
		assertEquals(userVO.getPassword(), outVO.getPassword());
		
		assertEquals(userVO.getLevel(), outVO.getLevel());//등급
		assertEquals(userVO.getLogin(), outVO.getLogin());//로그인 횟수
		assertEquals(userVO.getRecommend(), outVO.getRecommend());//추천수
		assertEquals(userVO.getEmail(), outVO.getEmail());//email

	}
	
	
	
	@Test
	public void beans() {
		LOG.debug("====================");
		LOG.debug("=beans=");		
		LOG.debug("=context="+context);
		LOG.debug("=dao="+dao);		
		LOG.debug("=loginDao="+loginDao);	
		LOG.debug("====================");
		
		assertNotNull(context);
		assertNotNull(dao);
		assertNotNull(loginDao);
	}

}
