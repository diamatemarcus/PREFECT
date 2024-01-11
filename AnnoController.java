package com.pcwk.ehr.anno.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pcwk.ehr.anno.domain.AnnoVO;
import com.pcwk.ehr.anno.service.AnnoService;

@Controller
public class AnnoController {

	@Autowired
	AnnoService annoService;
	
	@RequestMapping(value="/anno/doSelectOne.do",method = RequestMethod.POST)
	public String doSelectOne(Model model, HttpServletRequest req) throws SQLException {
		System.out.println("===================");
		System.out.println("=AnnoController=");
		System.out.println("===================");	     
		AnnoVO outVO =new AnnoVO();
		
		String userId = req.getParameter("userId");
		String password = req.getParameter("password");
		outVO.setUserId(userId);
		outVO.setPassword(password);
		
		System.out.println("=userId="+userId);
		System.out.println("=password="+password);
		System.out.println("=outVO="+outVO);
		
		AnnoVO vo = annoService.doSelectOne(outVO);
		model.addAttribute("userId", vo.getUserId());
		model.addAttribute("password", vo.getPassword());
		return "anno/anno";
	}
	
	//화면 호출
	@RequestMapping(value="/anno/view.do")
	public String annoView() {
		System.out.println("===================");
		System.out.println("=annoView=");
		System.out.println("===================");
		
		//prefix : /WEB-INF/views/
		//         anno/anno   -> /WEB-INF/views/anno/anno.jsp
		//suffix : .jsp		
		
		return "anno/anno";
	}
	
}
