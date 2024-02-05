package com.pcwk.ehr.licenses.domain;

import com.pcwk.ehr.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor // default 생성자
@AllArgsConstructor // 모든인자 생성자
public class LicensesVO extends DTO {
	private int licensesSeq;
	private String email;
	private String regDt;

	@Override
	public String toString() {
		return "LicensesVO [licensesSeq=" + licensesSeq + ", email=" + email + ", RegDt=" + regDt + ", toString()="
				+ super.toString() + "]";
	}

}
