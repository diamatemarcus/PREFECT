package com.pcwk.ehr.subject.controller;

import java.sql.SQLException;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.attendance.domain.AttendanceVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.course.domain.CourseVO;
import com.pcwk.ehr.course.service.CourseService;
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
	
	@Autowired
	CourseService courseService;
	
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
	
	    // 출석 리스트
		@GetMapping(value = "/moveToSubjectReg.do")
		public String moveToTraineeList(SubjectVO inVO, Model model, HttpSession httpSession)
				throws SQLException, EmptyResultDataAccessException, ParseException {
			String view = "subject/subject";


			if (inVO != null && inVO.getSubjectCode() == 0) {

				// inVO에 설정
				inVO.setSubjectCode(10);
			}
			
			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ moveToTraineeList                 │");
			LOG.debug("│ SubjectVO                         │" + inVO);
			LOG.debug("└───────────────────────────────────┘");

			// 로그인 한 회원의 정보
			UserVO user = new UserVO();

			// 로그인 한 사람이 교수님일 때 훈련생들의 회원정보
			List<UserVO> trainees = new ArrayList<UserVO>();

			// 로그인 한 사람이 교수님일 때 훈련생들 리스트의 성적 정보
			List<SubjectVO> subjectScores = new ArrayList<SubjectVO>();

			// 로그인 한 사람이 교수님일 때 훈련생들의 리스트
			List<CourseVO> courses = new ArrayList<CourseVO>();

			// 로그인 한 사람의 코스정보 가져오기
			CourseVO course = new CourseVO();
			if (null != httpSession.getAttribute("user")) {
				user = (UserVO) httpSession.getAttribute("user");
				LOG.debug("email:" + user.getEmail());
				course.setEmail(user.getEmail());
			}
			course = courseService.doSelectOne(course);
			LOG.debug("course:" + course);

			// 주어진 코스의 시작일과 종료일 사이에 오늘 날짜가 있는지 확인합니다.
			if (!LocalDate.parse(course.getStartDate()).isAfter(LocalDate.now()) && 
				    !LocalDate.parse(course.getEndDate()).isBefore(LocalDate.now())) {
				// 로그인한 사람이 교수님이면 그 코스를 수강하는 훈련생들 리스트와 회원 정보 가져오기
				courses = courseService.doRetrieve(course);
		
				for (CourseVO courseVO : courses) {
					LOG.debug("courseVO:" + courseVO);
					UserVO userVO = new UserVO();
					userVO.setEmail(courseVO.getEmail());
					userVO = userService.doSelectOne(userVO);
					trainees.add(userVO);
				}
		
				for (UserVO userVO : trainees) {
					LOG.debug("userVO:" + userVO);
					SubjectVO subjectVO = new SubjectVO();
					subjectVO.setTrainee(userVO.getEmail());
					subjectVO.setCoursesCode(course.getCourseCode());
					subjectVO.setSubjectCode(inVO.getSubjectCode());
					subjectVO = subjectService.doSelectOne(subjectVO);
					if (subjectVO != null)
						subjectScores.add(subjectVO);
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

			model.addAttribute("subjectCodeList", subjectCodeList);
			model.addAttribute("trainees", trainees);
			model.addAttribute("subjectScores", subjectScores);
			model.addAttribute("course", course);

			return view;

		}
	

	
    //단건조회
    @RequestMapping(value="/doSelectOne.do", method = RequestMethod.GET)
    public String doSelectOne(@RequestParam("trainee") String trainee,
                              @RequestParam("subjectCode") int subjectCode,
                              @RequestParam("coursesCode") int coursesCode,
                              Model model) throws SQLException {
        String view = "subject/subject_mod";

        // 조회 로직 구현...
        SubjectVO result = subjectService.doSelectOne(subjectVO); // 단건 조회 서비스 호출
        model.addAttribute("subject", result); // 조회 결과를 모델에 추가
        return view; // 상세 정보를 표시할 JSP 페이지 반환
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
