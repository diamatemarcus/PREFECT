package com.pcwk.ehr.attendance.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.attendance.dao.AttendanceDao;
import com.pcwk.ehr.attendance.domain.AttendanceVO;

@Service
public class AttendanceServiceImpl implements AttendanceService{
	
	@Autowired
	private AttendanceDao attendanceDao;
	
	public AttendanceServiceImpl() {}

	@Override
	public int doUpdate(AttendanceVO inVO) throws SQLException {
		return attendanceDao.doUpdate(inVO);
	}

	@Override
	public List<AttendanceVO> doRetrieve(String email) throws SQLException {
		return attendanceDao.doRetrieve(email);
	}
	
	@Override
	public int doSave(AttendanceVO inVO) throws SQLException {
		return attendanceDao.doSave(inVO);
	}

}
