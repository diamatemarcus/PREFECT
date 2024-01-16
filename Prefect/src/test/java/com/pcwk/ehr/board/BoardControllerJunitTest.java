package com.pcwk.ehr.board;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.sql.SQLException;
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
import com.pcwk.ehr.board.dao.BoardDao;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.code.domain.CodeVO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class BoardControllerJunitTest implements PcwkLogger {

	@Autowired
	BoardDao  dao;
	
	@Autowired
	WebApplicationContext webApplicationContext;
	//브라우저 대역
	MockMvc  mockMvc;
	List<BoardVO>  boardList;
	BoardVO   searchVO;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ setUp()                                   │");		
		LOG.debug("└───────────────────────────────────────────┘");	
		String div   = "10";
		String title = "p99";//p99-01
		String contents = "내용 99-01";
		int    readCnt  = 0;
		String regDt    = "사용 하지 않음";
		String regId    = "p99";
		String modDt    = "사용 하지 않음";
		String modId    = "p99";
		
		mockMvc  = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		boardList = Arrays.asList(
				 new BoardVO(dao.getBoardSeq(), div, title+"-01 제목", contents+"-01", readCnt,   regDt, regId, modDt, modId)
				,new BoardVO(dao.getBoardSeq(), div, title+"-02 제목", contents+"-02", readCnt+1, regDt, regId, modDt, modId)
				,new BoardVO(dao.getBoardSeq(), div, title+"-03 제목", contents+"-03", readCnt+2, regDt, regId, modDt, modId)
		);
		
		searchVO = new BoardVO();
		searchVO.setTitle(title);
		
	}
	
	@Test
	public void doRetrieve() throws Exception{
		//검색
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doRetrieve()                              │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.get("/board/doRetrieve.do")
				.param("pageSize",   "0")
				.param("pageNo",     "0")
				.param("searchDiv",  "")
				.param("searchWord", "")
				;		
		
		//호출 : ModelAndView      
		MvcResult mvcResult=  mockMvc.perform(requestBuilder).andExpect(status().isOk()).andReturn() ;
		//호출결과
		ModelAndView modelAndView = mvcResult.getModelAndView();
		List<BoardVO>  list  = (List<BoardVO>) modelAndView.getModel().get("list");
		BoardVO  paramVO  = (BoardVO) modelAndView.getModel().get("vo");
		
		
		List<CodeVO> boardSearchList=(List<CodeVO>) modelAndView.getModel().get("boardSearch");
		List<CodeVO> pageSizeList=(List<CodeVO>) modelAndView.getModel().get("pageSize");
		
		for(BoardVO vo  :list) {
			LOG.debug(vo);
		}
		
		assertNotNull(boardSearchList);
		assertNotNull(pageSizeList);
		assertNotNull(list);
		assertNotNull(paramVO);
		
	}

	@Ignore
	@Test
	public void doUpdate() throws Exception{
		//1.데이터 입력
		//2.등록데이터 조회
		//3.3번 조회된 데이터를 수정
		//4.update
		//5.수정데이터 조회
		//6.데이터 비교
		
		BoardVO board01 = boardList.get(0);
		//1.
		int flag = dao.doSave(board01);
		assertEquals(1, flag);
		
		//2.
		BoardVO vo = dao.doSelectOne(board01);
		
		//3.
		String upStr = "_U";
		vo.setDiv("20");
		vo.setTitle(vo.getTitle()+upStr);
		vo.setContents(vo.getContents()+upStr);
		vo.setModId(vo.getModId()+upStr);
		
		
		//4. url, param, method(get/post)
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.post("/board/doUpdate.do")
				.param("seq",     vo.getSeq()+"")
				.param("div",     vo.getDiv())
				.param("title",   vo.getTitle())
				.param("contents",vo.getContents())
				.param("modId",   vo.getModId())
				;
		//호출        
		ResultActions resultActions=  mockMvc.perform(requestBuilder).andExpect(status().isOk());
		//호출결과
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("│ result                                │"+result);		
		
		MessageVO messageVO=new Gson().fromJson(result, MessageVO.class);
		assertEquals("1", messageVO.getMsgId());
		
		//5.
		BoardVO updateResult = dao.doSelectOne(vo);
		
		//6.
		isSameBoard(updateResult,vo);
	}
	private void isSameBoard(BoardVO vo, BoardVO board) {
		assertEquals(vo.getSeq(), board.getSeq());
		assertEquals(vo.getDiv(), board.getDiv());
		assertEquals(vo.getTitle(), board.getTitle());
		assertEquals(vo.getContents(), board.getContents());
		assertEquals(vo.getModId(), board.getModId());
	}
	
	
	@Ignore
	@Test
	public void doSelectOne()throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSelectOne()                             │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		int flag = dao.doSave(boardList.get(0));
		assertEquals(1, flag);
		BoardVO vo = boardList.get(0);
		
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.get("/board/doSelectOne.do")
				.param("seq",     vo.getSeq()+"")
				.param("regId",   vo.getRegId())
				;		
		
		//호출 : ModelAndView      
		MvcResult mvcResult=  mockMvc.perform(requestBuilder).andExpect(status().isOk()).andReturn() ;
		//호출결과
		ModelAndView modelAndView = mvcResult.getModelAndView();
		BoardVO outVO = (BoardVO) modelAndView.getModel().get("vo");
		LOG.debug("│ outVO                                │"+outVO);
		assertNotNull(outVO);
	}
	
	@Ignore
	@Test
	public void doSave()throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSave  ()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");		
		
		BoardVO vo = boardList.get(0);
		//url, 호출방식(get), seq
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.post("/board/doSave.do")
				.param("seq",     vo.getSeq()+"")
				.param("div",     vo.getDiv())
				.param("title",   vo.getTitle())
				.param("contents",vo.getContents())
				.param("readCnt", vo.getReadCnt()+"")
				.param("regId",   vo.getRegId())
				.param("modId",   vo.getModId())
				;
		//호출        
		ResultActions resultActions=  mockMvc.perform(requestBuilder).andExpect(status().isOk());
		//호출결과
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("│ result                                │"+result);		
		MessageVO messageVO=new Gson().fromJson(result, MessageVO.class);
		LOG.debug("│ messageVO                                │"+messageVO);
		assertEquals("1", messageVO.getMsgId());
	}
	
	@Ignore
	@Test
	public void doDelete()throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doDelete()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		int flag = dao.doSave(boardList.get(0));
		assertEquals(1, flag);
		
		//url, 호출방식(get), seq
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.get("/board/doDelete.do")
				.param("seq", 0+"");
				//.param("seq", boardList.get(0).getSeq()+"");
		
		ResultActions resultActions=  mockMvc.perform(requestBuilder).andExpect(status().isOk());
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("│ result                                │"+result);		
		MessageVO messageVO=new Gson().fromJson(result, MessageVO.class);
		LOG.debug("│ messageVO                                │"+messageVO);
		assertEquals("1", messageVO.getMsgId());
		
	}
	
	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ webApplicationContext                     │"+webApplicationContext);		
		LOG.debug("│ mockMvc                                   │"+mockMvc);
		LOG.debug("│ dao                                       │"+dao);
		LOG.debug("└───────────────────────────────────────────┘");			
		assertNotNull(webApplicationContext);
		assertNotNull(mockMvc);
		assertNotNull(dao);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
