package com.pcwk.ehr.calendar;

import static org.junit.Assert.*;

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

import com.pcwk.ehr.calendar.dao.CalendarDao;
import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.schedule.domain.ScheduleVO;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class CalendarDaoJUnitTest implements PcwkLogger{

	@Autowired  //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;
	
	@Autowired
	CalendarDao dao;
	
	CalendarVO calendarVO01;
	
	@Before
	public void setUp() throws Exception {

		calendarVO01 = new CalendarVO ();
		calendarVO01.setMonth("02");
	}
	
	@Test
	public void getCalendar() throws SQLException {
		List<CalendarVO> outVO01 = dao.doSelectMonth(calendarVO01);
		assertNotNull(outVO01);// Not Null이면 true
		
		// 데이터 동일 테스트
		//isSameCalendar(calendarVO01, outVO01);
	}
	
//	private void isSameCalendar(CalendarVO calendarVO, List<CalendarVO> outVO01) {
//		
//		assertEquals(calendarVO.getCalID(), outVO01.getCalID());
//		assertEquals(calendarVO.getYear(), outVO01.getYear());
//		assertEquals(calendarVO.getDay(), outVO01.getDay());
//		assertEquals(calendarVO.getDayOfWeek(), outVO01.getDayOfWeek());
//		assertEquals(calendarVO.getWeekNo(), outVO01.getWeekNo());
//
//	}
	
	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ beans                     				   │");		
		LOG.debug("│ context                                   │"+context);
		LOG.debug("│ dao                                       │"+dao);
		LOG.debug("└───────────────────────────────────────────┘");				
		assertNotNull(context);
		assertNotNull(dao);

	}

}
