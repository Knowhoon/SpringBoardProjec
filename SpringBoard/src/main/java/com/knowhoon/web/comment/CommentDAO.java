package com.knowhoon.web.comment;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommentDAO {
	@Autowired
	private SqlSession sqlSession;

	public int commentWrite(CommentDTO commentDTO) {
		return sqlSession.insert("comment.commentWrite", commentDTO);
	}

	public int commentModify(CommentDTO commentDTO) {
		return sqlSession.update("comment.commentModify", commentDTO);
	}

	public int commentDelete(CommentDTO commentDTO) {
		return sqlSession.update("comment.commentDelete", commentDTO);
	}
	
}
