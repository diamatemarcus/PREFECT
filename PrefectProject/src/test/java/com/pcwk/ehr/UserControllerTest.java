package com.pcwk.ehr;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Arrays;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.user.domain.UserVO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정

@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)

public class UserControllerTest {
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	WebApplicationContext webApplicationContext;
	
	@Autowired
	ApplicationContext context;
	
	//브라우저 대역
	MockMvc  mockMvc;
	
	List<UserVO> users;
	UserVO searchVO;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ setUp()                                   │");		
		LOG.debug("└───────────────────────────────────────────┘");	
		
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		
		users = Arrays.asList(
				 new UserVO("CR7@gmail.com", "호날두", "7777", 01077777777 ,"초졸","1"));
			
		searchVO = new UserVO();
		searchVO.setEmail("CR7@gmail.com");
			
	}
	
	
	public UserVO doSelectOne(UserVO  inVO) throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSelectOne()                             │");		
		LOG.debug("└───────────────────────────────────────────┘");		
		
		inVO = users.get(0);

		MockHttpServletRequestBuilder  requestBuilder = 
				MockMvcRequestBuilders.get("/user/doSelectOne.do")
				.param("email",        inVO.getEmail())
				.param("name",          inVO.getName())
				.param("password",      inVO.getPassword())
				.param("tel",           String.valueOf(inVO.getTel()))
				.param("edu",           inVO.getEdu())
				.param("role",          inVO.getRole());		
		
		//ResultActions resultActions = this.mockMvc.perform(requestBuilder).andExpect(status().isOk());
		
	
		
		//String result = resultActions.andReturn().getResponse().getContentAsString();
	//ResultActions resultActions=this.mockMvc.perform(requestBuilder).andExpect(status().isOk());
		
		
		//호출 : ModelAndView      
		MvcResult mvcResult=  mockMvc.perform(requestBuilder).andExpect(status().isOk()).andReturn() ;
		//호출결과
		ModelAndView modelAndView = mvcResult.getModelAndView();
		UserVO outVO = (UserVO) modelAndView.getModel().get("outVO");
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ outVO                                     │"+outVO);		
		LOG.debug("└───────────────────────────────────────────┘");				
		assertNotNull(outVO);
		
	
		return outVO;
		
	}
	@Ignore
	@Test
	public void doUpdate() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doUpdate                                  │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		UserVO inVO = users.get(0);
		String upStr = "_U";
		MockHttpServletRequestBuilder  requestBuilder = 
                MockMvcRequestBuilders.post("/user/doUpdate.do")
               .param("email",         inVO.getEmail())
               .param("name",          inVO.getName()+upStr)
               .param("password",      inVO.getPassword()+upStr)
               .param("tel",           inVO.getTel()+"")
               .param("edu",           inVO.getEdu()+upStr)
               .param("role",          inVO.getRole()+"");		
		ResultActions resultActions=this.mockMvc.perform(requestBuilder).andExpect(status().isOk());
		
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ result                                    │"+result);		
		LOG.debug("└───────────────────────────────────────────┘");			
		
		MessageVO messageVO = new Gson().fromJson(result, MessageVO.class);
		assertEquals(String.valueOf(1), messageVO.getMsgId());
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ messageVO                                 │"+messageVO);		
		LOG.debug("└───────────────────────────────────────────┘");					
		
	}

	@Test
	public void addAndGet() throws Exception {
		// 1. 데이터 삭제
		// 2. 등록
		// 3. 한건조회  		
		
		//1.
		doDelete(users.get(0));

		
		// 2. 
		doSave(users.get(0));

		
		
		isSameUser(users.get(0), doSelectOne(users.get(0)));

	}
	
	
	private void isSameUser(UserVO userVO, UserVO outVO) {
	
		
		assertEquals(userVO.getEmail(), outVO.getEmail());
		assertEquals(userVO.getName(), outVO.getName());
		assertEquals(userVO.getPassword(), outVO.getPassword());
		assertEquals(String.valueOf(userVO.getTel()), String.valueOf(outVO.getTel()));
		assertEquals(userVO.getEdu(), outVO.getEdu());
		assertEquals(userVO.getRole(), outVO.getRole());
	

	}
	

	public void doDelete(UserVO  inVO) throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doDelete()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");
		//UserVO  inVO = users.get(0);
		//url + 호출방식(get) + param(Email)
		MockHttpServletRequestBuilder  requestBuilder = 
				MockMvcRequestBuilders.get("/user/doDelete.do")
				.param("Email",        inVO.getEmail());
		
		ResultActions resultActions=this.mockMvc.perform(requestBuilder).andExpect(status().isOk());
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ result                                    │"+result);		
		LOG.debug("└───────────────────────────────────────────┘");				
		
		MessageVO messageVO = new Gson().fromJson(result, MessageVO.class);
		//assertEquals(String.valueOf(1), messageVO.getMsgId());
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ messageVO                                 │"+messageVO);		
		LOG.debug("└───────────────────────────────────────────┘");			
	}
	
	
	public void doSave(UserVO  inVO) throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSave()                                  │");		
		LOG.debug("└───────────────────────────────────────────┘");			
		
		//MockMvcRequestBuilders : param 데이터 저장
		//MockMvc: 호출
		//UserVO  inVO = users.get(0);
		
  
		
		
		
		MockHttpServletRequestBuilder  requestBuilder = 
				                 MockMvcRequestBuilders.post("/user/doSave.do")
				                .param("email",       	inVO.getEmail())
				                .param("name",          inVO.getName())
				                .param("password",      inVO.getPassword())
				                .param("tel", 			inVO.getTel()+"")
				                .param("edu",        	inVO.getEdu())
				                .param("role",       	inVO.getRole());
		ResultActions resultActions=this.mockMvc.perform(requestBuilder).andExpect(status().isOk());
		
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ result                                    │"+result);		
		LOG.debug("└───────────────────────────────────────────┘");			
		
		MessageVO messageVO = new Gson().fromJson(result, MessageVO.class);
		assertEquals(String.valueOf(1), messageVO.getMsgId());
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ messageVO                                 │"+messageVO);		
		LOG.debug("└───────────────────────────────────────────┘");			
	}
	
	
	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ beans()                                   │");
		LOG.debug("│ webApplicationContext                     │"+webApplicationContext);
		LOG.debug("│ mockMvc                                   │"+mockMvc);
		LOG.debug("└───────────────────────────────────────────┘");		
		
		assertNotNull(mockMvc);
		assertNotNull(webApplicationContext);
		
	}

}
