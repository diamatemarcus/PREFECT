package com.pcwk.ehr.reply.dao;

import java.sql.SQLException;

import com.pcwk.ehr.cmn.WorkDiv;
import com.pcwk.ehr.reply.domain.ReplyVO;

public interface ReplyDao extends WorkDiv<ReplyVO> {

	public int getReplySeq() throws SQLException;
}
