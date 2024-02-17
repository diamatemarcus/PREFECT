package com.pcwk.ehr.reply.domain;

import com.pcwk.ehr.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter  //setter
@Setter  //getter
@NoArgsConstructor //default 생성자
@AllArgsConstructor//모든인자 생성자 
public class ReplyVO extends DTO {
	//소문자 변환: ctrl+shift+y
	//대문자 변환: ctrl+shift+x
	private Long   replySeq   ;//순번
	private Long   boardSeq   ;//게시순번
	private String reply      ;//댓글
	private String regDt      ;//등록일
	private String regId      ;//등록자
	private String modDt      ;//수정일
	@Override
	public String toString() {
		return "ReplyVO [replySeq=" + replySeq + ", boardSeq=" + boardSeq + ", reply=" + reply + ", regDt=" + regDt
				+ ", regId=" + regId + ", modDt=" + modDt + ", toString()=" + super.toString() + "]";
	}
	
}