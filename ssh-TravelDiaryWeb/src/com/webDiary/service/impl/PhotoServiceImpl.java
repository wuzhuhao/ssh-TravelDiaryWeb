package com.webDiary.service.impl;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.webDiary.dao.PhotoDAO;
import com.webDiary.pojo.Photo;
import com.webDiary.service.PhotoService;

public class PhotoServiceImpl implements PhotoService {

	private PhotoDAO photoDAO;

	public PhotoDAO getPhotoDAO() {
		return photoDAO;
	}

	public void setPhotoDAO(PhotoDAO photoDAO) {
		this.photoDAO = photoDAO;
	}

	@Override
	public boolean insert(int id) {

		return photoDAO.insert(id);
	}

	@Override
	public List<Photo> findByDid(int id) {
		// TODO Auto-generated method stub
		return photoDAO.findByDid(id);
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return photoDAO.delete(id);
	}
	@Override
	public boolean delete2(int id) {
		// TODO Auto-generated method stub
		return photoDAO.delete2(id);
	}

}
