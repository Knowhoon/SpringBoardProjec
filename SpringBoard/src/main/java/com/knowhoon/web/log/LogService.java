package com.knowhoon.web.log;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LogService {
	@Autowired
	private LogDAO logDAO;

	public void insertLog(LogDTO log) {
		logDAO.insertLog(log);
	}

	public List<LogDTO> logList(Map<String, Object> sendMap) {
		return logDAO.loglist(sendMap);
	}
	
	

}
