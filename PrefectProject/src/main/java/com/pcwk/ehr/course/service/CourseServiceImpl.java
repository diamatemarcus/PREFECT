package com.pcwk.ehr.course.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.course.dao.CourseDao;
import com.pcwk.ehr.course.domain.CourseVO;

@Service
public class CourseServiceImpl implements CourseService{

	@Autowired
	private CourseDao courseDao;
	
	public CourseServiceImpl() {}
	
	@Override
	public int doSaveCourse(CourseVO inVO) throws SQLException {
		return courseDao.doSaveCourse(inVO);
	}

	@Override
	public int doSaveAcademy(CourseVO inVO) throws SQLException {
		return courseDao.doSaveAcademy(inVO);
	}
	
	@Override
	public int doSave(CourseVO inVO) throws SQLException {
		return courseDao.doSave(inVO);
	}

	@Override
	public List<CourseVO> doRetrieveAllCourses(CourseVO inVO) throws SQLException {
		return courseDao.doRetrieveAllCourses(inVO);
	}

	@Override
	public List<CourseVO> doRetrieveAllTrainees(CourseVO inVO) throws SQLException {
		return courseDao.doRetrieveAllTrainees(inVO);
	}

	@Override
	public int doDeleteCourse(CourseVO inVO) throws SQLException {
		return courseDao.doDeleteCourse(inVO);
	}

	@Override
	public List<CourseVO> doRetrieveAllAcademys(CourseVO inVO) throws SQLException {
		return courseDao.doRetrieveAllAcademys(inVO);
	}

	@Override
	public int doUpdateAcademy(CourseVO inVO) throws SQLException {
		return courseDao.doUpdateAcademy(inVO);
	}

	@Override
	public int doDeleteAcademy(CourseVO inVO) throws SQLException {
		return courseDao.doDeleteAcademy(inVO);
	}

	@Override
	public int doDelete(CourseVO inVO) throws SQLException {
		return courseDao.doDeleteAcademy(inVO);
	}

	@Override
	public List<CourseVO> doRetrieve(CourseVO inVO) throws SQLException {
		return courseDao.doRetrieve(inVO);
	}

	@Override
	public CourseVO doSelectOne(CourseVO inVO) throws SQLException, EmptyResultDataAccessException {
		return courseDao.doSelectOne(inVO);
	}

	@Override
	public int doUpdate(CourseVO inVO) throws SQLException {
		return courseDao.doUpdate(inVO);
	}

	@Override
	public int findAcademySeqByUserEmail(String userEmail) throws SQLException {
		return courseDao.findAcademySeqByUserEmail(userEmail);
	}

}
