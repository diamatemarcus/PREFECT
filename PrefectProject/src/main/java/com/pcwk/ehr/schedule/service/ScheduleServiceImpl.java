package com.pcwk.ehr.schedule.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.schedule.dao.ScheduleDao;
import com.pcwk.ehr.schedule.domain.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService, PcwkLogger{

	@Autowired
	private ScheduleDao scheduleDao;
	
	public ScheduleServiceImpl () {
		
	}
	
	@Override
	public int doUpdate(ScheduleVO inVO) throws SQLException {
		return scheduleDao.doUpdate(inVO);
	}

	@Override
	public int doDelete(ScheduleVO inVO) throws SQLException {
		return scheduleDao.doDelete(inVO);
	}

	@Override
	public ScheduleVO doSelectOne(ScheduleVO inVO) throws SQLException, EmptyResultDataAccessException {
		return scheduleDao.doSelectOne(inVO);
	}

	@Override
	public int doSave(ScheduleVO inVO) throws SQLException {
		return scheduleDao.doSave(inVO);
	}

	@Override
	public List<ScheduleVO> doRetrieve(CalendarVO inVO) throws SQLException {
		return scheduleDao.doRetrieve(inVO);
	}

	@Override
	public int doDeleteMultiple(int[] scheduleIDs) throws SQLException {
		return scheduleDao.doDeleteMultiple(scheduleIDs);
	}

}
