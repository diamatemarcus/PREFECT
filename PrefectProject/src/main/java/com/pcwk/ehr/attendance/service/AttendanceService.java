package com.pcwk.ehr.attendance.service;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.attendance.domain.AttendanceVO;

public interface AttendanceService {

	public int doUpdate(AttendanceVO inVO) throws SQLException;
	
	public List<AttendanceVO> doRetrieve(String email) throws SQLException;
	
	public int doSave(AttendanceVO inVO) throws SQLException;
}
