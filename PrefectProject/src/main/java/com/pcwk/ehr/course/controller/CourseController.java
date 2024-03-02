package com.pcwk.ehr.course.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.course.domain.CourseVO;
import com.pcwk.ehr.course.service.CourseService;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller
@RequestMapping("course")
public class CourseController implements PcwkLogger{
	
	@Autowired
	CourseService  courseService;
	
	@Autowired
	UserService  userService;
	
	public CourseController () {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ CourseController                        │");
		LOG.debug("└───────────────────────────────────────────┘");
	}
	
	@GetMapping(value = "/doRetrieve.do")
	public List<CourseVO> doRetrieve(CourseVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieve                        │");
		LOG.debug("│ CourseVO                          │"+inVO);
		LOG.debug("└───────────────────────────────────┘");
		
		List<CourseVO> list = new ArrayList<CourseVO>();
		
		list = courseService.doRetrieve(inVO);
		
		return list;
	}

	@GetMapping(value="/doRetrieveAllTrainees.do")
	public String doRetrieveAllTrainees(CourseVO inVO, Model model, HttpSession httpSession) throws SQLException, EmptyResultDataAccessException{
		String view = "course/course_list";
		
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieveAllTrainees             │");
		LOG.debug("│ CourseVO                          │"+inVO);
		LOG.debug("└───────────────────────────────────┘");		
	
		
		CourseVO course = new CourseVO();
		
		if(null != httpSession.getAttribute("user")) {
			UserVO user = (UserVO) httpSession.getAttribute("user");
			LOG.debug("email:"+user.getEmail());
			course.setEmail(user.getEmail());
		}
		
		course = courseService.doSelectOne(course);
		LOG.debug("course:"+course);
		
		// 목록 조회
		List<CourseVO> trainees = courseService.doRetrieve(course);
		
		for(CourseVO trainee  :trainees) {
			LOG.debug("trainee:"+trainee.getEmail());
		}
		
		// 유저 조회
		List<UserVO>  users = new ArrayList<UserVO>();
		
		for (CourseVO courseVO : trainees) {
			LOG.debug("courseVO:" + courseVO);
			UserVO userVO = new UserVO();
			userVO.setEmail(courseVO.getEmail());
			LOG.debug("userVO:" + userVO);
			
			userVO = userService.doSelectOne(userVO);
			users.add(userVO);
			
			LOG.debug("users:" + users);
		}
		
		
		model.addAttribute("trainees", trainees);
		
		//유저 정보
		model.addAttribute("users",users);		
		
		return view;
		
	}
	
	// 코스 리스트
	@GetMapping(value = "/moveToList.do")
	public String moveToList(Model model, HttpSession httpSession) throws SQLException {
		String viewName = "course/course_list";
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ moveToList                        │");
		LOG.debug("└───────────────────────────────────┘");		
		
		// 세션에서 로그인한 사용자 정보를 가져옵니다.
		UserVO user = (UserVO) httpSession.getAttribute("user");
		
		try {
	        // 사용자 이메일로 학원 시퀀스를 조회
	        int academySeq = courseService.findAcademySeqByUserEmail(user.getEmail());

	        // 학원 시퀀스가 유효한 경우에만 코스 목록 조회
	        if(academySeq != -1) {
	            CourseVO inVO = new CourseVO();
	            inVO.setAcademySeq(academySeq);
	            List<CourseVO> courseList = courseService.doRetrieveAllCourses(inVO);
	            model.addAttribute("courseList", courseList);
	        } else {
	            // 유효한 학원 시퀀스가 없는 경우 (사용자가 어떤 코스에도 등록되지 않았을 때)
	            model.addAttribute("message", "등록된 학원이 없습니다.");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        model.addAttribute("message", "과정 정보를 조회하는 중 오류가 발생했습니다.");
	        return "common/error";
	    }
		
		return viewName;
	}
}
