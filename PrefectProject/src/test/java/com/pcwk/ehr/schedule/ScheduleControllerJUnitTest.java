package com.pcwk.ehr.schedule;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Arrays;
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
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.schedule.domain.ScheduleVO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정

@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)

public class ScheduleControllerJUnitTest implements PcwkLogger{

	@Autowired
	WebApplicationContext webApplicationContext;
	
	//브라우저 대역
	MockMvc  mockMvc;
	
	List<ScheduleVO> schedules;
	ScheduleVO searchVO;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ setUp()                                   │");		
		LOG.debug("└───────────────────────────────────────────┘");	
		
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		
		schedules = Arrays.asList(
				new ScheduleVO(1, 1, "일정", "일정입니다")
				,new ScheduleVO(2, 1, "일정1", "일정입니다1")
			);
			
		searchVO = new ScheduleVO();
		searchVO.setScheduleID(3);
			
	}
		
	public ScheduleVO doSelectOne(ScheduleVO inVO) throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSelectOne()                             │");		
		LOG.debug("└───────────────────────────────────────────┘");		
		
		//UserVO  inVO = users.get(0);
		//url + 호출방식(get) + param(Email)
		MockHttpServletRequestBuilder  requestBuilder = 
				MockMvcRequestBuilders.get("/schedule/doSelectOne.do")
				.param("scheduleID",        inVO.getScheduleID()+"");	
		

		
		MvcResult mvcResult=  mockMvc.perform(requestBuilder).andExpect(status().isOk()).andReturn() ;
		ModelAndView modelAndView = mvcResult.getModelAndView();
		ScheduleVO outVO = (ScheduleVO) modelAndView.getModel().get("outVO");
		
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
		
		ScheduleVO inVO = schedules.get(0);
		String upStr = "_U";
		int upNum    = 100;
		MockHttpServletRequestBuilder  requestBuilder = 
                MockMvcRequestBuilders.post("/schedule/doUpdate.do")
               .param("scheduleID",        inVO.getScheduleID()+"")
               .param("title",          inVO.getTitle()+upStr)
               .param("calID",      inVO.getCalID()+ upNum + "")
               .param("explanation",           inVO.getExplanation() + upStr);
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
		doDelete(schedules.get(0));
		doDelete(schedules.get(1));

		// 2. 
		doSave(schedules.get(0));
		doSave(schedules.get(1));
		
		
		isSameSchedule(schedules.get(0), doSelectOne(schedules.get(0)));
		isSameSchedule(schedules.get(1), doSelectOne(schedules.get(1)));
	}
	
	
	private void isSameSchedule(ScheduleVO scheduleVO, ScheduleVO outVO) {
		

		assertEquals(scheduleVO.getScheduleID(), outVO.getScheduleID());
		assertEquals(scheduleVO.getCalID(), outVO.getCalID());
		assertEquals(scheduleVO.getTitle(), outVO.getTitle());
		assertEquals(scheduleVO.getExplanation(), outVO.getExplanation());

	}
	

	public void doDelete(ScheduleVO  scheduleVO) throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doDelete()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");
		//UserVO  inVO = users.get(0);
		//url + 호출방식(get) + param(Email)
		MockHttpServletRequestBuilder  requestBuilder = 
				MockMvcRequestBuilders.get("/schedule/doDelete.do")
				.param("scheduleID",        scheduleVO.getScheduleID() + "");
		
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
	
	
	public void doSave(ScheduleVO  inVO) throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSave()                                  │");		
		LOG.debug("└───────────────────────────────────────────┘");			
		
		//MockMvcRequestBuilders : param 데이터 저장
		//MockMvc: 호출
		//UserVO  inVO = users.get(0);
		
		MockHttpServletRequestBuilder  requestBuilder = 
                MockMvcRequestBuilders.post("/schedule/doSave.do")
               .param("scheduleID",        inVO.getScheduleID()+"")
               .param("title",          inVO.getTitle())
               .param("calID",      inVO.getCalID()+ "")
               .param("explanation",           inVO.getExplanation());
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
