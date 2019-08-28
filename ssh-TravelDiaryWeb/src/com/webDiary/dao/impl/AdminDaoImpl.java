package com.webDiary.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.HibernateTemplate;

import com.webDiary.dao.AdminDao;
import com.webDiary.pojo.Admin;

public class AdminDaoImpl extends HibernateTemplate implements AdminDao {

	@Override
	public List<Admin> findAll() {
		String hql = "from Admin ";
		List<Admin> adminList = find(hql);
		return adminList;
	}

	@Override
	public boolean delete(int id) {
		List<Admin> adminList = find("from Admin where id =  " + id);
		try {
			delete(adminList.get(0));

		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public List<Admin> login(String userName, String passwd) {
		// TODO Auto-generated method stub
		String hql = "from Admin where userName = '" + userName + "' and passwd = '" + passwd + "'";
		List<Admin> uList = find(hql);

		return uList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.AdminDao#enableOrdiscontinuation(int, int)
	 */
	@Override
	public int enableOrdiscontinuation(int id, int state) {
		int flag = 0;
		Admin Admin = findAdminUser(id);
		if (Admin == null) {
			return flag;
		}
		Admin.setState(state);
		System.out.println(Admin);
		System.out.println("state：" + state);
		try {
			update(Admin);
			flag = 1;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("保存用户失败");
		}
		return flag;
	}

	public Admin findAdminUser(int uid) {
		String hql = "from Admin where id = " + uid + "";
		List<Admin> uList = find(hql);
		Admin user = null;
		if (uList.isEmpty()) {
			return user;
		}
		user = uList.get(0);
		return user;
	}

	@Override
	public boolean edit(Admin admin) {
		// TODO Auto-generated method stub
		update(admin);
		return true;
	}

}
