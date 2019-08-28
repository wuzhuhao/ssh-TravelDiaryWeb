package com.webDiary.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.webDiary.dao.DDiaryDAO;
import com.webDiary.pojo.DDiary;
import com.webDiary.pojo.User;
import com.webDiary.service.DDiaryService;
import com.webDiary.util.PageBean;

public class DDiaryServiceImpl implements DDiaryService {
	private DDiaryDAO dDiaryDAO;
	private final int limit = 3;

	public DDiaryDAO getdDiaryDAO() {
		return dDiaryDAO;
	}

	public void setdDiaryDAO(DDiaryDAO dDiaryDAO) {
		this.dDiaryDAO = dDiaryDAO;
	}

	@Override
	public boolean insert(DDiary diary) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		diary.setdTime(df.format(new Date()) + "");
		return dDiaryDAO.insert(diary);
	}

	@Override
	public List<DDiary> listpage(int offset, int length, User user) {
		return dDiaryDAO.listpage(offset, length, user);
	}

	@Override
	public List<DDiary> findByID(int id) {
		// TODO Auto-generated method stub
		return dDiaryDAO.findByID(id);
	}

	public void deleteId(int id) {
		dDiaryDAO.deleteId(id);
	}

	public void deleteAll() {
		dDiaryDAO.deleteAll();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DDiaryService#findByPage(int,
	 * java.util.HashMap)
	 */
	@Override
	public PageBean<DDiary> findByPage(int page, HashMap<String, Object> map) {
		PageBean<DDiary> pageBean = new PageBean<DDiary>();
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
		pageBean.setLimit(limit);
		// 设置总记录数:
		String countHql = "select count(*) from DDiary " + whereName;
		int totalCount = dDiaryDAO.findCount(countHql, patm);
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
		String selectHql = "from DDiary " + whereName;
		List<DDiary> list = dDiaryDAO.findByPage(selectHql, patm, begin, limit);
		pageBean.setList(list);
		return pageBean;
	}

}
