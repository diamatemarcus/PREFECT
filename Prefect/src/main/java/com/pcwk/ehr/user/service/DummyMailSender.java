package com.pcwk.ehr.user.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;



public class DummyMailSender implements MailSender {
	final Logger LOG = LogManager.getLogger(DummyMailSender.class);
	@Override
	public void send(SimpleMailMessage simpleMessage) throws MailException {
		LOG.debug("┌─────────────────────────────────────────────────────────┐");
		LOG.debug("│ DummyMailSender send() 개발에서는 mail전송 되지 않음!          │");
		LOG.debug("└─────────────────────────────────────────────────────────┘");		

	}

	@Override
	public void send(SimpleMailMessage... simpleMessages) throws MailException {
		// TODO Auto-generated method stub

	}

}
