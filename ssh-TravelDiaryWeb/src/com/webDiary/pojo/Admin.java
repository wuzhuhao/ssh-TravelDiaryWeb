package com.webDiary.pojo;

public class Admin {
	private int id;
	private String userName;
	private String power;
	private String describe_;
	private String telphone;
	private String email;
	private String time;
	private String passwd;
	private int state;

	public String getDescribe_() {
		return describe_;
	}

	public void setDescribe_(String describe_) {
		this.describe_ = describe_;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPower() {
		return power;
	}

	public void setPower(String power) {
		this.power = power;
	}

	public String getTelphone() {
		return telphone;
	}

	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String toString() {
		return id + "\t" + userName + "\t" + power + "\t" + describe_ + "\t" + telphone + "\t" + email + "\t" + time
				+ "\t" + passwd + "\t" + state;

	}
}
