package com.pcwk.ehr.calendar.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter // getter
@Setter // setter
@NoArgsConstructor // default 생성자
@AllArgsConstructor // 모든인자 생성자
public class WeekVO {

	private String sun;
	private String mon;
	private String tue;
	private String wed;
	private String thu;
	private String fri;
	private String sat;
	
	@Override
	public String toString() {
		return "WeekVO [sun=" + sun + ", mon=" + mon + ", tue=" + tue + ", wed=" + wed + ", thu=" + thu + ", fri=" + fri
				+ ", sat=" + sat + "]";
	}
	
}
