/**
 * 
 */
package com.webDiary.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.webDiary.dao.DiaryDAO;
import com.webDiary.dao.UserMessageDao;
import com.webDiary.pojo.User;
import com.webDiary.pojo.UserMessage;
import com.webDiary.service.UserMessageService;
import com.webDiary.util.PageBean;

/**
 * @author wuzhuhao
 *
 */
public class UserMessageServiceImpl implements UserMessageService {
	UserMessageDao userMessageDao;
	DiaryDAO diaryDao;

	public DiaryDAO getDiaryDao() {
		return diaryDao;
	}

	public void setDiaryDao(DiaryDAO diaryDao) {
		this.diaryDao = diaryDao;
	}

	public UserMessageDao getUserMessageDao() {
		return userMessageDao;
	}

	public void setUserMessageDao(UserMessageDao userMessageDao) {
		this.userMessageDao = userMessageDao;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.webDiary.service.UserMessageService#findUserMessageBySendeeId(int,
	 * int)
	 */
	@Override
	public PageBean<UserMessage> findUserMessageBySendeeId(int page, int sendeeId, int addCount) {
		PageBean<UserMessage> pageBean = new PageBean<UserMessage>();
		Object[] patm = new Object[1];
		int h = 0;
		patm[h] = sendeeId;
		String whereName = "where sendee.id = ?";
		// 设置参数:
		pageBean.setPage(page);
		// 设置每页显示记录数:
		int limit = 3;
		pageBean.setLimit(limit);
		// 设置总记录数:
		String countHql = "select count(*) from UserMessage " + whereName;
		int totalCount = diaryDao.findCount(countHql, patm);
		System.out.println("总数：" + totalCount);
		pageBean.setTotalCount(totalCount);
		// 设置总页数:
		int totalPage = 0;
		if (totalCount % limit == 0) {
			totalPage = totalCount / limit;
		} else {
			totalPage = totalCount / limit + 1;
		}
		pageBean.setTotalPage(totalPage);
		// 设置页面显示数据的集合:
		int begin = (page - 1) * limit + addCount;
		String selectHql = "from UserMessage " + whereName + " order by id DESC";
		List<UserMessage> list = userMessageDao.findByPage(selectHql, patm, begin, limit);
		pageBean.setList(list);
		return pageBean;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserMessageService#delUserMessage(int)
	 */
	@Override
	public boolean delUserMessage(int id) {
		boolean falg = false;
		if (userMessageDao.delUserMessage(id) == 1) {
			falg = true;
		}
		return falg;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserMessageService#replyUserMessage(int,
	 * java.lang.String)
	 */
	@Override
	public boolean replyUserMessage(int id, String replyContent) {
		boolean falg = false;
		if (userMessageDao.replyUserMessage(id, replyContent) == 1) {
			falg = true;
		}
		return falg;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.webDiary.service.UserMessageService#addUserMessage(com.webDiary.pojo.
	 * UserMessage)
	 */
	@Override
	public UserMessage addUserMessage(UserMessage userMessage) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		userMessage.setSendTime(df.format(new Date()) + "");
		if (userMessage.getSendee().getId() == userMessage.getSender().getId()) {
			return null;
		}
		return userMessageDao.addUserMessage(userMessage);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.webDiary.service.UserMessageService#findAllUserMessage()
	 */
	@Override
	public List<UserMessage> findAllUserMessage() {
		return userMessageDao.findHql("from UserMessage", null);
	}
	@Override
	public List<User> Contribution() {
		// TODO Auto-generated method stub
		List<Integer> uid = userMessageDao.findByUidTOP8();
		return userMessageDao.findByUser(uid);
	}

}
