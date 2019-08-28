package com.webDiary.dao;

import java.util.List;

import com.webDiary.pojo.DDiary;
import com.webDiary.pojo.User;

public interface DDiaryDAO {

	public boolean insert(DDiary diary);

	public List<DDiary> listpage(int offset, int length, User user);

	public List<DDiary> findByID(int id);

	public void deleteAll();

	public void deleteId(int id);

	/**
	 * @param countHql
	 * @param patm
	 * @return
	 */
	public int findCount(String countHql, Object[] patm);

	/**
	 * @param selectHql
	 * @param patm
	 * @param begin
	 * @param limit
	 * @return
	 */
	public List<DDiary> findByPage(String selectHql, Object[] patm, int begin, int limit);

}
