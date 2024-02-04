package com.pcwk.ehr;

import static org.junit.Assert.*;

import java.sql.SQLException;

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
import com.pcwk.ehr.search.dao.SearchEmailDao;
import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.UserVO;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class SearchEmailDaoJunitTest implements PcwkLogger {

	@Autowired  //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;
	
	@Autowired
	SearchEmailDao  searchEmailDao;
	
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
		userVO01 = new UserVO("pohomen@naver.com-01", "김진수-01", "4321-01","01078575437","대졸","11");
		userVO02 = new UserVO("pohomen@naver.com-02", "김진수-02", "4321-02","01027512278","대졸","12");
		userVO03 = new UserVO("pohomen@naver.com-03", "김진수-03", "4321-03","01035785999","대졸","11");
 
		// getCount에 사용
		searchVO = new UserVO();
		searchVO.setEmail("pohomen@naver.com");
	}
	
	
	@Test
	public void nameTelCheck()throws SQLException {
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
		//3.1 이름 Check
		int cnt = searchEmailDao.nameCheck(userVO01);
		assertEquals(1, cnt);
		
		//3.2 이름,전화번호 Check
		cnt = searchEmailDao.nameTelCheck(userVO01);
		assertEquals(1, cnt);
		
	
	}
	
	@Test
	public void beans() {
		LOG.debug("====================");
		LOG.debug("=beans=");		
		LOG.debug("=context="+context);
		LOG.debug("=dao="+dao);		
		LOG.debug("=searchEmailDao="+searchEmailDao);	
		LOG.debug("====================");
		
		assertNotNull(context);
		assertNotNull(dao);
		assertNotNull(searchEmailDao);
	}

}
