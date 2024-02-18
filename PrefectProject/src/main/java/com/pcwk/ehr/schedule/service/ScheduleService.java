package com.pcwk.ehr.schedule.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.schedule.domain.ScheduleVO;

public interface ScheduleService {
	
	public int doUpdate(ScheduleVO inVO) throws SQLException;
	
	public int doDelete(ScheduleVO inVO) throws SQLException;
	
	public ScheduleVO doSelectOne(ScheduleVO inVO) throws SQLException, EmptyResultDataAccessException;
	
	public int doSave(ScheduleVO inVO) throws SQLException;
	
	public List<ScheduleVO> doRetrieve(CalendarVO inVO) throws SQLException;
	
	public List<ScheduleVO> doRetrieve(ScheduleVO inVO) throws SQLException;
	
	public int doDeleteMultiple(int[] scheduleIDs) throws SQLException;
}
