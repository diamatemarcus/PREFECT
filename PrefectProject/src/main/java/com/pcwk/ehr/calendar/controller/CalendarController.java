package com.pcwk.ehr.calendar.controller;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;

import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.calendar.domain.WeekVO;
import com.pcwk.ehr.calendar.service.CalendarService;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;


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
	public String doRetrieveCalendar(CalendarVO inVO, Model model) throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doRetrieveCalendar                │");
		LOG.debug("│ CalendarVO                        │"+inVO);
		LOG.debug("└───────────────────────────────────┘");
		
		//월
		if (inVO != null && inVO.getMonth() == null && inVO.getYear() == null) {
		    LocalDate currentDate = LocalDate.now();
		    String currentYear = currentDate.format(DateTimeFormatter.ofPattern("yyyy"));
		    String currentMonth = currentDate.format(DateTimeFormatter.ofPattern("MM"));
		    inVO.setYear(currentYear);
		    inVO.setMonth(currentMonth);
		}
		
		//목록조회
		List<WeekVO>  list = calendarService.doRetrieveMonth(inVO);
		String year = inVO.getYear();
		String month = inVO.getMonth();
		
		model.addAttribute("calendarList", list);
		model.addAttribute("year", year);
		model.addAttribute("month", month);	
		
		//뷰
//		modelAndView.setViewName("schedule/calendar");//  /WEB-INF/views/board/board_list.jsp

		return "schedule/calendar";   
	}
		
}
