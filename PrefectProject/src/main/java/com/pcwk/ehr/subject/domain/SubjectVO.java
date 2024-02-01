package com.pcwk.ehr.subject.domain;

import com.pcwk.ehr.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class SubjectVO extends DTO {

	private int subjectCode;// 과목코드
	private int courseCode;// 과정코드
	private String professor;// 교수님
	private String trainee;// 훈련생
	private int score;// 점수

	@Override
	public String toString() {
		return "SubjecVO [subjectCode=" + subjectCode + ", courseCode=" + courseCode + ", professor=" + professor
				+ ", trainee=" + trainee + ", score=" + score + ", toString()=" + super.toString() + "]";
	}

}
