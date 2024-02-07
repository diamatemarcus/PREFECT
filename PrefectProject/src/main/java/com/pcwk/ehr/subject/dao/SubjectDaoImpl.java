package com.pcwk.ehr.subject.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.subject.domain.SubjectVO;
import com.pcwk.ehr.user.domain.UserVO;

@Repository
public class SubjectDaoImpl implements SubjectDao, PcwkLogger {

	final String NAMESPACE = "com.pcwk.ehr.subject";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	@Override
	public int doUpdate(SubjectVO inVO) throws SQLException {
		int flag = 0;

		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"doUpdate";
		LOG.debug("2.statement \n" + statement);
		flag=this.sqlSessionTemplate.update(statement, inVO);
		
		LOG.debug("3.flag \n" + flag);
		return flag;
	}

	@Override
	public int doDelete(SubjectVO inVO) throws SQLException {

		return 0;
	}

	@Override
	public SubjectVO doSelectOne(SubjectVO inVO) throws SQLException, EmptyResultDataAccessException {

		SubjectVO outVO = null;
		
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
	public int doSave(SubjectVO inVO) throws SQLException {
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
	public List<SubjectVO> doRetrieve(SubjectVO inVO) throws SQLException {
		List<SubjectVO> outList=new ArrayList<SubjectVO>();
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT +"doRetrieve";
		LOG.debug("2.statement \n" + statement);
		
		outList=this.sqlSessionTemplate.selectList(statement, inVO);
		
		for(SubjectVO vo :outList) {
			LOG.debug(vo);
		}		
		
				
		return outList;
	}

}