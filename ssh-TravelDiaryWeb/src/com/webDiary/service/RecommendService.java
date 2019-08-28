/**
 * 
 */
package com.webDiary.service;

import java.util.Map;

import com.webDiary.pojo.Recommend;
import com.webDiary.util.PageBean;

/**
 * @author wuzhuhao
 *
 */
public interface RecommendService {
	/**
	 * Diaryservice层分页
	 * 
	 * @param page
	 *            第几页
	 * @param map
	 *            hql参数
	 * @return 分页类实例
	 */
	public PageBean<Recommend> findByPage(Integer page, Map<String, Object> map);

	/**
	 * @param id
	 * @return
	 */
	public Recommend findById(int id);
}
