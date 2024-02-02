package com.pcwk.ehr.calendar.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.calendar.domain.WeekVO;

public interface CalendarDao{
	
	public List<WeekVO> doRetrieveMonth(CalendarVO inVO) throws SQLException, EmptyResultDataAccessException; 

}