package com.pcwk.ehr.subject.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.subject.domain.SubjectVO;

public interface SubjectDao extends WorkDiv<SubjectVO>  {


	// 학생 점수 등록 수정 삭제 읽기 WorkDiv에 있음
	public List<SubjectVO> doRetrieveBySubjectCode(SubjectVO inVO) throws SQLException;
	

}
