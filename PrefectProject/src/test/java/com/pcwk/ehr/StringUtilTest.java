package com.pcwk.ehr;

import java.util.UUID;

import com.pcwk.ehr.cmn.StringUtil;

public class StringUtilTest {
	
	static String IMG_PATH  = "C:\\JSPM_0907\\03_WEB\\0305_SPRING\\WORKSPACE\\sw18\\src\\main\\webapp\\resources\\upload";
	public static String getExt(String fileName) {
		String ext = "";
		String tmpFileName = fileName;
		if(tmpFileName.lastIndexOf(".")>-1) {
			int lastIdx = tmpFileName.lastIndexOf(".");
			ext=tmpFileName.substring(lastIdx+1);
		}		
		return ext;
	}
	
	//36byte
    //일련의 숫자와 문자로 구성된 128비트 값으로 이뤄져있다.
	//범용 고유 식별자(Universally Unique Identifiers)
	//yyyyMMdd+UUID
	public static String getUUID() {
		UUID  uuid=UUID.randomUUID();
		return uuid.toString();
	}
	
	public static void main(String[] args) {
		System.out.println(getExt("StringUtilTest.java"));
		System.out.println(IMG_PATH.length());
//		String str = null;
//		
//		String retStr = StringUtil.nvl(str, "0");
//		
//		System.out.println("retStr:"+retStr);
//		
//		String retStr2 = StringUtil.nvl(str );
//		System.out.println("retStr2:"+retStr2);
//	
//		
//		System.out.println("UUID:"+getUUID());
//		//20231227_a4b76be5-9733-4fc7-9bf3-6470efa7a985
//		//45 length
//		System.out.println("UUID length:"+getUUID().length());
//		System.out.println("========================");
		System.out.println(StringUtil.getPK());
	}

}
