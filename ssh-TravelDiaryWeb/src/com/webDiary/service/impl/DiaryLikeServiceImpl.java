/**
 * 
 */
package com.webDiary.service.impl;

import java.util.List;

import com.webDiary.dao.DiaryLikeDao;
import com.webDiary.pojo.DiaryLike;
import com.webDiary.service.DiaryLikeService;

/**
 * @author wuzhuhao
 *
 */
public class DiaryLikeServiceImpl implements DiaryLikeService {
	DiaryLikeDao diaryLikeDao;

	public DiaryLikeDao getDiaryLikeDao() {
		return diaryLikeDao;
	}

	public void setDiaryLikeDao(DiaryLikeDao diaryLikeDao) {
		this.diaryLikeDao = diaryLikeDao;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryLikeService#addLike(int, int)
	 */
	@Override
	public boolean addLike(int d_id, int u_id) {
		DiaryLike diaryLike = new DiaryLike(d_id, u_id);
		return diaryLikeDao.addLike(diaryLike);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryLikeService#delLike(int, int)
	 */
	@Override
	public boolean delLike(int d_id, int u_id) {
		DiaryLike diaryLike = new DiaryLike(d_id, u_id);
		return diaryLikeDao.delLike(diaryLike);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryLikeService#delLikeToDid(int)
	 */
	@Override
	public boolean delLikeToDid(int d_id) {
		// TODO Auto-generated method stub
		return diaryLikeDao.delLikeToDid(d_id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryLikeService#findLikeCount(int)
	 */
	@Override
	public int findLikeCount(int d_id) {
		// TODO Auto-generated method stub
		return diaryLikeDao.findLikeCount(d_id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryLikeService#isLike(int, int)
	 */
	@Override
	public boolean isLike(int d_id, int u_id) {
		// TODO Auto-generated method stub
		return diaryLikeDao.isLike(d_id, u_id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryLikeService#findForD_id(int)
	 */
	@Override
	public List<DiaryLike> findForD_id(int d_id) {
		// TODO Auto-generated method stub
		return diaryLikeDao.findForD_id(d_id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.DiaryLikeService#findLikeTopFive()
	 */
	@Override
	public List<Integer> findLikeTopFive() {
		// TODO Auto-generated method stub
		return diaryLikeDao.findLikeTopFive();
	}

	// DiaryLike diaryLike
	
	
	
}
