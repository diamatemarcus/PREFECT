package com.pcwk.ehr.licenses.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor //default 생성자
@AllArgsConstructor//모든인자 생성자
public class LicensesVO {
	private int seq;
	private int licensesSeq;
	private String email;
	private String name;
	private String RegDt;
	
	@Override
	public String toString() {
		return "LicensesVO [seq=" + seq + ", licensesSeq=" + licensesSeq + ", email=" + email + ", name=" + name
				+ ", RegDt=" + RegDt + ", toString()=" + super.toString() + "]";
	}
	
	

	
	
	
}
