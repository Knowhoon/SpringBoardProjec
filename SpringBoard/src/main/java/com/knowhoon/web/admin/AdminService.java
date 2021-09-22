package com.knowhoon.web.admin;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
	@Autowired
	private AdminDAO adminDAO;

	public List<HashMap<String, Object>> getCategory() {
		return adminDAO.getCategory();
	}

	public int categoryInsert(String categoryName) {
		return adminDAO.categoryInsert(categoryName);
	}

	public HashMap<String, Object> getCategory(int sca_no) {
		return adminDAO.getCategory(sca_no);
	}

	public Object categoryUpdate(HashMap<String, Object> cate) {
		return adminDAO.categoryUpdate(cate);
		
	}

	public List<AdminDTO> memberList() {
		return adminDAO.memberList();
	}
	public int gradeModify(AdminDTO adminDTO) {
		return adminDAO.gradeModify(adminDTO);
	}

	public int userDelete(Integer sm_no) {
		return adminDAO.userDelete(sm_no);
	}

	public int categoryVisible(HashMap<String,Object> cate) {
		return adminDAO.categoryVisible(cate);
	}


}
