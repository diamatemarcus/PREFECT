package com.pcwk.ehr.main.controller;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("main")
public class MainController {
	final Logger LOG = LogManager.getLogger(getClass());
	
	
	public MainController() {}
	
	@RequestMapping(value="/mainView.do")
	public String mainView(Model model,HttpSession httpsession) {
		

		String role = (String) httpsession.getAttribute("role");
		
		 model.addAttribute("role", role);
		 
		 LOG.debug("role:" + role);
		
		String view ="main/main";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ mainView                				   │");
		LOG.debug("└───────────────────────────────────────────┘");	
		
		
		return view;
	}
}
