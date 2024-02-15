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
	
	// 변수 정의
	UserVO userVO;


	@Before
	public void setUp() throws Exception {
		LOG.debug("데이터에 있는 유저 정보 세팅");
		// 변수 정보 등록
		userVO = new UserVO("karina00@naver.com", "유지민", "0000","01087654321","검정","5","");	
 
	}
	
	
	@Test
	public void searchCheck()throws SQLException {
	
		//3.1 이름 Check
		int cnt = searchEmailDao.nameCheck(userVO);
		assertEquals(1, cnt);
		
		//3.2 이름,전화번호 Check
		cnt = searchEmailDao.nameTelCheck(userVO);
		assertEquals(1, cnt);
		
	
	}
	
	@Test
	public void beans() {
		LOG.debug("====================");
		LOG.debug("=beans=");		
		LOG.debug("=context="+context);
		LOG.debug("=searchEmailDao="+searchEmailDao);	
		LOG.debug("====================");
		
		assertNotNull(context);
		assertNotNull(searchEmailDao);
	}

}
