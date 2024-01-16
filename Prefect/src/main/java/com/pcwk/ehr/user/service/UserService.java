package com.pcwk.ehr.user.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.EmptyResultDataAccessException;

import com.pcwk.ehr.user.domain.UserVO;

public interface UserService {

	/**
	 * 아이디 중복 체크
	 * @param inVO
	 * @return
	 * @throws SQLException
	 */
	public int idDuplicateCheck(UserVO inVO) throws SQLException;
	
	/**
	 * 회원목록 조회 
	 * @param inVO
	 * @return List<UserVO>
	 * @throws SQLException
	 */
	public List<UserVO> doRetrieve(UserVO inVO) throws SQLException;
	/**
	 * 회원정보 저장
	 * @param inVO
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	public int doSave(UserVO inVO) throws SQLException;
	
	/**
	 * 회원 단건 조회
	 * @param inVO
	 * @return inVO
	 * @throws SQLException
	 * @throws EmptyResultDataAccessException
	 */
	public UserVO doSelectOne(UserVO inVO) throws SQLException, EmptyResultDataAccessException;
	
	/**
	 * 회원삭제
	 * @param inVO
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	public int doDelete(final UserVO inVO) throws SQLException;
	/**
	 * 회원조회 건수
	 * @param inVO
	 * @return int
	 * @throws SQLException
	 */
	public int getCount(UserVO inVO) throws SQLException;
	/**
	 * 회원정보 수정
	 * @param inVO
	 * @return 1(성공)/0(실패)
	 * @throws SQLException
	 */
	public int doUpdate(UserVO inVO) throws SQLException;
	/**
	 * 등업 회원 조회
	 * @param inVO
	 * @return List<UserVO>
	 * @throws SQLException
	 */
	public List<UserVO> getAll(UserVO inVO) throws SQLException;
	
	/**
	 * 최초 로그인시 등급은 basic
	 * @param inVO
	 * @throws SQLException
	 */
	public void add(UserVO inVO) throws SQLException;	
	
	/**
	 * 회원등업
	 * @param inVO
	 * @throws SQLException
	 */
	public void upgradeLevels(UserVO inVO) throws Exception;
	
	
}
