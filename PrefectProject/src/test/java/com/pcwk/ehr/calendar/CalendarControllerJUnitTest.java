package com.pcwk.ehr.calendar;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.calendar.domain.WeekVO;
import com.pcwk.ehr.cmn.PcwkLogger;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정

@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)

public class CalendarControllerJUnitTest implements PcwkLogger{

	@Autowired
	WebApplicationContext webApplicationContext;
	
	//브라우저 대역
	MockMvc  mockMvc;
	
	CalendarVO calendarVO01;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ setUp()                                   │");		
		LOG.debug("└───────────────────────────────────────────┘");	
		
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		
		calendarVO01 = new CalendarVO ();
		calendarVO01.setMonth("02");
			
	}
	
	@Test
	public void doRetrieveCalendar() throws Exception{
		//검색
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doRetrieveCalendar()                      │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.get("/calendar/doRetrieveCalendar.do")
				.param("month",   calendarVO01.getMonth())
				;		
		
		//호출 : ModelAndView      
		MvcResult mvcResult=  mockMvc.perform(requestBuilder).andExpect(status().isOk()).andReturn() ;
		//호출결과
		ModelAndView modelAndView = mvcResult.getModelAndView();
		List<WeekVO>  list  = (List<WeekVO>) modelAndView.getModel().get("calendarList");
		String month = (String) modelAndView.getModel().get("month");

		for(WeekVO vo  :list) {
			LOG.debug(vo);
		}
		
		LOG.debug(month);
		
		assertNotNull(list);
		
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
