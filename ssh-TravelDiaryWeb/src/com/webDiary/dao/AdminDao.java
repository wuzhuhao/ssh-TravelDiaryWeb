package com.webDiary.dao;

import java.util.List;

import com.webDiary.pojo.Admin;

public interface AdminDao {

	public List<Admin> findAll();

	public boolean delete(int id);

	public List<Admin> login(String userName, String passwd);

	/**
	 * @param id
	 * @param state
	 * @return
	 */
	public int enableOrdiscontinuation(int id, int state);

	public boolean edit(Admin admin);

}
