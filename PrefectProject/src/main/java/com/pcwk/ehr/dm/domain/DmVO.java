package com.pcwk.ehr.dm.domain;

import com.pcwk.ehr.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Getter // getter
@Setter // setter
@NoArgsConstructor // default 생성자
@AllArgsConstructor // 모든인자 생성자
public class DmVO extends DTO {
	private int seq;
	private int room;
	private String sender;
	private String receiver;
	private String contents;
	private String sendDt;
	private String readDt;
	private int readChk;
	private String senderName;
    private String receiverName;
	@Override
	public String toString() {
		return "DmVO [seq=" + seq + ", room=" + room + ", sender=" + sender + ", receiver=" + receiver + ", contents="
				+ contents + ", sendDt=" + sendDt + ", readDt=" + readDt + ", readChk=" + readChk + ", senderName="
				+ senderName + ", receiverName=" + receiverName + ", toString()=" + super.toString() + "]";
	}
	
	
	
}
