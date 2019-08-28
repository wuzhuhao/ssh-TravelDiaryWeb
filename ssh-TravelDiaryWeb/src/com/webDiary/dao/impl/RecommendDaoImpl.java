/**
 * 
 */
package com.webDiary.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.HibernateTemplate;

import com.webDiary.dao.RecommendDao;
import com.webDiary.pojo.Recommend;
import com.webDiary.util.PageHibernateCallback;

/**
 * @author wuzhuhao
 *
 */
public class RecommendDaoImpl extends HibernateTemplate implements RecommendDao {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.RecommendDao#findCount(java.lang.String,
	 * java.lang.Object[])
	 */
	@Override
	public int findCount(String countHql, Object[] patm) {
		List<Long> list = find(countHql, patm);
		if (list != null && list.size() > 0) {
			return list.get(0).intValue();
		}
		return 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.RecommendDao#findByPage(java.lang.String,
	 * java.lang.Object[], int, int)
	 */
	@Override
	public List<Recommend> findByPage(String selectHql, Object[] patm, int begin, int limit) {
		List<Recommend> list = execute(new PageHibernateCallback<Recommend>(selectHql, patm, begin, limit));
		if (list != null && list.size() > 0) {
			return list;
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.RecommendDao#findById(int)
	 */
	@Override
	public List<Recommend> findById(int id) {
		String hql = "from Recommend where id = ?";
		List<Recommend> diaryList = find(hql, id);
		return diaryList;
	}

}
