package com.pcwk.ehr.main.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("main")
public class MainController {
	final Logger LOG = LogManager.getLogger(getClass());
	
	
	public MainController() {}
	
	@RequestMapping(value="/mainView.do")
	public String mainView() {
		String view ="main/main";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ mainView                                  │");
		LOG.debug("└───────────────────────────────────────────┘");	
		
		return view;
	}
}
