package com.webDiary.dao;

import java.util.List;

import com.webDiary.pojo.User;

public interface UserDao {
	/**
	 * 查找user的接口
	 * 
	 * @param username
	 *            user的账号
	 * @return user
	 */
	public User findUser(int uid);

	/**
	 * 修改用户信息的接口
	 * 
	 * @param user
	 *            修改后的封装数据
	 * @return 修改的结果
	 */
	public boolean updateUser(User user);

	/**
	 * 修改用户密码的接口
	 * 
	 * @param user
	 *            修改密码后的封装数据
	 * @return 修改的结果
	 */
	public boolean updatePassword(User user);

	/**
	 * @param uName
	 * @param passwd
	 * @return 登陆结果
	 */
	public boolean login(String uName, String passwd);

	public boolean image(String image);

	/**
	 * @param uName
	 * @return
	 */
	public boolean nameIsExistence(String uName);

	/**
	 * @param uName
	 * @return
	 */
	public User findUser(String uName);

	/**
	 * 获取账号状态
	 * 
	 * @param uName
	 * @return
	 */
	public int isState(String uName);

	/**
	 * 用户注册
	 * 
	 * @param user
	 * @return
	 */
	boolean register(User user);

	/**
	 * @param id
	 * @param state
	 * @return
	 */
	public int enableOrdiscontinuation(int id, int state);

	public List<Integer> findByUidTOP8();

	public List<User> findByUser(List<Integer> uid);

}
