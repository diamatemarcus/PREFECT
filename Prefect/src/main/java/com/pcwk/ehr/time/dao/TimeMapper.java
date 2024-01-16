package com.pcwk.ehr.time.dao;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {

	@Select("SELECT SYSDATE FROM dual")
	public String getDateTime();
	
	public String getPcwkDateTime();
	
}
