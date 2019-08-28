/**
 * 
 */
package com.webDiary.service.impl;

import java.util.List;

import com.webDiary.dao.UserDao;
import com.webDiary.pojo.User;
import com.webDiary.service.UserService;

/**
 * @author wuzhuhao
 *
 */
public class UserServiceImpl implements UserService {
	private UserDao userDao;

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserService#findUser(java.lang.String)
	 */
	@Override
	public User findUser(int uid) {
		return userDao.findUser(uid);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserService#findUser(java.lang.String)
	 */
	@Override
	public User findUser(String uName) {
		return userDao.findUser(uName);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserService#updateUser(com.webDiary.pojo.User)
	 */
	@Override
	public boolean updateUser(User user) {
		// TODO Auto-generated method stub
		return userDao.updateUser(user);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserService#updatePassword(java.lang.String,
	 * java.lang.String, java.lang.String)
	 */
	@Override
	public boolean updatePassword(int uid, String oldPassword, String newPassword) {
		User user = userDao.findUser(uid);
		if (user.getPasswd().equals(oldPassword)) {
			user.setPasswd(newPassword);
			return userDao.updatePassword(user);
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserService#login(int, java.lang.String)
	 */
	@Override
	public boolean login(String uName, String passwd) {
		return userDao.login(uName, passwd);
	}

	@Override
	public boolean image(String image) {
		return userDao.image(image);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserService#nameIsExistence(java.lang.String)
	 */
	@Override
	public boolean nameIsExistence(String uName) {
		return userDao.nameIsExistence(uName);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserService#isState()
	 */
	@Override
	public boolean isState(String uName) {
		if (userDao.isState(uName) == 1) {
			return true;
		}
		return false;
	}

	@Override
	public boolean register(User user) {
		return userDao.register(user);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserService#enableOrdiscontinuation(int, int)
	 */
	@Override
	public boolean enableOrdiscontinuation(int id, int state) {
		boolean falg = false;
		if (userDao.enableOrdiscontinuation(id, state) == 1) {
			falg = true;
		}
		return falg;
	}
	
	@Override
	public List<User> Contribution() {
		// TODO Auto-generated method stub
		List<Integer> uid = userDao.findByUidTOP8();
		return userDao.findByUser(uid);
	}
}
