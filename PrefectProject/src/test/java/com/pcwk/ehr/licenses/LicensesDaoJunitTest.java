package com.pcwk.ehr.licenses;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;

import java.sql.SQLException;
import java.util.List;

import org.hamcrest.core.IsSame;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.licenses.dao.LicensesDao;
import com.pcwk.ehr.licenses.domain.LicensesVO;

@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class LicensesDaoJunitTest implements PcwkLogger {
	@Autowired
	LicensesDao dao;

	LicensesVO license01;
	LicensesVO license02;
	LicensesVO license03;

	LicensesVO searchVO;

	@Autowired
	ApplicationContext context;

	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ setUp                             │");
		LOG.debug("└───────────────────────────────────┘");

		String email = "kjew03@gmail.com";
		int licensesSeq = 3;
		String regDt = "2024-02-02";

		license01 = new LicensesVO(licensesSeq, email, regDt);
		license02 = new LicensesVO(licensesSeq+1, email, regDt);
		license03 = new LicensesVO(licensesSeq+2, email, regDt);
	}

	//@Ignore
	@Test
	public void doRetrieve() throws SQLException {

		List<LicensesVO> licensesList = dao.doRetrieve(searchVO);

		// then
		assertNotNull(licensesList);
		assertFalse(licensesList.isEmpty());
	}
	
	@Ignore
	@Test
	public void doSave() throws SQLException {
		dao.doDelete(license01);
		dao.doDelete(license02);
		dao.doDelete(license03);
		
		int flag = dao.doSave(license01);
		assertEquals(1, flag);
		
		flag = dao.doSave(license02);
		assertEquals(1, flag);
		
		flag = dao.doSave(license03);
		assertEquals(1, flag);

	}
	@Ignore
	@Test
	public void doUpdate() throws SQLException{
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ update                            │");
		LOG.debug("└───────────────────────────────────┘");
		
		//첫번째 자격증 삭제
		dao.doDelete(license01);
		
		//등록 and 확인
		int flag = dao.doSave(license01);
		assertEquals(1, flag);
		
		LicensesVO vo01 = dao.doSelectOne(license01);
		String upDate = "2023-02-02";
		
		vo01.setRegDt(upDate);
		
		//업데이트 결과 확인
		flag = dao.doUpdate(vo01);
		assertEquals(1, flag);
	}

	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ beans                             │");
		LOG.debug("│ dao                               │" + dao);
		LOG.debug("│ context                           │" + context);
		LOG.debug("└───────────────────────────────────┘");

		assertNotNull(dao);
		assertNotNull(context);
	}

}
