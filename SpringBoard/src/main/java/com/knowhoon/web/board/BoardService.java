package com.knowhoon.web.board;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.knowhoon.web.comment.CommentDTO;

@Service
public class BoardService {
	@Autowired
	private BoardDAO boardDAO;
	
	public List<BoardDTO> boardList(Map<String, Object> sendMap){
		return boardDAO.boardList(sendMap);
	}

	public void write(BoardDTO boardDTO) {
		boardDAO.write(boardDTO);
	}

	public BoardDTO boardDetail(BoardDTO boardDTO) {
		return boardDAO.boardDetail(boardDTO);
	}

	public int delete(Integer sb_no) {
		
		return boardDAO.delete(sb_no);
	}

	public int modify(BoardDTO boardDTO) {
		return boardDAO.modify(boardDTO);
	}

	public String getCategory(int sb_cate) {
		return boardDAO.getCategory(sb_cate);
	}

	public List<BoardDTO> categoryList() {
		return boardDAO.categoryList();
	}

	public void boardCount(Integer sb_no) {
		boardDAO.boardCount(sb_no);
	}

	public String voteIdCheck(VoteDTO vote) {
		return boardDAO.voteIdCheck(vote);
	}

	public int detailVote(VoteDTO vote) {
		return boardDAO.detailVote(vote);
	}

	public List<CommentDTO> commentList(int sb_no) {
		return boardDAO.commentList(sb_no);
		
	}

	public List<BoardDTO> bestList(int i) {
		return boardDAO.bestList(i);
	}

	public List<BoardDTO> weekList() {
		return boardDAO.weekList();
	}

	public BoardDTO boardNextPrev(BoardDTO boardDTO) {
		return boardDAO.boardNextPrev(boardDTO);
	}

	public String votecmtIdCheck(VoteDTO vote) {
		return boardDAO.votecmtIdCheck(vote);
	}

	public int commentVote(VoteDTO vote) {
		return boardDAO.commentVote(vote);
	}

}
