package com.pcwk.ehr.schedule.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.schedule.domain.ScheduleVO;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {
	
	final Logger LOG = LogManager.getLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.schedule";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public ScheduleDaoImpl() {}
	
	@Override
	public int getCount(ScheduleVO inVO) throws SQLException {
		int count = 0;

		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"getCount";
		LOG.debug("2.statement \n" + statement);
		
		count=this.sqlSessionTemplate.selectOne(statement, inVO);
		
		LOG.debug("3.count \n" + count);
		
		
		
		return count;
	}
	

	@Override
	public int doUpdate(ScheduleVO inVO) throws SQLException {
		int flag = 0;

		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"doUpdate";
		LOG.debug("2.statement \n" + statement);
		flag=this.sqlSessionTemplate.update(statement, inVO);
		
		LOG.debug("3.flag \n" + flag);
		return flag;
	}

	@Override
	public int doDelete(ScheduleVO inVO) throws SQLException {
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

	@Override
	public ScheduleVO doSelectOne(ScheduleVO inVO) throws SQLException, EmptyResultDataAccessException {
		ScheduleVO outVO = null;
		
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"doSelectOne";
		LOG.debug("2.statement \n" + statement);
		
		outVO= this.sqlSessionTemplate.selectOne(statement, inVO);
		if(null != outVO) {
			LOG.debug("3.outVO \n" + outVO.toString());
		}
		return outVO;
	}

	@Override
	public int doSave(ScheduleVO inVO) throws SQLException {
		int flag = 0;
		LOG.debug("1.param \n" + inVO.toString());
		//----------------------------------------------------------------------

		String statement = this.NAMESPACE+DOT+"doSave";
		LOG.debug("2.statement \n" + statement);
		flag = this.sqlSessionTemplate.insert(statement, inVO);
		LOG.debug("3.flag \n" + flag);
		
		return flag;
	}

	@Override
	public List<ScheduleVO> doRetrieve(ScheduleVO inVO) throws SQLException {
		List<ScheduleVO> outList=new ArrayList<ScheduleVO>();
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT +"doRetrieve";
		LOG.debug("2.statement \n" + statement);
		
		outList=this.sqlSessionTemplate.selectList(statement, inVO);
		
		for(ScheduleVO vo :outList) {
			LOG.debug(vo);
		}		
		return outList;
	}



}

