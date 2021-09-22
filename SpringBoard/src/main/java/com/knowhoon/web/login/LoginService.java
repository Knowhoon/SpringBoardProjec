package com.knowhoon.web.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
	@Autowired
	private LoginDAO loginDAO;
	
	public LoginDTO loginAction(LoginDTO loginDTO) {
		
		return loginDAO.loginAction(loginDTO);
	}

	public String checkID(String sm_id) {
		return loginDAO.checkID(sm_id);
	}

	public int joinAction(LoginDTO loginDTO) {
		return loginDAO.joinAction(loginDTO);
	}

	public String checkEmail(String email) {
		return loginDAO.checkEmail(email);
	}

}
