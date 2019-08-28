package com.webDiary.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.webDiary.action.PhotoAction;
import com.webDiary.dao.DDiaryDAO;
import com.webDiary.pojo.DDiary;
import com.webDiary.pojo.DPhoto;
import com.webDiary.pojo.Photo;
import com.webDiary.pojo.User;
import com.webDiary.util.PageHibernateCallback;

public class DDiaryDAOImpl extends HibernateTemplate implements DDiaryDAO {

	@Override
	public boolean insert(DDiary diary) {
		// TODO Auto-generated method stub
		HttpSession session = ServletActionContext.getRequest().getSession();
		boolean flag = true;
		try {
			save(diary);
			List<DDiary> list = find("from DDiary where title = '" + diary.getTitle() + "'");
			PhotoAction photoAction = new PhotoAction();
			List<Photo> photoList1 = (List<Photo>) session.getAttribute("photoList1");
			List<DPhoto> photoList = new ArrayList<>();
			DPhoto photo1 = null;
			if (photoList1 != null)
				for (Photo photo : photoList1) {
					photo1 = new DPhoto();
					photo1.setImage(photo.getImage());
					photoList.add(photo1);
				}
			System.out.println(photoList.size() + "DDDAO");
			for (DPhoto photo : photoList) {
				photo.setdDiary(diary);
				save(photo);
			}
			session.removeAttribute("photoList1");
			session.setAttribute("photoList", photoList);
		}

		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			flag = false;
		}
		return flag;
	}

	public List<DDiary> listpage(int offset,

			int length, User user) {

		List<DDiary> list = executeFind(

				new HibernateCallback() {

					public Object doInHibernate(Session session)

							throws HibernateException, SQLException {

						Query query = session.createQuery("from DDiary where user = '" + user.getId() + "'");

						query.setFirstResult(offset);

						query.setMaxResults(length);

						List<DDiary> list = query.list();

						return list;

					}

				});

		return list;

	}

	@Override
	public List<DDiary> findByID(int id) {
		// TODO Auto-generated method stub
		String hql = "from DDiary where did = '" + id + "'";
		List<DDiary> diaryList = find(hql);

		if (diaryList.isEmpty())
			return null;
		return diaryList;
	}

	@Override
	public void deleteAll() {
		List<DPhoto> list1 = find("from DPhoto");
		for (DPhoto photo : list1) {
			delete(photo);
		}
		List<DDiary> list = find("from DDiary");
		for (DDiary diary : list) {
			delete(diary);
		}

	}

	@Override
	public void deleteId(int id) {
		List<DDiary> list = find("from DDiary where did = " + id);
		List<DPhoto> list1 = find("from DPhoto where did = " + id);
		for (DPhoto photo : list1) {
			delete(photo);
		}
		for (DDiary diary : list) {
			delete(diary);
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DDiaryDAO#findCount(java.lang.String,
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
	 * @see com.webDiary.dao.DDiaryDAO#findByPage(java.lang.String,
	 * java.lang.Object[], int, int)
	 */
	@Override
	public List<DDiary> findByPage(String selectHql, Object[] patm, int begin, int limit) {
		List<DDiary> list = execute(new PageHibernateCallback<DDiary>(selectHql, patm, begin, limit));
		if (list != null && list.size() > 0) {
			return list;
		}
		return null;
	}
}
