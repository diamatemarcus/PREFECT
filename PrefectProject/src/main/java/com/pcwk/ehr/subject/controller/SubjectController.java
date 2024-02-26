package com.pcwk.ehr.subject.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@Autowired
	UserService userService;
	
    SubjectVO subjectVO = new SubjectVO();

	public SubjectController() {}


	
	//목록조회
	@RequestMapping(value="/doRetrieve.do", method = RequestMethod.GET)
	public String doRetrieve(@RequestParam(value = "searchDiv", required = false) String searchDiv, HttpServletRequest req, Model model , HttpSession httpSession) throws SQLException {
		
		// 로그인한 유저의 이메일을 서브젝트 테이블에서 찾는 코드
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
	    
	    if (searchDiv != null && !searchDiv.isEmpty()) {
	        try {
	            // searchDiv를 int로 변환
	            int subjectCode = Integer.parseInt(searchDiv);
	            // 변환된 값을 setSubjectCode에 전달
	            subjectVO.setSubjectCode(subjectCode);
	        } catch(NumberFormatException e) {
	            // searchDiv가 유효한 정수가 아닌 경우의 처리
	            LOG.error("Invalid SUBJECT_CODE: " + searchDiv, e);
	        }
	    }
    
	    List<SubjectVO> list = subjectService.doRetrieve(subjectVO);   

	    // user정보에서 일치하는 trainee 찾아서 이름으로 보여주기 위한 코드
	    List<UserVO> userList = new ArrayList<>();
	    Set<String> addedEmails = new HashSet<>(); // 중복 이메일 추적을 위한 Set

	    for (SubjectVO vo : list) {

	        if (!addedEmails.contains(vo.getTrainee())) {
	            UserVO user = new UserVO();
	            user.setEmail(vo.getTrainee());
	            user = userService.doSelectOne(user);
	            if (user != null) {
	                LOG.debug("│ user: " + user);
	                userList.add(user);
	                addedEmails.add(user.getEmail()); // 이메일을 Set에 추가
	            }
	        }
	    }
		
	    // CMN_CODE_SUBJECT 찾아서 뷰어에서 subject_code 이름으로 사용하려고
		Map<String, Object> codes =new HashMap<String, Object>();
		String[] codeStr = {"SUBJECT"};
		codes.put("code", codeStr);
		
		List<CodeVO> codeList = codeService.doRetrieve(codes);
		List<CodeVO> subjectCodeList = new ArrayList<CodeVO>();
		
		for (CodeVO vo: codeList) {
			if(vo.getMstCode().equals("SUBJECT")) {
				subjectCodeList.add(vo);
			}
			LOG.debug(vo);
		}
		
		// CMN_CODE
		model.addAttribute("subjectCode",subjectCodeList);
		// trainee 이름 표시
	    model.addAttribute("userList", userList);
	    //로그인한 유저 subject테이블에서 찾은 결과
	    model.addAttribute("list", list);


	    
		return view;
	}
	
	
// 사용 안함	
//	//등록
//	@RequestMapping(value="/doSave.do",method = RequestMethod.POST
//			,produces = "application/json;charset=UTF-8"
//			)
//	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
//	public String doSave(SubjectVO inVO) throws SQLException{
//		String jsonString = "";
//		LOG.debug("┌───────────────────────────────────────────┐");
//		LOG.debug("│ doSave()                                  │inVO:"+inVO);
//		LOG.debug("└───────────────────────────────────────────┘");		
//		
//		
//		int flag = subjectService.doSave(inVO);
//		String message = "";
//		
//		if(1==flag) {
//			message = inVO.getScore()+"가 등록 되었습니다.";
//		}else {
//			message = inVO.getScore()+"등록 실패.";
//		}
//		
//		MessageVO messageVO=new MessageVO(flag+"", message);
//		jsonString = new Gson().toJson(messageVO);
//		LOG.debug("jsonString:"+jsonString);		
//				
//		return jsonString;
//	}
//	
	

	
	@RequestMapping(value="/doSelectOne.do", method = RequestMethod.GET)
	public String doSelectOne(SubjectVO inVO, HttpServletRequest req, Model model) throws SQLException {
	    String view = "subject/subject_mod";
	    LOG.debug("┌───────────────────────────────────────────┐");
	    LOG.debug("│ doSelectOne() │inVO:" + inVO);
	    LOG.debug("└───────────────────────────────────────────┘");

	    // HttpServletRequest를 사용하여 "email" 파라미터 값을 가져옵니다.
	    String traineeEmail = req.getParameter("email");
	    // 가져온 email 값을 inVO 객체의 trainee 필드에 설정합니다.
	    
	    LOG.debug("traineeEmail: " + traineeEmail);

	    inVO.setTrainee(traineeEmail);
	    LOG.debug("inVO: " + inVO.toString());

	    // trainee 정보를 조회합니다.
	    UserVO userTrainee = new UserVO();
	    userTrainee.setEmail(traineeEmail);
	    userTrainee = userService.doSelectOne(userTrainee);
	    LOG.debug("│ userTrainee                                :" + userTrainee);

	    // subject 정보를 조회합니다.
	    SubjectVO outVO = this.subjectService.doSelectOne(inVO);
	    LOG.debug("│ outVO :" + outVO);
	    LOG.debug("│ coursesCode :" + outVO.getCoursesCode());

	    // 모델에 조회된 데이터를 추가합니다.
	    model.addAttribute("outVO", outVO);
	    model.addAttribute("trainee", userTrainee);

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
