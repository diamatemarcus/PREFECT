package com.pcwk.ehr.message.dao;


import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.message.domain.MessageVO;

@Repository
public class MessageDao implements PcwkLogger {
	final String NAMESPACE = "com.pcwk.ehr.message";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public ArrayList<MessageVO> messageList(MessageVO vo){
		
		String nick =vo.getNick();
		
		ArrayList<MessageVO> list=sqlSessionTemplate.selectOne(NAMESPACE+DOT+"message_list", vo);
		
		for(MessageVO mvo :list) {
			mvo.setNick(nick);
			
			int unread = sqlSessionTemplate.selectOne(NAMESPACE+DOT+"countUnread", mvo);
			
			String name = sqlSessionTemplate.selectOne(NAMESPACE+DOT+"doGetName", mvo);
			
			mvo.setUnread(unread);
			mvo.setName(name);
			
			if(nick.equals(mvo.getReceiver())) {
				mvo.setOtherNick(mvo.getReceiver());
			}else {
				mvo.setOtherNick(mvo.getSender());
			}
		}
		
		return list;
	}
	
	public ArrayList<MessageVO> roomContentList(MessageVO vo){
		
		LOG.debug("room: "+vo.getRoom());
		LOG.debug("Receiver: "+vo.getReceiver());
		LOG.debug("nick: "+vo.getNick());
		
		ArrayList<MessageVO> clist= sqlSessionTemplate.selectOne(NAMESPACE+DOT+"room_content_list", vo);
		sqlSessionTemplate.update(NAMESPACE+DOT+"message_read_chk", vo);
		return clist;
	}
	
	public int messageSend(MessageVO vo) {
		
		if(vo.getRoom()==0) {
			int exist_chat =sqlSessionTemplate.selectOne(NAMESPACE+DOT+"exist_chat", vo);
			
			if(exist_chat ==0) {
				int max_room = sqlSessionTemplate.selectOne(NAMESPACE+DOT+"max_room", vo);
				vo.setRoom(max_room+1);
			}else {
				int room = Integer.parseInt(sqlSessionTemplate.selectOne(NAMESPACE+DOT+"select_room", vo));
				vo.setRoom(room);
			}
		}
		int flag = sqlSessionTemplate.insert(NAMESPACE+DOT+"messageSend", vo);
		return flag;
	}
}
