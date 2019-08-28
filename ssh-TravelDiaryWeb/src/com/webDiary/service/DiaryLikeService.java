/**
 * 
 */
package com.webDiary.service;

import java.util.List;

import com.webDiary.pojo.DiaryLike;

/**
 * @author wuzhuhao
 *
 */
public interface DiaryLikeService {
	/**
	 * 添加赞
	 * 
	 * @param diaryLike
	 *            赞实体类
	 * 
	 * @return 结果
	 */
	public boolean addLike(int d_id, int u_id);

	/**
	 * 删除赞
	 * 
	 * @param diaryLike
	 *            赞实体类
	 * @return 结果
	 */
	public boolean delLike(int d_id, int u_id);

	/**
	 * 根据文章id删除点赞
	 * 
	 * @param d_id
	 *            文章id
	 * @return 结果
	 */
	public boolean delLikeToDid(int d_id);

	/**
	 * 获取文章点赞数量
	 * 
	 * @param d_id
	 *            文章id
	 * @return 文章数量
	 */
	public int findLikeCount(int d_id);

	/**
	 * 用户是否点赞文章
	 * 
	 * @param d_id
	 *            文章id
	 * @param u_id
	 *            用户id
	 * @return 结果
	 */
	public boolean isLike(int d_id, int u_id);

	/**
	 * 查找文章的全部点赞
	 * 
	 * @param d_id
	 *            文章id
	 * @return List<DiaryLike>
	 */
	public List<DiaryLike> findForD_id(int d_id);

	/**
	 * 获取点赞前五的文章id
	 * 
	 * @return
	 */
	public List<Integer> findLikeTopFive();
	
	
}
