package com.pcwk.ehr;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.file.dao.AttachFileDao;
import com.pcwk.ehr.file.domain.FileVO;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class AttachFileDaoJunitTest {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	AttachFileDao  dao;
	
	FileVO  fileVO01;
	FileVO  fileVO02;
	FileVO  fileVO03;
	
	FileVO  searchVO;
	
	@Autowired  //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;
	
	
	@Before
	public void setUp() throws Exception {
		String UUID = "20231228_2eba5103-06e7-43e5-babd-3acb296e0b25";
		fileVO01 = new FileVO(UUID, 1, "good_job01.xlsx", StringUtil.getPK()+".xlsx", "xlsx", 201, "C:\\upload\\2023\\12", "사용하지 않음", "Admin");
		fileVO02 = new FileVO(UUID, 2, "good_job02.xlsx", StringUtil.getPK()+".xlsx", "xlsx", 202, "C:\\upload\\2023\\12", "사용하지 않음", "Admin");
		fileVO03 = new FileVO(UUID, 3, "good_job03.xlsx", StringUtil.getPK()+".xlsx", "xlsx", 203, "C:\\upload\\2023\\12", "사용하지 않음", "Admin");
		
		searchVO = new FileVO();
		searchVO.setUuid(UUID);
		
	}

	@Test
	public void doRerieve() throws SQLException {
		// 1. 데이터 삭제
		// 2. 등록
		// 3. 다건조회  
		
		// 1.
		dao.doDelete(fileVO01);
		dao.doDelete(fileVO02);
		dao.doDelete(fileVO03);
		
		// 2.
		int flag = dao.doSave(fileVO01);
		assertEquals(flag, 1);
		
		flag = dao.doSave(fileVO02);
		assertEquals(flag, 1);
		
		flag = dao.doSave(fileVO03);
		assertEquals(flag, 1);
		
		
		List<FileVO> list = dao.doRetrieve(searchVO);
		assertEquals(3, list.size());
		
	}
	
	@Test
	public void addAndGet() throws SQLException {
		// 1. 데이터 삭제
		// 2. 등록
		// 3. 한건조회  
		
		// 1.
		dao.doDelete(fileVO01);
		dao.doDelete(fileVO02);
		dao.doDelete(fileVO03);
		
		
		// 2.
		int flag = dao.doSave(fileVO01);
		assertEquals(flag, 1);
		
		flag = dao.doSave(fileVO02);
		assertEquals(flag, 1);
		
		flag = dao.doSave(fileVO03);
		assertEquals(flag, 1);
		
		// 3
		FileVO outVO01 = dao.doSelectOne(fileVO01);
		FileVO outVO02 = dao.doSelectOne(fileVO02);
		FileVO outVO03 = dao.doSelectOne(fileVO03);
		
		assertNotNull(outVO01);// Not Null이면 true
		assertNotNull(outVO02);// Not Null이면 true
		assertNotNull(outVO03);// Not Null이면 true		
		
		isSameFile(outVO01, fileVO01);
		isSameFile(outVO02, fileVO02);
		isSameFile(outVO03, fileVO03);
	}
	
	private void isSameFile(FileVO fileVO, FileVO outVO) {
		
		assertEquals(fileVO.getUuid(), outVO.getUuid());
		
		assertEquals(fileVO.getSeq(), outVO.getSeq());
		assertEquals(fileVO.getOrgFileName(), outVO.getOrgFileName());
		assertEquals(fileVO.getSaveFileName(), outVO.getSaveFileName());
		assertEquals(fileVO.getExtension(), outVO.getExtension());
		
		assertEquals(fileVO.getFileSize(), outVO.getFileSize());
		assertEquals(fileVO.getSavePath(), outVO.getSavePath());
		assertEquals(fileVO.getRegId(), outVO.getRegId());
		
	}
	
	@Test
	public void beans() {
		assertNotNull(context);
		assertNotNull(dao);
		LOG.debug("====================");
		LOG.debug("=context=" + context);
		LOG.debug("=dao=" + dao);
		LOG.debug("====================");		
	}

}
