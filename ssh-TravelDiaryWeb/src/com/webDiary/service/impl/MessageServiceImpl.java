package com.webDiary.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.webDiary.dao.MessageDAO;
import com.webDiary.pojo.Message;
import com.webDiary.service.MessageService;

public class MessageServiceImpl implements MessageService {
	private MessageDAO messageDAO;

	public MessageDAO getMessageDAO() {
		return messageDAO;
	}

	public void setMessageDAO(MessageDAO messageDAO) {
		this.messageDAO = messageDAO;
	}

	@Override
	public List<Message> find() {

		return messageDAO.find();
	}

	@Override
	public boolean insert(Message message) {
		// TODO Auto-generated method stub
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		message.setdTime(df.format(new Date()) + "");
		return messageDAO.insert(message);
	}

	@Override
	public boolean insertReply(int id, String reply) {
		// TODO Auto-generated method stub
		return messageDAO.insertReply(id, reply);
	}
	
	@Override
	public List<Message> findAll() {
		// TODO Auto-generated method stub
		 return messageDAO.findAll();
	}
	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return messageDAO.delete(id);
	}

}
