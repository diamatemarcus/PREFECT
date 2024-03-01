package com.pcwk.ehr.attendance.controller;

import java.sql.SQLException;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.attendance.domain.AttendanceVO;
import com.pcwk.ehr.attendance.service.AttendanceService;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.code.service.CodeService;
import com.pcwk.ehr.course.domain.CourseVO;
import com.pcwk.ehr.course.service.CourseService;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;

@Controller
@RequestMapping("attendance")
public class AttendanceController implements PcwkLogger {

	@Autowired
	CodeService codeService;

	@Autowired
	CourseService courseService;

	@Autowired
	UserService userService;

	@Autowired
	AttendanceService attendanceService;

	public AttendanceController() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ CourseController                        │");
		LOG.debug("└───────────────────────────────────────────┘");
	}
	
	// 출석 리스트
	@GetMapping(value = "/moveToAttendance.do")
	public String moveToTraineeList(AttendanceVO inVO, Model model, HttpSession httpSession)
			throws SQLException, EmptyResultDataAccessException, ParseException {
		String view = "attendance/attendance_list";

		if (inVO != null && inVO.getCalID() == 0) {
			// 현재 날짜 가져오기
			LocalDate currentDate = LocalDate.now();
			// LocalDate를 "yyyyMMdd" 형식의 정수로 변환
			int calID = Integer.parseInt(currentDate.format(DateTimeFormatter.ofPattern("yyyyMMdd")));

			// inVO에 설정
			inVO.setCalID(calID);
		}

		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ moveToTraineeList                  │");
		LOG.debug("│ AttendanceVO                      │" + inVO);
		LOG.debug("└───────────────────────────────────┘");

		// 로그인 한 회원의 정보
		UserVO user = new UserVO();

		// 로그인 한 사람이 교수님일 때 훈련생들의 회원정보
		List<UserVO> trainees = new ArrayList<UserVO>();

		// 로그인 한 사람이 교수님일 때 훈련생들 리스트의 출석정보
		List<AttendanceVO> attendances = new ArrayList<AttendanceVO>();

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
				AttendanceVO attendanceVO = new AttendanceVO();
				attendanceVO.setTrainee(userVO.getEmail());
				attendanceVO.setCalID(inVO.getCalID());
				attendanceVO = attendanceService.doSelectOne(attendanceVO);
				if (attendanceVO != null)
					attendances.add(attendanceVO);
			}
		 }

		// 코드목록 조회 : 'ATTEND_STAUS'
		Map<String, Object> codes = new HashMap<String, Object>();
		String[] codeStr = { "ATTEND_STATUS" };
		codes.put("code", codeStr);

		List<CodeVO> codeList = codeService.doRetrieve(codes);

		List<CodeVO> attendStatusList = new ArrayList<CodeVO>();

		for (CodeVO vo : codeList) {
			if (vo.getMstCode().equals("ATTEND_STATUS")) {
				attendStatusList.add(vo);
			}
			LOG.debug(vo);
		}

		model.addAttribute("attendStatusList", attendStatusList);
		model.addAttribute("trainees", trainees);
		model.addAttribute("attendances", attendances);
		model.addAttribute("course", course);

		return view;

	}

	// 등록
	@RequestMapping(value = "/doSave.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doSave(AttendanceVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSave()                                  │inVO:" + inVO);
		LOG.debug("└───────────────────────────────────────────┘");

		int flag = attendanceService.doSave(inVO);
		String message = "";

		if (1 == flag) {
			message = inVO.getTrainee() + "가 등록 되었습니다.";
		} else if (2 == flag) {
			message = inVO.getTrainee() + "가 이미 등록 되었습니다.";
		} else {
			message = "등록 실패.";
		}

		MessageVO messageVO = new MessageVO(flag + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:" + jsonString);

		return jsonString;
	}

	// 수정
	@RequestMapping(value = "/doUpdate.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody // HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doUpdate(AttendanceVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doUpdate()                                  │inVO:" + inVO);
		LOG.debug("└───────────────────────────────────────────┘");

		int flag = this.attendanceService.doUpdate(inVO);
		String message = "";
		if (1 == flag) {
			message = inVO.getTrainee() + "의 출석 정보가 수정 되었습니다.";
		} else {
			message = inVO.getTrainee() + "수정 실패";
		}
		MessageVO messageVO = new MessageVO(flag + "", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:" + jsonString);

		return jsonString;
	}

	// 출석 현황
	@GetMapping(value = "/moveToAttendStatus.do")
	public String moveToAttendStatus(AttendanceVO inVO, Model model, HttpSession httpSession)
			throws SQLException, EmptyResultDataAccessException, ParseException {
		String view = "attendance/attend_status";

		//날짜 default 처리
		if (inVO != null && inVO.getCalID() == 0) {
			// 현재 날짜 가져오기
			LocalDate currentDate = LocalDate.now();
			// LocalDate를 "yyyyMMdd" 형식의 정수로 변환
			int calID = Integer.parseInt(currentDate.format(DateTimeFormatter.ofPattern("yyyyMMdd")));

			// inVO에 설정
			inVO.setCalID(calID);
		}

		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ moveToAttendStatus                │");
		LOG.debug("│ AttendanceVO                      │" + inVO);
		LOG.debug("└───────────────────────────────────┘");

		// 로그인 한 회원의 정보
		UserVO user = new UserVO();
		
		// 로그인 한 사람의 코스정보 가져오기
		CourseVO course = new CourseVO();
		if (null != httpSession.getAttribute("user")) {
			user = (UserVO) httpSession.getAttribute("user");
			LOG.debug("email:" + user.getEmail());
			course.setEmail(user.getEmail());
		}
		course = courseService.doSelectOne(course);
		LOG.debug("course:" + course);
		
		List<AttendanceVO> attendances = new ArrayList<AttendanceVO>();
		AttendanceVO attendanceVO = new AttendanceVO();
		
		// 주어진 코스의 시작일과 종료일 사이에 오늘 날짜가 있는지 확인합니다.
		if (!LocalDate.parse(course.getStartDate()).isAfter(LocalDate.now()) && 
			    !LocalDate.parse(course.getEndDate()).isBefore(LocalDate.now())) {
		
			// 로그인한 훈련생의 모든 출석정보
			attendances = attendanceService.doRetrieve(user.getEmail());
	
			// 로그인한 훈련생의 그 날의 출석정보 조회
			LOG.debug("sessionUser:" + user);
			attendanceVO.setTrainee(user.getEmail());
			attendanceVO.setCalID(inVO.getCalID());
			attendanceVO = attendanceService.doSelectOne(attendanceVO);
		
		}
		
		// 코드목록 조회 : 'ATTEND_STAUS'
		Map<String, Object> codes = new HashMap<String, Object>();
		String[] codeStr = { "ATTEND_STATUS" };
		codes.put("code", codeStr);

		List<CodeVO> codeList = codeService.doRetrieve(codes);

		List<CodeVO> attendStatusList = new ArrayList<CodeVO>();

		for (CodeVO vo : codeList) {
			if (vo.getMstCode().equals("ATTEND_STATUS")) {
				attendStatusList.add(vo);
			}
			LOG.debug(vo);
		}

		model.addAttribute("attendStatusList", attendStatusList);
		model.addAttribute("attendanceVO", attendanceVO);
		model.addAttribute("attendances", attendances);
		model.addAttribute("course", course);
		
		return view;

	}
	
	    // 출석 현황
		@GetMapping(value = "/moveToCourseInfo.do")
		public String moveToCourseInfo(AttendanceVO inVO, Model model, HttpSession httpSession)
				throws SQLException, EmptyResultDataAccessException, ParseException {
			String view = "course/course_info";

			LOG.debug("┌───────────────────────────────────┐");
			LOG.debug("│ moveToAttendStatus                │");
			LOG.debug("│ AttendanceVO                      │" + inVO);
			LOG.debug("└───────────────────────────────────┘");

			// 로그인 한 회원의 정보
			UserVO user = new UserVO();
			
			// 로그인 한 사람의 코스정보 가져오기
			CourseVO course = new CourseVO();
			if (null != httpSession.getAttribute("user")) {
				user = (UserVO) httpSession.getAttribute("user");
				LOG.debug("email:" + user.getEmail());
				course.setEmail(user.getEmail());
			}
			course = courseService.doSelectOne(course);
			LOG.debug("course:" + course);
			
			// 로그인한 훈련생의 모든 출석정보
			List<AttendanceVO> attendances = attendanceService.doRetrieve(user.getEmail());

			model.addAttribute("attendances", attendances);
			model.addAttribute("course", course);
			
			return view;

		}

}
