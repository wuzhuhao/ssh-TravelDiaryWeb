package com.webDiary.dao.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.webDiary.dao.LoginDAO;
import com.webDiary.pojo.User;

public class LoginDAOImpl extends HibernateTemplate implements LoginDAO {

	@Override
	public boolean login(int uid, String passwd) {
		// TODO Auto-generated method stub
		String hql = "from User where id = '" + uid + "' and passwd = '" + passwd + "'";
		List<User> uList = find(hql);
		boolean flag = false;
		if (uList.isEmpty()) {
			return flag;
		}
		HttpSession session = ServletActionContext.getRequest().getSession();
		User user = uList.get(0);
		session.setAttribute("user", user);
		flag = true;
		return flag;
	}

	@Override
	public boolean register(User user) {
		boolean flag = true;
		try {
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

	@Override
	public List<User> findUser() {
		// TODO Auto-generated method stub
		String hql = "from User ";
		List<User> uList = find(hql);
		return uList;
	}

	@Override
	public boolean delete(int id) {
		List<User> userList = find("from User where id =  " + id);
		try {
			delete(userList.get(0));

		} catch (Exception e) {
			return false;
		}
		return true;
	}

}