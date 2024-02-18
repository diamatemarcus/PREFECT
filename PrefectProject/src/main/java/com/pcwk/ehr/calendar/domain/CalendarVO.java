package com.pcwk.ehr.calendar.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter // getter
@Setter // setter
@NoArgsConstructor // default 생성자
@AllArgsConstructor // 모든인자 생성자
public class CalendarVO {

	private int calID;// 날짜ID
	private String year;// 년도
	private String month;// 월
	private String day;// 일
	private String dayOfWeek;// 요일
	private String weekNo;// 주차
	private String email;
	
	public CalendarVO(int calID, String year, String month, String day, String dayOfWeek, String weekNo) {
		super();
		this.calID = calID;
		this.year = year;
		this.month = month;
		this.day = day;
		this.dayOfWeek = dayOfWeek;
		this.weekNo = weekNo;
	}
	
	@Override
	public String toString() {
		return "CalendarVO [calID=" + calID + ", year=" + year + ", month=" + month + ", day=" + day + ", dayOfWeek="
				+ dayOfWeek + ", weekNo=" + weekNo + ", email=" + email + "]";
	}

}
