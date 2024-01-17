package com.pcwk.ehr.file.domain;

import com.pcwk.ehr.cmn.DTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter  //setter
@Setter  //getter
@NoArgsConstructor //default 생성자
@ToString          //toString
@AllArgsConstructor//모든인자 생성자
public class FileVO extends DTO {
	

	private String uuid     ;//UUID   
	private int    seq      ;//순번
	private String orgFileName;//원본파일명
	private String saveFileName;//저장파일명
	private String extension;//확장자
	private long fileSize;//파일크기
	private String savePath;//저장경로: /resources/upload/2023/12
	
	private String regDt    ;//등록일
	private String regId    ;//등록자  ID

}
