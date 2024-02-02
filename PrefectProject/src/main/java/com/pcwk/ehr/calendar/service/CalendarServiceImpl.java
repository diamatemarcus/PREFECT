package com.pcwk.ehr.calendar.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.calendar.dao.CalendarDao;
import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.calendar.domain.WeekVO;
import com.pcwk.ehr.cmn.PcwkLogger;

@Service
public class CalendarServiceImpl implements PcwkLogger, CalendarService {

	@Autowired
	CalendarDao dao;
	
	@Override
	public List<WeekVO> doRetrieveMonth(CalendarVO inVO) throws SQLException {
		return dao.doRetrieveMonth(inVO);
	}

}
