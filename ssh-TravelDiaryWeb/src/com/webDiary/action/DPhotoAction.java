package com.webDiary.action;

import com.webDiary.pojo.DPhoto;
import com.webDiary.service.DPhotoService;

public class DPhotoAction {

	private DPhotoService dPhotoService;
	private DPhoto dPhoto;

	public DPhotoService getdPhotoService() {
		return dPhotoService;
	}

	public void setdPhotoService(DPhotoService dPhotoService) {
		this.dPhotoService = dPhotoService;
	}

	public DPhoto getdPhoto() {
		return dPhoto;
	}

	public void setdPhoto(DPhoto dPhoto) {
		this.dPhoto = dPhoto;
	}
}
