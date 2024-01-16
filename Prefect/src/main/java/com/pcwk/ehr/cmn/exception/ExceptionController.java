package com.pcwk.ehr.cmn.exception;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.taglibs.standard.tag.common.core.NullAttributeException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pcwk.ehr.user.domain.UserVO;

@Controller
@RequestMapping("except")
public class ExceptionController {
	final Logger LOG = LogManager.getLogger(getClass());
	
	//http://localhost:8080/ehr/except/nullPointerException.do?userId=""
	@RequestMapping(value = "/nullPointerException.do", method = RequestMethod.GET)
	public String nullPointerException(UserVO user) {
		if(null ==user.getUserId()  || "".equals(user.getUserId())) {
			LOG.debug("============================");
			LOG.debug("==nullPointerException===");
			LOG.debug("============================");
			
			throw new NullPointerException("아이디를 입력 하세요");
		}
		
		return "user/user_list";
	}
	
}
