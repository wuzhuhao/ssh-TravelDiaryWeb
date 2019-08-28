package com.webDiary.dao.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.webDiary.dao.PhotoDAO;
import com.webDiary.pojo.Admin;
import com.webDiary.pojo.Diary;
import com.webDiary.pojo.Photo;

public class PhotoDAOImpl extends HibernateTemplate implements PhotoDAO {

	@Override
	public boolean insert(int id) {
		// TODO Auto-generated method stub
		HttpSession session = ServletActionContext.getRequest().getSession();
		List<Photo> photoList = (List<Photo>) session.getAttribute("photoList");
		try {

			if (photoList.isEmpty())
				return false;
			else {
				for (Photo photo : photoList) {
					List<Diary> list = find("from Diary where did = " + id);
					photo.setDiary(list.get(0));
					save(photo);
				}

			}
			return true;
		} catch (Exception e) {
			System.out.println("有异常");
			return false;
		}

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
	public boolean delete(int id) {
	
		List<Photo> pList = find("from Photo where diary =  " + id);
		try {
			delete(pList.get(0));

		} catch (Exception e) {
			return false;
		}
		return true;
	}





@Override
public boolean delete2(int id) {

	List<Photo> pList = find("from Photo where id =  " + id);
	try {
		delete(pList.get(0));

	} catch (Exception e) {
		return false;
	}
	return true;
}

}
