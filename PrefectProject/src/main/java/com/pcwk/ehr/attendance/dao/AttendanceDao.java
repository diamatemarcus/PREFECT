package com.pcwk.ehr.attendance.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.attendance.domain.AttendanceVO;
import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.course.domain.CourseVO;
import com.pcwk.ehr.schedule.domain.ScheduleVO;

public interface AttendanceDao extends WorkDiv<AttendanceVO> {

	public List<AttendanceVO> doRetrieve(String email) throws SQLException;
}