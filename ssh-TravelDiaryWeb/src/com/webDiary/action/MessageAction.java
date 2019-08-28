package com.webDiary.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.webDiary.pojo.Message;
import com.webDiary.pojo.User;
import com.webDiary.service.MessageService;
import com.webDiary.util.ResultUtil;

public class MessageAction {
	private MessageService messageService;
	private Message message;
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public MessageService getMessageService() {
		return messageService;
	}

	public void setMessageService(MessageService messageService) {
		this.messageService = messageService;
	}

	public Message getMessage() {
		return message;
	}

	public void setMessage(Message message) {
		this.message = message;
	}

	public String list() {
		List<Message> messageList = messageService.findAll();
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("messageList", messageList);
		return "Success";
	}

	public void insert() throws IOException {
		HttpSession session = ServletActionContext.getRequest().getSession();
		User user = (User) session.getAttribute("user");
		message.setUser(user);

		boolean flag1 = (session.getAttribute("user") == null);
		if (!flag1) {
			message.setUser(user);
			messageService.insert(message);
		}
		System.out.println(flag1);
		String data = JSON.toJSONString(flag1);
		ResultUtil.sendJson(data);

	}

	public String reply() throws IOException {
		boolean flag = false;
		HttpSession session = ServletActionContext.getRequest().getSession();

		flag = messageService.insertReply(message.getId(), message.getReply());
		return "reply";
	}

	public String findAll() {
		List<Message> mList = messageService.findAll();
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("mList", mList);
		return "findAll";

	}

	public void delete() throws IOException {
		System.out.println(id);
		boolean flag = messageService.delete(id);
		try {
			String data = JSON.toJSONString(flag);
			PrintWriter write;
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			write = ServletActionContext.getResponse().getWriter();
			write.write(data);
		} catch (Exception e) {
			System.out.println("有异常");
		}
	}

	public String all() {
		System.out.println(id);
		Message mess = new Message();
		List<Message> mList = messageService.findAll();
		for (Message message : mList) {
			if (message.getId() == id) {
				mess = message;
				break;
			}
		}
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("message", mess);

		return "all";

	}
}
