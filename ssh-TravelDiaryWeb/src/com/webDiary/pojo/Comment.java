package com.webDiary.pojo;

public class Comment {
	private int id;
	private String content;
	private Diary diary;
	private String time;
	private String reply;
	private User user;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

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

	public Diary getDiary() {
		return diary;
	}

	public void setDiary(Diary diary) {
		this.diary = diary;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	@Override
	public String toString() {
		return "Comment [id=" + id + ", content=" + content + ", diary=" + diary + ", time=" + time + ", reply=" + reply
				+ ", user=" + user + "]";
	}

}
