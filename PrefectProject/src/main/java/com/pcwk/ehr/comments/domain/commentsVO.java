package com.pcwk.ehr.comments.domain;

import lombok.*;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter // getter
@Setter // setter
@NoArgsConstructor // default 생성자
@AllArgsConstructor // 모든인자 생성자
public class commentsVO {

	private int seq;
	private String regId;
	private int boardSeq;
	private String comments;
	
}