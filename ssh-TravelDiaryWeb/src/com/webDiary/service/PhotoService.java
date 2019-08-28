package com.webDiary.service;

import java.util.List;

import com.webDiary.pojo.Photo;

public interface PhotoService {

	public boolean insert(int id);

	public List<Photo> findByDid(int id);

	public boolean delete(int id);
	public boolean delete2(int id);

}
