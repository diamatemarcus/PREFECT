package com.pcwk.ehr;

import com.pcwk.ehr.file.domain.FileVO;

public class FileVOLombok {

	public static void main(String[] args) {
		FileVO fileVO=new FileVO();
		fileVO.setOrgFileName("원본파일명");
		
		
		System.out.println(fileVO.getOrgFileName());
		System.out.println(fileVO.toString());
	}

}
//원본파일명
//FileVO(orgFileName=원본파일명, saveFileName=null, fileSize=0, extension=null, savePath=null)