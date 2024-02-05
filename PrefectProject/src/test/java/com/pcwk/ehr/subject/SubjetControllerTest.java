package com.pcwk.ehr.subject;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.context.WebApplicationContext;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.subject.dao.SubjectDao;
import com.pcwk.ehr.subject.domain.SubjectVO;

public class SubjetControllerTest implements PcwkLogger {

	@Autowired
	SubjectDao dao;
	
	@Autowired
	WebApplicationContext webApplicationContext;
	
	MockMvc  mockMvc;

	@Before
	
	
	@Test
	public void test() {
		fail("Not yet implemented");
	}

}
