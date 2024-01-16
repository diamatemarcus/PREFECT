package com.pcwk.ehr;

import static com.pcwk.ehr.user.service.UserServiceImpl.MIN_LOGIN_COUNT_FOR_SILVER;
import static com.pcwk.ehr.user.service.UserServiceImpl.MIN_RECOMEND_COUNT_FOR_GOLD;
import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
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
import com.pcwk.ehr.user.domain.Level;
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
				 new UserVO("p99-01", "이상무99-01", "4321_1",Level.BASIC,  MIN_LOGIN_COUNT_FOR_SILVER-1,0,                            "jamesol@paran.com","사용하지 않음")
				,new UserVO("p99-02", "이상무99-02", "4321_2",Level.BASIC,  MIN_LOGIN_COUNT_FOR_SILVER  ,2,                            "jamesol@paran.com","사용하지 않음")  //O
				,new UserVO("p99-03", "이상무99-03", "4321_3",Level.SILVER, MIN_LOGIN_COUNT_FOR_SILVER+1,MIN_RECOMEND_COUNT_FOR_GOLD-1,"jamesol@paran.com","사용하지 않음")
				,new UserVO("p99-04", "이상무99-04", "4321_4",Level.SILVER, MIN_LOGIN_COUNT_FOR_SILVER+2,MIN_RECOMEND_COUNT_FOR_GOLD,  "jamesol@paran.com","사용하지 않음") //O
				,new UserVO("p99-05", "이상무99-05", "4321_5",Level.GOLD,   MIN_LOGIN_COUNT_FOR_SILVER+5,MIN_RECOMEND_COUNT_FOR_GOLD+5,"jamesol@paran.com","사용하지 않음") 
			);
			
		searchVO = new UserVO();
		searchVO.setUserId("p99");
			
	}
	
	
	public UserVO doSelectOne(UserVO  inVO) throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSelectOne()                             │");		
		LOG.debug("└───────────────────────────────────────────┘");		
		
		//UserVO  inVO = users.get(0);
		//url + 호출방식(get) + param(userId)
		MockHttpServletRequestBuilder  requestBuilder = 
				MockMvcRequestBuilders.get("/user/doSelectOne.do")
				.param("userId",        inVO.getUserId());	
		
		ResultActions resultActions=this.mockMvc.perform(requestBuilder).andExpect(status().isOk());
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ result                                    │"+result);		
		LOG.debug("└───────────────────────────────────────────┘");		
		
		UserVO outVO = new Gson().fromJson(result, UserVO.class);
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ outVO                                     │"+outVO);		
		LOG.debug("└───────────────────────────────────────────┘");				
		assertNotNull(outVO);
		
		return outVO;
		
	}
	
	@Test
	public void doUpdate() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doUpdate                                  │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		UserVO inVO = users.get(0);
		String upStr = "_U";
		int upNum    = 100;
		MockHttpServletRequestBuilder  requestBuilder = 
                MockMvcRequestBuilders.post("/user/doUpdate.do")
               .param("userId",        inVO.getUserId())
               .param("name",          inVO.getName()+upStr)
               .param("password",      inVO.getPassword()+upStr)
               .param("levelIntValue", (inVO.getLevelIntValue())+"")
               .param("login",         (inVO.getLogin()        +upNum)+"")
               .param("recommend",     (inVO.getRecommend()    +upNum)+"")
               .param("email",         inVO.getEmail()+upStr);		
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
	
	@Ignore
	@Test
	public void addAndGet() throws Exception {
		// 1. 데이터 삭제
		// 2. 등록
		// 3. 한건조회  		
		
		//1.
		doDelete(users.get(0));
		doDelete(users.get(1));
		doDelete(users.get(2));
		doDelete(users.get(3));
		doDelete(users.get(4));
		
		// 2. 
		doSave(users.get(0));
		doSave(users.get(1));
		doSave(users.get(2));
		doSave(users.get(3));
		doSave(users.get(4));
		
		
		isSameUser(users.get(0), doSelectOne(users.get(0)));
		isSameUser(users.get(1), doSelectOne(users.get(1)));
		isSameUser(users.get(2), doSelectOne(users.get(2)));
		isSameUser(users.get(3), doSelectOne(users.get(3)));
		isSameUser(users.get(4), doSelectOne(users.get(4)));
	}
	
	private void isSameUser(UserVO userVO, UserVO outVO) {
		assertEquals(userVO.getUserId(), outVO.getUserId());
		assertEquals(userVO.getName(), outVO.getName());
		assertEquals(userVO.getPassword(), outVO.getPassword());
		
		assertEquals(userVO.getLevel(), outVO.getLevel());//등급
		assertEquals(userVO.getLogin(), outVO.getLogin());//로그인 횟수
		assertEquals(userVO.getRecommend(), outVO.getRecommend());//추천수
		assertEquals(userVO.getEmail(), outVO.getEmail());//email

	}
	
	
	public void doDelete(UserVO  inVO) throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doDelete()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");
		//UserVO  inVO = users.get(0);
		//url + 호출방식(get) + param(userId)
		MockHttpServletRequestBuilder  requestBuilder = 
				MockMvcRequestBuilders.get("/user/doDelete.do")
				.param("userId",        inVO.getUserId());
		
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
				                .param("userId",        inVO.getUserId())
				                .param("name",          inVO.getName())
				                .param("password",      inVO.getPassword())
				                .param("levelIntValue", inVO.getLevelIntValue()+"")
				                .param("login",         inVO.getLogin()        +"")
				                .param("recommend",     inVO.getRecommend()    +"")
				                .param("email",         inVO.getEmail());
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
