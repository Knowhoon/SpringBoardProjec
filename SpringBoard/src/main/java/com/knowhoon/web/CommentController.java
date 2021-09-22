package com.knowhoon.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.knowhoon.web.comment.CommentDTO;
import com.knowhoon.web.comment.CommentService;

@Controller
public class CommentController {
	@Autowired
	private CommentService commentService;
	//댓글 작성
	@PostMapping("/commentWrite")
	public String commentWrite(HttpServletRequest request, CommentDTO commentDTO) {
		if(request.getSession().getAttribute("sm_id")!= null) {
			commentDTO.setSm_id((String)request.getSession().getAttribute("sm_id"));
			int result = commentService.commentWrite(commentDTO);
			if(result == 1) {
				return "redirect:/detail?sb_no="+commentDTO.getSb_no()+"&sb_cate="+commentDTO.getSb_cate();						
			} else {
				return "redirect:/error?cmtWriteError1";	
			}
		} else {
			return "redirect:/error?cmtWriteError2";		
		}
	}	
	//댓글 수정
	@PostMapping("/commentModify")
	public String commentModify(HttpServletRequest request, CommentDTO commentDTO) {
		if(request.getSession().getAttribute("sm_id")!= null) {
			commentDTO.setSm_id((String)request.getSession().getAttribute("sm_id"));
			int result = commentService.commentModify(commentDTO);
			if(result == 1) {
				return "redirect:/detail?sb_no="+commentDTO.getSb_no()+"&sb_cate="+commentDTO.getSb_cate();						
			} else {
				return "redirect:/error?cmtModifyError1";	
			}
		} else {
			return "redirect:/error?cmtModifyError2";		
		}
	}
	//댓글 삭제
	@PostMapping("/commentDelete")
	public String commentDelete(HttpServletRequest request, CommentDTO commentDTO) {
		if(request.getSession().getAttribute("sm_id")!= null) {
			commentDTO.setSm_id((String)request.getSession().getAttribute("sm_id"));
			int result = commentService.commentDelete(commentDTO);
			if(result == 1) {
				return "redirect:/detail?sb_no="+commentDTO.getSb_no()+"&sb_cate="+commentDTO.getSb_cate();						
			} else {
				return "redirect:/error?cmtDeleteError1";	
			}
		} else {
			return "redirect:/error?cmtDeleteError2";		
		}
	}
}
