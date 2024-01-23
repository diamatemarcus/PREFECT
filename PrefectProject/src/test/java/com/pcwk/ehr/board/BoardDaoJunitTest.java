package com.pcwk.ehr.board;

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

import com.pcwk.ehr.board.dao.BoardDao;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;

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
		
		String div ="20";
		String title = "testTitle";
		String contents = "testContents";
		int readCnt = 0;
		String regDt = "사용하지않음";
		String regId = "lm10@gmail.com";
		String modDt = "사용하지않음";
		String modId = "lm10@gmail.com";
		
		StringUtil uuid = new StringUtil();
		
		board01 = new BoardVO(dao.getBoardSeq(), div, title+"1", contents+"1", readCnt,regDt,regId, modDt, modId, uuid.getUUID());
		board02 = new BoardVO(dao.getBoardSeq(), div, title+"2", contents+"2", readCnt,regDt,regId, modDt, modId, uuid.getUUID());
		board03 = new BoardVO(dao.getBoardSeq(), div, title+"3", contents+"3", readCnt,regDt,regId, modDt, modId, uuid.getUUID());
		
		searchVO = new BoardVO();
		searchVO.setTitle(title);
	}
	
	@Ignore
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
		//최초 등록자와 id가 동일하면 update 안 됨
		board01.setRegId(board01.getRegId()+"U");
		flag = dao.updateReadCnt(board01);
		assertEquals(1, flag);
		BoardVO vs01 = dao.doSelectOne(board01);
		
		assertEquals(vs01.getSeq(), board01.getSeq());
		assertEquals(vs01.getReadCnt(), board01.getReadCnt()+1);
	}
	
	@Ignore
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
	
	@Ignore
	@Test
	public void update() throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ update                            │");
		LOG.debug("└───────────────────────────────────┘");
		
		//1. 데이터 삭제
		dao.doDeleteAll(searchVO);
		
		//2. 데이터 등록
		//3. 등록데이터 조회
		int flag = dao.doSave(board01);
		assertEquals(1, flag);
		
		flag = dao.doSave(board02);
		assertEquals(1, flag);	
		
		flag = dao.doSave(board03);
		assertEquals(1, flag);		
		
		//4. 3번 조회된 데이터를 수정
		BoardVO vo01 =dao.doSelectOne(board01);
		String div   = "20";
		String title = vo01.getTitle()+"_U";
		String contents = vo01.getContents()+"_U";
		String modId    = vo01.getModId()+"_U";
		
		vo01.setDiv(div);
		vo01.setTitle(title);
		vo01.setContents(contents);
		vo01.setModId(modId);
		
		//5. update
		flag = dao.doUpdate(vo01);
		assertEquals(1, flag);
		
		//6. 수정데이터 조회
		BoardVO vs01=dao.doSelectOne(vo01);
		
		//7. 비교
		isSameBoard(vs01, vo01);
	}
	
	@Ignore
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
		assertEquals(vo.getUuid(), board.getUuid());
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
