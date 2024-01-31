package com.pcwk.ehr.dm.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.dm.dao.DmDao;
import com.pcwk.ehr.dm.domain.DmVO;
import com.pcwk.ehr.dm.service.DmService;

@Controller
@RequestMapping("dm")
public class DmController implements PcwkLogger{
	
	@Autowired
	DmService service;
	
	
	public DmController () {}
	
	@GetMapping(value="/moveTolist.do")//저 url로 get매핑함
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
		
		inVO.getSeq();
		
		LOG.debug("│ BoardVO seq                       │"+inVO);
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
}
