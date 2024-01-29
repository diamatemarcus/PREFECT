package com.pcwk.ehr.schedule.service;

import java.sql.SQLException;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.schedule.domain.ScheduleVO;

public interface ScheduleService {
	
	public int doUpdate(ScheduleVO inVO) throws SQLException;
	
	public int doDelete(ScheduleVO inVO) throws SQLException;
	
	public ScheduleVO doSelectOne(ScheduleVO inVO) throws SQLException, EmptyResultDataAccessException;
	
	public int doSave(ScheduleVO inVO) throws SQLException;
	

}
