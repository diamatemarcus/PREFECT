package com.pcwk.ehr.calendar.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.calendar.domain.WeekVO;


public interface CalendarService {

	public List<WeekVO> doRetrieveMonth(CalendarVO inVO) throws SQLException;
}
