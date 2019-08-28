package com.webDiary.pojo;

public class User {
	private int id;
	private String userName, passwd, sex, email, individualResume;
	private String image;
	private String site;
	private int state;

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
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

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIndividualResume() {
		return individualResume;
	}

	public void setIndividualResume(String individualResume) {
		this.individualResume = individualResume;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getSite() {
		return site;
	}

	public void setSite(String site) {
		this.site = site;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", passwd=" + passwd + ", sex=" + sex + ", email=" + email
				+ ", individualResume=" + individualResume + ", image=" + image + ", site=" + site + ", state=" + state
				+ "]";
	}

}
