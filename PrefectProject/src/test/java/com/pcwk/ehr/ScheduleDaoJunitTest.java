package com.pcwk.ehr;

import static org.junit.Assert.*;

import java.sql.SQLException;

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

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.schedule.dao.ScheduleDao;
import com.pcwk.ehr.schedule.domain.ScheduleVO;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ScheduleDaoJunitTest implements PcwkLogger{

	@Autowired  //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;
	
	@Autowired
	ScheduleDao dao;
	
	// 등록
	ScheduleVO scheduleVO01;
	ScheduleVO searchVO;
	
	@Before
	public void setUp() throws Exception {

		// 등록
		scheduleVO01 = new ScheduleVO(1, 1, "일정", "일정입니다");
		
	
		searchVO = new ScheduleVO();
		searchVO.setScheduleID(2);

	
	}
	
	@Test
	public void update() throws SQLException {
		//1.데이터 삭제
		//2.데이터 입력
		//3.등록데이터 조회
		//4.3번 조회된 데이터를 수정
		//5.update
		//6.수정데이터 조회
		//7.비교
		
		LOG.debug("====================");
		LOG.debug("=update()=");
		LOG.debug("====================");		
		
		//1.
		dao.doDelete(scheduleVO01);
		assertEquals(0, dao.getCount(searchVO));
		
		//2.
		dao.doSave(scheduleVO01);
		assertEquals(1, dao.getCount(searchVO));

		//3.
		ScheduleVO getVO = dao.doSelectOne(scheduleVO01);
		isSameSchedule(getVO, scheduleVO01);
		
		//4
		String upStr = "_수정";
		int    upInt = 10;
		
		getVO.setCalID(getVO.getCalID()+upInt);
		getVO.setTitle(getVO.getTitle()+upStr);
		getVO.setExplanation(getVO.getExplanation()+upStr);
		
		//5.update
		int flag = dao.doUpdate(getVO);
		assertEquals(1, flag);
		
		//6.
		ScheduleVO vsVO = dao.doSelectOne(getVO);
		
		//7.
		isSameSchedule(vsVO, getVO);
		
		
	}
	
	@Ignore
	@Test // long 1/1000초
	public void addAndGet() throws SQLException {
		// 1. 데이터 삭제
		// 2. 등록
		// 3. 한건조회  

		// 1.
		dao.doDelete(scheduleVO01);
		assertEquals(dao.getCount(searchVO), 0);
		
		// 2.
		int flag = dao.doSave(scheduleVO01);
		int count = dao.getCount(searchVO);
		assertEquals(flag, 1);
		assertEquals(count, 1);

		ScheduleVO outVO01 = dao.doSelectOne(scheduleVO01);
		assertNotNull(outVO01);// Not Null이면 true

		// 데이터 동일 테스트
		isSameSchedule(scheduleVO01, outVO01);
	}
	
	private void isSameSchedule(ScheduleVO scheduleVO, ScheduleVO outVO) {
		
		assertEquals(scheduleVO.getScheduleID(), outVO.getScheduleID());
		assertEquals(scheduleVO.getCalID(), outVO.getCalID());
		assertEquals(scheduleVO.getTitle(), outVO.getTitle());
		assertEquals(scheduleVO.getExplanation(), outVO.getExplanation());

	}
	
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
