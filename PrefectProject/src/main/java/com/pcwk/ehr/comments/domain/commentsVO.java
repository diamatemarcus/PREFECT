package com.pcwk.ehr.comments.domain;

import com.pcwk.ehr.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter  //setter
@Setter  //getter
@NoArgsConstructor //default 생성자
@ToString          //toString
@AllArgsConstructor//모든인자 생성자
public class commentsVO extends DTO{

	private int seq; //댓글 순번
	private String regId;//댓글 등록자
	private int boardSeq;//게시판 순번
	private String comments;//댓글 내용
	
	@Override
	public String toString() {
		return "commentsVO ["+"seq="+seq+",regId="+regId+
				", boardSeq="+boardSeq+", comments="+comments+", toString()="+ super.toString() + "]";
	}
}