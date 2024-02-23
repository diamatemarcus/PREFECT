package com.pcwk.ehr.login.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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

	@RequestMapping(value = "/doLogin.do")
	public String login(String email, String password, HttpSession httpSession) throws SQLException {
		String id = loginService.login(email, password);
		UserVO user = loginDao.getUserEmail(email);
		UserVO outVO = loginService.doSelectOne(user);
	
		LOG.debug(id);
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doLogin                                   │user:" + id);
		LOG.debug("└───────────────────────────────────────────┘");

		if (id == null) {
			LOG.debug("로그인 실패");
			return "login/login";
		} else {
			httpSession.setAttribute("user", outVO);
			LOG.debug(outVO);
			LOG.debug("로그인 성공");
			return "main/main";
		}
		
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
