package com.pcwk.ehr.login.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.login.service.LoginService;
import com.pcwk.ehr.mail.service.MailSendService;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller
@RequestMapping("login")
public class LoginController implements PcwkLogger{
	
	@Autowired
	LoginService loginService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	CodeService codeService;
 	
	public LoginController() {}
	
	@RequestMapping(value="/loginView.do")
	public String loginView() {
		String view = "login/login";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ loginView                                 │");
		LOG.debug("└───────────────────────────────────────────┘");				
				
		return view;
	}
	
	@RequestMapping(value="/doLogin.do", method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8"
			)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doLogin(UserVO user, HttpSession httpSession)throws SQLException{
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doLogin                                   │user:"+user);
		LOG.debug("└───────────────────────────────────────────┘");				
		
		MessageVO  message =new MessageVO();
		
		//입력 validation
		//Email null check `
		if(null == user.getEmail() || "".equals(user.getEmail())) {
			message.setMsgId("1");
			message.setMsgContents("이메일을 입력 하세요.");
			
			jsonString = new Gson().toJson(message);
			LOG.debug("jsonString:"+jsonString);
			return jsonString;
		}
		
		
		//pass null check
		if(null == user.getPassword()|| "".equals(user.getPassword())) {
			message.setMsgId("2");
			message.setMsgContents("비밀번호를 입력 하세요.");
			
			jsonString = new Gson().toJson(message);
			LOG.debug("jsonString:"+jsonString);
			return jsonString;
		}		
		
		  
	    int check=loginService.loginCheck(user);
	    if(10==check) {//이메일 확인
	    	message.setMsgId("10");
			message.setMsgContents("이메일을 확인 하세요.");
			
	    }else if(20==check) {//비번확인
	    	message.setMsgId("20");
			message.setMsgContents("비밀번호를 확인 하세요.");	    	
		
	    }else if(30==check) {//정상
	    	UserVO outVO = loginService.doSelectOne(user);
	    	message.setMsgId("30");
			message.setMsgContents(outVO.getName()+"님 반갑습니다.");	   
			
			
			
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
	
	@RequestMapping(value="/doLogout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		String view = "login/login";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ loginView                                 │");
		LOG.debug("└───────────────────────────────────────────┘");				
				
		return view;
	}
	
}
