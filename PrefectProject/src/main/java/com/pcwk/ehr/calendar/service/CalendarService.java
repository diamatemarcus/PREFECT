package com.pcwk.ehr.calendar.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.calendar.domain.CalendarVO;


public interface CalendarService {

	public List<CalendarVO> doRetrieve(CalendarVO inVO) throws SQLException;
}
