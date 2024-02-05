package com.pcwk.ehr.licenses;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;

import java.sql.SQLException;
import java.util.List;

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
import com.pcwk.ehr.licenses.dao.LicensesDao;
import com.pcwk.ehr.licenses.domain.LicensesVO;

@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class LicensesDaoJunitTest implements PcwkLogger{
	@Autowired
	LicensesDao dao;
	
	LicensesVO vo;
	
	
	@Autowired
	ApplicationContext context;

	@Before
	public void setUp() throws Exception {
	}
	
	@Test
	public void doSelectAll() throws SQLException {
	    // given
	    LicensesVO vo = new LicensesVO();
	    
	    // when
	    List<LicensesVO> licensesList = dao.doSelectAll(vo);
	    
	    // then
	    assertNotNull(licensesList);
	    assertFalse(licensesList.isEmpty());
	    assertEquals(9, licensesList.size());
	}

	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ beans                             │");
		LOG.debug("│ dao                               │"+dao);
		LOG.debug("│ context                           │"+context);
		LOG.debug("└───────────────────────────────────┘");
		
		assertNotNull(dao);
		assertNotNull(context);
	}

}
