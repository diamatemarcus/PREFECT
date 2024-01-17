package com.pcwk.ehr.board.dao;

import java.sql.SQLException;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.WorkDiv;

public interface BoardDao extends WorkDiv<BoardVO>,PcwkLogger {
									

	/**
	 * board_seq 
	 * @return int
	 * @throws SQLException
	 */
	int getBoardSeq()throws SQLException;
	
	/**
	 * 글제목으로 삭제: test only
	 * @param inVO
	 * @return int
	 * @throws SQLException
	 */
	int doDeleteAll(BoardVO inVO)throws SQLException;
	
	/**
	 * 조회건수 증가
	 * @param inVO
	 * @return int
	 * @throws SQLException
	 */
	int updateReadCnt(BoardVO inVO)throws SQLException;  
	
}
