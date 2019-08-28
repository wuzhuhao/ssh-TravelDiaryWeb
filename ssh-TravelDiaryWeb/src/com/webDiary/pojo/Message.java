package com.webDiary.pojo;

public class Message {
	private int id;
	private String content;
	private String reply;
	private String dTime;
	private User user;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getdTime() {
		return dTime;
	}

	public void setdTime(String dTime) {
		this.dTime = dTime;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Message [id=" + id + ", content=" + content + ", reply=" + reply + ", dTime=" + dTime + ", user=" + user
				+ "]";
	}


}
