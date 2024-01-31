package com.pcwk.ehr.calendar.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.calendar.service.CalendarService;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.schedule.domain.ScheduleVO;
import com.pcwk.ehr.schedule.service.ScheduleService;

@Controller
@RequestMapping("calendar")
public class CalendarController implements PcwkLogger{
	
	@Autowired
	CalendarService  calendarService;
	
	public CalendarController () {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ CalendarController                        │");
		LOG.debug("└───────────────────────────────────────────┘");
	}

	
	@GetMapping(value = "/doRetrieveCalendar.do")
	public ModelAndView doRetrieveCalendar(CalendarVO inVO, ModelAndView modelAndView) throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieveCalendar                │");
		LOG.debug("│ CalendarVO                           │"+inVO);
		LOG.debug("└───────────────────────────────────┘");

		//목록조회
		List<CalendarVO>  list = calendarService.doRetrieve(inVO);
		
		modelAndView.addObject("calendarList", list);
		
		//뷰
		modelAndView.setViewName("schedule/calendar");//  /WEB-INF/views/board/board_list.jsp

		return modelAndView;   
	}
		
}
