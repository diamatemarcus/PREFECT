package com.pcwk.ehr.file.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.file.dao.AttachFileDao;
import com.pcwk.ehr.file.domain.FileVO;


/*
 * 이 스프링 코드는 파일 첨부 기능을 관리하는 AttachFileServiceImpl 서비스 레이어의 구현체입니다.
 * 이 클래스는 AttachFileService 인터페이스를 구현하며, 파일 관련 데이터를 처리하기 위한 메서드를 제공합니다.
 * 주요 기능으로는 파일 저장, 파일 삭제, 파일 조회 등이 있습니다.
 * 코드 내에서 MyBatis를 사용하여 데이터베이스와의 상호작용을 처리하는 AttachFileDao에 의존성을 주입받습니다(@Autowired).
 */

@Service
public class AttachFileServiceImpl implements AttachFileService, PcwkLogger {
	
/*
 * AttachFileDao 의존성 주입: AttachFileDao 인터페이스에 대한 의존성을 스프링 프레임워크로부터 자동 주입받습니다 (@Autowired).
 *  이 DAO는 파일 데이터 관련 데이터베이스 작업을 수행합니다.
 */
	@Autowired
	AttachFileDao attachFileDao;
	
	public AttachFileServiceImpl() {
	}

	/*
	 * up File Delete (List <FileVO> list)
		여러 파일 정보를 삭제하는 기능을 수행합니다.
		입력받은 File VO 객체 리스트(list)에 대해 순회하며, 각 파일을 삭제합니다.
		삭제는 attach File Dao.do Delete(vo)를 호출하여 수행하고, 성공적으로 삭제된 파일의 수를 flag에 누적합니다.
		SQL Exception이 발생하면, 로그를 남기고 해당 예외를 다시 throw합니다.
	 */
	@Override
	public int upFileDelete(List<FileVO> list) throws SQLException {
		int flag = 0;
		try {
			for (FileVO vo : list) {
				flag += attachFileDao.upFileDelete(vo);
			}
		} catch (SQLException e) {
			LOG.debug("====================");
			LOG.debug("=upFileDelete SQLException=" + e.getMessage());
			LOG.debug("====================");
			throw e;
		}
		return flag;
	}

	/*
	 * do Select One (FileVO inVO)
		특정 파일 정보를 조회하는 기능을 수행합니다.
		attach File Dao.do Select One(inVO)를 호출하여 특정 파일 정보를 조회하고, 결과를 반환합니다.
	 */
	@Override
	public FileVO doSelectOne(FileVO inVO) throws SQLException, EmptyResultDataAccessException {
		return attachFileDao.doSelectOne(inVO);
	}

	/*
	 * up File Save (List <File VO> list)
		여러 파일 정보를 저장하는 기능을 수행합니다.
		입력받은 FileVO 객체 리스트(list)에 대해 순회하며, 각 파일을 저장합니다.
		저장은 attach File Dao.do Save(vo)를 호출하여 수행하고, 성공적으로 저장된 파일의 수를 flag에 누적합니다.
		SQL Exception이 발생하면, 로그를 남기고 해당 예외를 다시 throw합니다.
	 */
	@Override
	public int upFileSave(List<FileVO> list) throws SQLException {
		int flag = 0;
		try {
			for (FileVO vo : list) {
				flag += attachFileDao.doSave(vo);
			}
		} catch (SQLException e) {
			LOG.debug("====================");
			LOG.debug("=upFileSave SQLException=" + e.getMessage());
			LOG.debug("====================");
			throw e;
		}

		return flag;
	}

	/*
	 * do Retrieve(FileVO inVO)
		조건에 맞는 파일 정보들을 조회하는 기능을 수행합니다.
		attach File Dao.do Retrieve(inVO)를 호출하여 조건에 맞는 파일 정보 목록을 조회하고, 결과를 반환합니다.
	 */
	@Override
	public List<FileVO> doRetrieve(FileVO inVO) throws SQLException {
		return attachFileDao.doRetrieve(inVO);
	}

	@Override
	public int getFileSeq()throws SQLException {
		return attachFileDao.getFileSeq();
	}

	@Override
	public List<FileVO> getFileUuid(String uuid) {
		return attachFileDao.getFileUuid(uuid);
	}

	@Override
	public int doDelete(FileVO inVO) throws SQLException {
		return attachFileDao.upFileDelete(inVO);
	}

	@Override
	public int getLastSeq(String uuid) throws SQLException {
		return attachFileDao.getLastSeq(uuid);
	}
	
	/*
	 * 예외 처리
		SQLException: SQL 작업 중 예외가 발생할 경우, 이를 호출한 측으로 전파합니다. 
		각 CRUD 작업 메서드에서 SQLException을 throw할 수 있으며, 이는 데이터베이스 작업 중 발생할 수 있는 일반적인 예외입니다.
		
		Empty Result Data Access Exception: do Select One 메서드에서 결과가 없는 경우 발생할 수 있는 예외입니다. 
		이 예외는 호출 측에서 처리될 수 있습니다.
	 */

}
