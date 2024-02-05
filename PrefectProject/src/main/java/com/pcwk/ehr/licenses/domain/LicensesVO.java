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
	private String name;
	@Override
	public String toString() {
		return "LicenseVO [seq=" + seq + ", name=" + name + ", toString()=" + super.toString() + "]";
	}
	
	
}
