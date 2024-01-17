package com.pcwk.ehr.file.service;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.file.dao.AttachFileDao;
import com.pcwk.ehr.file.domain.FileVO;

@Service
public class AttachFileServiceImpl implements AttachFileService {
	final Logger LOG = LogManager.getLogger(getClass());

	@Autowired
	AttachFileDao attachFileDao;

	public AttachFileServiceImpl() {
	}

	@Override
	public int upFileDelete(List<FileVO> list) throws SQLException {
		int flag = 0;
		try {
			for (FileVO vo : list) {
				flag += attachFileDao.doDelete(vo);
			}
		} catch (SQLException e) {
			LOG.debug("====================");
			LOG.debug("=upFileDelete SQLException=" + e.getMessage());
			LOG.debug("====================");
			throw e;
		}
		return flag;
	}

	@Override
	public FileVO doSelectOne(FileVO inVO) throws SQLException, EmptyResultDataAccessException {
		return attachFileDao.doSelectOne(inVO);
	}

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

	@Override
	public List<FileVO> doRetrieve(FileVO inVO) throws SQLException {
		return attachFileDao.doRetrieve(inVO);
	}

}
