package com.webDiary.service;

import java.util.List;

import com.webDiary.pojo.User;

public interface LoginService {

	public boolean login(int uid, String password);

	public boolean register(User user);

	public List<User> findUser();

	public boolean delete(int id);
}
