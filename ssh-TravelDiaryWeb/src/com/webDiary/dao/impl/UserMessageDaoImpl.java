/**
 * 
 */
package com.webDiary.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.webDiary.dao.UserMessageDao;
import com.webDiary.pojo.User;
import com.webDiary.pojo.UserMessage;
import com.webDiary.util.PageHibernateCallback;

/**
 * @author wuzhuhao
 *
 */
public class UserMessageDaoImpl extends HibernateTemplate implements UserMessageDao {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserMessageDao#findByPage(java.lang.String,
	 * java.lang.Object[], int, int)
	 */
	@Override
	public List<UserMessage> findByPage(String hql, Object[] patm, int begin, int limit) {
		List<UserMessage> list = execute(new PageHibernateCallback<UserMessage>(hql, patm, begin, limit));
		if (list != null && list.size() > 0) {
			return list;
		}
		return new ArrayList<UserMessage>();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserMessageDao#delUserMessage(int)
	 */
	@Override
	public int delUserMessage(int id) {
		int flag = 0;
		UserMessage userMessage = findUserMessage(id);
		if (userMessage == null) {
			return flag;
		}
		try {
			delete(userMessage);
			flag = 1;
		} catch (Exception e) {
			System.out.println("删除留言失败");
		}
		return flag;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserMessageDao#replyUserMessage(int,
	 * java.lang.String)
	 */
	@Override
	public int replyUserMessage(int id, String replyContent) {
		int flag = 0;
		UserMessage userMessage = findUserMessage(id);
		if (userMessage == null) {
			return flag;
		}
		userMessage.setReplyContent(replyContent);
		try {
			update(userMessage);
			flag = 1;
		} catch (Exception e) {
			System.out.println("回复留言失败");
		}
		return flag;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserMessageDao#findUserMessage(int)
	 */
	@Override
	public UserMessage findUserMessage(int id) {
		String hql = "from UserMessage where id = " + id + "";
		List<UserMessage> uList = find(hql);
		UserMessage userMessage = null;
		if (uList.isEmpty()) {
			return userMessage;
		}
		userMessage = uList.get(0);
		return userMessage;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserMessageDao#addUserMessage(com.webDiary.pojo.
	 * UserMessage)
	 */
	@Override
	public UserMessage addUserMessage(UserMessage userMessage) {
		try {
			save(userMessage);
			return getLsatUserMessage();
		} catch (Exception e) {
			System.out.println("插入userMessage失败");
		}
		return null;
	}

	@Override
	public List<UserMessage> findHql(String hql, Object[] patm) {
		List<UserMessage> list = find(hql, patm);
		return list;
	}

	/**
	 * 获取最后一条userMessage
	 * 
	 * @return
	 */
	private UserMessage getLsatUserMessage() {
		Session session = getSession();
		Query q = session.createQuery("from UserMessage order by id desc");
		q.setMaxResults(1);
		UserMessage userMessage = (UserMessage) q.uniqueResult();
		return userMessage;
	}

	public List<Integer> findByUidTOP8() {
		//sql语句为：SELECT * FROM USER  WHERE id IN ( SELECT COUNT(*) FROM diary GROUP BY Uid ORDER BY COUNT(*) DESC ) LIMIT 8
		String hql = "SELECT sendee.id FROM UserMessage GROUP BY sendee ORDER BY COUNT(*) DESC ";
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
