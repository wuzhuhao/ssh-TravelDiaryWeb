/**
 * 
 */
package com.webDiary.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.webDiary.dao.UserDao;
import com.webDiary.pojo.User;

/**
 * @author wuzhuhao
 *
 */
public class UserDaoImpl extends HibernateTemplate implements UserDao {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserDao#findUser(java.lang.String)
	 */
	@Override
	public User findUser(int uid) {
		String hql = "from User where id = " + uid + "";
		List<User> uList = find(hql);
		User user = null;
		if (uList.isEmpty()) {
			return user;
		}
		user = uList.get(0);
		return user;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserDao#findUser(java.lang.String)
	 */
	@Override
	public User findUser(String uName) {
		String hql = "from User where userName = ?";
		List<User> uList = find(hql, uName);
		User user = null;
		if (!uList.isEmpty()) {
			user = uList.get(0);
		}
		return user;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserDao#updateUser(com.webDiary.pojo.User)
	 */
	@Override
	public boolean updateUser(User user) {
		// TODO Auto-generated method stub
		try {
			super.update(user);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserDao#updatePassword(com.webDiary.pojo.User)
	 */
	@Override
	public boolean updatePassword(User user) {
		// TODO Auto-generated method stub
		try {
			super.update(user);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserDao#login(int, java.lang.String)
	 */
	@Override
	public boolean login(String uName, String passwd) {
		String hql = "from User where userName = ? and passwd = ?";
		List<User> uList = find(hql, uName, passwd);
		boolean flag = false;
		if (uList.isEmpty()) {
			System.out.println("密码错误");
			return flag;
		}
		flag = true;
		return flag;
	}

	@Override
	public boolean image(String image) {
		HttpSession session = ServletActionContext.getRequest().getSession();
		User user = (User) session.getAttribute("user");
		user.setImage(image);
		try {
			super.update(user);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserDao#nameIsExistence(java.lang.String)
	 */
	@Override
	public boolean nameIsExistence(String uName) {
		List uselist = find("from User where UserName = ?", uName);
		if (uselist == null || uselist.size() == 0) {
			return false;
		}
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserDao#isState(java.lang.String)
	 */
	@Override
	public int isState(String uName) {
		List<Integer> state = find("select state from User where UserName = ?", uName);
		return (state != null && state.size() != 0 && state.get(0) == 1) ? 1 : 2;
	}

	@Override
	public boolean register(User user) {
		boolean flag = true;
		try {
			user.setSite("");
			user.setState(1);
			user.setImage("images/4.jpg");
			save(user);
			User user2 = (User) find("from User where userName = '" + user.getUserName() + "' and passwd = '"
					+ user.getPasswd() + "' and IndividualResume = '" + user.getIndividualResume() + "'").get(0);
			int id = user2.getId();
			HttpSession session = ServletActionContext.getRequest().getSession();
			session.setAttribute("user_id", id);
		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}
		return flag;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.UserDao#enableOrdiscontinuation(int, int)
	 */
	@Override
	public int enableOrdiscontinuation(int id, int state) {
		int flag = 0;
		User user = findUser(id);
		if (user == null) {
			return flag;
		}
		user.setState(state);
		System.out.println("state：" + state);
		try {
			update(user);
			flag = 1;
		} catch (Exception e) {
			System.out.println("保存用户失败");
		}
		return flag;
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
