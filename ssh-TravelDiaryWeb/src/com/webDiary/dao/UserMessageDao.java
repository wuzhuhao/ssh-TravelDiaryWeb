/**
 * 
 */
package com.webDiary.dao;

import java.util.List;

import com.webDiary.pojo.User;
import com.webDiary.pojo.UserMessage;

/**
 * @author wuzhuhao
 *
 */
public interface UserMessageDao {

	/**
	 * @param selectHql
	 * @param patm
	 * @param begin
	 * @param limit
	 * @return
	 */
	List<UserMessage> findByPage(String selectHql, Object[] patm, int begin, int limit);

	/**
	 * @param id
	 * @return
	 */
	int delUserMessage(int id);

	/**
	 * dao层 回复留言
	 * 
	 * @param id
	 * @param replyContent
	 * @return
	 */
	int replyUserMessage(int id, String replyContent);

	/**
	 * dao层 查找userMessage用id
	 * 
	 * @param id
	 * @param replyContent
	 * @return
	 */
	UserMessage findUserMessage(int id);

	/**
	 * dao层 增加用户留言
	 * 
	 * @param userMessage
	 * @return
	 */
	UserMessage addUserMessage(UserMessage userMessage);

	/**
	 * 进行hql查询
	 * 
	 * @param hql
	 * @param patm
	 * @return
	 */
	List<UserMessage> findHql(String hql, Object[] patm);

	List<Integer> findByUidTOP8();

	List<User> findByUser(List<Integer> uid);

}
