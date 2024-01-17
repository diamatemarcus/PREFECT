package com.pcwk.ehr.board;

import static org.junit.Assert.*;

import java.sql.SQLException;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.board.dao.BoardDao;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class BoardDaoJunitTest implements PcwkLogger{
	@Autowired
	BoardDao dao;
	
	BoardVO  board01;
	BoardVO  board02;
	BoardVO  board03;
	
	BoardVO  searchVO;
	
	@Autowired  //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;	

	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ setUp                             │");
		LOG.debug("└───────────────────────────────────┘");
		
		String email = "thdals5123@naver.com";
		String div ="10";
		String title = "바보당";
		String contents = "바보아니예여";
		int readCnt = 100;
		String regDt = "사용하지않음";
		String regId = "이한나";
		String modDt = "사용하지않음";
		String modId = "고송민";
		
		board01 = new BoardVO(dao.getBoardSeq(),email, div, title+"1", contents+"1", readCnt,regDt,regId, modDt, modId);
//		board02 = new BoardVO(dao.getBoardSeq(),email, div, title+"2", contents+"2", readCnt,regDt,regId, modDt, modId);
//		board03 = new BoardVO(dao.getBoardSeq(),email, div, title+"3", contents+"3", readCnt,regDt,regId, modDt, modId);
	}
	
	@Test
	public void addAndGet()throws SQLException{
		//1. 삭제
		//2. 등록
		//3. 단건조회
		
		//1.
		dao.doDelete(board01);
//		dao.doDelete(board02);
//		dao.doDelete(board03);
		
		LOG.debug("board01.getSeq():"+board01.getSeq());
//		LOG.debug("board02.getSeq():"+board02.getSeq());
//		LOG.debug("board03.getSeq():"+board03.getSeq());
		
		//2.
		int flag = dao.doSave(board01);
		assertEquals(1, flag);
		
//		flag = dao.doSave(board02);
//		assertEquals(1, flag);
//		
//		flag = dao.doSave(board03);
//		assertEquals(1, flag);		
		
		//3.
		BoardVO vo01 = dao.doSelectOne(board01);
//		BoardVO vo02 = dao.doSelectOne(board02);
//		BoardVO vo03 = dao.doSelectOne(board03);
		
		isSameBoard(vo01, board01);
//		isSameBoard(vo02, board02);
//		isSameBoard(vo03, board03);
	}
	
	private void isSameBoard(BoardVO vo, BoardVO board) {
		assertEquals(vo.getSeq(), board.getSeq());
		assertEquals(vo.getEmail(), board.getEmail());
		assertEquals(vo.getDiv(), board.getDiv());
		assertEquals(vo.getTitle(), board.getTitle());
		assertEquals(vo.getContents(), board.getContents());
		assertEquals(vo.getReadCnt(), board.getReadCnt());
		assertEquals(vo.getRegId(), board.getRegId());
		assertEquals(vo.getModId(), board.getModId());
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
