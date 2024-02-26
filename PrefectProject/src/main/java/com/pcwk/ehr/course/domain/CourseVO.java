package com.pcwk.ehr.course.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CourseVO{

	private int courseCode; //과정코드
	private String courseName; //과정이름
	private int numberOfTimes; //과정 몇회차
	private String courseInfo; //과정 정보
	private int academySeq;	//학원순번
	private String academyName; //학원이름
	private String email; //훈련생, 교수님
	private String startDate; //시작하는 날
	private String endDate; //끝나는 날
	
	@Override
	public String toString() {
		return "CourseVO [courseCode=" + courseCode + ", courseName=" + courseName + ", numberOfTimes=" + numberOfTimes
				+ ", courseInfo=" + courseInfo + ", academySeq=" + academySeq + ", academyName=" + academyName
				+ ", email=" + email + ", startDate=" + startDate + ", endDate=" + endDate + "]";
	}
	
}

