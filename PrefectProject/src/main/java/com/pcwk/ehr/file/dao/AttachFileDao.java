package com.pcwk.ehr.file.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.file.domain.FileVO;

public interface AttachFileDao extends WorkDiv<FileVO> {
	
	public int getFileSeq() throws SQLException;
	
	public List<FileVO> getFileUuid(String uuid);

}
