package com.pcwk.ehr.reply;

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
import org.springframework.test.context.web.WebAppConfiguration;

import com.pcwk.ehr.board.dao.BoardDao;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.reply.dao.ReplyDao;
import com.pcwk.ehr.reply.domain.ReplyVO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ReplyDaoJunitTest implements PcwkLogger {

	@Autowired
	ReplyDao  dao;   
	
	@Autowired
	BoardDao  boardDao;
	
	BoardVO board01;
	
	ReplyVO reply01;
	ReplyVO reply02;
	ReplyVO reply03;
	
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ setUp                             │");
		LOG.debug("└───────────────────────────────────┘");		
		
		board01 = new BoardVO(boardDao.getBoardSeq(), "10", "제목99", "내용99", 0, "사용X", "pcwk99", "사용X", "pcwk99","");
		//게시순번
		long boardSeq = board01.getSeq();
		
		reply01 = new ReplyVO( Long.parseLong(dao.getReplySeq()+""), boardSeq, "댓글내용-01", "사용X", "pcwk99", "사용X");
		reply02 = new ReplyVO( Long.parseLong(dao.getReplySeq()+""), boardSeq, "댓글내용-02", "사용X", "pcwk99", "사용X");
		reply03 = new ReplyVO( Long.parseLong(dao.getReplySeq()+""), boardSeq, "댓글내용-03", "사용X", "pcwk99", "사용X");
		
	}
	
	@Test
	public void addAndGet() throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ addAndGet                         │");
		LOG.debug("└───────────────────────────────────┘");
		
		//board등록 하고
		boardDao.doDelete(board01);//게시글 삭제
		
		int flag = boardDao.doSave(board01);
		
		//1. 삭제
		//2. 등록
		//3. 데이터 조회
		//4. 조회데이터 비교
		
		//1.?050278403271
		dao.doDelete(reply01);
		dao.doDelete(reply02);
		dao.doDelete(reply03);
		
		
		//2.
		flag = dao.doSave(reply01);
		assertEquals(1, flag);
		
		flag = dao.doSave(reply02);
		assertEquals(1, flag);
		
		flag = dao.doSave(reply03);
		assertEquals(1, flag);
		
		//3.
		ReplyVO vo01 = dao.doSelectOne(reply01);
		
		
		//4. 비교
		isSameReply(vo01,reply01);
	}  
	
	private void isSameReply(ReplyVO vo01, ReplyVO reply01) {
		assertEquals(vo01.getReplySeq(), reply01.getReplySeq());
		assertEquals(vo01.getBoardSeq(), reply01.getBoardSeq());
		assertEquals(vo01.getReply(), reply01.getReply());
		assertEquals(vo01.getRegId(), reply01.getRegId());		
	}
	
	@Ignore
	@Test
	public void doSave() throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSave                            │");
		LOG.debug("└───────────────────────────────────┘");				
		//board등록 하고
		boardDao.doDelete(board01);//게시글 삭제
		
		int flag = boardDao.doSave(board01);
		assertEquals(1, flag);
		
		
		//댓글 등록----------------------------------
		//댓글 삭제, 등록
		dao.doDelete(reply01);
		
		flag = dao.doSave(reply01);
		assertEquals(1, flag);
		
		
	}
	
	@Ignore
	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ beans                             │");
		LOG.debug("│ dao                               │"+dao);
		LOG.debug("│ boardDao                          │"+boardDao);
		LOG.debug("└───────────────────────────────────┘");				
		assertNotNull(dao);
		assertNotNull(boardDao);
	}

}
