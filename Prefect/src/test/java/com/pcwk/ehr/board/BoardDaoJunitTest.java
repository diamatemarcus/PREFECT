package com.pcwk.ehr.board;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

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

import com.pcwk.ehr.board.dao.BoardDao;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class BoardDaoJunitTest implements PcwkLogger {

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
		String div   = "10";
		String title = "p99";//p99-01
		String contents = "내용 99-01";
		int    readCnt  = 0;
		String regDt    = "사용 하지 않음";
		String regId    = "p99";
		String modDt    = "사용 하지 않음";
		String modId    = "p99";
		board01 = new BoardVO(dao.getBoardSeq(), div, title+"-01 제목", contents+"-01", readCnt,   regDt, regId, modDt, modId);
		board02 = new BoardVO(dao.getBoardSeq(), div, title+"-02 제목", contents+"-02", readCnt+1, regDt, regId, modDt, modId);
		board03 = new BoardVO(dao.getBoardSeq(), div, title+"-03 제목", contents+"-03", readCnt+2, regDt, regId, modDt, modId);
		
		searchVO = new BoardVO();
		searchVO.setTitle(title);
		
	}

	@Test
	public void updateReadCnt() throws SQLException {
		//1.
		dao.doDeleteAll(searchVO);
		//2.
		int flag = dao.doSave(board01);
		assertEquals(1, flag);
		
		flag = dao.doSave(board02);
		assertEquals(1, flag);	
		
		flag = dao.doSave(board03);
		assertEquals(1, flag);	
		
		//3.단건조회
		//최초 등록자와 id가 동일하면 update 않됨
		board01.setRegId(board01.getRegId()+"U");
		flag = dao.updateReadCnt(board01);
		assertEquals(1, flag);
		BoardVO vs01 = dao.doSelectOne(board01);
		
		assertEquals(vs01.getSeq(), board01.getSeq());
		assertEquals(vs01.getReadCnt(), board01.getReadCnt()+1);
	}
	
	@Test
	public void doRetrieve() throws SQLException {
		//searchVO.setSearchDiv("10");//제목으로 검색
		//searchVO.setSearchWord(searchVO.getTitle());
		
		searchVO.setPageNo(1);
		searchVO.setPageSize(10);
		//1.
		dao.doDeleteAll(searchVO);
		//2.
		int flag = dao.doSave(board01);
		assertEquals(1, flag);
		
		flag = dao.doSave(board02);
		assertEquals(1, flag);	
		
		flag = dao.doSave(board03);
		assertEquals(1, flag);	
		
		List<BoardVO> list=dao.doRetrieve(searchVO);
		
		for(BoardVO vo :list) {
			LOG.debug(vo);
		}
	}
	
	@Test
	public void update() throws SQLException {
		//1. 데이터 삭제
		//2. 데이터 등록
		//3. 등록데이터 조회
		//4. 3번 조회된 데이터를 수정
		//5. update
		//6. 수정데이터 조회
		//7. 비교
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ update                            │");
		LOG.debug("└───────────────────────────────────┘");
		
		//1.
		dao.doDeleteAll(searchVO);
		//2.
		int flag = dao.doSave(board01);
		assertEquals(1, flag);
		
		flag = dao.doSave(board02);
		assertEquals(1, flag);	
		
		flag = dao.doSave(board03);
		assertEquals(1, flag);		
		
		//3.
		BoardVO vo01 =dao.doSelectOne(board01);
		String div   = "20";
		String title = vo01.getTitle()+"_U";
		String contents = vo01.getContents()+"_U";
		String modId    = vo01.getModId()+"_U";
		
		//4.
		vo01.setDiv(div);
		vo01.setTitle(title);
		vo01.setContents(contents);
		vo01.setModId(modId);
		
		//5.
		flag = dao.doUpdate(vo01);
		assertEquals(1, flag);
		
		//6. 
		BoardVO vs01=dao.doSelectOne(vo01);
		isSameBoard(vs01, vo01);
	}
	
	@Test
	public void addAndGet()throws SQLException{
		//1. 삭제
		//2. 등록
		//3. 단건조회
		
		//1.
		dao.doDelete(board01);
		dao.doDelete(board02);
		dao.doDelete(board03);
		
		LOG.debug("board01.getSeq():"+board01.getSeq());
		LOG.debug("board02.getSeq():"+board02.getSeq());
		LOG.debug("board03.getSeq():"+board03.getSeq());
		
		//2.
		int flag = dao.doSave(board01);
		assertEquals(1, flag);
		
		flag = dao.doSave(board02);
		assertEquals(1, flag);
		
		flag = dao.doSave(board03);
		assertEquals(1, flag);		
		
		//3.
		BoardVO vo01 = dao.doSelectOne(board01);
		BoardVO vo02 = dao.doSelectOne(board02);
		BoardVO vo03 = dao.doSelectOne(board03);
		
		isSameBoard(vo01, board01);
		isSameBoard(vo02, board02);
		isSameBoard(vo03, board03);
	}
	
	private void isSameBoard(BoardVO vo, BoardVO board) {
		assertEquals(vo.getSeq(), board.getSeq());
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
		//assertNotNull(board01);
	}

}











