package com.knowhoon.web.admin;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public List<HashMap<String, Object>> getCategory(){
		return sqlSession.selectList("admin.getCategory");
	}

	public int categoryInsert(String categoryName) {
		return sqlSession.insert("admin.categoryInsert", categoryName);
	}

	public HashMap<String, Object> getCategory(int sca_no) {
		return sqlSession.selectOne("admin.getCategory", sca_no);
	}

	public Object categoryUpdate(HashMap<String, Object> cate) {
		return sqlSession.update("admin.categoryUpdate", cate);
	}

	public List<AdminDTO> memberList() {
		return sqlSession.selectList("admin.memberList");
	}

	public int gradeModify(AdminDTO adminDTO) {
		return sqlSession.update("admin.gradeModify", adminDTO);
	}

	public int userDelete(Integer sm_no) {
		return sqlSession.update("admin.userDelete", sm_no);
	}

	public int categoryVisible(HashMap<String, Object> cate) {
		return sqlSession.update("admin.categoryVisible", cate);
	}
	
}
