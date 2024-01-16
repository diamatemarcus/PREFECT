package com.pcwk.ehr.file.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.file.domain.FileVO;

@Repository
public class AttachFileDaoImpl implements AttachFileDao {
	final Logger LOG = LogManager.getLogger(getClass());
	final String NAMESPACE = "com.pcwk.ehr.file";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public AttachFileDaoImpl() {}
	
	
	@Override
	public int doUpdate(FileVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int doDelete(FileVO inVO) throws SQLException {
		LOG.debug("1.param \n" + inVO.toString());
		return sqlSessionTemplate.delete(NAMESPACE+DOT+"doDelete",inVO);
	}

	@Override
	public FileVO doSelectOne(FileVO inVO) throws SQLException, EmptyResultDataAccessException {
		LOG.debug("1.param \n" + inVO.toString());
		
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"doSelectOne", inVO);
	}
   
	@Override
	public int doSave(FileVO inVO) throws SQLException {
		LOG.debug("1.param \n" + inVO.toString());
		int flag = 0;
		try {
			flag = sqlSessionTemplate.insert(NAMESPACE+DOT+"doSave", inVO);
		}catch(Exception e) {
			LOG.debug("====================");
			LOG.debug("=doSave SQLException="+e.getMessage());
			LOG.debug("====================");				
			throw e;
		}
		return flag;
	}

	@Override
	public List<FileVO> doRetrieve(FileVO inVO) throws SQLException {
		LOG.debug("1.param \n" + inVO.toString());
		
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"doRetrieve", inVO);
	}

}
