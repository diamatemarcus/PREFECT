package com.pcwk.ehr.reply;

//import static com.pcwk.ehr.user.service.UserServiceImpl.MIN_LOGIN_COUNT_FOR_SILVER;
import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.lang.reflect.Type;
import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.pcwk.ehr.board.dao.BoardDao;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.reply.dao.ReplyDao;
import com.pcwk.ehr.reply.domain.ReplyVO;
//import com.pcwk.ehr.user.domain.Level;
import com.pcwk.ehr.user.domain.UserVO;


@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임워크의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ReplyControllerJunitTest implements PcwkLogger {

	@Autowired
	ReplyDao  dao;
	
	@Autowired
	WebApplicationContext webApplicationContext;
	
	//브라우저 대역
	MockMvc  mockMvc;
	   
	
	@Autowired
	BoardDao boardDao;
	
	BoardVO  board01;
	
	ReplyVO reply01;
	ReplyVO reply02;
	ReplyVO reply03;
	
	
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ setUp()                                   │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		
		board01 = new BoardVO(boardDao.getBoardSeq(), "10", "제목55", "내용55", 0, "사용X", "pcwk99", "사용X", "pcwk99","", 0);
		//게시순번
		long boardSeq = (long)board01.getSeq();
		
		reply01 = new ReplyVO( Long.parseLong(dao.getReplySeq()+""), boardSeq, "댓글내용-01", "사용X", "pcwk101", "사용X");
		reply02 = new ReplyVO( Long.parseLong(dao.getReplySeq()+""), boardSeq, "댓글내용-02", "사용X", "pcwk101", "사용X");
		reply03 = new ReplyVO( Long.parseLong(dao.getReplySeq()+""), boardSeq, "댓글내용-03", "사용X", "pcwk101", "사용X");
				
	}

	
	@Test
	public void doRetrieve() throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doRetrieve                                │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		//Board 1.기존 데이터 삭제
		//      2.신규등록
		//1
		this.boardDao.doDelete(board01);
		//2
		int flag = boardDao.doSave(board01);
		assertEquals(1, flag);	
		
		//댓글1. 등록
		flag = dao.doSave(reply01);
		assertEquals(1, flag);	
		
		flag = dao.doSave(reply02);
		assertEquals(1, flag);	
		
		flag = dao.doSave(reply03);
		assertEquals(1, flag);			
		LOG.debug("│ reply01.getBoardSeq()            │"+reply01.getBoardSeq());
		
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.get("/reply/doRetrieve.do")
				.param("boardSeq",     reply01.getBoardSeq()+"")
				;			
		
		//호출        
		ResultActions resultActions=  mockMvc.perform(requestBuilder).andExpect(status().isOk());
		//호출결과
		String result = resultActions.andDo(print()).andReturn().getResponse().getContentAsString();
		LOG.debug("│ result                                │"+result);			
		//Json(List<ReplyVO>) : 
		Type listType = new TypeToken<List<ReplyVO>>(){}.getType();
		
		List<ReplyVO>  list=new Gson().fromJson(result, listType);
		
		assertEquals(3, list.size());
		assertNotNull(list);
		
		for (ReplyVO vo   :list) {
			LOG.debug(vo);
		}
		
		
	}
	
	
	
	//@Ignore
	@Test
	public void doUpdate()throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doUpdate()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");		
		
		
		//Board 1.기존 데이터 삭제
		//      2.신규등록
		
		//1
		this.boardDao.doDelete(board01);
		
		//2
		int flag = boardDao.doSave(board01);
		assertEquals(1, flag);		
		
		//댓글1. 등록
		flag = dao.doSave(reply01);
		assertEquals(1, flag);
		
		//댓글2. 단건조회
		ReplyVO vo = dao.doSelectOne(reply01);
		
		//댓글 수정
		vo.setReply(vo.getReply()+"_U");
		
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.post("/reply/doUpdate.do")
				.param("replySeq",     vo.getReplySeq()+"")
				.param("reply",        vo.getReply())
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
	
	
//	@Ignore
	@Test
	public void doDelete()throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doDelete()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		//Board 1.기존 데이터 삭제
		//      2.신규등록
		
		//1
		this.boardDao.doDelete(board01);
		
		//2
		int flag = boardDao.doSave(board01);
		assertEquals(1, flag);
		
		//Reply삭제
		
		//1. 등록
		flag = dao.doSave(reply01);
		assertEquals(1, flag);
		
		//2. 삭제
		ReplyVO vo = reply01;  
		

		//post/get
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.get("/reply/doDelete.do")
				.param("replySeq",     vo.getReplySeq()+"")
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
	
	
//	@Ignore
	@Test
	public void doSave() throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSave()                                  │");		
		LOG.debug("└───────────────────────────────────────────┘");		
		
		//Board 1.기존 데이터 삭제
		//      2.신규등록
		
		//1
		this.boardDao.doDelete(board01);
		
		//2
		int flag = boardDao.doSave(board01);
		assertEquals(1, flag);
		
		ReplyVO vo = reply01;  
		
			
		//Reply 등록
		//post/get
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.post("/reply/doSave.do")
				.param("replySeq",     vo.getReplySeq()+"")
				.param("boardSeq",     vo.getBoardSeq()+"")
				.param("reply",        vo.getReply())
				.param("regId",        vo.getRegId())
				;		
		
		//session
        // 가상의 HTTPServletRequest 및 HTTPSession 생성
        MockHttpServletRequest request = new MockHttpServletRequest();
        HttpSession session = new MockHttpSession();

        UserVO user=new UserVO("email", "술상무", "4321_1", "01034563456", "univ", "trainee","");
        
        // 세션에 데이터 추가
        session.setAttribute("user", user);

        // 요청에 세션 설정
        request.setSession(session);	
                
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
	public void beans() {
		LOG.debug("│ dao                                   │"+dao);
		LOG.debug("│ webApplicationContext                 │"+webApplicationContext);
		LOG.debug("│ mockMvc                 │"+mockMvc);
		
		assertNotNull(dao);
		assertNotNull(webApplicationContext);
		assertNotNull(mockMvc);
	}

}
