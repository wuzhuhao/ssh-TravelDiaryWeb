package com.webDiary.util;

import java.io.PrintWriter;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

public class ResultUtil {

	public static Result success(String[] images) {
		Result result = new Result();
		result.setErrno(0);
		result.setData(images);
		return result;
	}

	public static Result success() {
		return success(null);
	}

	public static void sendJson(String data) {
		try {
			PrintWriter write;
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			write = ServletActionContext.getResponse().getWriter();
			write.write(data);
		} catch (Exception e) {
			System.out.println("有异常");
		}
	}
	
	public static void sendDataForView(Map<String, Object> data) {
		Set<String> keys = data.keySet();
		for(String key:keys) {
			ActionContext.getContext().getValueStack().set(key, data.get(key));
		}
	}
	
	public static void sendDataForSession(Map<String, Object> data) {
		//解耦合获取session
		Map session = ActionContext.getContext().getSession();
		session.putAll(data);
	}
}
