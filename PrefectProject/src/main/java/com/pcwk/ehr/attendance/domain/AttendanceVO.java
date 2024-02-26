package com.pcwk.ehr.attendance.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceVO{

	private String seq;
	private String professor;// 교수님
	private String trainee;// 훈련생
	private int attendStatus;// 출석, 지각, 조퇴, 결석
	private int calID;// 날짜ID
	
	@Override
	public String toString() {
		return "AttendanceVO [seq=" + seq + ", professor=" + professor + ", trainee=" + trainee + ", attendStatus="
				+ attendStatus + ", calID=" + calID + "]";
	}
	
}

