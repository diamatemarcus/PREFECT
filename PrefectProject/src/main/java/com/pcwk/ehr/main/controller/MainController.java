package com.pcwk.ehr.main.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pcwk.ehr.board.domain.BoardVO;
import com.pcwk.ehr.board.service.BoardService;
import com.pcwk.ehr.user.service.UserService;


@Controller
@RequestMapping("main")
public class MainController {
	final Logger LOG = LogManager.getLogger(getClass());
	
	
	public MainController() {}
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	UserService userService;
	@RequestMapping(value="/mainView.do")
	public String mainView(Model model,HttpSession httpsession) throws SQLException{
		

		String role = (String) httpsession.getAttribute("role");
		
		 model.addAttribute("role", role);
		 
		 LOG.debug("role:" + role);
		 
		 int totalBoard =boardService.totalBoard();
		 model.addAttribute("totalBoard", totalBoard);
		 
		 int totalUsers = userService.totalUsers();
	     model.addAttribute("totalUsers", totalUsers);
	        
		String view ="main/main";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ mainView                				   │");
		LOG.debug("└───────────────────────────────────────────┘");	
		
		List<BoardVO> topBoards = boardService.doRetrieveByReadCnt();
		model.addAttribute("topBoards", topBoards);
		
		return view;
	}
}
