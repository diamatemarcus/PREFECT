package com.pcwk.ehr.board.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.board.domain.BoardVO;

public interface BoardService {
   
	public int getBoardSeq()throws SQLException;
	
	public int doUpdate(BoardVO inVO) throws SQLException;
	
	public int doDelete(BoardVO inVO) throws SQLException;
	
	public BoardVO doSelectOne(BoardVO inVO) throws SQLException, EmptyResultDataAccessException;
	
	public int doSave(BoardVO inVO) throws SQLException;
	
	public List<BoardVO> doRetrieve(BoardVO inVO) throws SQLException;
}
