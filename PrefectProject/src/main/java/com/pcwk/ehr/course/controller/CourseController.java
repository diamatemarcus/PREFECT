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
import org.springframework.web.servlet.ModelAndView;

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
	
//	// 학원관리자 : 학원에 등록된 모든 과정 조회
//	@GetMapping(value="/doRetrieveAllCourses.do")
//	public String doRetrieveAllCourses(CourseVO inVO, HttpSession session, Model model) throws SQLException, EmptyResultDataAccessException{
//		String view = "course/course_list";
//		LOG.debug("┌───────────────────────────────────┐");
//		LOG.debug("│ doRetrieveAllCourses              │");
//		LOG.debug("│ CourseVO                          │"+inVO);
//		LOG.debug("└───────────────────────────────────┘");		
//		
//		// 로그인한 학원 관리자의 학원 SEQ 가져오기
//        inVO.setAcademySeq((int) session.getAttribute("academySeq"));
//        LOG.debug("현재 세션 academySeq:" + inVO.getAcademySeq());
//	
//		//목록조회
//		List<CourseVO> list = courseService.doRetrieveAllCourses(inVO);
//		LOG.debug("list:" + list);
//		
//		//Model
//		model.addAttribute("list", list);
//		
//		return view;	
//	}
	
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
		
		List<CourseVO> trainees = courseService.doRetrieve(course);
		
		for(CourseVO trainee  :trainees) {
			LOG.debug("trainee:"+trainee.getEmail());
		}
		
		model.addAttribute("trainees", trainees);
		
		return view;
		
	}
}
