package com.pcwk.ehr;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Arrays;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.file.dao.AttachFileDao;
import com.pcwk.ehr.file.domain.FileVO;
import com.pcwk.ehr.file.service.AttachFileService;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class AttachFileServiceJunitTest {

	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	AttachFileDao  attachFileDao;
	
	@Autowired
	AttachFileService attachFileService;
	
	List<FileVO>   fileList;
	FileVO         searchVO;
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("**********************************************************");
		LOG.debug("=setUp()=");		
		String UUID = "20231228_2eba5103-06e7-43e5-babd-3acb296e0b25";
		
		fileList = Arrays.asList(
				 new FileVO(UUID, 1, "good_job01.xlsx", StringUtil.getPK()+".xlsx", "xlsx", 201, "C:\\upload\\2023\\12", "사용하지 않음", "PCWK")
				,new FileVO(UUID, 2, "good_job02.xlsx", StringUtil.getPK()+".xlsx", "xlsx", 202, "C:\\upload\\2023\\12", "사용하지 않음", "PCWK")
				,new FileVO(UUID, 3, "good_job03.xlsx", StringUtil.getPK()+".xlsx", "xlsx", 203, "C:\\upload\\2023\\12", "사용하지 않음", "PCWK")
				,new FileVO(UUID, 4, "good_job04.xlsx", StringUtil.getPK()+".xlsx", "xlsx", 204, "C:\\upload\\2023\\12", "사용하지 않음", "PCWK")
				,new FileVO(UUID, 5, "good_job05.xlsx", StringUtil.getPK()+".xlsx", "xlsx", 205, "C:\\upload\\2023\\12", "사용하지 않음", "PCWK")
				);
		searchVO = new FileVO();
		searchVO.setUuid(UUID);
	}
	
	
	@Test(expected = SQLIntegrityConstraintViolationException.class)
	public void upFileSave() throws SQLException{
		attachFileDao.doDelete(fileList.get(0));
		attachFileDao.doDelete(fileList.get(1));
		attachFileDao.doDelete(fileList.get(2));
		attachFileDao.doDelete(fileList.get(3));
		attachFileDao.doDelete(fileList.get(4));
		

		int saveFlag = 0;
		try {
			 fileList.get(2).setSeq(2);
			 saveFlag = attachFileService.upFileSave(fileList);
		} catch (SQLException e) {
			LOG.debug("====================");
			LOG.debug("=SQLException="+e.getMessage());
			LOG.debug("====================");			
		}
		
		
	}
	
	@Test
	public void upFileDelete() throws SQLException{
		attachFileDao.doDelete(fileList.get(0));
		attachFileDao.doDelete(fileList.get(1));
		attachFileDao.doDelete(fileList.get(2));
		attachFileDao.doDelete(fileList.get(3));
		attachFileDao.doDelete(fileList.get(4));
		
		int addFlag = 0;
		for(FileVO vo   :fileList) {
			addFlag+=attachFileDao.doSave(vo);
		}
		
		assertEquals(5, addFlag);
		
		int deleteFlag = 0;
		try {
			 deleteFlag = attachFileService.upFileDelete(fileList);
		} catch (SQLException e) {
			LOG.debug("====================");
			LOG.debug("=SQLException="+e.getMessage());
			LOG.debug("====================");			
		}
		assertEquals(5, deleteFlag);
		
	}
	

	@Test
	public void beans() {
		LOG.debug("====================");
		LOG.debug("=beans()=");
		LOG.debug("=attachFileDao="+attachFileDao);

		LOG.debug("=attachFileService="+attachFileService);
		LOG.debug("====================");		
		assertNotNull(attachFileDao);
		assertNotNull(attachFileService);
	}

}
