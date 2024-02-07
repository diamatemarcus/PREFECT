package com.pcwk.ehr.subject;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.context.WebApplicationContext;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.subject.dao.SubjectDao;
import com.pcwk.ehr.subject.domain.SubjectVO;
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정

@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)

public class SubjetControllerTest implements PcwkLogger {

	@Autowired
	SubjectVO dao;
	
	@Autowired
	WebApplicationContext webApplicationContext;
	
	MockMvc  mockMvc;

	@Before
	public void setUp() throws Exception{
		
	
	}
	
	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ beans()                                   │");
		LOG.debug("│ webApplicationContext                     │"+webApplicationContext);
		LOG.debug("│ mockMvc                                   │"+mockMvc);
		LOG.debug("└───────────────────────────────────────────┘");		
		assertNotNull(dao);
		assertNotNull(mockMvc);
		assertNotNull(webApplicationContext);
	}

}
