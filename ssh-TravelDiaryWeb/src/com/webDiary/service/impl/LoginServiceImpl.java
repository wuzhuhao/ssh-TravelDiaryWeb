package com.webDiary.service.impl;

import java.util.List;

import com.webDiary.dao.LoginDAO;
import com.webDiary.pojo.User;
import com.webDiary.service.LoginService;

public class LoginServiceImpl implements LoginService {
	private LoginDAO loginDAO;

	@Override
	public boolean login(int uid, String passwd) {

		return loginDAO.login(uid, passwd);
	}

	public LoginDAO getLoginDAO() {
		return loginDAO;
	}

	public void setLoginDAO(LoginDAO loginDAO) {
		this.loginDAO = loginDAO;
	}

	@Override
	public boolean register(User user) {
		return loginDAO.register(user);
	}

	@Override
	public List<User> findUser() {
		// TODO Auto-generated method stub
		return loginDAO.findUser();
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return loginDAO.delete(id);
	}

}
