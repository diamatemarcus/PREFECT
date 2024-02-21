package com.pcwk.ehr.subject.domain;


import com.pcwk.ehr.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SubjectVO extends DTO {

	private int subjectCode;// 과목코드
	private int coursesCode;// 과정코드
	private String professor;// 교수님
	private String trainee;// 훈련생
	private int score;// 점수
    private int javaScore;
    private int sqlScore;
    
	@Override
	public String toString() {
		return "SubjectVO [subjectCode=" + subjectCode + ", coursesCode=" + coursesCode + ", professor=" + professor
				+ ", trainee=" + trainee + ", score=" + score + ", java_score=" + javaScore + ", sql_score="
				+ sqlScore + ", toString()=" + super.toString() + "]";
	}

	

}
