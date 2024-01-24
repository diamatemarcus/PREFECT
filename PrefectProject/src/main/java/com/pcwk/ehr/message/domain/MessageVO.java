package com.pcwk.ehr.message.domain;

import com.pcwk.ehr.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Getter // getter
@Setter // setter
@NoArgsConstructor // default 생성자
@AllArgsConstructor // 모든인자 생성자
public class MessageVO extends DTO {
	private String seq;
	private int room;
	private String sender;
	private String receiver;
	private String contents;
	private String sendDt;
	private String readDt;
	private String readChk;
	
	private String name;
	private String otherNick;
	private String nick;
	private int unread;
	@Override
	public String toString() {
		return "MessageVO [seq=" + seq + ", room=" + room + ", sender=" + sender + ", receiver=" + receiver
				+ ", contents=" + contents + ", sendDt=" + sendDt + ", readDt=" + readDt + ", readChk=" + readChk
				+ ", name=" + name + ", otherNick=" + otherNick + ", nick=" + nick + ", unread=" + unread
				+ ", toString()=" + super.toString() + "]";
	}
	

}
