package com.webDiary.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.webDiary.pojo.Diary;
import com.webDiary.pojo.Photo;
import com.webDiary.pojo.User;
import com.webDiary.util.PageBean;

public interface DiaryService {
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
	 * Diary seach service层分页
	 * 
	 * @param page
	 *            第几页
	 * @param map
	 *            hql参数
	 * @return 分页类实例
	 */
	public PageBean<Diary> findDiaryForSeachByPage(Integer page, Map<String, Object> map);

	/**
	 * Diaryservice层分页
	 * 
	 * @param page
	 *            第几页
	 * @param map
	 *            hql参数
	 * @return 分页类实例
	 */
	public PageBean<Diary> findByPage(Integer page, Map<String, Object> map);

	public ArrayList<Object>[] getTopCity();

	public List<Diary> findAll();

	/**
	 * 点赞排序
	 * 
	 * @return
	 */
	public PageBean<Diary> findAllForLikeSort(Integer page, Map<String, Object> map);

	/**
	 * @param page
	 * @param whereName
	 * @param ptamList
	 * @return
	 */
	PageBean<Diary> findByPageForFour(Integer page, String whereName, ArrayList<Object> ptamList);

	/**
	 * 获取猜你喜欢的文章
	 * 
	 * @param classify
	 * @param keyLandscape
	 * @return
	 */
	List<Diary> GuessLike(String classify, String keyLandscape);

	public List<User> Contribution();
}
