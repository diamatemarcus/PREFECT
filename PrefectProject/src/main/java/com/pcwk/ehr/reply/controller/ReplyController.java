package com.pcwk.ehr.reply.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.reply.domain.ReplyVO;
import com.pcwk.ehr.reply.service.ReplyService;
import com.pcwk.ehr.user.domain.UserVO;

@Controller
@RequestMapping("reply")
public class ReplyController implements PcwkLogger {

	
	@Autowired
	ReplyService service;
	
	@Autowired
	MessageSource messageSource;
	
	public ReplyController() {}
	
	
	@GetMapping(value="/doRetrieve.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<ReplyVO> doRetrieve(ReplyVO inVO) throws SQLException{
		List<ReplyVO> list=new ArrayList<ReplyVO>();
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieve                        │");
		LOG.debug("│ ReplyVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");			
		
		if( 0 == inVO.getBoardSeq()) {
			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ ReplySeq                          │"+inVO.getBoardSeq());
			LOG.debug("└───────────────────────────────────┘");
			
			throw new NullPointerException("보드 순번을 입력 하세요.");
		}
		
		list = service.doRetrieve(inVO);
		
		
		
		return list;
	}
	
	
	@PostMapping(value = "/doUpdate.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageVO doUpdate(ReplyVO inVO) throws SQLException{
		MessageVO messageVO = null;
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDelete                          │");
		LOG.debug("│ ReplyVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");	
		
		if( 0 == inVO.getReplySeq()) {
			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ ReplySeq                          │"+inVO.getReplySeq());
			LOG.debug("└───────────────────────────────────┘");
			
			return new MessageVO(String.valueOf("3"), "순번을 선택 하세요.");
		}
		
		int flag = service.doUpdate(inVO);
		//Locale  locale=LocaleContextHolder.getLocale();
		
		String message = "";
		if(1 == flag ) {
			//{0} 되었습니다.
			//message = this.messageSource.getMessage("common.message.update",null ,locale);
			//LOG.debug("│ message                           │"+message);
			
			//String tranMessage = "수정";
			//message = MessageFormat.format(message, tranMessage);
			message = "수정성공";
			LOG.debug("│ message                           │"+message);
		}else {
			message = "수정 실패!";
		}		
		
		messageVO = new MessageVO(flag+"", message);
		LOG.debug("│ messageVO                           │"+messageVO);		
		
		
		return messageVO;
	}
	
	@GetMapping(value = "doDelete.do",produces = "application/json;charset=UTF-8" )//@RequestMapping(value = "/doDelete.do",method = RequestMethod.GET)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public MessageVO doDelete(ReplyVO inVO) throws SQLException{
		MessageVO messageVO = null;
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDelete                          │");
		LOG.debug("│ ReplyVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");	
		
		if( 0 == inVO.getReplySeq()) {
			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ nullPointException                │");
			LOG.debug("└───────────────────────────────────┘");
			
			return new MessageVO(String.valueOf("3"), "순번을 선택 하세요.");
		}
		
		int flag = service.doDelete(inVO);
		
		//Locale  locale=LocaleContextHolder.getLocale();
		
		String message = "";
		
		  if(1 == flag ) { //{0} 되었습니다. message =
		  //this.messageSource.getMessage("common.message.update",null ,locale);
		  LOG.debug("│ message                           │"+message);
		  
		  //String tranMessage = "삭제"; message = MessageFormat.format(message,
		  //tranMessage);
		  message = "삭제성공";
		  LOG.debug("│ message                           │"+message); }else { message =
		 "삭제 실패!"; }
		 
		
		messageVO = new MessageVO(flag+"", message);
		LOG.debug("│ messageVO                           │"+messageVO);
		
		return messageVO;
	}
	
	@PostMapping(value = "/doSave.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageVO doSave(ReplyVO inVO,HttpSession httpSession) throws SQLException{
		MessageVO  messageVO = null;
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSave                            │");
		LOG.debug("│ ReplyVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");	
		
		//replySeq 조회
		int replySeq = service.getReplySeq();
		inVO.setReplySeq( Long.parseLong(replySeq+""));
		
		
		//등록자 ID입력
		UserVO user=(UserVO) httpSession.getAttribute("user");
		if( null ==user) {
			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ nullPointException                │");
			LOG.debug("└───────────────────────────────────┘");
			
			return new MessageVO(String.valueOf("3"), "로그인 하세요.");
		}
		
		
		if(null !=user) {
			inVO.setRegId(user.getEmail());
		}
		LOG.debug("│ ReplyVO                           │"+inVO);
		
		int flag = service.doSave(inVO);
		
		
		//Locale  locale=LocaleContextHolder.getLocale();
		
		String message = "";
		if(1 == flag ) {
			//{0} 되었습니다.
//			message = this.messageSource.getMessage("common.message.update",null ,locale);
//			LOG.debug("│ message                           │"+message);
			
			String tranMessage = "등록";
//			message = MessageFormat.format(message, tranMessage);
			message = "등록성공";	
			LOG.debug("│ message                           │"+message);
		}else {
			message = "등록 실패!";
		}
		
		messageVO = new MessageVO(flag+"",message);
		LOG.debug("│ messageVO                           │"+messageVO);
		
		return messageVO;
	}
	
	
}


