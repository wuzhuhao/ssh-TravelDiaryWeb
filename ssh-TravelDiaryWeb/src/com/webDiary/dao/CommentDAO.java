package com.webDiary.dao;

import java.util.List;

import com.webDiary.pojo.Comment;
import com.webDiary.pojo.User;

public interface CommentDAO {

	public int likenum(int diaryId);

	/* public int addLikenum(int diaryId); */

	public List<Comment> find(int diaryId);

	public boolean insert(Comment comment, int diartId);

	public List<Comment> findAll();

	public boolean delete(int id);

	public boolean insertReply(int id, String reply);

	/**
	 * @param selectHql
	 * @param patm
	 * @param begin
	 * @param limit
	 * @return
	 */
	public List<Comment> findByPage(String selectHql, Object[] patm, int begin, int limit);

	/**
	 * @param countHql
	 * @param patm
	 * @return
	 */
	public int findCount(String countHql, Object[] patm);

	public List<Integer> findByUidTOP8();

	public List<User> findByUser(List<Integer> uid);

}
