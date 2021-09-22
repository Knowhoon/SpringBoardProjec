package com.knowhoon.web.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService {
	@Autowired
	private CommentDAO commentDAO;
	
	public int commentWrite(CommentDTO commentDTO) {
		return commentDAO.commentWrite(commentDTO);
	}

	public int commentModify(CommentDTO commentDTO) {
		return commentDAO.commentModify(commentDTO);
	}

	public int commentDelete(CommentDTO commentDTO) {
		return commentDAO.commentDelete(commentDTO);
	}

}
