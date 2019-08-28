package com.webDiary.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.webDiary.dao.DiaryDAO;
import com.webDiary.pojo.Diary;
import com.webDiary.pojo.Photo;
import com.webDiary.pojo.User;
import com.webDiary.service.DiaryService;
import com.webDiary.util.PageBean;

public class DiaryServiceImpl implements DiaryService {

	private DiaryDAO diaryDAO;

	public DiaryDAO getDiaryDAO() {
		return diaryDAO;
	}

	public void setDiaryDAO(DiaryDAO diaryDAO) {
		this.diaryDAO = diaryDAO;
	}

	@Override
	public boolean insert(Diary diary) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		diary.setdTime(df.format(new Date()) + "");
		return diaryDAO.insert(diary);
	}

	@Override
	public List<Diary> list(User user) {
		return diaryDAO.list(user);

	}

	@Override
	public List<Diary> listpage(int offset, int length, User user) {
		return diaryDAO.listpage(offset, length, user);

	}

	public int classifyCount(User user, String classify) {
		return diaryDAO.classifyCount(user, classify);
	}

	@Override
	public List<Diary> findById(int dId) {
		return diaryDAO.findById(dId);
	}

	@Override
	public List<Diary> findByClassify(String type) {
		// TODO Auto-generated method stub
		return diaryDAO.findByClassify(type);
	}

	@Override
	public List<Diary> seach(String seach) {
		// TODO Auto-generated method stub
		return diaryDAO.seach(seach);
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return diaryDAO.delete(id);
	}

	@Override
	public List<Diary> LikenumSort() {
		return diaryDAO.LikenumSort();
	}

	@Override
	public List<Photo> findByDid(int id) {
		// TODO Auto-generated method stub
		return diaryDAO.findByDid(id);
	}

	@Override
	public List<Photo> find(Diary diary) {
		// TODO Auto-generated method stub
		return diaryDAO.find(diary);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryService#findByPage(java.lang.Integer,
	 * java.util.Map)
	 */
	@Override
	public PageBean<Diary> findDiaryForSeachByPage(Integer page, Map<String, Object> map) {
		PageBean<Diary> pageBean = new PageBean<Diary>();
		String whereName = "";
		Object[] patm = null;
		int h = 0;
		if (map != null && map.size() != 0) {
			patm = new Object[map.size()];
			whereName = " where ";
			if (map.size() == 3) {
				for (String s : map.keySet()) {
					if (h == 0) {
						whereName += s + " ? ";
					} else if (h == 1) {
						whereName += "and (" + s + " ? ";
					} else {
						whereName += "or " + s + " ? ";
					}
					patm[h] = map.get(s);
					h++;
				}
				whereName += ")";
			} else {
				for (String s : map.keySet()) {
					if (h == 0) {
						whereName += s + " ? ";
					} else {
						whereName += "or " + s + " ? ";
					}
					patm[h] = map.get(s);
					h++;
				}
			}
		}

		// 设置参数:
		pageBean.setPage(page);
		// 设置每页显示记录数:
		int limit = 5;
		pageBean.setLimit(limit);
		// 设置总记录数:
		String countHql = "select count(*) from Diary " + whereName;
		int totalCount = diaryDAO.findCount(countHql, patm);
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
		String selectHql = "from Diary " + whereName + " order by dTime DESC";
		List<Diary> list = diaryDAO.findByPage(selectHql, patm, begin, limit);
		pageBean.setList(list);
		return pageBean;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryService#findByPage(java.lang.Integer,
	 * java.util.Map)
	 */
	@Override
	public PageBean<Diary> findByPage(Integer page, Map<String, Object> map) {
		PageBean<Diary> pageBean = new PageBean<Diary>();
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
		int limit = 5;
		pageBean.setLimit(limit);
		// 设置总记录数:
		String countHql = "select count(*) from Diary " + whereName;
		int totalCount = diaryDAO.findCount(countHql, patm);
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
		String selectHql = "from Diary " + whereName + " order by dTime DESC";
		List<Diary> list = diaryDAO.findByPage(selectHql, patm, begin, limit);
		pageBean.setList(list);
		return pageBean;

	}

	@Override
	public PageBean<Diary> findByPageForFour(Integer page, String whereName, ArrayList<Object> ptamList) {
		PageBean<Diary> pageBean = new PageBean<Diary>();
		Object[] patm = new Object[ptamList.size()];
		int h = 0;
		for (Object ob : ptamList) {
			patm[h] = ob;
			h++;
		}
		// 设置参数:
		pageBean.setPage(page);
		// 设置每页显示记录数:
		int limit = 6;
		pageBean.setLimit(limit);
		// 设置总记录数:
		String countHql = "select count(*) from Diary " + whereName;
		int totalCount = diaryDAO.findCount(countHql, patm);
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
		String selectHql = "from Diary " + whereName + " order by dTime DESC";
		List<Diary> list = diaryDAO.findByPage(selectHql, patm, begin, limit);
		pageBean.setList(list);
		return pageBean;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryService#getTopCity()
	 */
	@Override
	public ArrayList<Object>[] getTopCity() {
		ArrayList<Object>[] result = new ArrayList[2];
		result[0] = new ArrayList<>();
		result[1] = new ArrayList<>();
		List list = diaryDAO.getTopCity();
		Iterator it = list.iterator();
		while (it.hasNext()) {
			Object[] res = (Object[]) it.next();
			// 注意这里的类型转化
			int count = ((Number) res[0]).intValue();
			result[1].add(count);
			result[0].add(res[1] + "");
		}
		return result;
	}

	@Override
	public List<Diary> findAll() {
		// TODO Auto-generated method stub
		return diaryDAO.findAll();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.webDiary.service.DiaryService#findAllForLikeSort(java.lang.Integer,
	 * java.util.Map)
	 */
	@Override
	public PageBean<Diary> findAllForLikeSort(Integer page, Map<String, Object> map) {
		PageBean<Diary> pageBean = new PageBean<Diary>();
		Object[] patm = null;

		// 设置参数:
		pageBean.setPage(page);
		// 设置每页显示记录数:
		int limit = 5;
		pageBean.setLimit(limit);
		// 设置总记录数:
		String countHql = "select count(*) from Diary";
		int totalCount = diaryDAO.findCount(countHql, patm);
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
		String selectHql = "from Diary order by likenum DESC";
		List<Diary> list = diaryDAO.findByPage(selectHql, patm, begin, limit);
		pageBean.setList(list);
		return pageBean;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryService#GuessLike(java.lang.String,
	 * java.lang.String)
	 */
	@Override
	public List<Diary> GuessLike(String classify, String keyLandscape) {
		Object[] classifys = classify.split("-");
		StringBuilder hqlAndWhere = new StringBuilder();
		// hql参数
		Object[] andPatm = new Object[classifys.length + 1];
		// 获取hql类别的where和赋值hql参数
		hqlAndWhere.append("( ");
		for (int i = 0; i < classifys.length; i++) {
			andPatm[i] = classifys[i];
			if (i == classifys.length - 1) {
				hqlAndWhere.append("classify like ?");
			} else {
				hqlAndWhere.append("classify like ? or ");
			}
		}
		hqlAndWhere.append(" )");
		andPatm[classifys.length] = keyLandscape;
		// 两个条件都满足的hql的语句
		String hqlAnd = "from Diary where " + hqlAndWhere.toString() + " and keyLandscape like ?";
		List<Diary> list = diaryDAO.findByPage(hqlAnd, andPatm, 0, 5);
		if (list.isEmpty() || list.size() < 5) {
			// 两个条件都满足茶差集的hql的语句
			String hqlOr = "from Diary where (not (" + hqlAndWhere.toString() + " and keyLandscape like ?)) " + "and ("
					+ hqlAndWhere.toString() + " or keyLandscape like ?)";
			// hql参数
			Object[] orPatm = new Object[(andPatm.length) * 2];
			List orList = new ArrayList(Arrays.asList(andPatm));
			orList.addAll(Arrays.asList(andPatm));
			orList.toArray(orPatm);
			List<Diary> orDataList = diaryDAO.findByPage(hqlOr, orPatm, 0, 5 - list.size());
			list.addAll(orDataList);
		}
		return list;
	}

	public static void main(String[] args) {
		String classify = "类型一-类型二";
		String keyLandscape = "测试条件";
		Object[] classifys = classify.split("-");
		StringBuilder hqlAndWhere = new StringBuilder();
		// hql参数
		Object[] andPatm = new Object[classifys.length + 1];
		// 获取hql类别的where和赋值hql参数
		for (int i = 0; i < classifys.length; i++) {
			andPatm[i] = classifys[i];
			if (i == classifys.length - 1) {
				hqlAndWhere.append("classify like ?)");
			} else if (i == 0) {
				hqlAndWhere.append("(classify like ? or ");
			} else {
				hqlAndWhere.append(" classify like ? or");
			}
		}
		andPatm[classifys.length] = keyLandscape;

		// 两个条件都满足的hql的语句
		String hqlAnd = "from Diary where " + hqlAndWhere.toString() + " and keyLandscape like ?";
		// 两个条件都满足茶差集的hql的语句
		String hqlOr = "from Diary where (" + hqlAndWhere.toString() + " or keyLandscape like ?) " + "and not ("
				+ hqlAndWhere.toString() + " and keyLandscape like ?)";
		// 第二句语句hql参数
		Object[] orPatm = new Object[(andPatm.length) * 2];
		List orList = new ArrayList(Arrays.asList(andPatm));
		orList.addAll(Arrays.asList(andPatm));
		orList.toArray(orPatm);
		System.out.println(hqlAnd);
		System.out.println(Arrays.toString(andPatm));
		System.out.println("---=====-----");
		System.out.println(hqlOr);
		System.out.println(Arrays.toString(orPatm));
	}
	
	@Override
	public List<User> Contribution() {
		// TODO Auto-generated method stub
		List<Integer> uid = diaryDAO.findByUidTOP8();
		return diaryDAO.findByUser(uid);
	}
}
