package com.pcwk.ehr;

import static org.junit.Assert.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.PlatformTransactionManager;

import com.pcwk.ehr.user.dao.UserDao;
import com.pcwk.ehr.user.domain.Level;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.TestUserService;
import com.pcwk.ehr.user.service.UserService;

import static com.pcwk.ehr.user.service.UserServiceImpl.MIN_LOGIN_COUNT_FOR_SILVER;
import static com.pcwk.ehr.user.service.UserServiceImpl.MIN_RECOMEND_COUNT_FOR_GOLD;

@RunWith(SpringJUnit4ClassRunner.class) //스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class UserServiceTest {
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Resource(name ="dummyMailSender" )
	MailSender  mailSender;

	
	@Autowired
	UserDao  userDao;
	
	@Autowired
	UserService  userService;
	
	List<UserVO> users;
	UserVO searchVO;
	
	
	@Before
	public void setUp() throws Exception {
		LOG.debug("**********************************************************");
		LOG.debug("=setUp()=");		
		
		//BASIC
		//BASIC -> SILVER(O)
		//SILVER
		//SILVER -> GOLD(O)
		//GOLD
		
		users = Arrays.asList(
			 new UserVO("p99-01", "이상무99-01", "4321_1",Level.BASIC,  MIN_LOGIN_COUNT_FOR_SILVER-1,0,                            "jamesol@paran.com","사용하지 않음")
			,new UserVO("p99-02", "이상무99-02", "4321_2",Level.BASIC,  MIN_LOGIN_COUNT_FOR_SILVER  ,2,                            "jamesol@paran.com","사용하지 않음")  //O
			,new UserVO("p99-03", "이상무99-03", "4321_3",Level.SILVER, MIN_LOGIN_COUNT_FOR_SILVER+1,MIN_RECOMEND_COUNT_FOR_GOLD-1,"jamesol@paran.com","사용하지 않음")
			,new UserVO("p99-04", "이상무99-04", "4321_4",Level.SILVER, MIN_LOGIN_COUNT_FOR_SILVER+2,MIN_RECOMEND_COUNT_FOR_GOLD,  "jamesol@paran.com","사용하지 않음") //O
			,new UserVO("p99-05", "이상무99-05", "4321_5",Level.GOLD,   MIN_LOGIN_COUNT_FOR_SILVER+5,MIN_RECOMEND_COUNT_FOR_GOLD+5,"jamesol@paran.com","사용하지 않음") 
		);
		
		searchVO = new UserVO();
		searchVO.setUserId("p99");
	}

	@Ignore
	@Test
	public void upgradeAllOrNothing()throws Exception{
		/**
		 * 5명중 2명 등업 대상
		 * 4번째 사용자에서 강제 예외 발생
		 * 2번째(p99-02) 사용자 등금이 rollback되면 성공
		 */
		
		TestUserService  testUserService=new TestUserService(users.get(3).getUserId());
		//수동으로 userDao DI
//		testUserService.setUserDao(userDao);
//		testUserService.setDataSource(dataSource);
//		testUserService.setTransactionManager(transactionManager);
//		
//		testUserService.setMailSender(mailSender);
		
		
		//testUserService.setD
		LOG.debug("┌─────────────────────────────────────────────────────────┐");
		LOG.debug("│ upgradeAllOrNothing()                                   │");
		LOG.debug("└─────────────────────────────────────────────────────────┘");		
		
		try {
			//1.전체 데이터 삭제
			for(UserVO vo :users) {
				userDao.doDelete(vo);
			}
			//assertEquals(0, userDao.getCount(searchVO));
			  
			//2. 추가
			for(UserVO vo :users) {
				userDao.doSave(vo);
			}
			//assertEquals(5, userDao.getCount(searchVO));
			
			//3. 등업(트랜잭션:X)
			testUserService.upgradeLevels(searchVO);
			
		}catch(Exception e) {
			LOG.debug("┌─────────────────────────────────────────────────────────┐");
			LOG.debug("│ Exception                                               │"+e.getMessage());
			LOG.debug("└─────────────────────────────────────────────────────────┘");				
		}
		//rollback되지 않음!: BASIC으로 돌아와야 하는데 그렇치 않음(SILVER)
		checkLevel(users.get(1), false);
		
	}
	
	
	//@Ignore
	@Test
	public void add()throws SQLException{
		//1.users 데이터 모두 삭제
		//2.users 데이터 입력: Level이 없는 데이터 생성
		//3.추가
		//4.데이터 비교
		LOG.debug("┌─────────────────────────────────────────────────────────┐");
		LOG.debug("│ add()                                                   │");
		LOG.debug("└─────────────────────────────────────────────────────────┘");
		
		//1.
		for(UserVO vo :users) {
			userDao.doDelete(vo);
		}
		assertEquals(0, userDao.getCount(searchVO));
		
		//2.users 데이터 입력: Level이 없는 데이터 생성
		for(UserVO vo:users) {
			
			if(vo.getUserId().equals("p99-01")) {
				vo.setLevel(null);
			}
			//3.추가
			userService.add(vo);			
		}
		//4
		checkLevel(users.get(0), false);
		
	}
	
	
	
	//@Ignore
	@Test
	public void upgradeLevels()throws Exception{
		LOG.debug("┌─────────────────────────────────────────────────────────┐");
		LOG.debug("│ pgradeLevels()                                          │");
		LOG.debug("└─────────────────────────────────────────────────────────┘");

		//1.users 데이터 모두 삭제
		//2.users 데이터 입력
		//3.등업
		//4.등업 데이터 비교 p99-02(SILVER),p99-04(GOLD)
		
		//1.
		for( UserVO vo : users) {
			userDao.doDelete(vo);
		}
		assertEquals(0, userDao.getCount(searchVO));
		
		
		//2.
		for( UserVO vo : users) {
			userDao.doSave(vo);
		}
		assertEquals(5, userDao.getCount(searchVO));
		try {
			//3. 
			userService.upgradeLevels(searchVO);
		}catch(Exception e) {
			LOG.debug("┌─────────────────────────────────────────────────────────┐");
			LOG.debug("│ Exception                                          │"+e.getMessage());
			LOG.debug("└─────────────────────────────────────────────────────────┘");			
		}
		
		//BASIC
		//BASIC -> SILVER(O)
		//SILVER
		//SILVER -> GOLD(O)
		//GOLD
		checkLevel(users.get(0), false);
		checkLevel(users.get(1), false);//등업 :basic->silver
		checkLevel(users.get(2), false);
		checkLevel(users.get(3), false);//등업 :silver->gold
		checkLevel(users.get(4), false);
		
		
	}
	/**
	 * 
	 * @param userVO   
	 * @param upgraded : true(등업대상)/false
	 * @throws EmptyResultDataAccessException
	 * @throws SQLException
	 */
	private void checkLevel(UserVO userVO, boolean upgraded) throws EmptyResultDataAccessException, SQLException {
		UserVO userUpdate=userDao.doSelectOne(userVO);
		
		LOG.debug("┌────────────────────────────┐");
		LOG.debug("│ checkLevel                 │");
		LOG.debug("└────────────────────────────┘");			
		if(upgraded == true) {//등업 대상
			LOG.debug(userUpdate.getLevel()+"=="+userVO.getLevel().nextLevel());
			assertEquals(userUpdate.getLevel(), userVO.getLevel().nextLevel());
		}else {
			assertEquals(userUpdate.getLevel(), userVO.getLevel());
		}
	
		
	}
	
	
	
	//@Ignore
	@Test
	public void beans() {
		LOG.debug("====================");
		LOG.debug("=beans()=");
		LOG.debug("=mailSender="+mailSender);

		LOG.debug("=userDao="+userDao);
		LOG.debug("=userService="+userService);
		LOG.debug("====================");
		assertNotNull(mailSender);
		assertNotNull(userDao);
		assertNotNull(userService);
				
	}

}
