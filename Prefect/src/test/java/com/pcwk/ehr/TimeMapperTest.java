package com.pcwk.ehr;

import static org.junit.Assert.*;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.time.dao.TimeMapper;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class TimeMapperTest {
	
	final Logger LOG = LogManager.getLogger(getClass());
	@Autowired
	private TimeMapper timeMapper;
	
	@Before
	public void setUp() throws Exception {
		LOG.info("==================");
		LOG.info("=setUp()=");
		LOG.info("==================");		
	}

	@Test
	public void getPcwkDateTime() {
		LOG.info("==================");
		LOG.info("=getPcwkDateTime()=");
		LOG.info("==================");			
		
		LOG.info("timeMapper.getPcwkDateTime()==>"+timeMapper.getPcwkDateTime());		
	}
	
	@Ignore
	@Test
	public void getDateTime() {
		LOG.info("==================");
		LOG.info("=getDateTime()=");
		LOG.info("==================");			
		
		LOG.info("timeMapper.getDateTime()==>"+timeMapper.getDateTime());
	}
	
	
	@Test
	public void beans() {
		LOG.info("==================");
		LOG.info("=beans()=");
		LOG.info("=timeMapper="+timeMapper);
		LOG.info("==================");
		assertNotNull(timeMapper);
		
	}

}
