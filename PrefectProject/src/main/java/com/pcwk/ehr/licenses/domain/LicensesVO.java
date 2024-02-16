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
public class LicensesVO {

	private int licensesSeq;
	private String email;
	private String regDt;
	private String licensesName;

	public LicensesVO(int licensesSeq, String email, String regDt) {
		this.licensesSeq = licensesSeq;
		this.email = email;
		this.regDt = regDt;
	}

	public LicensesVO(int licensesSeq, String licensesName) {
		this.licensesSeq = licensesSeq;
		this.licensesName = licensesName;
	}

	@Override
	public String toString() {
		return "LicensesVO [licensesSeq=" + licensesSeq + ", email=" + email + ", regDt=" + regDt + ", licensesName="
				+ licensesName + "]";
	}

}
