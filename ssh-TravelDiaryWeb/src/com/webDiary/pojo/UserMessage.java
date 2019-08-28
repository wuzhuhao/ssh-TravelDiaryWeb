package com.webDiary.pojo;

public class UserMessage {
	private int id;
	private String content;
	private String replyContent;
	private String sendTime;
	private User sender;
	private User sendee;

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

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public User getSendee() {
		return sendee;
	}

	public void setSendee(User sendee) {
		this.sendee = sendee;
	}

}
