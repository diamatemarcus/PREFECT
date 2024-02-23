package com.pcwk.ehr.login.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.login.dao.LoginDao;
import com.pcwk.ehr.login.service.LoginService;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller
@RequestMapping("login")
public class LoginController implements PcwkLogger {

	@Autowired
	LoginService loginService;

	@Autowired
	LoginDao loginDao;

	@Autowired
	UserService userService;

	@Autowired
	CodeService codeService;

	public LoginController() {
	}

	@RequestMapping(value = "/loginView.do")
	public String loginView() {
		String view = "login/login";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ loginView                                 │");
		LOG.debug("└───────────────────────────────────────────┘");

		return view;
	}

	//@RequestMapping(value = "/doLogin.do")
//	public String login(String email, String password, HttpSession httpSession) throws SQLException {
//		String id = loginService.login(email, password);
//		UserVO user = loginDao.getUserEmail(email);
//		UserVO outVO = loginService.doSelectOne(user);
//	
//		LOG.debug(id);
//		LOG.debug("┌───────────────────────────────────────────┐");
//		LOG.debug("│ doLogin                                   │user:" + id);
//		LOG.debug("└───────────────────────────────────────────┘");
//
//		if (id == null) {
//			LOG.debug("로그인 실패");
//			return "login/login";
//		} else {
//			httpSession.setAttribute("user", outVO);
//			LOG.debug(outVO);
//			LOG.debug("로그인 성공");
//			return "main/main";
//		}
//		
//	}
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
		//id null check 
		if(null == user.getEmail() || "".equals(user.getEmail())) {
			message.setMsgId("1");
			message.setMsgContents("아이디를 입력 하세요.");
			
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
	    if(10==check) {//id확인
	    	message.setMsgId("10");
			message.setMsgContents("아이디를 확인 하세요.");
			
	    }else if(20==check) {//비번확인
	    	message.setMsgId("20");
			message.setMsgContents("비번을 확인 하세요.");	    	
		
	    }else if(30==check) {//비번확인
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
	@RequestMapping(value = "/doLogout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		//String view = "login/login";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ loginView                                 │");
		LOG.debug("└───────────────────────────────────────────┘");

		return "redirect:/login/loginView.do";
	}

}
