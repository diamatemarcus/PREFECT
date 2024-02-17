package com.pcwk.ehr.reply.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.reply.domain.ReplyVO;

public interface ReplyService {
	
	/**
	 * 시퀀스 조회 
	 * @return int(sequence)
	 * @throws SQLException
	 */
	public int getReplySeq() throws SQLException;
	

	/**
	 * 수정
	 * @param inVO
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doUpdate(ReplyVO inVO) throws SQLException;
	
	/**
	 * 삭제
	 * @param inVO
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doDelete(ReplyVO inVO) throws SQLException;
	
	/**
	 * 단건 조회
	 * @param inVO
	 * @return ReplyVO
	 * @throws SQLException
	 * @throws EmptyResultDataAccessException
	 */
	ReplyVO doSelectOne(ReplyVO inVO) throws SQLException, EmptyResultDataAccessException;
	
	/**
	 * 저장
	 * @param inVO
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	int doSave(ReplyVO inVO) throws SQLException;
	
	/**
	 * 목록조회
	 * @param inVO
	 * @return List<ReplyVO>
	 * @throws SQLException
	 */
	List<ReplyVO> doRetrieve(ReplyVO inVO) throws SQLException;
		
}
