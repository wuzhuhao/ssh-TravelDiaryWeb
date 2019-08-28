/**
 * 
 */
package com.webDiary.service.impl;

import java.util.List;
import java.util.Map;

import com.webDiary.dao.RecommendDao;
import com.webDiary.pojo.Recommend;
import com.webDiary.service.RecommendService;
import com.webDiary.util.PageBean;

/**
 * @author wuzhuhao
 *
 */
public class RecommendServiceImpl implements RecommendService {
	RecommendDao recommendDao;

	public RecommendDao getRecommendDao() {
		return recommendDao;
	}

	public void setRecommendDao(RecommendDao recommendDao) {
		this.recommendDao = recommendDao;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.RecommendService#findByPage(java.lang.Integer,
	 * java.util.Map)
	 */
	@Override
	public PageBean<Recommend> findByPage(Integer page, Map<String, Object> map) {
		PageBean<Recommend> pageBean = new PageBean<Recommend>();
		String whereName = "";
		Object[] patm = null;
		int h = 0;
		if (map != null && map.size() != 0) {
			patm = new Object[map.size()];
			whereName = " where ";
			for (String s : map.keySet()) {
				if (h == 0) {
					whereName += s + " ? ";
				} else {
					whereName += "and " + s + " ? ";
				}
				patm[h] = map.get(s);
				h++;
			}
		}

		// 设置参数:
		pageBean.setPage(page);
		// 设置每页显示记录数:
		int limit = 8;
		pageBean.setLimit(limit);
		// 设置总记录数:
		String countHql = "select count(*) from Recommend " + whereName;
		int totalCount = recommendDao.findCount(countHql, patm);
		System.out.println("总数：" + totalCount);
		pageBean.setTotalCount(totalCount);
		// 设置总页数:
		int totalPage = 0;
		if (totalCount % limit == 0) {
			totalPage = totalCount / limit;
		} else {
			totalPage = totalCount / limit + 1;
		}
		pageBean.setTotalPage(totalPage);
		// 设置页面显示数据的集合:
		int begin = (page - 1) * limit;
		String selectHql = "from Recommend " + whereName;
		List<Recommend> list = recommendDao.findByPage(selectHql, patm, begin, limit);
		pageBean.setList(list);
		return pageBean;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.RecommendService#findById(int)
	 */
	@Override
	public Recommend findById(int id) {
		List<Recommend> list = recommendDao.findById(id);
		return list.size() == 0 ? null : list.get(0);
	}

}
