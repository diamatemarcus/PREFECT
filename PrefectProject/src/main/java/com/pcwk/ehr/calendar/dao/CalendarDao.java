package com.pcwk.ehr.calendar.dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.calendar.domain.CalendarVO;

public interface CalendarDao{
	
	public List<CalendarVO> doSelectMonth(CalendarVO inVO) throws SQLException, EmptyResultDataAccessException; 

}