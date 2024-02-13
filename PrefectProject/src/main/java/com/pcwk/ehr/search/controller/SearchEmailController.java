package com.pcwk.ehr.search.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.search.service.SearchEmailService;
import com.pcwk.ehr.user.domain.UserVO;

@Controller
@RequestMapping("search")
public class SearchEmailController implements PcwkLogger{

	@Autowired
	SearchEmailService searchEmailService;
	
	public SearchEmailController () {}
	

	@RequestMapping(value="/searchEmailView.do")

	public String searchEmail() {
		String view = "search/search_email";
		LOG.debug("이메일 찾기 창");
		
		return view;
		}
	
	@RequestMapping(value="/searchEmail.do", method = RequestMethod.POST
	,produces = "application/json;charset=UTF-8")
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String findEmail(UserVO user, HttpSession httpSession)throws SQLException{
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ findEmail                                 │user:"+user);
		LOG.debug("└───────────────────────────────────────────┘");				
	
		MessageVO  message =new MessageVO();
	
			//입력 validation
			//이름 null check 
			if(null == user.getName() || "".equals(user.getName())) {
				message.setMsgId("1");
				message.setMsgContents("이름을 입력 하세요.");
			
				jsonString = new Gson().toJson(message);
				LOG.debug("jsonString:"+jsonString);
				return jsonString;
			}
		
		
		//전화번호 null check
		if(null == user.getTel()|| "".equals(user.getTel())) {
			message.setMsgId("2");
			message.setMsgContents("전화번호를 입력 하세요.");
			
			jsonString = new Gson().toJson(message);
			LOG.debug("jsonString:"+jsonString);
			return jsonString;
		}		
		
		
		int check= searchEmailService.searchEmailCheck(user);
			if(10==check) {//이메일 확인
			message.setMsgId("10");
			message.setMsgContents("이름을 확인 하세요.");
			
			}else if(20==check) {//비번확인
			message.setMsgId("20");
			message.setMsgContents("전화번호를 확인 하세요.");	    	
			
			}else if(30==check) {
			UserVO outVO = searchEmailService.findEmail(user);
			message.setMsgId("30");
			message.setMsgContents("찾으시는 이메일은:"+outVO.getEmail()+"입니다.");	   
			
		
		
		if(null != outVO) {
			httpSession.setAttribute("user", outVO);
		}			
		}else {
			message.setMsgId("99");
			message.setMsgContents("오류가 발생 했습니다.");	   	    	
			}
			jsonString = new Gson().toJson(message);
			LOG.debug("jsonString:"+jsonString);
		
		return jsonString;
	}
		
	@RequestMapping(value="/searchEmailResultView.do")
	public String searchEmailResult() {
		String view = "search/search_result_email";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ searchEmailResultView                     │");
		LOG.debug("└───────────────────────────────────────────┘");				
				
		return view;
		}

}