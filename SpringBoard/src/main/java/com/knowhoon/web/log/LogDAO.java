package com.knowhoon.web.log;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LogDAO {
	@Autowired
	private SqlSession sqlSession;

	public void insertLog(LogDTO log) {
		sqlSession.insert("log.insertLog",log);
	}

	public List<LogDTO> loglist(Map<String, Object> sendMap) {
		return sqlSession.selectList("log.logList", sendMap);
	}
}
