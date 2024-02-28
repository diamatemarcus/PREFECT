package com.pcwk.ehr.subject.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.subject.domain.SubjectVO;

public interface SubjectService {
   
    public int doUpdate(SubjectVO inVO) throws SQLException;
        
    public SubjectVO doSelectOne(SubjectVO inVO) throws SQLException, EmptyResultDataAccessException;
    
    public int doSave(SubjectVO inVO) throws SQLException;
    
    public List<SubjectVO> doRetrieve(SubjectVO inVO) throws SQLException;
    
    public List<SubjectVO> doRetrieveBySubjectCode(SubjectVO inVO) throws SQLException;
    
    public int doSaveSubject(CodeVO inVO) throws SQLException;
}
