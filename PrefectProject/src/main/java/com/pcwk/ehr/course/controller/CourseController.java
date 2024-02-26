package com.pcwk.ehr.course.controller;

import java.sql.SQLException;
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

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.course.domain.CourseVO;
import com.pcwk.ehr.course.service.CourseService;
import com.pcwk.ehr.user.domain.UserVO;

@Controller
@RequestMapping("course")
public class CourseController implements PcwkLogger{
	
	@Autowired
	CourseService  courseService;
	
	public CourseController () {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ CourseController                        │");
		LOG.debug("└───────────────────────────────────────────┘");
	}

	@GetMapping(value="/moveToTraineeList.do")
	public String moveToTraineeList(CourseVO inVO, Model model, HttpSession httpSession) throws SQLException, EmptyResultDataAccessException{
		String view = "course/course_list";
		
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ moveToCourseList                  │");
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
		
		List<CourseVO> trainees = courseService.doRetrieve(course);
		
		for(CourseVO trainee  :trainees) {
			LOG.debug("trainee:"+trainee.getEmail());
		}
		
		model.addAttribute("trainees", trainees);
		
		return view;
		
	}
}
