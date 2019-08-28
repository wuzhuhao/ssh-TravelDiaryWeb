package com.webDiary.dao;

import java.util.List;

import com.webDiary.pojo.Diary;
import com.webDiary.pojo.Photo;
import com.webDiary.pojo.User;

public interface DiaryDAO {
	public boolean insert(Diary diary);

	public List<Diary> list(User user);

	public List<Diary> listpage(int offset,

			int length, User user);

	public int classifyCount(User user, String classify);

	public List<Diary> findById(int dId);

	public List<Diary> findByClassify(String type);

	public List<Diary> seach(String seach);

	public boolean delete(int id);

	public List<Diary> LikenumSort();

	public List<Photo> findByDid(int id);

	public List<Photo> find(Diary diary);

	/**
	 * 查询分页总数
	 * 
	 * @param hql
	 *            hql语句
	 * @param patm
	 *            hql使用的参数
	 * @return 分页总数
	 */
	public int findCount(String hql, Object[] patm);

	/**
	 * 分页查询
	 * 
	 * @param hql
	 *            查询语句
	 * @param patm
	 *            查询参数
	 * @param begin
	 *            开始下标
	 * @param limit
	 *            每页记录数
	 * @return 分页结果
	 */
	public List<Diary> findByPage(String hql, Object[] patm, int begin, int limit);

	/**
	 * 获取前五城市
	 * 
	 * @return
	 */
	public List getTopCity();

	public List<Diary> findAll();

	public List<Diary> findHql(String hql, Object[] patm, int maxResult);

	public List<Integer> findByUidTOP8();

	public List<User> findByUser(List<Integer> uid);

}
