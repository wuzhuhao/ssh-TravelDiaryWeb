package com.webDiary.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.webDiary.dao.CommentDAO;
import com.webDiary.pojo.Comment;
import com.webDiary.pojo.Diary;
import com.webDiary.pojo.User;
import com.webDiary.util.PageHibernateCallback;

public class CommentDAOImpl extends HibernateTemplate implements CommentDAO {

	@Override
	public int likenum(int diaryId) {
		String hql = "from Comment where  likenum = 1 and diary = " + diaryId;
		List<Comment> list = find(hql);
		if (list.isEmpty())
			return 0;
		else
			return list.size();

	}

	/*
	 * @Override public int addLikenum(int diaryId) { Comment comment = new
	 * Comment(); String hql = "from Diary where did = " + diaryId; List<Diary>
	 * diaryList = find(hql); Diary diart = diaryList.get(0);
	 * comment.setDiary(diart); comment.setLikenum(1);
	 * diart.setLikenum(diart.getLikenum() + 1); update(diart); save(comment);
	 * return likenum(comment.getDiary().getDid());
	 * 
	 * }
	 */

	@Override
	public List<Comment> find(int diaryId) {
		String hql = "from Comment where content is not null and diary = " + diaryId + " ";
		List<Comment> commentList = find(hql);
		return commentList;
	}

	@Override
	public boolean insert(Comment comment, int diaryId) {
		String hql = "from Diary where did = " + diaryId;
		List<Diary> list = find(hql);
		comment.setDiary(list.get(0));
		boolean flag = true;
		try {
			save(comment);
			System.out.println("无异常");
		} catch (Exception e) {
			System.out.println("有异常");
			flag = false;
		}
		return flag;
	}

	@Override
	public List<Comment> findAll() {
		String hql = "from Comment where content is not null order by diary";
		List<Comment> commentList = find(hql);
		return commentList;
	}

	@Override
	public boolean delete(int id) {
		List<Comment> commentList = find("from Comment where id =  " + id);
		try {
			delete(commentList.get(0));

		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public boolean insertReply(int id, String reply) {
		String hql = "from Comment where id = '" + id + "'";
		// TODO Auto-generated method stub
		List<Comment> commentList = find(hql);
		Comment comment = commentList.get(0);
		comment.setReply(reply);
		boolean flag = true;
		try {
			update(comment);
		} catch (Exception e) {
			System.out.println("评论回复插入失败");
			flag = false;
		}
		return flag;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryDAO#findCount(java.lang.String,
	 * java.lang.Object[])
	 */
	@Override
	public int findCount(String hql, Object[] patm) {
		List<Long> list = find(hql, patm);
		if (list != null && list.size() > 0) {
			return list.get(0).intValue();
		}
		return 0;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryDAO#findByPage(java.lang.String,
	 * java.lang.Object[], int, int)
	 */
	@Override
	public List<Comment> findByPage(String hql, Object[] patm, int begin, int limit) {
		List<Comment> list = execute(new PageHibernateCallback<Comment>(hql, patm, begin, limit));
		if (list != null && list.size() > 0) {
			return list;
		}
		return new ArrayList<>();
	}
	public List<Integer> findByUidTOP8() {
		//sql语句为：SELECT * FROM USER  WHERE id IN ( SELECT COUNT(*) FROM diary GROUP BY Uid ORDER BY COUNT(*) DESC ) LIMIT 8
		String hql = "SELECT diary.user.id FROM Comment GROUP BY diary ORDER BY COUNT(*) DESC ";
		Session session2 = getSession();
		Query query = session2.createQuery(hql);
		query.setMaxResults(8);
		List list = query.list();
		System.out.println(list.size());
		return list;
	}

	public List<User> findByUser(List<Integer> uid) {
		// sql语句为：SELECT * FROM USER WHERE id IN ( SELECT COUNT(*) FROM diary GROUP BY
		// Uid ORDER BY COUNT(*) DESC ) LIMIT 8
		List<User> uList = new ArrayList<>();
		for (int i = 0; i < uid.size(); i++) {
			String hql = " FROM User  WHERE id =" + uid.get(i);
			List<User> uList1 = find(hql);
			
			uList.add(uList1.get(0));
		}

		return uList;
	}
}
