package com.pcwk.ehr.search.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.user.domain.UserVO;

@Repository
public class SearchPasswordDaoImpl implements SearchPasswordDao,PcwkLogger {
	
	final String NAMESPACE = "com.pcwk.ehr.search";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sql;

	@Override
	public int updatePw(UserVO inVO) throws Exception {
		
		return sql.update(NAMESPACE+DOT+"updatePw", inVO);
	}

	@Override
	public int emailCheck(UserVO inVO) throws Exception {
		int count = 0;
		LOG.debug("1.param :" + inVO.toString());
		String statement = NAMESPACE+DOT+"telCheck";
		LOG.debug("2.statement :" + statement);
		
		count = sql.selectOne(statement, inVO);
		LOG.debug("3.count :n" + count);
		return count;
	}

	@Override
	public UserVO readMember(UserVO inVO) throws Exception {
		return sql.selectOne(NAMESPACE+DOT+"readMember", inVO);
	}

}
