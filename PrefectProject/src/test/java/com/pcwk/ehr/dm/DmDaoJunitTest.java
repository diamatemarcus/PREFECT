package com.pcwk.ehr.dm;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.List;

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

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.dm.dao.DmDao;
import com.pcwk.ehr.dm.domain.DmVO;
@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class DmDaoJunitTest implements PcwkLogger{
	@Autowired
	DmDao dao;
	
	DmVO dm;
	DmVO searchVO;
	@Autowired  //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;	
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ setUp                             │");
		LOG.debug("└───────────────────────────────────┘");
		
		int seq =0;
		int room =1;
		String sender ="gyu";
		String receiver ="seo";
		String contents= "test123";
		String sendDt= "사용하지않음";
		String readDt= "사용하지않음";
		int readChk= 0;
		String senderName="";
	    String receiverName="";
		
		dm = new DmVO(seq,room,sender,receiver,contents,sendDt,sendDt,readChk,senderName,receiverName);
		searchVO = new DmVO();
		searchVO.setRoom(1);
		
	}
	//@Ignore
	@Test
	public void doSend() throws SQLException{
		dao.doSend(dm);
	}
	
	
	@Test
	public void contentsList() throws SQLException {
		
        List<DmVO> list=dao.contentsList(searchVO);
		
        dao.updateReadChk(dm);
	}
	
	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ beans                             │");
		LOG.debug("│ dao                               │"+dao);
		LOG.debug("│ context                           │"+context);
		LOG.debug("└───────────────────────────────────┘");
		
		assertNotNull(dao);
		assertNotNull(context);
	}

}
