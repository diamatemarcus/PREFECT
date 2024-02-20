package com.pcwk.ehr;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Arrays;
import java.util.List;

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
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.UserVO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class SearchControllerJunitTest implements PcwkLogger{

	@Autowired
	WebApplicationContext webApplicationContext;
	
	//브라우저 대역
	MockMvc  mockMvc;
	
	List<UserVO> users;
	UserVO searchVO;
	
	@Autowired
	UserDao  dao;
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ setUp()                                   │");		
		LOG.debug("└───────────────────────────────────────────┘");		
		
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		
		users = Arrays.asList(
				 new UserVO("pohomen@naver.com-01", "김진수-01", "4321_01","01012341234","대졸","11","")
				 , new UserVO("pohomen@naver.com-02", "김진수-02", "4321-02","01027512278","대졸","12","")
				 , new UserVO("pohomen@naver.com-03", "김진수-03", "4321-03","01035785999","대졸","11","")
				
			);
			
		searchVO = new UserVO();
		searchVO.setEmail("pohomen@naver.com");		
	}

	@Test
	public void findEmail()throws Exception{
		
		dao.doDelete(users.get(0));
		dao.doDelete(users.get(1));
		dao.doDelete(users.get(2));
	
		
		assertEquals(0,dao.getCount(searchVO));
		
		//2
		int flag = dao.doSave(users.get(0));
		assertEquals(1, flag);
		assertEquals(1,dao.getCount(searchVO));		
		
		flag = dao.doSave(users.get(1));
		assertEquals(1, flag);
		assertEquals(2,dao.getCount(searchVO));		
		
		flag = dao.doSave(users.get(2));
		assertEquals(1, flag);
		assertEquals(3,dao.getCount(searchVO));		
		
		
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ searchEmail                               │");		
		LOG.debug("└───────────────────────────────────────────┘");		
		
		MockHttpServletRequestBuilder  requestBuilder = 
				MockMvcRequestBuilders.post("/search/searchEmail.do")
				.param("name",        users.get(0).getName())
				.param("tel",      users.get(0).getTel());
				
		ResultActions resultActions=this.mockMvc.perform(requestBuilder).andExpect(status().isOk());
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ result                                    │"+result);		
		LOG.debug("└───────────────────────────────────────────┘");		
				
		MessageVO messageVO = new Gson().fromJson(result, MessageVO.class);
		assertEquals(String.valueOf(30), messageVO.getMsgId());
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ messageVO                                 │"+messageVO);		
		LOG.debug("└───────────────────────────────────────────┘");					
				
	}
	
	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ beans()                                   │");		
		
		LOG.debug("webApplicationContext:"+webApplicationContext);	
		LOG.debug("mockMvc:"+mockMvc);	
		LOG.debug("dao:"+dao);	
		
		LOG.debug("└───────────────────────────────────────────┘");
		
		assertNotNull(webApplicationContext);
		assertNotNull(mockMvc);
		assertNotNull(dao);
		
	}

}