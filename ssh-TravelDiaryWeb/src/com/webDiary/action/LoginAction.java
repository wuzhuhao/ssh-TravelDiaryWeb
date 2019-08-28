package com.webDiary.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.opensymphony.xwork2.ActionSupport;
import com.webDiary.pojo.User;
import com.webDiary.service.LoginService;

public class LoginAction extends ActionSupport {
	private LoginService loginService;
	private User user;
	private String fileFileName;
	private String fileContentType;
	private File inputImage;// 动作类上传的属性必须是file类型,upload为表单的name值
	private String uploadFileName; // 上传的文件名称,固定写法:name+FileName;
	private boolean result;
	private String image;
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LoginService getLoginService() {
		return loginService;
	}

	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public void login() throws IOException {

		boolean flag = loginService.login(user.getId(), user.getPasswd());// 调用数据库查询方法，验证用户名、密码
		PrintWriter write;

		String data = JSON.toJSONString(flag);
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			write = ServletActionContext.getResponse().getWriter();
			write.write(data);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void register() throws IOException {
		loginService.register(user);// 调用数据库查询方法，插入个人资料
		HttpSession session = ServletActionContext.getRequest().getSession();
		int id = (Integer) session.getAttribute("user_id");
		System.out.println("id是" + id);
		PrintWriter write;
		String data = JSON.toJSONString(id);
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			write = ServletActionContext.getResponse().getWriter();
			write.write(data);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public String exit() {
		HttpSession session = ServletActionContext.getRequest().getSession();

		session.invalidate();
		return "Success";
	}

	public String fangKe() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.removeAttribute("user");
		return "Success";

	}

	public String findAll() {
		List<User> uList = loginService.findUser();
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("uList", uList);
		return "findAll";

	}

	public void delete() {
		boolean flag = loginService.delete(id);
		try {
			String data = JSON.toJSONString(flag);
			PrintWriter write;
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			write = ServletActionContext.getResponse().getWriter();
			write.write(data);
		} catch (Exception e) {
			System.out.println("有异常");
		}

	}

	public File getInputImage() {
		return inputImage;
	}

	public void setInputImage(File inputImage) {
		this.inputImage = inputImage;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

}