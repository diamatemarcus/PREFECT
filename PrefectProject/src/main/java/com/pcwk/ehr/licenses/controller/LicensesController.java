package com.pcwk.ehr.licenses.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.licenses.service.LicensesService;

@Controller
@RequestMapping("licenses")
public class LicensesController implements PcwkLogger{
	@Autowired
	LicensesService service;
	
	public LicensesController() {}

}
