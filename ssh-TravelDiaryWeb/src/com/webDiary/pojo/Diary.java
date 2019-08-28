package com.webDiary.pojo;

public class Diary {
	private int Did;
	private String title, content, classify, content2;
	private String dTime;
	private User user;
	private String image;
	private String countryRegion;
	private String province;
	private String city;
	private int likenum;
	private int monthTime;
	private int totalTime;
	private String keyLandscape;

	public int getMonthTime() {
		return monthTime;
	}

	public void setMonthTime(int monthTime) {
		this.monthTime = monthTime;
	}

	public int getTotalTime() {
		return totalTime;
	}

	public void setTotalTime(int totalTime) {
		this.totalTime = totalTime;
	}

	public String getKeyLandscape() {
		return keyLandscape;
	}

	public void setKeyLandscape(String keyLandscape) {
		this.keyLandscape = keyLandscape;
	}

	public String getCountryRegion() {
		return countryRegion;
	}

	public void setCountryRegion(String countryRegion) {
		this.countryRegion = countryRegion;
	}

	public int getDid() {
		return Did;
	}

	public void setDid(int did) {
		Did = did;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getClassify() {
		return classify;
	}

	public void setClassify(String classify) {
		this.classify = classify;
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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getLikenum() {
		return likenum;
	}

	public void setLikenum(int likenum) {
		this.likenum = likenum;
	}

	public String getContent2() {
		return content2;
	}

	public void setContent2(String content2) {
		this.content2 = content2;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

}
