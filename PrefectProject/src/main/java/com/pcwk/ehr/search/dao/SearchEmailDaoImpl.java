package com.pcwk.ehr.search.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.user.domain.UserVO;

@Repository
public class SearchEmailDaoImpl implements SearchEmailDao,PcwkLogger {
	
	final String NAMESPACE = "com.pcwk.ehr.search";
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
		// TODO Auto-generated method stub
		return null;
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
	public int nameCheck(UserVO inVO) throws SQLException {
		int count = 0;
		LOG.debug("1.param :" + inVO.toString());
		String statement = NAMESPACE+DOT+"nameCheck";
		LOG.debug("2.statement :" + statement);
		
		count = sqlSessionTemplate.selectOne(statement, inVO);
		LOG.debug("3.count :n" + count);
		return count;
	}

	@Override
	public int telCheck(UserVO inVO) throws SQLException {
		int count = 0;
		LOG.debug("1.param :" + inVO.toString());
		String statement = NAMESPACE+DOT+"telCheck";
		LOG.debug("2.statement :" + statement);
		
		count = sqlSessionTemplate.selectOne(statement, inVO);
		LOG.debug("3.count :n" + count);
		return count;
	}

}
