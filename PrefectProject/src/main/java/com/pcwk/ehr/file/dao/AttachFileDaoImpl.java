package com.pcwk.ehr.file.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.file.domain.FileVO;

/*
이 스프링 코드는 파일 첨부 기능을 처리하기 위한 DAO(Data Access Object) 구현체입니다.
Attach File DaoImpl 클래스는 Attach File Dao 인터페이스를 구현하며,
My Batis를 사용하여 데이터베이스와의 상호 작용을 처리합니다. 
각 메서드는 데이터베이스의 CRUD(Create, Read, Update, Delete) 작업에 대응됩니다.
*/
@Repository

//클래스 정의: Attach File Dao Impl 클래스는 Attach File Dao 인터페이스를 구현합니다.
public class AttachFileDaoImpl implements AttachFileDao, PcwkLogger {
	
	//NAMESPACE: My Batis의 SQL 매핑 문서를 찾기 위한 네임스페이스를 정의합니다. 쿼리의 ID를 찾을 때 사용됩니다.
	final String NAMESPACE = "com.pcwk.ehr.file";
	//DOT: 문자열 .을 상수로 정의하여, 네임스페이스와 쿼리 ID를 결합할 때 사용합니다.
	final String DOT       = ".";
	
	//Sql Session Template: My Batis의 Sql Session Template을 주입받아, 데이터베이스와의 세션을 관리합니다.
	//이 객체를 통해 실제 데이터베이스 작업을 수행합니다.
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public AttachFileDaoImpl() {}
	
	/*CRUD 메서드
	각 메서드는 특정 데이터베이스 작업을 수행하며, 입력 값으로 FileVO 객체를 받습니다.
	FileVO는 파일 정보를 담고 있는 객체입니다.
	do Update(FileVO inVO) 현재는 구현되지 않았습니다(반환 값이 0).
	*/
	@Override
	public int doUpdate(FileVO inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	/*
	do Delete(FileVO inVO)	파일 정보를 삭제합니다.
	LOG.debug를 사용하여 입력 값 inVO를 로깅합니다.
	sql Session Template.delete 메서드를 호출하여
	SQL 매핑 파일에서 
	NAME SPACE+DOT+"do Delete"에 해당하는 SQL을 실행합니다.
	*/
	@Override
	public int doDelete(FileVO inVO) throws SQLException {
		LOG.debug("1.param \n" + inVO.toString());
		return sqlSessionTemplate.delete(NAMESPACE+DOT+"doDelete",inVO);
	}
	/*
	SQL Exception: SQL 처리 중 발생할 수 있는 예외입니다.
	각 메서드가 SQL Exception을 throw 할 수 있으므로, 이를 호출하는 서비스 레이어에서 적절히 처리해야 합니다.
	Empty Result Data Access Exception: do Select One 메서드에서 발생할 수 있는 예외로, 결과가 없을 때 발생합니다.
	호출하는 측에서 이를 처리해야 합니다.
	*/
	
	/*
	do Select One(FileVO inVO)
	하나의 파일 정보를 조회합니다. LOG.debug를 사용하여 입력 값 inVO를 로깅합니다.
	sql Session Template.select One 메서드를 호출하여 
	SQL 매핑 파일에서 NAME SPACE+DOT+"do Select One"에 해당하는 SQL을 실행합니다.
	 */
	@Override
	public FileVO doSelectOne(FileVO inVO) throws SQLException, EmptyResultDataAccessException {
		LOG.debug("1.param \n" + inVO.toString());
		
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"doSelectOne", inVO);
	}
   
	/*
	do Save(FileVO inVO)
	새로운 파일 정보를 저장합니다.
	LOG.debug를 사용하여 입력 값 inVO를 로깅합니다.
	try-catch 블록 내에서 sql Session Template.insert 메서드를 호출하여 
	SQL 매핑 파일에서 NAME SPACE+DOT+"do Save"에 해당하는 SQL을 실행합니다.
	예외 발생 시, 예외 정보를 로깅하고 예외를 다시 throw합니다.
	*/

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

	/* do Retrieve(FileVO inVO)
	조건에 맞는 파일 정보 목록을 조회합니다.
	LOG.debug를 사용하여 입력 값 inVO를 로깅합니다.
	sql Session Template.select List 메서드를 호출하여 
	SQL 매핑 파일에서 NAME SPACE+DOT+"do Retrieve"에 해당하는 SQL을 실행합니다.
	 */
	@Override
	public List<FileVO> doRetrieve(FileVO inVO) throws SQLException {
		LOG.debug("1.param \n" + inVO.toString());
		
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"doRetrieve", inVO);
	}

	@Override
	public int getFileSeq() throws SQLException {
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"getFileSeq");
	}

	@Override
	public List<FileVO> getFileUuid(String uuid) {		
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"getFileUuid", uuid);
	}

	@Override
	public int upFileDelete(FileVO inVO) throws SQLException {
		return sqlSessionTemplate.update(NAMESPACE+DOT+"upFileDelete", inVO);
	}

	@Override
	public int getLastSeq(String uuid) {
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"getLastSeq", uuid);
	}


}
