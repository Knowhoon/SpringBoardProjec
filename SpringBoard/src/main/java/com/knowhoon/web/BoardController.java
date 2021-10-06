package com.knowhoon.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.knowhoon.util.FileSave;
import com.knowhoon.util.Util;
import com.knowhoon.web.board.BoardDTO;
import com.knowhoon.web.board.BoardService;
import com.knowhoon.web.board.VoteDTO;
import com.knowhoon.web.log.LogDTO;
import com.knowhoon.web.log.LogService;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/*
 *  boardController
 *  
 *  user -> RD -> Controller -> Service -> DAO -> mybats -> DB
 *  					DTO(VO)
 *  user <-----------   View(jsp)
 */

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	@Autowired
	private Util util;
	@Autowired
	private LogService logService;
	@Autowired
	private FileSave fileSave;
	@Autowired
	private ServletContext servletContext;
	
	//메뉴 호출
	@RequestMapping("/menu")
	public ModelAndView menu(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("menu");
		int sb_cate = 0;
		String category = null;
		//카테고리 리스트
		List<BoardDTO> categoryList = boardService.categoryList();
		mv.addObject("categoryList", categoryList);
		//카테고리 넘버
		if(request.getParameter("sb_cate") != null || util.str2Int(request.getParameter("sb_cate")) != 0){
			sb_cate = Integer.parseInt(request.getParameter("sb_cate"));
			if(sb_cate > categoryList.size()) {
				sb_cate = 1;
			}
			//카테고리 이름 저장
			category = (String) categoryList.get(sb_cate-1).getSca_category();
		}
		mv.addObject("category", category);	
		return mv;		
	}
	//게시판 호출
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public ModelAndView board(HttpServletRequest request) {		
		ModelAndView mv = new ModelAndView("board");
		
		int sb_cate = 1 ;
		
		if(request.getParameter("sb_cate") != null || util.str2Int(request.getParameter("sb_cate")) != 0){
			sb_cate = Integer.parseInt(request.getParameter("sb_cate"));			
		}
		Map<String, Object> sendMap = new HashMap<String, Object>();
		sendMap.put("sb_cate", sb_cate);
		//검색
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
		
		//페이지 번호
		if(request.getParameter("pageNo") != null) {
			pageNo = util.str2Int(request.getParameter("pageNo"));
		}
		
		paginationInfo.setCurrentPageNo(pageNo);	//현재 페이지 번호
		paginationInfo.setRecordCountPerPage(listScale);	//한 페이지에 나올 글 수
		paginationInfo.setPageSize(pageScale);	//페이지 개수
		
		int startPage = paginationInfo.getFirstRecordIndex(); // 시작페이지
		int lastPage = paginationInfo.getRecordCountPerPage(); // 마지막페이지
		
		sendMap.put("startPage", startPage); // sendMap에 시작페이지 추가
		sendMap.put("lastPage", lastPage);	 // sendMap에 마지막 페이지 추가
		mv.addObject("sb_cate", sb_cate);
		//게시글 리스트
		List<BoardDTO> boardList = boardService.boardList(sendMap);
				
		String target = "board?sb_cate="+ sb_cate;
		
		if(boardList.size() > 0) {
			paginationInfo.setTotalRecordCount(boardList.get(0).getTotalList());//전체 글 수 저장
			mv.addObject("boardList", boardList);
			mv.addObject("paginationInfo", paginationInfo);
			mv.addObject("pageNo", pageNo);
			target = boardList.get(0).getSca_category();
		}
		//로그 기록
		LogDTO log = new LogDTO(
				util.getIP(request), 
				target , 
				(String)request.getSession().getAttribute("sm_id"), 
				target + " 접속");
		logService.insertLog(log);		
		return mv;
	}
	//글쓰기
	@GetMapping("/write")
	public String write(HttpServletRequest request) {
		if(request.getSession().getAttribute("sm_id") != null && request.getSession().getAttribute("sm_name") != null) {
			return "write";			
		}else {
			return "redirect:/?writeError";
		}	
	}
	//글쓰기
	@PostMapping("/write")
	public String write2(HttpServletRequest request, MultipartFile file) throws IOException {
		BoardDTO boardDTO = new BoardDTO();
		//XSS 관련 필터링
		boardDTO.setSb_title(util.replace(request.getParameter("sb_title")));
		boardDTO.setSb_content(util.replace(request.getParameter("sb_content")));
		boardDTO.setSb_cate(Integer.parseInt(request.getParameter("sb_cate")));
		
		//업로드 파일
		boardDTO.setSb_orifile(file.getOriginalFilename());
		
		String realPath = servletContext.getRealPath("resources/upfile");
		String upfile = fileSave.save(realPath, file);
		//실제 저장 파일 이름
		boardDTO.setSb_file(upfile);
		
		//로그 기록
		if(request.getSession().getAttribute("sm_id") != null && request.getSession().getAttribute("sm_name") != null) {
			boardDTO.setSm_id((String) request.getSession().getAttribute("sm_id"));
			boardService.write(boardDTO);
			String target = "글쓰기";
			LogDTO log = new LogDTO(
					util.getIP(request), 
					target , 
					(String)request.getSession().getAttribute("sm_id"), 
					target + " 접속");
			logService.insertLog(log);		
			return "redirect:/board?sb_cate=" + boardDTO.getSb_cate();//board 메소드 다시 실행			
		}else {
			return "redirect:/?writeError2";
		}	
	}
	//글 상세보기
	@GetMapping("/detail")
	public ModelAndView detail(HttpServletRequest request, BoardDTO boardDTO) {
		ModelAndView mv = new ModelAndView("detail");
		BoardDTO detail = boardService.boardDetail(boardDTO);
		//댓글 갯수 확인
		if(detail.getCommentcount() > 0) {
			//해당 게시글 댓글 저장
			mv.addObject("comment",boardService.commentList(boardDTO.getSb_no()));
		}
		//로그 기록
		String target = "detail?sb_no" + boardDTO.getSb_no();
		LogDTO log = new LogDTO(
				util.getIP(request), 
				target , 
				(String)request.getSession().getAttribute("sm_id"), 
				target + " 게시글 확인");
		logService.insertLog(log);
		
		//게시글 작성자가 아닐때
		if(!detail.getSm_id().equals(request.getSession().getAttribute("sm_id"))){
			//게시글 조회수 카운트
			boardService.boardCount(detail.getSb_no());
			//글 상세 보기 진입시 선반영
			detail.setSb_count(detail.getSb_count()+1);
		}
		mv.addObject("detail", detail);
		return mv;
	}
	//글 삭제
	@GetMapping("/boardDelete")
	public String boardDelete(HttpServletRequest request) {
		int sb_no = Integer.parseInt(request.getParameter("sb_no"));
		int result = boardService.delete(sb_no);	
		//로그 기록
		if(result ==1) {
			String target = "delete?sb_no" + sb_no;
			LogDTO log = new LogDTO(
					util.getIP(request), 
					target , 
					(String)request.getSession().getAttribute("sm_id"), 
					target + " 접속");
			logService.insertLog(log);	
			return "redirect:/board";
		}else {
			return "redirect:/error?deleteError";
		}
	}
	//글 수정
	@GetMapping("/boardModify")
	public ModelAndView boardUpdate(HttpServletRequest request, BoardDTO boardDTO) {
		ModelAndView mv = new ModelAndView("boardModify");
		
		mv.addObject("modify",boardService.boardDetail(boardDTO));
		//로그 기록
		String target = "Modify?sb_no" + boardDTO.getSb_no();
		LogDTO log = new LogDTO(
				util.getIP(request), 
				target , 
				(String)request.getSession().getAttribute("sm_id"), 
				target + " 접속");
		logService.insertLog(log);	
		return mv;
	}
	//글 수정
	@PostMapping("/boardModify")
	public String boardModify2(HttpServletRequest request, BoardDTO boardDTO) { //name이 똑같다면 자동으로 저장
		
		int result = boardService.modify(boardDTO);
		if(result == 1) {
			//로그 기록
			String target = "modify?sb_no" + boardDTO.getSb_no();
			LogDTO log = new LogDTO(
					util.getIP(request), 
					target , 
					(String)request.getSession().getAttribute("sm_id"), 
					target + " 수정 완료 ");
			logService.insertLog(log);	
			return "redirect:/detail?sb_no=" + boardDTO.getSb_no() + "&sb_cate=" + boardDTO.getSb_cate();			
		}else {
			return "redirect:/error?modifyError";
		}
	}
	//추천 아이디 중복 확인
	@PostMapping("/voteIdCheck")
	public @ResponseBody String checkID(VoteDTO vote, HttpServletRequest request) {
		String check = "1";
		check = boardService.voteIdCheck(vote);
		System.out.println(check);
		return check;
	}
	//좋아요,싫어요 기능
	@GetMapping("/detailVote")
	public String detailVote(VoteDTO vote, HttpServletRequest request) {
		int result = boardService.detailVote(vote);
		if(result == 1) {
			return "redirect:/detail?sb_no=" + vote.getSb_no() + "&sb_cate=" + request.getParameter("sb_cate");		
			//boardService.detailVoteCount(vote);
		}else {			
			return "redirect:/error?detailVoteError";		
		}
	}
	//이전글, 다음글 기능
	@GetMapping("/nextPrev")
	public String nextPrev(BoardDTO boardDTO, HttpServletRequest request) {
		if(request.getParameter("option").equals("prev")) {
			boardDTO.setSb_nno(boardDTO.getSb_nno()-1);			
		}else if(request.getParameter("option").equals("next")) {
			boardDTO.setSb_nno(boardDTO.getSb_nno()+1);
		}else {
			return "redirect:/error?detailNextPrevError=";		
		}
		BoardDTO result = boardService.boardNextPrev(boardDTO);
		return "redirect:/detail?sb_no=" + result.getSb_no() + "&sb_cate=" + result.getSb_cate();		
		
	}
}
