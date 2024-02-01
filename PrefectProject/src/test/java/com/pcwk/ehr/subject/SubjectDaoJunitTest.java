package com.pcwk.ehr.subject;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.SQLException;
import java.util.List;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.subject.dao.SubjectDao;
import com.pcwk.ehr.subject.domain.SubjectVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class SubjectDaoJunitTest implements PcwkLogger {
	
	@Autowired
	SubjectDao dao;
	
	SubjectVO subject01;
	SubjectVO subject02;
	SubjectVO subject03;
	
	SubjectVO searchVO;
	
	@Autowired
	ApplicationContext context;	
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ setUp                             │");
		LOG.debug("└───────────────────────────────────┘");
		
		subject01 = new SubjectVO(1, 1, "professor1", "trainee1", 90);
		subject02 = new SubjectVO(2, 2, "professor2", "trainee2", 85);
		subject03 = new SubjectVO(3, 3, "professor3", "trainee3", 88);
		
		searchVO = new SubjectVO();
		searchVO.setTrainee("trainee1");
	}
	
	@Test
	public void addAndGet() throws SQLException {
		dao.doDelete(subject01);
		dao.doDelete(subject02);
		dao.doDelete(subject03);
		
		int flag = dao.doSave(subject01);
		assertEquals(1, flag);
		
		flag = dao.doSave(subject02);
		assertEquals(1, flag);
		
		flag = dao.doSave(subject03);
		assertEquals(1, flag);
		
		SubjectVO vo01 = dao.doSelectOne(subject01);
		SubjectVO vo02 = dao.doSelectOne(subject02);
		SubjectVO vo03 = dao.doSelectOne(subject03);
		
		isSameSubject(vo01, subject01);
		isSameSubject(vo02, subject02);
		isSameSubject(vo03, subject03);
	}
	
	@Test
	public void doRetrieve() throws SQLException {
		dao.doDelete(subject01);
		dao.doDelete(subject02);
		dao.doDelete(subject03);
		
		int flag = dao.doSave(subject01);
		assertEquals(1, flag);
		
		flag = dao.doSave(subject02);
		assertEquals(1, flag);
		
		flag = dao.doSave(subject03);
		assertEquals(1, flag);
		
		List<SubjectVO> list = dao.doRetrieve(searchVO);
		
		for (SubjectVO vo : list) {
			LOG.debug(vo);
		}
	}
	
	@Test
	public void doupdate() throws SQLException {
		dao.doDelete(subject01);
		dao.doDelete(subject02);
		dao.doDelete(subject03);
		
		int flag = dao.doSave(subject01);
		assertEquals(1, flag);
		
		flag = dao.doSave(subject02);
		assertEquals(1, flag);
		
		flag = dao.doSave(subject03);
		assertEquals(1, flag);
		
		SubjectVO vo01 = dao.doSelectOne(subject01);
		String professor = "professor1_updated";
		vo01.setProfessor(professor);
		
		flag = dao.doUpdate(vo01);
		assertEquals(1, flag);
		
		SubjectVO updatedVO = dao.doSelectOne(vo01);
		assertEquals(professor, updatedVO.getProfessor());
	}
	
	private void isSameSubject(SubjectVO vo, SubjectVO subject) {
		assertEquals(vo.getSubjectCode(), subject.getSubjectCode());
		assertEquals(vo.getCourseCode(), subject.getCourseCode());
		assertEquals(vo.getProfessor(), subject.getProfessor());
		assertEquals(vo.getTrainee(), subject.getTrainee());
		assertEquals(vo.getScore(), subject.getScore());
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
