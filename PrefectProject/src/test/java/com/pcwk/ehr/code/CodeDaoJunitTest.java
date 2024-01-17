package com.pcwk.ehr.code;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.pcwk.ehr.code.dao.CodeDao;
import com.pcwk.ehr.code.domain.CodeVO;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class CodeDaoJunitTest  implements PcwkLogger {

	@Autowired
	CodeDao dao;
	
	@Autowired  //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;	
	
	CodeVO searchVO;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ setUp                             │");
		LOG.debug("└───────────────────────────────────┘");		
		
		searchVO = new CodeVO();
	}

	@Test
	public void doRetrieve() throws SQLException{
		
		Map<String,Object> codes = new HashMap<String,Object>();
		//
		String[] codesStr = {"U_LEVEL","PAGE_SIZE"};
		
		codes.put("code",codesStr);
		
		List<CodeVO> list = dao.doRetrieve(codes);
		for(CodeVO vo  :list) {
			LOG.debug(vo);
		}
		
		assertNotNull(list);
		assertEquals(7, list.size());
	}
	
	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ beans                             │");
		LOG.debug("│ dao                               │"+dao);
		LOG.debug("│ context                           │"+context);
		LOG.debug("│ searchVO                          │"+searchVO);
		LOG.debug("└───────────────────────────────────┘");
		
		assertNotNull(dao);
		assertNotNull(context);
		assertNotNull(searchVO);
	}

}
