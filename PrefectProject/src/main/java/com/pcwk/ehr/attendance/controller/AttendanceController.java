package com.pcwk.ehr.attendance.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pcwk.ehr.attendance.domain.AttendanceVO;
import com.pcwk.ehr.attendance.service.AttendanceService;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.course.domain.CourseVO;
import com.pcwk.ehr.course.service.CourseService;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller
@RequestMapping("attendance")
public class AttendanceController implements PcwkLogger{

	@Autowired
	CodeService codeService;
	
	@Autowired
	CourseService  courseService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	AttendanceService attendanceService;
	
	public AttendanceController () {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ CourseController                        │");
		LOG.debug("└───────────────────────────────────────────┘");
	}

	@GetMapping(value="/moveToAttendance.do")
	public String moveToTraineeList(AttendanceVO inVO, Model model, HttpSession httpSession) throws SQLException, EmptyResultDataAccessException{
		String view = "attendance/attendance";
		
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ moveToCourseList                  │");
		LOG.debug("│ AttendanceVO                      │"+inVO);
		LOG.debug("└───────────────────────────────────┘");		
	
		//로그인 한 사람의 코스정보 가져오기
		CourseVO course = new CourseVO();
		if(null != httpSession.getAttribute("user")) {
			UserVO user = (UserVO) httpSession.getAttribute("user");
			LOG.debug("email:"+user.getEmail());
			course.setEmail(user.getEmail());
		}
		
		course = courseService.doSelectOne(course);
		LOG.debug("course:"+course);
		
		//로그인한 사람이 교수님이면 그 코스를 수강하는 훈련생들 리스트 가져오기
		List<CourseVO> courses = courseService.doRetrieve(course);
		List<UserVO> trainees = new ArrayList<UserVO>();
		
		for(CourseVO courseVO  :courses) {
			LOG.debug("courseVO:"+courseVO);
			UserVO userVO = new UserVO ();
			userVO.setEmail(courseVO.getEmail());
			userVO = userService.doSelectOne(userVO);
			trainees.add(userVO);
		}
		
		for(UserVO user  :trainees) {
			LOG.debug("user:"+user);
		}
		
		
		//코드목록 조회 : 'ATTEND_STAUS'
		Map<String, Object> codes =new HashMap<String, Object>();
		String[] codeStr = {"ATTEND_STATUS"};
		codes.put("code", codeStr);
		
		List<CodeVO> codeList = codeService.doRetrieve(codes);
		
		List<CodeVO> attendStatusList = new ArrayList<CodeVO>();
		
		for(CodeVO vo: codeList) {
			if(vo.getMstCode().equals("ATTEND_STATUS")) {
				attendStatusList.add(vo);
			}
			LOG.debug(vo);
		}
		
		model.addAttribute("attendStatusList", attendStatusList);
		model.addAttribute("trainees", trainees);
		
		return view;
		
	}
}
