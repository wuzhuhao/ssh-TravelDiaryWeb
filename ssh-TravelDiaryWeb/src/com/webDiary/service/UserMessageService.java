/**
 * 
 */
package com.webDiary.service;

import java.util.List;

import com.webDiary.pojo.User;
import com.webDiary.pojo.UserMessage;
import com.webDiary.util.PageBean;

/**
 * @author wuzhuhao
 *
 */
public interface UserMessageService {
	PageBean<UserMessage> findUserMessageBySendeeId(int page, int sendeeId, int addCount);

	/**
	 * 删除用户留言
	 * 
	 * @param id
	 * @return
	 */
	boolean delUserMessage(int id);

	/**
	 * 回复留言
	 * 
	 * @param id
	 * @return
	 */
	boolean replyUserMessage(int id, String replyContent);

	/**
	 * 增加userMessage
	 * 
	 * @param userMessage
	 * @return
	 */
	UserMessage addUserMessage(UserMessage userMessage);

	/**
	 * 获取所有的用户留言
	 * 
	 * @return
	 */
	List<UserMessage> findAllUserMessage();

	List<User> Contribution();
}
