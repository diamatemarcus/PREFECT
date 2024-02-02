package com.pcwk.ehr.dm;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.dm.dao.DmDao;
import com.pcwk.ehr.dm.domain.DmVO;
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class DmControllerJunitTest implements PcwkLogger{
	@Autowired
	DmDao dao;
	
	@Autowired
	WebApplicationContext webApplicationContext;
	
	MockMvc  mockMvc;
	List<DmVO> dmList;
	DmVO searchVO;
	@Before
	public void setUp() throws Exception {
		String seq ="사용하지 않음";
		int room =1;
		String sender ="gyu";
		String receiver ="seo";
		String contents= "피곤";
		String sendDt= "사용하지않음";
		String readDt= "사용하지않음";
		int readChk= 0;
		
		mockMvc  = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		dmList = Arrays.asList(
				new DmVO(seq,room,sender,receiver,contents,sendDt,sendDt,readChk)
				);
		searchVO = new DmVO();
		searchVO.setRoom(room);
	}
	@Ignore
	@Test
	public void doSend()throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSave  ()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");		
		
		DmVO vo = dmList.get(0);
		//url, 호출방식(get), seq
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.post("/dm/doSend.do")
				.param("seq",     vo.getSeq())
				.param("room",     vo.getRoom()+"")
				.param("sender",   vo.getSender())
				.param("receiver",vo.getReceiver())
				.param("contents",vo.getContents())
				.param("sendDt",   vo.getSendDt())
				.param("readDt",   vo.getReadDt())
				.param("readChk",   vo.getReadChk()+"")
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
	public void contentsList() throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ contentsList()                            │");		
		LOG.debug("└───────────────────────────────────────────┘");
		DmVO vo = dmList.get(0);
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.post("/dm/doContentsList.do")
				.param("seq",     vo.getSeq())
				.param("room",     vo.getRoom()+"")
				.param("sender",   vo.getSender())
				.param("receiver",vo.getReceiver())
				.param("contents",vo.getContents())
				.param("sendDt",   vo.getSendDt())
				.param("readDt",   vo.getReadDt())
				.param("readChk",   vo.getReadChk()+"")
				;
				
		MvcResult mvcResult=  mockMvc.perform(requestBuilder).andExpect(status().isOk()).andReturn() ;
		//호출결과
		ModelAndView modelAndView = mvcResult.getModelAndView();
		List<DmVO>  list  = (List<DmVO>) modelAndView.getModel().get("list");
		DmVO  paramVO  = (DmVO) modelAndView.getModel().get("paramVO");
		
	
		
		for(DmVO dvo  :list) {
			LOG.debug(dvo);
		}
	
		assertNotNull(list);
		assertNotNull(paramVO);
				
	}
	@Ignore
	@Test
	public void doSelectOne()throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSelectOne()                             │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		//int flag = dao.doSend(dmList.get(0));
		//assertEquals(1, flag);
		DmVO vo = dmList.get(0);
		
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.get("/dm/recentMessage.do")
				.param("seq",     "10")
				.param("room",     vo.getRoom()+"")
				.param("sender",   vo.getSender())
				.param("receiver",vo.getReceiver())
				.param("contents",vo.getContents())
				.param("sendDt",   vo.getSendDt())
				.param("readDt",   vo.getReadDt())
				.param("readChk",   vo.getReadChk()+"")
				
				;		
		
		//호출 : ModelAndView      
		MvcResult mvcResult=  mockMvc.perform(requestBuilder).andExpect(status().isOk()).andReturn() ;
		//호출결과
		ModelAndView modelAndView = mvcResult.getModelAndView();
		BoardVO outVO = (BoardVO) modelAndView.getModel().get("vo");
		LOG.debug("│ outVO                                │"+outVO);
		assertNotNull(outVO);
	}
	//@Ignore
	@Test
	public void doDelete() throws Exception{
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doDelete()                                │");		
		LOG.debug("└───────────────────────────────────────────┘");
		
		//int flag = dao.doSend(dmList.get(0));
		//assertEquals(1, flag);
		
		//url, 호출방식(get), seq
		MockHttpServletRequestBuilder  requestBuilder  =
				MockMvcRequestBuilders.get("/dm/doDelete.do")
				.param("seq", "13");
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
