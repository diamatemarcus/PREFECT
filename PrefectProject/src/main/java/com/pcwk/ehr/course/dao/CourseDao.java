package com.pcwk.ehr.course.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.course.domain.CourseVO;
import com.pcwk.ehr.schedule.domain.ScheduleVO;

public interface CourseDao extends WorkDiv<CourseVO> {

	int doSaveCourse(CourseVO inVO) throws SQLException;

	int doSaveAcademy(CourseVO inVO) throws SQLException;

	List<CourseVO> doRetrieveAllCourses(CourseVO inVO) throws SQLException;

	List<CourseVO> doRetrieveAllTrainees(CourseVO inVO) throws SQLException;

	int doDeleteCourse(CourseVO inVO) throws SQLException;

	List<CourseVO> doRetrieveAllAcademys(CourseVO inVO) throws SQLException;

	int doUpdateAcademy(CourseVO inVO) throws SQLException;

	int doDeleteAcademy(CourseVO inVO) throws SQLException;


}