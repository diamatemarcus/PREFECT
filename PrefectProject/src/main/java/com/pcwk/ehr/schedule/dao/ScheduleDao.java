package com.pcwk.ehr.schedule.dao;

import java.sql.SQLException;
import java.util.List;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.schedule.domain.ScheduleVO;

public interface ScheduleDao extends WorkDiv<ScheduleVO> {

	int getCount(ScheduleVO inVO) throws SQLException;
	


}