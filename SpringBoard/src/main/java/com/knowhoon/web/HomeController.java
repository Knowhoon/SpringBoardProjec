package com.knowhoon.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.knowhoon.web.board.BoardDTO;
import com.knowhoon.web.board.BoardService;


@Controller
public class HomeController {
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value ={"/","/home"})
	public ModelAndView main() {
		ModelAndView mv = new ModelAndView("home");
		//주간 베스트 게시글
		mv.addObject("weekList", boardService.weekList());		
		//카테고리 리스트
		List<BoardDTO> categoryList = boardService.categoryList();
		mv.addObject("categoryList", categoryList);
		//카테고리 별 베스트 게시글 저장
		for (int i = 0; i < categoryList.size(); i++) {
			mv.addObject("bestList"+categoryList.get(i).getSb_cate(), boardService.bestList((int)categoryList.get(i).getSb_cate()));
		}
		
		
		return mv;
	}
	
}
