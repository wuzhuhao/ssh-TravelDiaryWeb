/**
 * 
 */
package com.webDiary.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.webDiary.pojo.User;
import com.webDiary.pojo.UserMessage;
import com.webDiary.service.UserMessageService;
import com.webDiary.util.ResultUtil;

/**
 * @author wuzhuhao
 *
 */
public class UserMessageAction extends ActionSupport {
	UserMessage userMessage;
	UserMessageService userMessageService;

	public UserMessage getUserMessage() {
		return userMessage;
	}

	public void setUserMessage(UserMessage userMessage) {
		this.userMessage = userMessage;
	}

	public UserMessageService getUserMessageService() {
		return userMessageService;
	}

	public void setUserMessageService(UserMessageService userMessageService) {
		this.userMessageService = userMessageService;
	}
	

	public String findAll() {
		List<UserMessage> userMessage = userMessageService.findAllUserMessage();
		Map session = ActionContext.getContext().getSession();
		session.put("userMessageList", userMessage);
		return "findAll";
	}
	/**
	 * 删除用户留言
	 */
	public void deleteById() {
		String data1 = JSON.toJSONString(userMessageService.delUserMessage(userMessage.getId()));
		System.out.println(12);
		ResultUtil.sendJson(data1);
	}
public String Contribution() {
		
		HttpSession session = ServletActionContext.getRequest().getSession();
		List<User> contribution = userMessageService.Contribution();
		String text = "人气";
		session.setAttribute("text",text );
		session.setAttribute("contribution", contribution);
		
		return "contribution";
	}
}
