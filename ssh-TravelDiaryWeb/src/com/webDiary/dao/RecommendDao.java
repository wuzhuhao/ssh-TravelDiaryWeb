/**
 * 
 */
package com.webDiary.dao;

import java.util.List;

import com.webDiary.pojo.Recommend;

/**
 * @author wuzhuhao
 *
 */
public interface RecommendDao {

	/**
	 * @param countHql
	 * @param patm
	 * @return
	 */
	int findCount(String countHql, Object[] patm);

	/**
	 * @param selectHql
	 * @param patm
	 * @param begin
	 * @param limit
	 * @return
	 */
	List<Recommend> findByPage(String selectHql, Object[] patm, int begin, int limit);

	/**
	 * @param id
	 * @return
	 */
	List<Recommend> findById(int id);

}
