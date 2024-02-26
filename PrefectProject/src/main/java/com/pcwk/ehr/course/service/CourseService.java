package com.pcwk.ehr.course.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.course.domain.CourseVO;

public interface CourseService {
	
	public int doSaveCourse(CourseVO inVO) throws SQLException;

	public int doSaveAcademy(CourseVO inVO) throws SQLException;
	
	public int doSave(CourseVO inVO) throws SQLException;

	public List<CourseVO> doRetrieveAllCourses(CourseVO inVO) throws SQLException;

	public List<CourseVO> doRetrieveAllTrainees(CourseVO inVO) throws SQLException;

	public int doDeleteCourse(CourseVO inVO) throws SQLException;

	public List<CourseVO> doRetrieveAllAcademys(CourseVO inVO) throws SQLException;

	public int doUpdateAcademy(CourseVO inVO) throws SQLException;

	public int doDeleteAcademy(CourseVO inVO) throws SQLException;
	
	public int doDelete(CourseVO inVO) throws SQLException;
	
	public List<CourseVO> doRetrieve(CourseVO inVO) throws SQLException;
	
	public CourseVO doSelectOne(CourseVO inVO) throws SQLException, EmptyResultDataAccessException;
	
	public int doUpdate(CourseVO inVO) throws SQLException ;

}
