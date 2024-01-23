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

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.login.dao.LoginDao;
import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.UserVO;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class LoginDaoJunitTest implements PcwkLogger{

	@Autowired  //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;
	
	@Autowired
	LoginDao  loginDao;
	
	@Autowired
	UserDao   dao;
	
	// 등록
	UserVO userVO01;

	// getCount에 사용
	UserVO searchVO;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("====================");
		LOG.debug("=setUp=" );		
		LOG.debug("====================");
		// 등록
		userVO01 = new UserVO("pohomen@naver.com", "김진수", "4321","01012341234","대졸","11");
		
 
		// getCount에 사용
		searchVO = new UserVO();
		searchVO.setEmail("pohomen");
	}
	
	@Test
	public void doLogin()throws SQLException {
		//1. 데이터 삭제
		//2. 데이터 입력
		//3. login
		dao.doDelete(userVO01);
		
		
		assertEquals(0,dao.getCount(searchVO));
		//2.
		int flag = dao.doSave(userVO01);
		//3
		assertEquals(1, flag);
		assertEquals(1,dao.getCount(searchVO));

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
		assertEquals(userVO.getEmail(), outVO.getEmail());
		assertEquals(userVO.getName(), outVO.getName());
		assertEquals(userVO.getPassword(), outVO.getPassword());
		assertEquals(userVO.getTel(), outVO.getTel());
		assertEquals(userVO.getEdu(), outVO.getEdu());
		assertEquals(userVO.getRole(), outVO.getRole());


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
