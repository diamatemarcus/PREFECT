package com.pcwk.ehr.licenses;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.lang.reflect.Type;
import java.sql.SQLException;
import java.util.List;

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
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.pcwk.ehr.cmn.MessageVO;
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

		user01 = new UserVO("cr7@gmail.com", "호날두_U", "7777_U", "01077777777", "초졸_U", "1","");

		licenses01 = new LicensesVO(6, "cr7@gmail.com", "23/02/02");
		licenses02 = new LicensesVO(7, "cr7@gmail.com", "23/02/02");
		licenses03 = new LicensesVO(8, "cr7@gmail.com", "23/02/02");

	}
	@Ignore
	@Test
	public void getLicensesName() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
	    LOG.debug("│ getLicensesName()                         │");
	    LOG.debug("└───────────────────────────────────────────┘");
	    
	 // 엔드포인트 호출
	    MockHttpServletRequestBuilder requestBuilder =
	        MockMvcRequestBuilders.get("/licenses/getLicensesName.do");
	    
	    // 호출 및 검증
	    ResultActions resultActions = mockMvc.perform(requestBuilder)
	                                          .andExpect(status().isOk());
	    
	    // 호출 결과 확인
	    String result = resultActions.andDo(print())
	                                 .andReturn()
	                                 .getResponse()
	                                 .getContentAsString();
	    
	    LOG.debug("│ result                                │" + result);
	    
	    Type listType = new TypeToken<List<LicensesVO>>(){}.getType();
		
		List<LicensesVO>  list=new Gson().fromJson(result, listType);
		
		assertEquals(9, list.size());
		assertNotNull(list);
		
		for (LicensesVO vo   :list) {
			LOG.debug(vo);
		}
	    
	}
	
	@Ignore
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
		
	 // 엔드포인트 호출
	    MockHttpServletRequestBuilder requestBuilder =
	        MockMvcRequestBuilders.get("/licenses/doRetrieve.do");
	    
	    // 호출 및 검증
	    ResultActions resultActions = mockMvc.perform(requestBuilder)
	                                          .andExpect(status().isOk());
	    
	    // 호출 결과 확인
	    String result = resultActions.andDo(print())
	                                 .andReturn()
	                                 .getResponse()
	                                 .getContentAsString();
	    
	    LOG.debug("│ result                                │" + result);
	    
	    Type listType = new TypeToken<List<LicensesVO>>(){}.getType();
		
		List<LicensesVO>  list=new Gson().fromJson(result, listType);
		
		assertEquals(5, list.size());
		assertNotNull(list);
		
		for (LicensesVO vo   :list) {
			LOG.debug(vo);
		}
	    
	}
	@Ignore
	@Test
	public void doUpdate() throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doUpdate()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		userDao.doDelete(user01);
	    int flag = userDao.doSave(user01);
	    assertEquals(1, flag);
	    
	    flag = licensesDao.doSave(licenses01);
	    assertEquals(1, flag);
	    
	    LicensesVO vo = licensesDao.doSelectOne(licenses01);
	    
	    vo.setRegDt("2020-02-02");
	    
	    MockHttpServletRequestBuilder  requestBuilder  =
	    		MockMvcRequestBuilders.post("/licenses/doUpdate.do")
	    		.param("email", vo.getEmail())
	    		.param("regDt", vo.getRegDt())
	    		.param("licensesSeq", vo.getLicensesSeq()+"")
	    		;
	    
		//호출        
		ResultActions resultActions=  mockMvc.perform(requestBuilder).andExpect(status().isOk());
		//호출결과
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("│ result                                │"+result);		
		
		MessageVO messageVO=new Gson().fromJson(result, MessageVO.class);
		assertEquals("1", messageVO.getMsgId());
		
	}
	
	@Ignore
	@Test
	public void doDelete()throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doDelete()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		//userDao.doDelete(user01);//날두 회원 삭제 중복방지를 위해서
	    //int flag = userDao.doSave(user01);//날두 생성
	    //assertEquals(1, flag);//성공
	    
	    //int flag = licensesDao.doSave(licenses01);//날두 6번 자격증 취득
	    
	    //assertEquals(1, flag);//성공
	    
	    LicensesVO vo = licenses01;//6번 자격증
	    
	 
  		MockHttpServletRequestBuilder  requestBuilder  =
  				MockMvcRequestBuilders.post("/licenses/doDelete.do")
	    		.param("email", vo.getEmail())
	    		.param("regDt", vo.getRegDt())
	    		.param("licensesSeq", vo.getLicensesSeq()+"")
	    		;
  		
	  	//호출        
		ResultActions resultActions=  mockMvc.perform(requestBuilder).andExpect(status().isOk());
		//호출결과
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("│ result                                │"+result);		
		MessageVO messageVO=new Gson().fromJson(result, MessageVO.class);
		LOG.debug("│ messageVO                                │"+messageVO);
		assertEquals("1", messageVO.getMsgId());
		//왜 3개가 모두 삭제되는거지??
	  		
	}
	
	@Ignore
	@Test
	public void doSave() throws Exception {
	
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSave()                                  │");		
		LOG.debug("└───────────────────────────────────────────┘");	
			
	 	userDao.doDelete(user01);//날두 지우고
 	
	    int flag = userDao.doSave(user01);//날두 만들고
	    assertEquals(1, flag);
    
    
	    //flag = licensesDao.doSave(licenses01);//날두한테 자격증 준다. 근데 왜 이게 무결성에 걸리지?
	    
	    LicensesVO vo = licenses01;
	    
	    MockHttpServletRequestBuilder  requestBuilder  =
  				MockMvcRequestBuilders.post("/licenses/doSave.do")
	    		.param("email", vo.getEmail())
	    		.param("regDt", vo.getRegDt())
	    		.param("licensesSeq", vo.getLicensesSeq()+"")
	    		;
	    
	    //assertEquals(1, flag);
		    
	    // 호출
		ResultActions resultActions = mockMvc.perform(requestBuilder).andExpect(status().isOk());
		// 호출결과
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("│ result                                │" + result);
		MessageVO messageVO = new Gson().fromJson(result, MessageVO.class);
		LOG.debug("│ messageVO                                │" + messageVO);
		assertEquals("1", messageVO.getMsgId());
		    
		
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