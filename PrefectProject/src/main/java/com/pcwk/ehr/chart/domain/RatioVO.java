package com.pcwk.ehr.chart.domain;

import com.pcwk.ehr.cmn.DTO;

import lombok.Data;

@Data
public class RatioVO extends DTO {
	private String gender; // 세션에서 받아온 이메일
	private String genderCount;
}
