package com.pcwk.ehr.chart.domain;

import com.pcwk.ehr.cmn.DTO;

import lombok.Data;

@Data
public class ScoreVO extends DTO {
	private String subjectCode;
	private int score;
	private String trainee; // 이름을 조건으로 점수를 가져오기 위함
	private String email;

}
