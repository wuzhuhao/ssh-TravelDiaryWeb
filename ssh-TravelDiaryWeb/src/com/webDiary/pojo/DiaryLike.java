/**
 * 
 */
package com.webDiary.pojo;

/**
 * @author wuzhuhao
 *
 */
public class DiaryLike {
	private int id;
	private int diary_id;
	private int user_id;

	/**
	 * 
	 */
	public DiaryLike() {
		super();
	}

	/**
	 * @param diary_id
	 * @param user_id
	 */
	public DiaryLike(int diary_id, int user_id) {
		super();
		this.diary_id = diary_id;
		this.user_id = user_id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getDiary_id() {
		return diary_id;
	}

	public void setDiary_id(int diary_id) {
		this.diary_id = diary_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

}
