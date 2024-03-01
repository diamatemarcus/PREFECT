package com.pcwk.ehr.subject;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.After;
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
import org.springframework.test.context.web.WebAppConfiguration;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.dm.domain.DmVO;
import com.pcwk.ehr.subject.dao.SubjectDao;
import com.pcwk.ehr.subject.domain.SubjectVO;
import com.pcwk.ehr.user.domain.UserVO;

@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@WebAppConfiguration
public class SubjectDaoJunitTest implements PcwkLogger {

	@Autowired
	SubjectDao dao;

	SubjectVO subjectVO;
	SubjectVO searchVO;
	@Autowired // 테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;

	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ setUp                             │");
		LOG.debug("└───────────────────────────────────┘");

		int subjectCode = 20;
		int coursesCode = 12;// 과정코드
		String professor = "cristiano@gmail.com";// 교수님
		String trainee = "ronaldoo1@gmail.com";// 훈련생
		int score = 90;// 점수

		subjectVO = new SubjectVO(subjectCode, coursesCode, professor, trainee, score);
		searchVO = new SubjectVO();
		searchVO.setTrainee("ronaldoo");
	}
	@Ignore
	@Test
	public void doSave() throws SQLException {

		int flag = dao.doSave(subjectVO);
		assertEquals(1, flag);
	}

	//@Ignore
	@Test
	public void doRetrieve() throws SQLException {
		
		searchVO.setPageNo(1);
		searchVO.setPageSize(10);

		// 1.
		int flag = dao.doDelete(searchVO);
		assertEquals(0, flag);
		// 2.
		flag = dao.doSave(subjectVO);
		assertEquals(1, flag);

		List<SubjectVO> list = dao.doRetrieve(searchVO);

		for(SubjectVO vo : list) {
			LOG.debug(vo);
		}

	}

	@Ignore
	@Test
	public void beans() {
		LOG.debug("====================");
		LOG.debug("=beans=");
		LOG.debug("=context=" + context);
		LOG.debug("=dao=" + dao);
		LOG.debug("====================");
		assertNotNull(context);
		assertNotNull(dao);

	}

}
