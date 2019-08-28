package com.webDiary.service;

import java.util.List;

import com.webDiary.pojo.Message;

public interface MessageService {

	public List<Message> find();

	public boolean insert(Message message);

	public boolean insertReply(int id, String reply);
	public List<Message> findAll();

	public boolean delete(int id);

}
