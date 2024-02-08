package com.pcwk.ehr.licenses.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.licenses.domain.LicensesVO;
import com.pcwk.ehr.licenses.service.LicensesService;

@Controller
@RequestMapping("licenses")
public class LicensesController implements PcwkLogger {
	
	@Autowired
	LicensesService service;

	public LicensesController() {
	}

	@GetMapping(value = "/doRetrieve.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<LicensesVO> doRetreive(LicensesVO inVO) throws SQLException {
		List<LicensesVO> list = new ArrayList<LicensesVO>();
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieve                        │");
		LOG.debug("│ LicensesVO                        │" + inVO);
		LOG.debug("└───────────────────────────────────┘");
		
		list = service.doRetrieve(inVO);

		return list;
	}

	@PostMapping(value = "/doUpdate.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageVO doUpdate(LicensesVO inVO) throws SQLException {
		MessageVO messageVO = null;

		int flag = service.doUpdate(inVO);

		String message = "";

		if (1 == flag) {
			message = "수정완료";
		} else {
			message = "수정실패";
		}

		messageVO = new MessageVO(flag + "", message);

		LOG.debug("│ messageVO                           │" + messageVO);
		
		return messageVO;
	}

	@PostMapping(value = "/doDelete.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageVO doDelete(LicensesVO inVO) throws SQLException {

		MessageVO messageVO = null;
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDelete                          │");
		LOG.debug("│ ReplyVO                           │" + inVO);
		LOG.debug("└───────────────────────────────────┘");

		int flag = service.doDelete(inVO);

		String message = "";

		if (1 == flag) {
			message = "삭제완료";
		} else {
			message = "삭제실패";
		}

		messageVO = new MessageVO(flag + "", message);

		LOG.debug("│ messageVO                           │" + messageVO);
		return messageVO;

	}
	
	@PostMapping(value = "/doSave.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageVO doSave(LicensesVO inVO) throws SQLException{
		MessageVO messageVO = null;
		
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSave                            │");
		LOG.debug("│ ReplyVO                           │" + inVO);
		LOG.debug("└───────────────────────────────────┘");
		
		
		int flag = service.doSave(inVO);
		
		String message = "";
		
		if (1 == flag) {
			message = "등록성공";
		} else {
			message = "등록 실패";
		}
		
		messageVO = new MessageVO(flag + "", message);

		LOG.debug("│ messageVO                           │" + messageVO);
		return messageVO;
		
	}
	
}
