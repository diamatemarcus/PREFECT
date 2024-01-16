package com.pcwk.ehr.user.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.user.domain.UserVO;

@Repository
public class UserDaoImpl implements UserDao {
	
	final Logger LOG = LogManager.getLogger(getClass());
	
	final String NAMESPACE = "com.pcwk.ehr.user";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public UserDaoImpl() {}

	@Override
	public List<UserVO> getAll(UserVO inVO) throws SQLException {
		List<UserVO> outList=new ArrayList<UserVO>();
		LOG.debug("1.param \n" + inVO.toString());
				
		String statement = NAMESPACE+DOT +"getAll";
		LOG.debug("2.statement \n" + statement);
		
		outList=this.sqlSessionTemplate.selectList(statement, inVO);
		
		for(UserVO vo :outList) {
			LOG.debug(vo);
		}
		return outList;
	}
	
	 
	@Override
	public int doUpdate(UserVO inVO) throws SQLException {
		int flag = 0;

		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"doUpdate";
		LOG.debug("2.statement \n" + statement);
		flag=this.sqlSessionTemplate.update(statement, inVO);
		
		LOG.debug("3.flag \n" + flag);
		return flag;
	}

	@Override
	public int getCount(UserVO inVO) throws SQLException {
		int count = 0;

		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"getCount";
		LOG.debug("2.statement \n" + statement);
		
		count=this.sqlSessionTemplate.selectOne(statement, inVO);
		
		LOG.debug("3.count \n" + count);
		
		
		
		return count;
	}
	

	
	
	
	// ctrl+o : class 내 메소드
	@Override
	public int doDelete(final UserVO inVO) throws SQLException {
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
	public UserVO doSelectOne(UserVO inVO) throws SQLException, EmptyResultDataAccessException {
		UserVO outVO = null;
		
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT+"doSelectOne";
		LOG.debug("2.statement \n" + statement);
		
		outVO= this.sqlSessionTemplate.selectOne(statement, inVO);
		if(null != outVO) {
			LOG.debug("3.outVO \n" + outVO.toString());
		}
		return outVO;
	}

	/**
	 * 단건 등록
	 * 
	 * @param inVO
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	@Override
	public int doSave(UserVO inVO) throws SQLException {
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
	public List<UserVO> doRetrieve(UserVO inVO) throws SQLException {
		List<UserVO> outList=new ArrayList<UserVO>();
		LOG.debug("1.param \n" + inVO.toString());
		String statement = NAMESPACE+DOT +"doRetrieve";
		LOG.debug("2.statement \n" + statement);
		
		outList=this.sqlSessionTemplate.selectList(statement, inVO);
		
		for(UserVO vo :outList) {
			LOG.debug(vo);
		}		
		return outList;
	}

	@Override
	public int idDuplicateCheck(UserVO inVO) throws SQLException {
		int flag = 0;
		LOG.debug("1.param :" + inVO.toString());
		
		flag = sqlSessionTemplate.selectOne(NAMESPACE+DOT+"idDuplicateCheck", inVO);
		LOG.debug("2.flag :" + flag);
		return flag;
	}

}
























