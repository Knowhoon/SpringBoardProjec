package com.knowhoon.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.knowhoon.web.admin.AdminDTO;
import com.knowhoon.web.admin.AdminService;
import com.knowhoon.web.log.LogDTO;
import com.knowhoon.web.log.LogService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private AdminService adminService;
	@Autowired
	private LogService logService;
	
	//카테고리
	@RequestMapping(value = "/category", method = RequestMethod.GET)
	public ModelAndView category(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("/admin/category");
		List<HashMap<String, Object>> cate = adminService.getCategory();
		
		mv.addObject("category", cate);
	    return mv;
	}
	//게시판 추가
	@PostMapping("/category")
	public String categoryInsert(HttpServletRequest request) {
		String categoryName = request.getParameter("categoryName");
		adminService.categoryInsert(categoryName);
		return "redirect:/admin/category";
	}
	//게시판 이름 수정
	@GetMapping("/categoryUpdate")
	public ModelAndView categoryUpdate(HttpServletRequest request) {
		int sca_no = Integer.parseInt(request.getParameter("sca_no"));
		ModelAndView mv = new ModelAndView("/admin/categoryUpdate");
		HashMap<String, Object> cate = adminService.getCategory(sca_no);
		mv.addObject("cate", cate);
		return mv;
	}
	//게시판 이름 수정
	@PostMapping("/categoryUpdate")
	public String categoryUpdate2(HttpServletRequest request) {
		String categoryName = request.getParameter("sca_category");
		String categoryNo = request.getParameter("sca_no");
		HashMap<String, Object> cate = new HashMap<String, Object>();
		cate.put("sca_category", categoryName);
		cate.put("sca_no", categoryNo);
		adminService.categoryUpdate(cate);
		return "redirect:/admin/category";
	}
	//회원 리스트
	@GetMapping("/memberList")
	public ModelAndView member(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();//페이지없이생성
		mv.setViewName("admin/memberList");
		int sm_grade = 0;
		if(request.getSession().getAttribute("sm_grade") != null) {
			sm_grade = (int) request.getSession().getAttribute("sm_grade");
		}
		if(sm_grade != 0 && sm_grade == 9) {
			mv.addObject("memberList", adminService.memberList());
		}else {
			System.out.println("잘못된 접근");			
		}
		return mv;		
	}
	//회원 등급 수정
	@GetMapping("/gradeModify")
	public String gradeModify(AdminDTO adminDTO, HttpServletRequest request) {
		int grade = Integer.parseInt(request.getParameter("sm_grade"));
		if(request.getParameter("code").equals("up")) {
			grade++;					
		}else if(request.getParameter("code").equals("down")) {
			grade--;
		}
		adminDTO.setSm_grade(grade);
		int result = adminService.gradeModify(adminDTO);
		if(result == 1) {
			return "redirect:/admin/memberList";			
		}else {
			return "redirect:/admin/error?gradeModifyError";
		}		
	}
	//회원 삭제(등급 최하위 하락)
	@GetMapping("/userDelete")
	public String userDelete(@RequestParam("sm_no") Integer sm_no) {
		int result = adminService.userDelete(sm_no);
		if(result == 1) {
			return "redirect:/admin/memberList";
		}else {
			return "redirect:/admin/error?userDeleteError";
		}
		
	}
	//게시판 노출 기능
	@GetMapping("/categoryVisible")
	public String categoryVisible(HttpServletRequest request) {
		HashMap<String, Object> cate = new HashMap<String, Object>();
		cate.put("sca_no", request.getParameter("sca_no"));
		cate.put("sca_visible", request.getParameter("sca_visible"));
		
		int result = adminService.categoryVisible(cate);
		
		if(result == 1) {
			return "redirect:/admin/category";
		}else {
			return "redirect:/admin/error?categoryVisibleError";
		}		
	}
	//로그 리스트
	@GetMapping("/logList")
	public ModelAndView logber(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();//페이지없이생성
		mv.setViewName("admin/logList");
		
		if(request.getSession().getAttribute("sm_grade") != null && (int) request.getSession().getAttribute("sm_grade") == 9) {
			
			Map<String, Object> sendMap = new HashMap<String, Object>();
			
			if(request.getParameter("search") != null) {
			sendMap.put("searchOption", request.getParameter("searchOption"));
			sendMap.put("search", request.getParameter("search"));			
			mv.addObject("searchOption", sendMap.get("searchOption"));
			mv.addObject("search", sendMap.get("search"));
			}
			//페이지네이션인포
			PaginationInfo paginationInfo = new PaginationInfo();
			int pageNo = 1; //현재 페이지 번호
			int listScale = 10; //한 페이지에 나올 글 수
			int pageScale = 10; // 페이지 개수
			
			if(request.getParameter("pageNo") != null) {
				pageNo = Integer.parseInt(request.getParameter("pageNo"));
			}
			
			paginationInfo.setCurrentPageNo(pageNo);	//현재 페이지 번호
			paginationInfo.setRecordCountPerPage(listScale);	//한 페이지에 나올 글 수
			paginationInfo.setPageSize(pageScale);	//페이지 개수
			
			int startPage = paginationInfo.getFirstRecordIndex(); // 시작페이지
			int lastPage = paginationInfo.getRecordCountPerPage(); // 마지막페이지
			
			sendMap.put("startPage", startPage); // sendMap에 시작페이지 추가
			sendMap.put("lastPage", lastPage);	 // sendMap에 마지막 페이지 추가			
			List<LogDTO> logList = logService.logList(sendMap);
			if(logList.size() > 0) {
				paginationInfo.setTotalRecordCount(logList.get(0).getTotalList());//전체 글 수 저장			
				mv.addObject("logList", logList);
				mv.addObject("paginationInfo", paginationInfo);
				mv.addObject("pageNo", pageNo);
			}			
		}else {
			System.out.println("잘못된 접근");			
		}
		return mv;		
	}
}
