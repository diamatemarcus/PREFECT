package com.pcwk.ehr.message.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcwk.ehr.message.dao.MessageDao;
import com.pcwk.ehr.message.domain.MessageVO;

@Controller
public class MessageController {
	
	@Autowired
	private MessageDao messageDao;
	
	@RequestMapping(value ="/message_list.do")
	public String messge_list(HttpServletRequest request, HttpSession session) {
		
		String nick = (String) session.getAttribute("nick");
		
		MessageVO vo = new MessageVO();
		vo.setNick(nick);
		
		ArrayList<MessageVO> list = messageDao.messageList(vo);
		
		request.setAttribute("list", list);
		return "message/message_list";
	}
	
	@RequestMapping(value ="/message_ajax_list.do")
	public String message_ajax_list(HttpServletRequest request, HttpSession session) {
		
		String nick = (String) session.getAttribute("nick");
		
		MessageVO vo = new MessageVO();
		vo.setNick(nick);
		
        ArrayList<MessageVO> list = messageDao.messageList(vo);
		
		request.setAttribute("list", list);
		
		return "message/message_ajax_list";
	}
	
	@RequestMapping(value ="/message_content_list.do")
	public String message_content_list(HttpServletRequest request, HttpSession session) {
		
		int room = Integer.parseInt(request.getParameter("room"));
		
		MessageVO vo = new MessageVO();
		vo.setRoom(room);
		vo.setNick((String)session.getAttribute("nick"));
		
		ArrayList<MessageVO> clist = messageDao.roomContentList(vo);
		
		request.setAttribute("clist", clist);
		
		return "message/message_content_list";
	}
	@ResponseBody
	@RequestMapping(value ="/message_send_inlist.do")
	public int message_send_inlist(@RequestParam int room,@RequestParam String otherNick,
									@RequestParam String contents, HttpSession session) {
		
		MessageVO vo = new MessageVO();
		vo.setRoom(room);
		vo.setSender((String)session.getAttribute("nick"));
		vo.setReceiver(otherNick);
		vo.setContents(contents);
		
		int flag = messageDao.messageSend(vo);
		return flag;
		
	}
}
