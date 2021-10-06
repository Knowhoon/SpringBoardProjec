package com.knowhoon.web.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.knowhoon.web.comment.CommentDTO;

/*	mybatis와 연결
 * 
 */
//				Service - DAO - sqlSession - DB
/*
 *  컨트롤러 @Controller
 *  서비스 @service
 *  DAO @repository
 *  그 외 @component
 * 
 */

@Repository
public class BoardDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public List<BoardDTO> boardList(Map<String, Object> sendMap) {
		
		return sqlSession.selectList("board.boardList", sendMap); //네임스페이스.id
	}

	public void write(BoardDTO boardDTO) {
		sqlSession.insert("board.boardWrite", boardDTO);		
	}

	public BoardDTO boardDetail(BoardDTO boardDTO) {
		return sqlSession.selectOne("board.boardDetail", boardDTO);
	}

	public int delete(Integer sb_no) {
		return sqlSession.update("board.boardDelete", sb_no);
	}

	public int modify(BoardDTO boardDTO) {
		return sqlSession.update("board.boardModify", boardDTO);
	}

	public String getCategory(int sb_cate) {
		return sqlSession.selectOne("board.getCategory", sb_cate);
	}

	public List<BoardDTO> categoryList() {
		return sqlSession.selectList("board.categoryList");
	}

	public void boardCount(Integer sb_no) {
		sqlSession.update("board.boardCount", sb_no);
	}

	public String voteIdCheck(VoteDTO vote) {
		return sqlSession.selectOne("board.voteIdCheck",vote);
	}

	public int detailVote(VoteDTO vote) {
		return sqlSession.insert("board.detailVote", vote);
	}

//	public void detailVoteCount(VoteDTO vote) {
//		sqlSession.update("board.detailVoteCount", vote);
//	}

	public List<CommentDTO> commentList(int sb_no) {
		return sqlSession.selectList("board.commentList", sb_no);
	}

	public List<BoardDTO> bestList(int i) {
		return sqlSession.selectList("board.bestList", i) ;
	}

	public List<BoardDTO> weekList() {
		return sqlSession.selectList("board.weekList");
	}

	public BoardDTO boardNextPrev(BoardDTO boardDTO) {
		return sqlSession.selectOne("board.boardNextPrev", boardDTO);
	}

	public String votecmtIdCheck(VoteDTO vote) {
		return sqlSession.selectOne("board.votecmtIdCheck", vote);
	}

	public int commentVote(VoteDTO vote) {
		return sqlSession.insert("board.commentVote",vote);
	}

}
