package com.pcwk.ehr.search.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pcwk.ehr.cmn.PcwkLogger;

@Controller
@RequestMapping("search")
public class SearchEmailController implements PcwkLogger{

@RequestMapping(value="/searchEmail.do")
public String searchEmail() {
	String view = "search/search_email";
	LOG.debug("┌───────────────────────────────────────────┐");
	LOG.debug("│ searchEmail                               │");
	LOG.debug("└───────────────────────────────────────────┘");				
			
	return view;
	}

}
