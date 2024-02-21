package com.pcwk.ehr.subject;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.code.domain.CodeVO;
import com.pcwk.ehr.dm.domain.DmVO;
import com.pcwk.ehr.subject.dao.SubjectDao;
import com.pcwk.ehr.subject.domain.SubjectVO;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정

@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)

public class SubjectControllerTest implements PcwkLogger {

	@Autowired
	SubjectDao dao;

	@Autowired
	WebApplicationContext webApplicationContext;

	MockMvc mockMvc;
	List<SubjectVO> subjectList;
	SubjectVO searchVO;

	@Before
	public void setUp() throws Exception {
		int subjectCode = 10;
		int coursesCode = 200;// 과정코드
		String professor = "cristiano@gmail.com";// 교수님
		String trainee = "ronaldoo1@gmail.com";// 훈련생
		int score = 10;// 점수

		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
		subjectList = Arrays.asList(new SubjectVO(subjectCode, coursesCode, professor, trainee, score, score, score));
		searchVO = new SubjectVO();
		searchVO.setTrainee(trainee);
	}

	// 통과됨
	//@Ignore
	@Test
	public void doSave() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSave()                                  │");
		LOG.debug("└───────────────────────────────────────────┘");

		SubjectVO vo = subjectList.get(0);
		MockHttpServletRequestBuilder requestBuilder = MockMvcRequestBuilders.post("/subject/doSave.do")
				.param("subjectCode", vo.getSubjectCode() + "").param("coursesCode", vo.getCoursesCode() + "")
				.param("professor", vo.getProfessor() + "").param("trainee", vo.getTrainee() + "")
				.param("score", vo.getScore() + "");

		// 요청을 수행하고 리다이렉션을 예상합니다
		ResultActions resultActions = this.mockMvc.perform(requestBuilder).andExpect(status().is3xxRedirection()) // 리다이렉션
																													// 상태를
																													// 예상합니다
				.andExpect(redirectedUrl("/login/loginView.do")); // 예상된 리다이렉션 URL이 실제 URL과 일치하는지 확인합니다

		// 필요한 경우 여기에 추가적인 단언문을 추가할 수 있습니다
	}

	
	@Test
	public void doSelectOne() throws Exception {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doSelectOne()                             │");
		LOG.debug("└───────────────────────────────────────────┘");

		// 테스트 데이터 설정
		SubjectVO vo = subjectList.get(0);

		// MockMvc를 사용하여 컨트롤러 메소드 호출
		MockHttpServletRequestBuilder requestBuilder = MockMvcRequestBuilders.get("/subject/doSelectOne")
				.param("subjectCode", String.valueOf(vo.getSubjectCode())).param("trainee", vo.getTrainee());

		// 요청 수행 및 결과 검증
		MvcResult result = mockMvc.perform(requestBuilder).andExpect(status().isOk())
				.andExpect(model().attributeExists("subjectVO")).andDo(print()).andReturn();

		// 모델에서 "subjectVO" 속성 가져오기
		SubjectVO resultVO = (SubjectVO) result.getModelAndView().getModel().get("subjectVO");

		// 추가적인 결과 검증
		assertNotNull(resultVO);
		assertEquals(vo.getSubjectCode(), resultVO.getSubjectCode());
		assertEquals(vo.getCoursesCode(), resultVO.getCoursesCode());
		assertEquals(vo.getTrainee(), resultVO.getTrainee());
		assertEquals(vo.getScore(), resultVO.getScore());

		// 추가적인 내용을 검증하려면 여기에 더 많은 assert문을 추가하세요.
	}
	//@Ignore
	@Test
	public void doRetrieve() throws Exception {

	    // 교수 권한을 가진 사용자 세션 설정
	    MockHttpSession session = new MockHttpSession();
	    session.setAttribute("USER_EMAIL", "cristiano@gmail.com"); // 교수 이메일 설정
	    session.setAttribute("USER_ROLE", 20); // 교수 역할을 나타내는 코드 (예: 20)

	    // mockMvc를 사용하여 doRetrieve 메소드 호출
	    mockMvc.perform(get("/subject/doRetrieve.do")
	            .session(session)) // 설정한 세션 사용
	            .andExpect(status().isOk()) // HTTP 상태 코드 200 예상
	            .andExpect(view().name("subject/subject_list")) // 반환된 뷰 이름 검증
	            .andExpect(model().attributeExists("list")) // 모델에 "list" 속성이 존재하는지 검증
	            .andDo(print()); // 요청 및 응답 출력 (디버깅 용)
	}
	
	@Ignore
	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ beans()                                   │");
		LOG.debug("│ webApplicationContext                     │" + webApplicationContext);
		LOG.debug("│ mockMvc                                   │" + mockMvc);
		LOG.debug("└───────────────────────────────────────────┘");
		assertNotNull(dao);
		assertNotNull(mockMvc);
		assertNotNull(webApplicationContext);
	}

}
