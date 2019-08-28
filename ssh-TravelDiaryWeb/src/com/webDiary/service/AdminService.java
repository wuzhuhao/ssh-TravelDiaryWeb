package com.webDiary.service;

import java.util.List;

import com.webDiary.pojo.Admin;

public interface AdminService {

	public List<Admin> findAll();

	public boolean delete(int id);

	public List<Admin> login(String userName, String passwd);

	/**
	 * 启用或停用管理员账号
	 * 
	 * @param id
	 * @param i
	 * @return
	 */
	public boolean enableOrdiscontinuation(int id, int i);

	public boolean edit(Admin admin);

}
