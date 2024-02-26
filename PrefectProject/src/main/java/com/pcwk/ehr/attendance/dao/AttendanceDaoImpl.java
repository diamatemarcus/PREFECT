package com.pcwk.ehr.attendance.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.attendance.domain.AttendanceVO;
import com.pcwk.ehr.course.domain.CourseVO;

@Repository
public class AttendanceDaoImpl implements AttendanceDao {
	
	final Logger LOG = LogManager.getLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.attendance";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public AttendanceDaoImpl() {}

	@Override
	public int doUpdate(AttendanceVO inVO) throws SQLException {
		int flag = 0;

		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"updateAttendanceStatus";
		LOG.debug("2.statement \n" + statement);
		flag=this.sqlSessionTemplate.update(statement, inVO);
		
		LOG.debug("3.flag \n" + flag);
		return flag;
	}

	@Override
	public int doDelete(AttendanceVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public AttendanceVO doSelectOne(AttendanceVO inVO) throws SQLException, EmptyResultDataAccessException {
		AttendanceVO outVO =new AttendanceVO();
		LOG.debug("1.param \n" + inVO);
		String statement = NAMESPACE+DOT +"doSelectOne";
		LOG.debug("2.statement \n" + statement);
		
		outVO=this.sqlSessionTemplate.selectOne(statement, inVO);
		
		LOG.debug(outVO);
	
		return outVO;
	}

	@Override
	public int doSave(AttendanceVO inVO) throws SQLException {
		int flag = 0;

		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"doSave";
		LOG.debug("2.statement \n" + statement);
		
		try {
	        flag = this.sqlSessionTemplate.update(statement, inVO);
	    } catch (DataIntegrityViolationException e) {
	        // 무결성 제약 조건이 발생한 경우
	        flag = 2;
	        LOG.error("무결성 제약 조건이 발생하였습니다.", e);
	    }

		
		LOG.debug("3.flag \n" + flag);
		return flag;
	}

	@Override
	public List<AttendanceVO> doRetrieve(AttendanceVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<AttendanceVO> doRetrieve(String email) throws SQLException {
		List<AttendanceVO> outList=new ArrayList<AttendanceVO>();
		LOG.debug("1.param \n" + email);
		String statement = NAMESPACE+DOT +"getAttendanceInfoByEmail";
		LOG.debug("2.statement \n" + statement);
		
		outList=this.sqlSessionTemplate.selectList(statement, email);
		
		for(AttendanceVO vo :outList) {
			LOG.debug(vo);
		}		
		return outList;
	}

	
}

