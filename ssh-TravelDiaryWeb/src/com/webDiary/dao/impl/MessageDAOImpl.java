package com.webDiary.dao.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.webDiary.dao.MessageDAO;
import com.webDiary.pojo.Message;
import com.webDiary.pojo.User;

public class MessageDAOImpl extends HibernateTemplate implements MessageDAO {

	@Override
	public List<Message> find() {

		HttpSession session = ServletActionContext.getRequest().getSession();
		User user = (User) (session.getAttribute("user"));
		String hql = "from Message where user = '" + user.getId() + "'";

		List<Message> MessageList = find(hql);

		return MessageList;
	}

	@Override
	public boolean insert(Message message) {
		boolean flag = true;
		try {
			save(message);

		} catch (Exception e) {
			// TODO: handle exception
			flag = false;
		}
		return flag;
	}

	@Override
	public boolean insertReply(int id, String reply) {
		String hql = "from Message where id = '" + id + "'";
		// TODO Auto-generated method stub
		List<Message> MessageList = find(hql);
		Message message = MessageList.get(0);
		message.setReply(reply);
		boolean flag = true;
		try {
			update(message);
		} catch (Exception e) {
			System.out.println("留言回复插入失败");
			flag = false;
		}
		return flag;

	}

	@Override
	public List<Message> findAll() {
		String hql = "from Message";
		List<Message> MessageList = find(hql);
		return MessageList;
	}

	@Override
	public boolean delete(int id) {
		List<Message> MessageList = find("from Message where id =  " + id);
		try {
			delete(MessageList.get(0));
			
		} catch (Exception e) {
			return false;
		}
		return true;
	}
	
}
