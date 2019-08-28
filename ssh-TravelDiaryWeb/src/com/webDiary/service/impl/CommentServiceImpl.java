package com.webDiary.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.webDiary.dao.CommentDAO;
import com.webDiary.pojo.Comment;
import com.webDiary.pojo.User;
import com.webDiary.service.CommentService;
import com.webDiary.util.PageBean;

public class CommentServiceImpl implements CommentService {
	private CommentDAO commentDAO;

	public CommentDAO getCommentDAO() {
		return commentDAO;
	}

	public void setCommentDAO(CommentDAO commentDAO) {
		this.commentDAO = commentDAO;
	}

	@Override
	public int likenum(int diaryId) {

		int likenum = commentDAO.likenum(diaryId);

		System.out.println(likenum);
		return likenum;
	}

	/*
	 * @Override public int addLikenum(int diaryId) { return
	 * commentDAO.addLikenum(diaryId); }
	 */

	@Override
	public List<Comment> find(int diaryId) {
		return commentDAO.find(diaryId);
	}

	@Override
	public boolean insert(Comment comment, int diaryId) {
		// TODO Auto-generated method stub
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		comment.setTime(df.format(new Date()) + "");
		System.out.println(diaryId);
		return commentDAO.insert(comment, diaryId);
	}

	@Override
	public List<Comment> findAll() {
		// TODO Auto-generated method stub
		return commentDAO.findAll();
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return commentDAO.delete(id);
	}

	@Override
	public boolean insertReply(int id, String reply) {
		// TODO Auto-generated method stub
		return commentDAO.insertReply(id, reply);
	}

	@Override
	public PageBean<Comment> findByPage(Integer page, String whereName, ArrayList<Object> ptamList) {
		PageBean<Comment> pageBean = new PageBean<>();
		Object[] patm = new Object[ptamList.size()];
		int h = 0;
		for (Object ob : ptamList) {
			patm[h] = ob;
			h++;
		}
		// 设置参数:
		pageBean.setPage(page);
		// 设置每页显示记录数:
		int limit = 3;
		pageBean.setLimit(limit);
		// 设置总记录数:
		String countHql = "select count(*) from Comment " + whereName;
		int totalCount = commentDAO.findCount(countHql, patm);
		System.out.println("总数：" + totalCount);
		pageBean.setTotalCount(totalCount);
		// 设置总页数:
		int totalPage = 0;
		if (totalCount % limit == 0) {
			totalPage = totalCount / limit;
		} else {
			totalPage = totalCount / limit + 1;
		}
		pageBean.setTotalPage(totalPage);
		// 设置页面显示数据的集合:
		int begin = (page - 1) * limit;
		String selectHql = "from Comment " + whereName + " order by time DESC";
		List<Comment> list = commentDAO.findByPage(selectHql, patm, begin, limit);
		pageBean.setList(list);
		return pageBean;

	}
	@Override
	public List<User> Contribution() {
		// TODO Auto-generated method stub
		List<Integer> uid = commentDAO.findByUidTOP8();
		return commentDAO.findByUser(uid);
	}
}
