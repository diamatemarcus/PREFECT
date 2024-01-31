package com.pcwk.ehr.book;

import static org.junit.Assert.*;

import java.io.IOException;

import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pcwk.ehr.book.service.BookSearchService;
import com.pcwk.ehr.cmn.DTO;
import com.pcwk.ehr.cmn.PcwkLogger;

@RunWith(SpringJUnit4ClassRunner.class) // 스프링 테스트 컨텍스트 프레임웤그의 JUnit의 확장기능 지정
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class BookSearchJunitTest implements PcwkLogger {

	@Autowired
	BookSearchService bookService;

	@Autowired
	ApplicationContext context;

	DTO dto;

	@Before
	public void setUp() throws Exception {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ setUp                             │");
		LOG.debug("└───────────────────────────────────┘");
		dto = new DTO();
		dto.setPageNo(1);
		dto.setPageSize(10);
		dto.setSearchDiv("10");
		dto.setSearchWord("파이썬");
	}

	@Test
	public void doSearchBook() {
		try {
			String jsonString = bookService.doBookSearch(dto);

			LOG.debug("jsonString:" + jsonString);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@Test
	public void beans() {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ beans                             │");
		LOG.debug("│ context                           │" + context);
		LOG.debug("│ naverSearchService                │" + bookService);
		LOG.debug("└───────────────────────────────────┘");

		assertNotNull(bookService);
		assertNotNull(context);

	}

}
