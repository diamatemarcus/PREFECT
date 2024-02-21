package com.pcwk.ehr.subject.controller;

import java.sql.SQLException;
import java.util.List;

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
import com.pcwk.ehr.subject.domain.SubjectVO;
import com.pcwk.ehr.subject.service.SubjectService;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller
@RequestMapping("subject")
public class SubjectController implements PcwkLogger {

	@Autowired
	SubjectService subjectService;
	
	@Autowired
	CodeService codeService;
	
    SubjectVO subjectVO = new SubjectVO();

	public SubjectController() {}


	
	//목록조회
	@RequestMapping(value="/doRetrieve.do", method = RequestMethod.GET)
	public String doRetrieve(HttpServletRequest req, Model model , HttpSession httpSession) throws SQLException {
		String view = "subject/subject_list";
		String email = "";

	    if(null != httpSession.getAttribute("user")) {
			UserVO user = (UserVO) httpSession.getAttribute("user");
			 email = user.getEmail();
		}
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│           Email                           │" +email);
		LOG.debug("└───────────────────────────────────────────┘");		
		
		
	    SubjectVO subjectVO = new SubjectVO();
	    subjectVO.setProfessor(email); // 로그인한 사용자의 이메일 설정
	    List<SubjectVO> list = subjectService.doRetrieve(subjectVO);
		


	    model.addAttribute("list", list);


	    
		return view;
	}
	
	
	//등록
	@RequestMapping(value="/doSave.do",method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8"
			)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doSave(SubjectVO inVO) throws SQLException{
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSave()                                  │inVO:"+inVO);
		LOG.debug("└───────────────────────────────────────────┘");		
		
		
		int flag = subjectService.doSave(inVO);
		String message = "";
		
		if(1==flag) {
			message = inVO.getScore()+"가 등록 되었습니다.";
		}else {
			message = inVO.getScore()+"등록 실패.";
		}
		
		MessageVO messageVO=new MessageVO(flag+"", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:"+jsonString);		
				
		return jsonString;
	}
	
	
	
//	// 단건조회
//	@RequestMapping(value="/doSelectOne.do", method = RequestMethod.GET)
//	public String doSelectOne(SubjectVO inVO,HttpServletRequest req, Model model) throws SQLException, EmptyResultDataAccessException {
//		String view = "subject/subject_mod";
//		LOG.debug("┌───────────────────────────────────────────┐");
//		LOG.debug("│ doSelectOne()                             │inVO:"+inVO);
//		LOG.debug("└───────────────────────────────────────────┘");	
//		String trainee = req.getParameter("trainee");
//		LOG.debug("│ trainee                                :"+trainee);		
//		
//		SubjectVO outVO = this.subjectService.doSelectOne(inVO);
//		LOG.debug("│ outVO                                :"+outVO);		
//
//		model.addAttribute("outVO", outVO);
//		
//		return view;
//	}
	@RequestMapping(value="/doSelectOne.do", method = RequestMethod.GET)
	public String doSelectOne(SubjectVO inVO, HttpServletRequest req, Model model) throws SQLException {
	    String view = "subject/subject_mod";
	    LOG.debug("┌───────────────────────────────────────────┐");
	    LOG.debug("│ doSelectOne() │inVO:" + inVO);
	    LOG.debug("└───────────────────────────────────────────┘");
	    String subjectCode = req.getParameter("subjectCode");
	    String trainee = req.getParameter("trainee");
	    String coursesCode = req.getParameter("coursesCode");
	    
	    inVO.setTrainee(trainee); // inVO 객체에 trainee 설정

	    // coursesCode 값이 null이 아니고 숫자로 구성된 문자열인지 확인
	    if (coursesCode != null && coursesCode.matches("\\d+")) {
	        inVO.setCoursesCode(Integer.parseInt(coursesCode));
	    } else {
	        LOG.error("Invalid coursesCode: " + coursesCode);
	        // 여기서 오류 처리 로직을 추가하거나 기본값을 설정할 수 있습니다.
	    }

	    LOG.debug("│ trainee :" + trainee);
	    LOG.debug("│ coursesCode :" + coursesCode);

	    SubjectVO outVO = this.subjectService.doSelectOne(inVO);
	    LOG.debug("│ outVO :" + outVO);

	    model.addAttribute("outVO", outVO);

	    return view;
	}
	
	
	
	

	
	//수정
	@RequestMapping(value="/doUpdate.do",method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8"
			)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doUpdate(SubjectVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doUpdate()                                │inVO:"+inVO);
		LOG.debug("└───────────────────────────────────────────┘");		
				
		int flag = this.subjectService.doUpdate(inVO);
		String message = "";
		if(1==flag) {
			message = inVO.getScore()+"가 수정 되었습니다.";
		}else {
			message = inVO.getScore()+"수정 실패";
		}
		MessageVO messageVO = new MessageVO(flag+"", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:"+jsonString);	
						
		
		return jsonString;
	}
	
	

	
	 


	

}
