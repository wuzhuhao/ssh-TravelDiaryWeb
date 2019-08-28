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

import com.webDiary.dao.DiaryDAO;
import com.webDiary.pojo.Comment;
import com.webDiary.pojo.DPhoto;
import com.webDiary.pojo.Diary;
import com.webDiary.pojo.DiaryLike;
import com.webDiary.pojo.Photo;
import com.webDiary.pojo.User;
import com.webDiary.util.PageHibernateCallback;

public class DiaryDAOImpl extends HibernateTemplate implements DiaryDAO {

	@Override
	public boolean insert(Diary diary) {
		// TODO Auto-generated method stub
		HttpSession session = ServletActionContext.getRequest().getSession();

		boolean flag = true;
		try {
			save(diary);
			List<Diary> list = find("from Diary where title = '" + diary.getTitle() + "' ");
			List<Photo> photoList = (List<Photo>) session.getAttribute("photoList1");
			System.out.println((session.getAttribute("id")));
			if (session.getAttribute("id") != null) {

				int draftsId = (Integer) session.getAttribute("id");
				session.removeAttribute("id");
				List<DPhoto> photoList3 = find("from DPhoto where dDiary = " + draftsId);
				List<DPhoto> List5 = find("from DDiary where did = " + draftsId);

				List<Photo> photoList4 = new ArrayList<>();
				Photo dphoto = null;
				for (DPhoto photo : photoList3) {
					dphoto = new Photo();
					dphoto.setImage(photo.getImage());
					photoList4.add(dphoto);
					delete(photo);
				}
				if (!List5.isEmpty())
					delete(List5.get(0));
				for (Photo photo : photoList4) {
					photo.setDiary(diary);
					save(photo);

				}
			}

			if (photoList != null)
				for (Photo photo : photoList) {
					photo.setDiary(diary);
					save(photo);
				}
			session.removeAttribute("photoList1");

		}

		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			flag = false;
		}
		return flag;
	}

	@Override
	public List<Diary> list(User user) {

		String hql = "from Diary where user = '" + user.getId() + "'";
		List<Diary> diaryList = find(hql);
		return diaryList;

	}

	public List<Diary> listpage(int offset,

			int length, User user) {

		List<Diary> list = executeFind(

				new HibernateCallback() {

					public Object doInHibernate(Session session)

							throws HibernateException, SQLException {

						Query query = session.createQuery("from Diary where user = '" + user.getId() + "'");

						query.setFirstResult(offset);

						query.setMaxResults(length);

						List<Diary> list = query.list();

						return list;

					}

				});

		return list;

	}

	public int classifyCount(User user, String classify) {
		// TODO Auto-generated method stub
		int count = 5;

		String hql = "from Diary where classify like '%" + classify + "%'";
		// "' and user = '" + user.getId() + "'";
		List<Diary> diaryList = find(hql);
		if (diaryList == null) {

			return count;
		} else {

			count = diaryList.size();

		}
		return count;
	}

	@Override
	public List<Diary> findById(int dId) {
		String hql = "from Diary where did = '" + dId + "'";
		List<Diary> diaryList = find(hql);

		if (diaryList.isEmpty())
			return null;
		return diaryList;
	}

	@Override
	public List<Diary> findByClassify(String type) {
		// TODO Auto-generated method stub
		String hql = "from Diary where classify = '" + type + "'";
		List<Diary> diaryList = find(hql);
		if (diaryList.isEmpty())
			return null;
		return diaryList;
	}

	@Override
	public List<Diary> seach(String seach) {
		// TODO Auto-generated method stub
		HttpSession session = ServletActionContext.getRequest().getSession();
		int id = ((User) session.getAttribute("user")).getId();
		String hql = "from Diary where content like '%" + seach + "%' or title like '%" + seach + "%'and user = '" + id
				+ "'";
		List<Diary> diaryList = find(hql);
		if (diaryList.isEmpty())
			return null;
		return diaryList;
	}

	@Override
	public boolean delete(int id) {
		boolean flag = true;
		Diary diary = get(Diary.class, id);
		List<Comment> commentList = find("from Comment where diary =" + id);
		List<Photo> photoList = find("from Photo where diary =" + id);
		List<DiaryLike> likeList = find("from DiaryLike where diary_id =" + id);
		for (int i = 0; i < commentList.size(); i++) {
			delete(commentList.get(i));
		}
		for (int i = 0; i < photoList.size(); i++) {
			delete(photoList.get(i));
		}
		for (int i = 0; i < likeList.size(); i++) {
			delete(likeList.get(i));
		}
		System.out.println("进来dao了" + "id=" + id);
		try {
			delete(diary);

		} catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}

		return flag;

	}

	@Override
	public List<Diary> LikenumSort() {
		// TODO Auto-generated method stub
		String hql = "from Diary order by likenum desc";

		Session session2 = getSession();
		Query query = session2.createQuery(hql);
		query.setMaxResults(8);
		return query.list();

	}

	@Override
	public List<Photo> findByDid(int id) {
		// TODO Auto-generated method stub
		String hql = "FROM Photo where diary = " + id;
		List<Photo> photoList = find(hql);
		System.out.println("长度是" + photoList.isEmpty());
		if (photoList.isEmpty())
			return null;
		else
			return photoList;

	}

	@Override
	public List<Photo> find(Diary diary) {
		String hql2 = "from Diary where title = '" + diary.getTitle() + "' and content = '" + diary.getContent()
				+ "' and classify = '" + diary.getClassify() + "'";
		List<Diary> list = find(hql2);

		// TODO Auto-generated method stub
		String hql = "FROM Photo where diary = " + list.get(0).getDid();
		List<Photo> photoList = find(hql);
		System.out.println("长度是" + photoList.isEmpty());
		if (photoList.isEmpty())
			return null;
		else
			return photoList;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryDAO#findCount(java.lang.String,
	 * java.lang.Object[])
	 */
	@Override
	public int findCount(String hql, Object[] patm) {
		List<Long> list = find(hql, patm);
		if (list != null && list.size() > 0) {
			return list.get(0).intValue();
		}
		return 0;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryDAO#findByPage(java.lang.String,
	 * java.lang.Object[], int, int)
	 */
	@Override
	public List<Diary> findByPage(String hql, Object[] patm, int begin, int limit) {
		List<Diary> list = execute(new PageHibernateCallback<Diary>(hql, patm, begin, limit));
		if (list != null && list.size() > 0) {
			return list;
		}
		return new ArrayList<>();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryDAO#getTopCity()
	 */
	@Override
	public List getTopCity() {
		String hql = "select count(*),city from Diary group by city order by count(*) desc";
		Session session2 = getSession();
		Query query = session2.createQuery(hql);
		query.setMaxResults(5);
		List list = query.list();
		return list;
	}

	@Override
	public List<Diary> findAll() {
		String hql = "from Diary";
		List<Diary> list = find(hql);
		return list;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.dao.DiaryDAO#findHql(java.lang.String,
	 * java.lang.Object[], int)
	 */
	@Override
	public List<Diary> findHql(String hql, Object[] patm, int maxResult) {
		List<Diary> list = find(hql, patm);
		if (list.size() > 5) {
			list = list.subList(0, maxResult);
		}
		return list;
	}
	public List<Integer> findByUidTOP8() {
		//sql语句为：SELECT * FROM USER  WHERE id IN ( SELECT COUNT(*) FROM diary GROUP BY Uid ORDER BY COUNT(*) DESC ) LIMIT 8
		String hql = "SELECT user.id FROM Diary GROUP BY user ORDER BY COUNT(*) DESC ";
		Session session2 = getSession();
		Query query = session2.createQuery(hql);
		query.setMaxResults(8);
		List list = query.list();
		System.out.println(list.size());
		return list;
	}

	public List<User> findByUser(List<Integer> uid) {
		// sql语句为：SELECT * FROM USER WHERE id IN ( SELECT COUNT(*) FROM diary GROUP BY
		// Uid ORDER BY COUNT(*) DESC ) LIMIT 8
		List<User> uList = new ArrayList<>();
		for (int i = 0; i < uid.size(); i++) {
			String hql = " FROM User  WHERE id =" + uid.get(i);
			List<User> uList1 = find(hql);
			
			uList.add(uList1.get(0));
		}

		return uList;
	}

}
