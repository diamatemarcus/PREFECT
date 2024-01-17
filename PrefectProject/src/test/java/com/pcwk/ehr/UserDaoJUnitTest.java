package com.pcwk.ehr;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;

import java.sql.SQLException;
import java.util.List;

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

import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.UserVO;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@WebAppConfiguration
public class UserDaoJUnitTest {

	final Logger LOG = LogManager.getLogger(getClass());
	@Autowired
	UserDao dao;
	// 등록
	UserVO userVO01;
	UserVO searchVO;
	
	
	@Autowired  //테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스트에 자동으로 객체값으로 주입
	ApplicationContext context;
	

	@Before
	public void setUp() throws Exception {

		// 등록
		userVO01 = new UserVO("mn8467@naver.com", "이름임1", "1234", 01011112222 ,"고졸","1");
		
	
		searchVO = new UserVO();
		searchVO.setEmail("mn");
		
		LOG.debug("====================");
		LOG.debug("=context=" + context);
		LOG.debug("=dao=" + dao);
		LOG.debug("====================");
	
	}
	
	@After
	public void tearDown() throws Exception {
		LOG.debug("=tearDown==========================");
	}
	
	@Ignore	
	@Test
	public void idDuplicateCheck()throws SQLException{
		//1.데이터 삭제
		//2.데이터 입력
		//3.idCheck
		//1.
		dao.doDelete(userVO01);
		
		assertEquals(0,dao.getCount(searchVO));
		//2.
		int flag = dao.doSave(userVO01);
		//3
		assertEquals(1, flag);
		assertEquals(1,dao.getCount(searchVO));
		
		//idCheck : id가 있는 경우
		int idCheckCnt = dao.idDuplicateCheck(userVO01);
		assertEquals(1, idCheckCnt);
		
		
		//id가 없는 경우 : 
		userVO01.setEmail("unknown_user");
		idCheckCnt= dao.idDuplicateCheck(userVO01);
		assertEquals(0, idCheckCnt);
		
	}
	
	@Ignore
	@Test
	public void doRetrieve()throws SQLException{
		LOG.debug("====================");
		LOG.debug("=doRetrieve()=");
		LOG.debug("====================");			
		
		searchVO.setPageSize(10L);
		searchVO.setPageNo(1L);
		searchVO.setSearchDiv("30");
		searchVO.setSearchWord("이름임1");
		
		List<UserVO> list = dao.doRetrieve(this.searchVO);
		assertEquals(1, list.size());
	}
	
	
	@Ignore
	@Test
	public void getAll()throws SQLException{
		//1.데이터 삭제
		//2.데이터 입력
		//3.건수확인
		//4.getAll()
		//5.3건 
		//6.데이터 비교
		LOG.debug("====================");
		LOG.debug("=getAll()=");
		LOG.debug("====================");		
		
		//1.
		dao.doDelete(userVO01);
		
		assertEquals(0,dao.getCount(searchVO));
	
		//2.
		int flag = dao.doSave(userVO01);
		//3
		assertEquals(1, flag);
		assertEquals(1,dao.getCount(searchVO));
		
		//4.
		List<UserVO> list = dao.getAll(searchVO);
		
		//5
		assertEquals(1, list.size());
		
		for(UserVO vo   :list) {
			LOG.debug(vo);
		}
		
		isSameUser(userVO01, list.get(0));
	}
	@Ignore
	@Test(timeout = 30000)
	public void addAndGet() throws SQLException {
		// 1. 데이터 삭제
		// 2. 등록
		// 3. 한건조회  

		// 1.
		dao.doDelete(userVO01);
		
		assertThat(dao.getCount(searchVO), is(0));
		
		// 2.
		int flag = dao.doSave(userVO01);
		int count = dao.getCount(searchVO);
		assertThat(flag, is(1));
		assertThat(count, is(1));




		UserVO outVO01 = dao.doSelectOne(userVO01);
		assertNotNull(outVO01);// Not Null이면 true

		// 데이터 동일 테스트
		isSameUser(userVO01, outVO01);

	}

	private void isSameUser(UserVO userVO, UserVO outVO) {
		assertEquals(userVO.getEmail(), outVO.getEmail());
		assertEquals(userVO.getName(), outVO.getName());
		assertEquals(userVO.getPassword(), outVO.getPassword());
		assertEquals(userVO.getTel(), outVO.getTel());
		assertEquals(userVO.getEdu(), outVO.getEdu());
		assertEquals(userVO.getRole(), outVO.getRole());


	}

	
	@Test
	public void beans() {
		LOG.debug("====================");
		LOG.debug("=beans=");		
		LOG.debug("=context="+context);
		LOG.debug("=dao="+dao);				
		LOG.debug("====================");		
		assertNotNull(context);
		assertNotNull(dao);

	}

}
