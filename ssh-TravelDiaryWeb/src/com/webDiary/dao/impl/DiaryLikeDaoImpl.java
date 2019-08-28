/**
 * 
 */
package com.webDiary.dao.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.webDiary.dao.DiaryLikeDao;
import com.webDiary.pojo.DiaryLike;

/**
 * @author wuzhuhao
 *
 */
public class DiaryLikeDaoImpl extends HibernateTemplate implements DiaryLikeDao {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryLikeDao#addLike(com.webDiary.pojo.DiaryLike)
	 */
	@Override
	public boolean addLike(DiaryLike diaryLike) {
		if (isLike(diaryLike.getDiary_id(), diaryLike.getUser_id())) {
			return false;
		}
		try {
			save(diaryLike);
			return true;
		} catch (Exception e) {
			e.printStackTrace();

		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryLikeDao#delLike(com.webDiary.pojo.DiaryLike)
	 */
	@Override
	public boolean delLike(DiaryLike diaryLike) {
		try {
			delete(diaryLike);
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryLikeDao#delLikeToDid(int)
	 */
	@Override
	public boolean delLikeToDid(int d_id) {
		// TODO Auto-generated method stub
		List<DiaryLike> likes = findForD_id(d_id);
		if (likes == null || likes.isEmpty()) {
			return true;
		} else {
			try {
				for (DiaryLike dl : likes) {
					if (!delLike(dl)) {
						throw new RuntimeException("意外删除失败");
					}
				}
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryLikeDao#findLikeCount(int)
	 */
	@Override
	public int findLikeCount(int d_id) {
		String hql = "select count(*) from DiaryLike where diary_id = ? ";
		List<Long> list = find(hql, d_id);
		if (list != null && list.size() > 0) {
			return list.get(0).intValue();
		}
		return 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryLikeDao#isLike(int, int)
	 */
	@Override
	public boolean isLike(int d_id, int u_id) {
		String hql = "from DiaryLike where diary_id = ? and user_id = ?";
		List<DiaryLike> list = find(hql, d_id, u_id);
		if (list == null || list.isEmpty()) {
			return false;
		}
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryLikeDao#findForD_id(int)
	 */
	@Override
	public List<DiaryLike> findForD_id(int d_id) {
		String hql = "from DiaryLike where diary_id = ?";
		List<DiaryLike> list = find(hql, d_id);
		return list;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryLikeDao#findLikeTopFive()
	 */
	@Override
	public List<Integer> findLikeTopFive() {
		String hql = "select count(*),diary_id from DiaryLike group by diary_id order by count(*) desc";
		List<Integer> ss = new ArrayList<>();
		Session session2 = getSession();
		Query query = session2.createQuery(hql);
		query.setMaxResults(5);
		List list = query.list();
		Iterator it = list.iterator();
		while (it.hasNext()) {
			Object[] res = (Object[]) it.next();
			// 注意这里的类型转化
			int count = ((Number) res[0]).intValue();
			ss.add((Integer) res[1]);
		}
		return ss;
	}

}
