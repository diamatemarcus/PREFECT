package com.pcwk.ehr.licenses;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.licenses.dao.LicensesDao;
import com.pcwk.ehr.licenses.domain.LicensesVO;
import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.UserVO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class LicensesControllerJunitTest implements PcwkLogger {

	@Autowired
	LicensesDao licensesDao;

	@Autowired
	WebApplicationContext webApplicationContext;

	MockMvc mockMvc;

	@Autowired
	UserDao userDao;

	UserVO user01;

	LicensesVO licenses01;
	LicensesVO licenses02;
	LicensesVO licenses03;

	@Before
	public void setUp() throws Exception {
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();

		user01 = new UserVO("cr7@gmail.com", "호날두_U", "7777_U", "01077777777", "초졸_U", "1");

		licenses01 = new LicensesVO(6, "cr7@gmail.com", "23/02/02");
		licenses02 = new LicensesVO(7, "cr7@gmail.com", "23/02/02");
		licenses03 = new LicensesVO(8, "cr7@gmail.com", "23/02/02");

	}
	
	@Test
	public void doRetrieve() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
	    LOG.debug("│ doRetrieve()                              │");
	    LOG.debug("└───────────────────────────────────────────┘");
	    
	    userDao.doDelete(user01);
	    int flag = userDao.doSave(user01);
	    assertEquals(1, flag);
	    
	    flag = licensesDao.doSave(licenses01);
	    assertEquals(1, flag);
	    
	    flag = licensesDao.doSave(licenses02);
	    assertEquals(1, flag);
	    
	    flag = licensesDao.doSave(licenses03);
	    assertEquals(1, flag);
	}

	@Ignore
	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ webApplicationContext                     │" + webApplicationContext);
		LOG.debug("│ mockMvc                                   │" + mockMvc);
		LOG.debug("│ dao                                       │" + licensesDao);
		LOG.debug("└───────────────────────────────────────────┘");
		assertNotNull(webApplicationContext);
		assertNotNull(mockMvc);
		assertNotNull(licensesDao);

	}

}
