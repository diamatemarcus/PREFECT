package com.pcwk.ehr.subject.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.subject.domain.SubjectVO;
import com.pcwk.ehr.subject.service.SubjectService;
import com.google.gson.Gson;

@Controller
@RequestMapping("/subject")
public class SubjectController implements PcwkLogger {

	@Autowired
	SubjectService service;
	
	@Autowired
	MessageSource MessageSource;
	
	public SubjectController() {}
	
	@GetMapping(value = "/doSave.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageVO doSave(SubjectVO inVO) throws SQLException{
		MessageVO  messageVO = null;
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSave                            │");
		LOG.debug("│ SubjectVO                         │"+inVO);
		LOG.debug("└───────────────────────────────────┘");	
		
		// subjectCode 조회
		
		
		
		return messageVO;

	}

		
}
