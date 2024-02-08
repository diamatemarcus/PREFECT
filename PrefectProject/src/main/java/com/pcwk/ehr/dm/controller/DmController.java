package com.pcwk.ehr.dm.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.dm.dao.DmDao;
import com.pcwk.ehr.dm.domain.DmVO;
import com.pcwk.ehr.dm.service.DmService;
import com.pcwk.ehr.user.domain.UserVO;

@Controller
@RequestMapping("dm")
public class DmController implements PcwkLogger{
	
	@Autowired
	DmService service;
	
	
	public DmController () {}
	
	@PostMapping(value="/moveTolist.do")//저 url로 get매핑함
	public String moveToReg() {
		String viewName = "";
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ moveToReg                         │");
		LOG.debug("└───────────────────────────────────┘");		
		viewName = "dm/dm_list";///WEB-INF/views/ viewName .jsp
		return viewName;
	}
	@PostMapping(value = "/doSend.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageVO doSend(DmVO inVO) throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSave                            │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");				
		int seq = service.getDmSeq();
		inVO.setSeq(seq);
		
		LOG.debug("│ DmVO seq                       │"+inVO);
		int flag = service.doSend(inVO);
		
		String message = "";
		if(1 == flag) {
			message = "등록 되었습니다.";
		}else {
			message = "등록 실패.";
		}
		
		MessageVO  messageVO=new MessageVO(String.valueOf(flag), message);
		LOG.debug("│ messageVO                           │"+messageVO);
		return messageVO;
	}
	@GetMapping(value = "/recentMessage.do")
	public String recentMessage(DmVO inVO, Model model) throws SQLException, EmptyResultDataAccessException{
		String view = "dm/dm_mng";///WEB-INF/views/+board/board_mng+.jsp ->/WEB-INF/views/board/board_mng.jsp
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ recentMessage                     │");
		LOG.debug("│ DmVO                              │"+inVO);
		LOG.debug("└───────────────────────────────────┘");			
		if(0 == inVO.getSeq() ) {
			LOG.debug("============================");
			LOG.debug("==nullPointerException===");
			LOG.debug("============================");
			
			throw new NullPointerException("순번을 입력 하세요");
		}
		
		
		
		DmVO  outVO = service.recentMessage(inVO);
		model.addAttribute("vo", outVO);
		
		
		return view;
	}
	@GetMapping(value ="/doDelete.do",produces = "application/json;charset=UTF-8" )//@RequestMapping(value = "/doDelete.do",method = RequestMethod.GET)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public MessageVO doDelete(DmVO inVO) throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDelete                          │");
		LOG.debug("│ DmVO inVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");		
		if(0 == inVO.getSeq() ) {
			LOG.debug("============================");
			LOG.debug("==nullPointerException===");
			LOG.debug("============================");
			MessageVO messageVO=new MessageVO(String.valueOf("3"), "순번을 선택 하세요.");
			return messageVO;
		} 
		
		
		int flag = service.doDelete(inVO);
		
		String   message = "";
		if(1==flag) {//삭제 성공
			message = inVO.getSeq()+"삭제 되었습니다.";	
		}else {
			message = inVO.getSeq()+"삭제 실패!";
		}
		
		MessageVO messageVO=new MessageVO(String.valueOf(flag), message);
		
		LOG.debug("│ messageVO                           │"+messageVO);
		return messageVO;
	}
	@GetMapping(value = "/doContentsList.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public ModelAndView contentsList(DmVO inVO, ModelAndView modelAndView,HttpSession httpSession) throws SQLException{
		
				if(null != httpSession.getAttribute("user")) {
				UserVO user = (UserVO) httpSession.getAttribute("user");
				inVO.setSender(user.getEmail());
			    }
				//페이지 사이즈:10
				if(null != inVO && inVO.getPageSize() == 0) {
					inVO.setPageSize(10L);
				}

				//페이지 번호:1
				if(null != inVO && inVO.getPageNo() == 0) {
					inVO.setPageNo(1L);
				}
				
				//검색구분:""
				if(null != inVO && null == inVO.getSearchDiv()) {
					inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchDiv()));
				}
				//검색어:""
				if(null != inVO && null == inVO.getSearchWord()) {
					inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchWord()));
				}
				LOG.debug("│ DmVO Default처리                          │"+inVO);
				
				
				
				//목록조회
				List<DmVO>  list = service.contentsList(inVO);
				
				

				//뷰
				modelAndView.setViewName("dm/dm_list");//  /WEB-INF/views/board/board_list.jsp
				//Model
				modelAndView.addObject("list", list);
				//검색데이터
				modelAndView.addObject("paramVO", inVO);  
			
					
				
				return modelAndView; 
	}
}
