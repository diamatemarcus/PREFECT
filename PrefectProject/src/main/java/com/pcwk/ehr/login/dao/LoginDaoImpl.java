package com.pcwk.ehr.login.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.user.dao.UserDaoImpl;
import com.pcwk.ehr.user.domain.UserVO;

@Repository
public class LoginDaoImpl implements LoginDao {
	final Logger LOG = LogManager.getLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.login";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public int doUpdate(UserVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doDelete(UserVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public UserVO doSelectOne(UserVO inVO) throws SQLException, EmptyResultDataAccessException {
		UserVO  outVO = null;
		LOG.debug("1.param :" + inVO.toString());
		String statement = NAMESPACE+DOT+"doSelectOne";
		LOG.debug("2.statement :" + statement);
		outVO=sqlSessionTemplate.selectOne(statement, inVO);
		if(null != outVO) {
			LOG.debug("3.outVO \n" + outVO.toString());
		}
		return outVO;
	}

	@Override
	public int doSave(UserVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<UserVO> doRetrieve(UserVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int idCheck(UserVO inVO) throws SQLException {
		int count = 0;
		LOG.debug("1.param :" + inVO.toString());
		String statement = NAMESPACE+DOT+"idCheck";
		LOG.debug("2.statement :" + statement);
		
		count = sqlSessionTemplate.selectOne(statement, inVO);
		LOG.debug("3.count :n" + count);
		return count;
	}

	@Override
	public int idPassCheck(UserVO inVO) throws SQLException {
		int count = 0;
		LOG.debug("1.param :" + inVO.toString());
		String statement = NAMESPACE+DOT+"idPassCheck";
		LOG.debug("2.statement :" + statement);
		
		count =sqlSessionTemplate.selectOne(statement, inVO);
		LOG.debug("3.count :n" + count);
		return count;
	}

	
	
	
}





