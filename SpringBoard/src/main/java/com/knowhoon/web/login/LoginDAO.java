package com.knowhoon.web.login;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public LoginDTO loginAction(LoginDTO loginDTO) {
		return sqlSession.selectOne("login.loginAction", loginDTO);
	}

	public String checkID(String sm_id) {
		return sqlSession.selectOne("login.checkID", sm_id);
	}

	public int joinAction(LoginDTO loginDTO) {
		return sqlSession.insert("login.joinAction", loginDTO);
	}

	public String checkEmail(String sm_email) {
		return sqlSession.selectOne("login.checkEmail", sm_email);
	}

	public String getSalt(String sm_id) {
		return sqlSession.selectOne("login.getSalt", sm_id);
	}	
}