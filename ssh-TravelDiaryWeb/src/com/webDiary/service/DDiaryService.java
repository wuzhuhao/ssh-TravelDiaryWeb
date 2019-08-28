package com.webDiary.service;

import java.util.HashMap;
import java.util.List;

import com.webDiary.pojo.DDiary;
import com.webDiary.pojo.User;
import com.webDiary.util.PageBean;

public interface DDiaryService {

	public boolean insert(DDiary diary);

	public List<DDiary> listpage(int offset, int length, User user);

	public List<DDiary> findByID(int id);

	public void deleteId(int id);
	// TODO Auto-generated method stub

	public void deleteAll();
	// TODO Auto-generated method stub

	/**
	 * 草稿箱分页查询
	 * 
	 * @param page
	 * @param hm
	 * @return
	 */
	public PageBean<DDiary> findByPage(int page, HashMap<String, Object> map);

}
