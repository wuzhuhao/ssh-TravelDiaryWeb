package com.webDiary.service.impl;

import java.util.List;

import com.webDiary.dao.AdminDao;
import com.webDiary.pojo.Admin;
import com.webDiary.service.AdminService;

public class AdminServiceImpl implements AdminService {

	private AdminDao adminDao;

	public AdminDao getAdminDao() {
		return adminDao;
	}

	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	@Override
	public List<Admin> findAll() {
		// TODO Auto-generated method stub
		return adminDao.findAll();
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return adminDao.delete(id);
	}

	@Override
	public List<Admin> login(String userName, String passwd) {
		// TODO Auto-generated method stub
		return adminDao.login(userName, passwd);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.AdminService#enableOrdiscontinuation(int, int)
	 */
	@Override
	public boolean enableOrdiscontinuation(int id, int state) {
		boolean falg = false;
		if (adminDao.enableOrdiscontinuation(id, state) == 1) {
			falg = true;
		}
		return falg;
	}

	@Override
	public boolean edit(Admin admin) {
		// TODO Auto-generated method stub
		return adminDao.edit(admin);
		
	}

}
