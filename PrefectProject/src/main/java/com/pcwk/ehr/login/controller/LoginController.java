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
	
	@Autowired
	private MailSendService mailService;
 	
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
		//Email null check 
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
	

	
	//이메일 인증
	@RequestMapping(value="/mailCheck.do",method = RequestMethod.GET
			,produces = "application/json;charset=UTF-8"
			)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String mailCheck(HttpServletRequest request) {
		String email = request.getParameter("email");
		
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ mailCheck()                               │email:"+email);
		LOG.debug("└───────────────────────────────────────────┘");	
		return mailService.joinEmail(email);
		
	}
	
	//http://localhost:8080/ehr/user/idDuplicateCheck.do?userId='p8-03'
		@RequestMapping(value="/emailDuplicateCheck.do",method = RequestMethod.GET
				,produces = "application/json;charset=UTF-8"
				)
		@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
		public String emailDuplicateCheck(UserVO inVO) throws SQLException {
			String jsonString = "";  
			LOG.debug("┌───────────────────────────────────────────┐");
			LOG.debug("│ emailDuplicateCheck()                     │inVO:"+inVO);
			LOG.debug("└───────────────────────────────────────────┘");		
						
			int flag = userService.emailDuplicateCheck(inVO);
			String message = "";
			if(0==flag) {
				message = inVO.getEmail()+"사용 가능한 아이디 입니다.";
			}else {
				message = inVO.getEmail()+"사용 불가한 아이디 입니다.";
			}
			MessageVO messageVO=new MessageVO(flag+"", message);
			jsonString = new Gson().toJson(messageVO);		
			LOG.debug("jsonString:"+jsonString);		
			return jsonString;
		}
		
		@RequestMapping(value="/moveToReg.do", method = RequestMethod.GET)
		public String moveToReg(Model model)throws SQLException {
			String view = "user/user_reg";
			LOG.debug("┌───────────────────────────────────────────┐");
			LOG.debug("│ moveToReg                                 │");
			LOG.debug("└───────────────────────────────────────────┘");	
			
			//코드목록 조회 : 'EDUCATION','ROLE'
			Map<String, Object> codes =new HashMap<String, Object>();
			String[] codeStr = {"EDUCATION","ROLE"};
			
			codes.put("code", codeStr);
			List<CodeVO> codeList = this.codeService.doRetrieve(codes);
			
			List<CodeVO> educationList=new ArrayList<CodeVO>();
			List<CodeVO> roleList=new ArrayList<CodeVO>();
			
			
			for(CodeVO vo :codeList) {
				//EDUCATION
				if(vo.getMstCode().equals("EDUCATION")) {
					educationList.add(vo);
				}
				
				if(vo.getMstCode().equals("ROLE")) {
					roleList.add(vo);
				}	
				LOG.debug(vo);
			}
			
			LOG.debug("educationList");
			for(CodeVO vo :educationList) {
				LOG.debug(vo);
			}
			
			LOG.debug("roleList");
			for(CodeVO vo :roleList) {
				LOG.debug(vo);
			}
			
			
			model.addAttribute("education", educationList);
			
			model.addAttribute("role",roleList);
			
			
			
			return view;
		}
		
		//등록
		@RequestMapping(value="/doSave.do",method = RequestMethod.POST
				,produces = "application/json;charset=UTF-8"
				)
		@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
		public String doSave(UserVO inVO) throws SQLException{
			String jsonString = "";
			LOG.debug("┌───────────────────────────────────────────┐");
			LOG.debug("│ doSave()                                  │inVO:"+inVO);
			LOG.debug("└───────────────────────────────────────────┘");		
			
			
			int flag = userService.doSave(inVO);
			String message = "";
			
			if(1==flag) {
				message = inVO.getEmail()+"가 등록 되었습니다.";
			}else {
				message = inVO.getEmail()+"등록 실패.";
			}
			
			MessageVO messageVO=new MessageVO(flag+"", message);
			jsonString = new Gson().toJson(messageVO);
			LOG.debug("jsonString:"+jsonString);		
					
			return jsonString;
		}
		
	
}
