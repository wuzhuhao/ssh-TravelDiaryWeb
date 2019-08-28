package com.webDiary.service.impl;

import com.webDiary.dao.DPhotoDAO;
import com.webDiary.service.DPhotoService;

public class DPhotoServiceImpl implements DPhotoService {
	private DPhotoDAO dPhotoDAO;

	public DPhotoDAO getdPhotoDAO() {
		return dPhotoDAO;
	}

	public void setdPhotoDAO(DPhotoDAO dPhotoDAO) {
		this.dPhotoDAO = dPhotoDAO;
	}

}
