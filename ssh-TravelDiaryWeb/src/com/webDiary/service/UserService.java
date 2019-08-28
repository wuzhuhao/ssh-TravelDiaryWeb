/**
 * 
 */
package com.webDiary.service;

import java.util.List;

import com.webDiary.pojo.User;

/**
 * @author wuzhuhao
 *
 */
public interface UserService {

	public boolean login(String uName, String password);

	public User findUser(int uid);

	public User findUser(String uName);

	public boolean updateUser(User user);

	public boolean updatePassword(int uid, String oldPassword, String newPassword);

	public boolean image(String image);

	/**
	 * 查重用户名
	 * 
	 * @param uName
	 * @return
	 */
	public boolean nameIsExistence(String uName);

	public boolean isState(String uName);

	/**
	 * @param user
	 * @return
	 */
	boolean register(User user);

	/**
	 * 启用用户账号
	 * 
	 * @param id
	 * @return
	 */
	public boolean enableOrdiscontinuation(int id, int state);

	public List<User> Contribution();
}
