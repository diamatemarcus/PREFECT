package com.pcwk.ehr.schedule.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.pcwk.ehr.calendar.domain.CalendarVO;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.cmn.StringUtil;
import com.pcwk.ehr.schedule.domain.ScheduleVO;
import com.pcwk.ehr.schedule.service.ScheduleService;
import com.pcwk.ehr.user.domain.UserVO;

@Controller
@RequestMapping("schedule")
public class ScheduleController implements PcwkLogger{
	
	@Autowired
	ScheduleService  scheduleService;
	
	public ScheduleController () {
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ ScheduleController                        │");
		LOG.debug("└───────────────────────────────────────────┘");
	}
	
	@RequestMapping(value="/moveToReg.do", method = RequestMethod.GET)
	public String moveToReg()throws SQLException {
		String view = "scheudle/schdule_reg";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ moveToReg                                 │");
		LOG.debug("└───────────────────────────────────────────┘");	
		
		return view;
	}
	
	//수정
	@RequestMapping(value="/doUpdate.do",method = RequestMethod.POST
			,produces = "application/json;charset=UTF-8"
			)
	@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
	public String doUpdate(ScheduleVO inVO) throws SQLException {
		String jsonString = "";
		LOG.debug("┌───────────────────────────────────────────┐");
		LOG.debug("│ doUpdate()                                  │inVO:"+inVO);
		LOG.debug("└───────────────────────────────────────────┘");		
				
		int flag = this.scheduleService.doUpdate(inVO);
		String message = "";
		if(1==flag) {
			message = inVO.getScheduleID()+"가 수정 되었습니다.";
		}else {
			message = inVO.getScheduleID()+"수정 실패";
		}
		MessageVO messageVO = new MessageVO(flag+"", message);
		jsonString = new Gson().toJson(messageVO);
		LOG.debug("jsonString:"+jsonString);	
						
		
		return jsonString;
	}
	
		//단건조회
		@RequestMapping(value="/doSelectOne.do", method = RequestMethod.GET)
		public String doSelectOne(ScheduleVO inVO,HttpServletRequest req, Model model) throws SQLException, EmptyResultDataAccessException {
			String view = "schedule/schedule_mod";
			LOG.debug("┌───────────────────────────────────────────┐");
			LOG.debug("│ doSelectOne()                             │inVO:"+inVO);
			LOG.debug("└───────────────────────────────────────────┘");	
			String scheduleID = req.getParameter("scheduleID");
			LOG.debug("│ scheduleID                                :"+scheduleID);		
			
			ScheduleVO outVO = this.scheduleService.doSelectOne(inVO);
			LOG.debug("│ outVO                                :"+outVO);		

			model.addAttribute("outVO", outVO);
			return view;
		}
		
		//삭제
		@RequestMapping(value = "/doDelete.do", method = RequestMethod.GET
				,produces = "application/json;charset=UTF-8"
				)
		@ResponseBody
		public String doDelete(ScheduleVO inVO,HttpServletRequest req) throws SQLException {
			String jsonString = "";
			LOG.debug("┌───────────────────────────────────────────┐");
			LOG.debug("│ doDelete()                                │inVO:"+inVO);
			LOG.debug("└───────────────────────────────────────────┘");	
			String scheduleID = req.getParameter("scheduleID");
			LOG.debug("│ scheduleID                                :"+scheduleID);
			
			
			int flag = scheduleService.doDelete(inVO);
			String message = "";
			
			if(1==flag) {
				message = inVO.getScheduleID()+"가 삭제 되었습니다.";
			}else {
				message = inVO.getScheduleID()+" 삭제 실패.";
			}
			
			MessageVO  messageVO=new MessageVO(String.valueOf(flag),message);
			jsonString = new Gson().toJson(messageVO);
			
			LOG.debug("jsonString:"+jsonString);		
			return jsonString;
		}
		
		//등록
		@RequestMapping(value="/doSave.do",method = RequestMethod.POST
				,produces = "application/json;charset=UTF-8"
				)
		@ResponseBody// HTTP 요청 부분의 body부분이 그대로 브라우저에 전달된다.
		public String doSave(ScheduleVO inVO) throws SQLException{
			String jsonString = "";
			LOG.debug("┌───────────────────────────────────────────┐");
			LOG.debug("│ doSave()                                  │inVO:"+inVO);
			LOG.debug("└───────────────────────────────────────────┘");		
			
			
			int flag = scheduleService.doSave(inVO);
			String message = "";
			
			if(1==flag) {
				message = inVO.getScheduleID()+"가 등록 되었습니다.";
			}else {
				message = inVO.getScheduleID()+"등록 실패.";
			}
			
			MessageVO messageVO=new MessageVO(flag+"", message);
			jsonString = new Gson().toJson(messageVO);
			LOG.debug("jsonString:"+jsonString);		
					
			return jsonString;
		}
		
		
		@GetMapping(value = "/doSelectAllSchedule.do"
				,produces = "application/json;charset=UTF-8")
		@ResponseBody
		public List<ScheduleVO> doRetrievePopup(CalendarVO inVO, HttpServletRequest req, Model model) throws SQLException {
			LOG.debug("┌───────────────────────────────────────────┐");
			LOG.debug("│ doRetrievePopup                           │inVO:"+inVO);
			LOG.debug("└───────────────────────────────────────────┘");				

			String calID = req.getParameter("calID");
			LOG.debug("│ calID                                :"+calID);	
			
			List<ScheduleVO>  list = this.scheduleService.doRetrieve(inVO);
			
			for(ScheduleVO vo  :list) {
				LOG.debug("vo:"+vo);
			}
			
			//model.addAttribute("scheduleList", list);
			
			return list;
		}
		
}
