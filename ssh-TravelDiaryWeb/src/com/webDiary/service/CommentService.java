package com.webDiary.service;

import java.util.ArrayList;
import java.util.List;

import com.webDiary.pojo.Comment;
import com.webDiary.pojo.User;
import com.webDiary.util.PageBean;

public interface CommentService {

	public int likenum(int diaryId);

	/* public int addLikenum(int diaryId); */

	public List<Comment> find(int diaryId);

	public boolean insert(Comment comment, int diaryId);

	public List<Comment> findAll();

	public boolean delete(int id);

	public boolean insertReply(int id, String reply);

	/**
	 * @param page
	 * @param whereName
	 * @param ptamList
	 * @return
	 */
	PageBean<Comment> findByPage(Integer page, String whereName, ArrayList<Object> ptamList);

	public List<User> Contribution();

}
