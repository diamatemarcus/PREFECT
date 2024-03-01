package com.pcwk.ehr.course.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.course.domain.CourseVO;

@Repository
public class CourseDaoImpl implements CourseDao {
	
	final Logger LOG = LogManager.getLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.course";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public CourseDaoImpl() {}

	//수강 포기
	@Override
	public int doDelete(CourseVO inVO) throws SQLException {
		int flag = 0;

		//----------------------------------------------------------------------
		String statement = this.NAMESPACE+this.DOT+"doDelete";
		LOG.debug("1.param \n" + inVO.toString());
		LOG.debug("2.statement \n" + statement);
		
		flag=this.sqlSessionTemplate.delete(statement, inVO);
		
		LOG.debug("3.flag \n" + flag);
		//----------------------------------------------------------------------
		return flag;
	}
	
	//학원관리자, 시스템관리자가 코스 정보 삭제 
	@Override
	public int doDeleteCourse(CourseVO inVO) throws SQLException {
		int flag = 0;

		//----------------------------------------------------------------------
		String statement = this.NAMESPACE+this.DOT+"doDeleteCourse";
		LOG.debug("1.param \n" + inVO.toString());
		LOG.debug("2.statement \n" + statement);
		
		flag=this.sqlSessionTemplate.delete(statement, inVO);
		
		LOG.debug("3.flag \n" + flag);
		//----------------------------------------------------------------------
		return flag;
	}
	
	//시스템관리자가 학원 정보 삭제
	@Override
	public int doDeleteAcademy(CourseVO inVO) throws SQLException {
		int flag = 0;

		//----------------------------------------------------------------------
		String statement = this.NAMESPACE+this.DOT+"doDeleteAcademy";
		LOG.debug("1.param \n" + inVO.toString());
		LOG.debug("2.statement \n" + statement);
		
		flag=this.sqlSessionTemplate.delete(statement, inVO);
		
		LOG.debug("3.flag \n" + flag);
		//----------------------------------------------------------------------
		return flag;
	}



	//과정 추가
	@Override
	public int doSaveCourse(CourseVO inVO) throws SQLException {
		int flag = 0;
		LOG.debug("1.param \n" + inVO.toString());
		//----------------------------------------------------------------------

		String statement = this.NAMESPACE+DOT+"doSaveCourse";
		LOG.debug("2.statement \n" + statement);
		flag = this.sqlSessionTemplate.insert(statement, inVO);
		LOG.debug("3.flag \n" + flag);
		
		return flag;
	}
	
	//학원 추가
	@Override
	public int doSaveAcademy(CourseVO inVO) throws SQLException {
		int flag = 0;
		LOG.debug("1.param \n" + inVO.toString());
		//----------------------------------------------------------------------

		String statement = this.NAMESPACE+DOT+"doSaveAcademy";
		LOG.debug("2.statement \n" + statement);
		flag = this.sqlSessionTemplate.insert(statement, inVO);
		LOG.debug("3.flag \n" + flag);
		
		return flag;
	}
	
	//학생을 과정에 추가
	@Override
	public int doSave(CourseVO inVO) throws SQLException {
		int flag = 0;
		LOG.debug("1.param \n" + inVO.toString());
		//----------------------------------------------------------------------

		String statement = this.NAMESPACE+DOT+"doSave";
		LOG.debug("2.statement \n" + statement);
		flag = this.sqlSessionTemplate.insert(statement, inVO);
		LOG.debug("3.flag \n" + flag);
		
		return flag;
	}
	
	//교수의 코스를 수강하는 학생들 조회
	@Override
	public List<CourseVO> doRetrieve(CourseVO inVO) throws SQLException {
		List<CourseVO> outList=new ArrayList<CourseVO>();
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT +"doRetrieve";
		LOG.debug("2.statement \n" + statement);
		
		outList=this.sqlSessionTemplate.selectList(statement, inVO);
		
		for(CourseVO vo :outList) {
			LOG.debug(vo);
		}		
		return outList;
	}
	
	//학원관리자가 학원을 다니는 학생들 조회
	@Override
	public List<CourseVO> doRetrieveAllTrainees(CourseVO inVO) throws SQLException {
		List<CourseVO> outList=new ArrayList<CourseVO>();
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT +"doRetrieveAllTrainees";
		LOG.debug("2.statement \n" + statement);
		
		outList=this.sqlSessionTemplate.selectList(statement, inVO);
		
		for(CourseVO vo :outList) {
			LOG.debug(vo);
		}		
		return outList;
	}

	//학원관리자가 학원의 모든 코스들 조회
	@Override
	public List<CourseVO> doRetrieveAllCourses(CourseVO inVO) throws SQLException {
		List<CourseVO> outList=new ArrayList<CourseVO>();
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT +"doRetrieveAllCourses";
		LOG.debug("2.statement \n" + statement);
		
		outList=this.sqlSessionTemplate.selectList(statement, inVO);
		
		for(CourseVO vo :outList) {
			LOG.debug(vo);
		}		
		return outList;
	}
	
	//시스템관리자가 모든 학원의 모든 코스들 조회
	@Override
	public List<CourseVO> doRetrieveAllAcademys(CourseVO inVO) throws SQLException {
		List<CourseVO> outList=new ArrayList<CourseVO>();
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT +"doRetrieveAllAcademys";
		LOG.debug("2.statement \n" + statement);
		
		outList=this.sqlSessionTemplate.selectList(statement, inVO);
		
		for(CourseVO vo :outList) {
			LOG.debug(vo);
		}		
		return outList;
	}
	
	//교수나, 학생이 포함된 과정 정보 조회 
	@Override
	public CourseVO doSelectOne(CourseVO inVO) throws SQLException, EmptyResultDataAccessException {
		CourseVO course = new CourseVO ();
		
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT +"doRetrieveCourseInfo";
		LOG.debug("2.statement \n" + statement);
		
		course=this.sqlSessionTemplate.selectOne(statement, inVO);
		
		return course;
	}
	
	//학원관리자, 시스템관리자가 코스 정보 수정
	@Override
	public int doUpdate(CourseVO inVO) throws SQLException {
		int flag = 0;

		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"doUpdateCourse";
		LOG.debug("2.statement \n" + statement);
		flag=this.sqlSessionTemplate.update(statement, inVO);
		
		LOG.debug("3.flag \n" + flag);
		return flag;
	}
	
	//학원관리자, 시스템관리자가 학원 정보 수정
	@Override
	public int doUpdateAcademy(CourseVO inVO) throws SQLException {
		int flag = 0;

		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"doUpdateAcademy";
		LOG.debug("2.statement \n" + statement);
		flag=this.sqlSessionTemplate.update(statement, inVO);
		
		LOG.debug("3.flag \n" + flag);
		return flag;
	}

	//사용자 이메일로 코스 정보 조회
	@Override
	public int  findAcademySeqByUserEmail(String userEmail) throws SQLException {
		// 사용자 이메일로 USERS_COURSES에서 COURSES_CODE를 조회
	    String statement = NAMESPACE + DOT + "findCourseCodesByUserEmail";
	    List<Integer> courseCodes = sqlSessionTemplate.selectList(statement, userEmail);
	    
	    // 등록된 코스가 없으면 -1 또는 예외 처리
	    if(courseCodes.isEmpty()) {
	        return -1;
	    }

	    // COURSES_CODE로 COURSES에서 ACADEMYS_SEQ를 찾음
	    statement = NAMESPACE + DOT + "findAcademySeqByCourseCode";
	    Integer academySeq = sqlSessionTemplate.selectOne(statement, courseCodes.get(0));

	    return academySeq;
	}

}

