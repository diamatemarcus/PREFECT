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
		sqlSessionTemplate.update(NAMESPACE+DOT+"room_content_list", vo);
		return clist;
	}
}
