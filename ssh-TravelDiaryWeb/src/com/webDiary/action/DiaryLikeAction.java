/**
 * 
 */
package com.webDiary.action;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.webDiary.pojo.DiaryLike;
import com.webDiary.pojo.User;
import com.webDiary.service.DiaryLikeService;
import com.webDiary.util.ResultUtil;

/**
 * @author wuzhuhao
 *
 */
public class DiaryLikeAction extends ActionSupport implements ModelDriven<DiaryLike> {
	DiaryLikeService diaryLikeService;
	DiaryLike diaryLike;

	public DiaryLikeService getDiaryLikeService() {
		return diaryLikeService;
	}

	public void setDiaryLikeService(DiaryLikeService diaryLikeService) {
		this.diaryLikeService = diaryLikeService;
	}

	public void addLike() {
		boolean flag = false;
		if (diaryLike.getDiary_id() != 0 && diaryLike.getUser_id() != 0) {
			diaryLikeService.addLike(diaryLike.getDiary_id(), diaryLike.getUser_id());
		}
		if (diaryLikeService.isLike(diaryLike.getDiary_id(), diaryLike.getUser_id())) {
			flag = true;
		}
		int num = diaryLikeService.findLikeCount(diaryLike.getDiary_id());
		Map<String, Object> hm = new HashMap<String, Object>();
		User loginUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
		if (loginUser == null || loginUser.getId() == 0) {
			hm.put("tip", "暂未登陆，无法点赞！");
		}
		hm.put("rs", flag);
		hm.put("num", num);
		if (!flag) {
			hm.put("d_id", diaryLike.getDiary_id());
			hm.put("u_id", diaryLike.getUser_id());
		}
		String data = JSON.toJSONString(hm);
		ResultUtil.sendJson(data);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.opensymphony.xwork2.ModelDriven#getModel()
	 */
	@Override
	public DiaryLike getModel() {
		if (diaryLike == null) {
			diaryLike = new DiaryLike();
		}
		return diaryLike;
	}
}
