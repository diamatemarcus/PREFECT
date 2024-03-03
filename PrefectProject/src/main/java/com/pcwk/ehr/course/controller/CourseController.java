package com.pcwk.ehr.course.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
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
	
	@Autowired
	CodeService  codeService;
	
	public CourseController () {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ CourseController                          │");
		LOG.debug("└───────────────────────────────────────────┘");
	}
	
	@PostMapping(value = "/doSave.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MessageVO doSave(CourseVO inVO, HttpSession httpSession) throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSave                            │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");			
		
		// 세션에서 로그인한 사용자 정보를 가져옵니다.
		UserVO user = (UserVO) httpSession.getAttribute("user");
		
		inVO.setAcademySeq(courseService.findAcademySeqByUserEmail(user.getEmail()));
		
		int flag = courseService.doSaveCourse(inVO);
		
		String message = "";
		if(1 == flag) {
			message = "등록 되었습니다.";
		}else {
			message = "등록이 실패되었습니다.";
		}
		
		MessageVO  messageVO=new MessageVO(String.valueOf(flag), message);
		LOG.debug("│ messageVO                           │"+messageVO);
		return messageVO;
	}
	
	@GetMapping(value="/moveToReg.do")//저 url로 get매핑함
	public String moveToReg(Model model, CourseVO inVO, HttpSession session) throws SQLException {
		String viewName = "";
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ moveToReg                         │");
		LOG.debug("└───────────────────────────────────┘");	
		
		// 세션에서 로그인한 사용자 정보를 가져옵니다.
	    UserVO user = (UserVO) session.getAttribute("user");
	    if (user != null) {
	        try {
	            int academySeq = courseService.findAcademySeqByUserEmail(user.getEmail());
	            // 모델에 academySeq 추가
	            model.addAttribute("academysSeq", academySeq);
	        } catch (SQLException e) {
	            LOG.error("SQL 오류", e);
	            // 오류 처리
	        }
	    }
				 				
		viewName = "course/course_reg";///WEB-INF/views/ viewName .jsp
		return viewName;
	}
	
	@GetMapping(value = "/doRetrieveAllCourses.do")
	public ModelAndView doRetrieveAllCourses(CourseVO inVO, ModelAndView modelAndView) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieveAllCourses              │");
		LOG.debug("│ CourseVO                          │"+inVO);
		LOG.debug("└───────────────────────────────────┘");
		
		//페이지 사이즈:10
		if(null != inVO && inVO.getPageSize() == 0) {
			inVO.setPageSize(10L);
		}

		//페이지 번호:1
		if(null != inVO && inVO.getPageNo() == 0) {
			inVO.setPageNo(1L);
		}
		
		//검색구분:""
		if(null != inVO && null == inVO.getSearchDiv()) {
			inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchDiv()));
		}
		//검색어:""
		if(null != inVO && null == inVO.getSearchWord()) {
			inVO.setSearchDiv(StringUtil.nvl(inVO.getSearchWord()));
		}
		LOG.debug("│ BoardVO Default처리                          │"+inVO);
		
		//코드목록 조회 : 'PAGE_SIZE','BOARD_SEARCH'
		Map<String, Object> codes =new HashMap<String, Object>();
		String[] codeStr = {"PAGE_SIZE","COURSE_SEARCH"};
		
		codes.put("code", codeStr);
		List<CodeVO> codeList = this.codeService.doRetrieve(codes);
		
		List<CodeVO> courseSearchList=new ArrayList<CodeVO>();
		List<CodeVO> pageSizeList=new ArrayList<CodeVO>();
		
		
		for(CodeVO vo :codeList) {
			if(vo.getMstCode().equals("COURSE_SEARCH")) {
				courseSearchList.add(vo);
			}
			
			if(vo.getMstCode().equals("PAGE_SIZE")) {
				pageSizeList.add(vo);
			}	
			//LOG.debug(vo);
		}
		
		List<CourseVO> list = courseService.doRetrieve(inVO);
		
		List<UserVO>  users = new ArrayList<UserVO>();
				
		for (CourseVO courseVO : list) {
			LOG.debug("courseVO:" + courseVO);
			UserVO userVO = new UserVO();
			userVO.setEmail(courseVO.getEmail());
			LOG.debug("userVO:" + userVO);
			
			userVO = userService.doSelectOne(userVO);
			users.add(userVO);
			
			LOG.debug("users:" + users);
		}
		
		long totalCnt = 0;
		//총글수 
		for(CourseVO vo  :list) {
			if(totalCnt == 0) {
				totalCnt = vo.getTotalCnt();
				break;
			}
		}
		
		modelAndView.addObject("totalCnt", totalCnt);
		modelAndView.setViewName("course/course_list");
		modelAndView.addObject("list", list);
		modelAndView.addObject("paramVO", inVO); //검색데이터
		modelAndView.addObject("boardSearch", courseSearchList); //검색조건
		modelAndView.addObject("pageSize",pageSizeList); //페이지 사이즈
		modelAndView.addObject("users",users); //유저 정보
		
		//페이징
		long bottomCount = StringUtil.BOTTOM_COUNT;//바닥글
		String html = StringUtil.renderingPager(totalCnt, inVO.getPageNo(), inVO.getPageSize(), bottomCount,
				"/ehr/course/doRetrieve.do", "pageDoRerive");
		modelAndView.addObject("pageHtml", html);
		
		return modelAndView;
	}

//	@GetMapping(value="/doRetrieveAllTrainees.do")
//	public String doRetrieveAllTrainees(CourseVO inVO, Model model, HttpSession httpSession) throws SQLException, EmptyResultDataAccessException{
//		String view = "course/course_list";
//		
//		LOG.debug("┌───────────────────────────────────┐");
//		LOG.debug("│ doRetrieveAllTrainees             │");
//		LOG.debug("│ CourseVO                          │"+inVO);
//		LOG.debug("└───────────────────────────────────┘");		
//	
//		
//		CourseVO course = new CourseVO();
//		
//		if(null != httpSession.getAttribute("user")) {
//			UserVO user = (UserVO) httpSession.getAttribute("user");
//			LOG.debug("email:"+user.getEmail());
//			course.setEmail(user.getEmail());
//		}
//		
//		course = courseService.doSelectOne(course);
//		LOG.debug("course:"+course);
//		
//		// 목록 조회
//		List<CourseVO> trainees = courseService.doRetrieve(course);
//		
//		for(CourseVO trainee  :trainees) {
//			LOG.debug("trainee:"+trainee.getEmail());
//		}
//		
//		// 유저 조회
//		List<UserVO>  users = new ArrayList<UserVO>();
//		
//		for (CourseVO courseVO : trainees) {
//			LOG.debug("courseVO:" + courseVO);
//			UserVO userVO = new UserVO();
//			userVO.setEmail(courseVO.getEmail());
//			LOG.debug("userVO:" + userVO);
//			
//			userVO = userService.doSelectOne(userVO);
//			users.add(userVO);
//			
//			LOG.debug("users:" + users);
//		}
//		
//		
//		model.addAttribute("trainees", trainees);
//		
//		//유저 정보
//		model.addAttribute("users",users);		
//		
//		return view;
//		
//	}
	
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
