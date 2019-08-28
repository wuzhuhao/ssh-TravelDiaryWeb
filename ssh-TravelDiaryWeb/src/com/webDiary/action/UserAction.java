package com.webDiary.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.webDiary.pojo.Diary;
import com.webDiary.pojo.User;
import com.webDiary.pojo.UserMessage;
import com.webDiary.service.DiaryService;
import com.webDiary.service.LoginService;
import com.webDiary.service.UserMessageService;
import com.webDiary.service.UserService;
import com.webDiary.util.PageBean;
import com.webDiary.util.ResultUtil;

public class UserAction extends ActionSupport {
	// 登陆服务层
	private LoginService loginService;
	// 用户实体类服务层
	private UserService userService;
	// 用户互动留言服务层
	private UserMessageService userMessageService;
	// 接收用户数据实体类
	private User user;
	private int id;
	private String userName, passwd, sex, email, individualResume;
	private String site;
	private boolean result;
	private String image;
	private int u_id;
	private DiaryService diaryService;
	// 页数
	private int page = 0;
	private UserMessage userMessage;
	// 页面偏差量
	private int addCount;

	public int getAddCount() {
		return addCount;
	}

	public void setAddCount(int addCount) {
		this.addCount = addCount;
	}

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

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIndividualResume() {
		return individualResume;
	}

	public void setIndividualResume(String individualResume) {
		this.individualResume = individualResume;
	}

	public String getSite() {
		return site;
	}

	public void setSite(String site) {
		this.site = site;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public DiaryService getDiaryService() {
		return diaryService;
	}

	public void setDiaryService(DiaryService diaryService) {
		this.diaryService = diaryService;
	}

	public int getU_id() {
		return u_id;
	}

	public void setU_id(int u_id) {
		this.u_id = u_id;
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
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

	public boolean isResult() {
		return result;
	}

	public void setResult(boolean result) {
		this.result = result;
	}

	public void login() throws IOException {
		boolean flag = userService.login(user.getUserName(), user.getPasswd());// 调用数据库查询方法，验证用户名、密码
		boolean flag1 = userService.isState(user.getUserName());
		String data;
		HashMap<String, String> map = new HashMap<String, String>();
		if ((flag && flag1)) {
			HttpSession session = ServletActionContext.getRequest().getSession();
			User user1 = userService.findUser(user.getUserName());
			session.setAttribute("user", user1);
			map.put("result", "success");
		}
		if (!flag) {
			map.put("result", "Error");
		}
		else if (!flag1) {
			map.put("result", "stateError");
		}
		data = JSON.toJSONString(map);
		ResultUtil.sendJson(data);
	}

	public void register() throws IOException {
		boolean flag = false;
		if (userService.nameIsExistence(user.getUserName())) {
			flag = false;
		} else {
			userService.register(user);// 调用数据库查询方法，插入个人资料
			HttpSession session = ServletActionContext.getRequest().getSession();
			int id = (Integer) session.getAttribute("user_id");
			System.out.println("id是" + id);
			flag = true;
		}
		String data = JSON.toJSONString(flag);
		ResultUtil.sendJson(data);

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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	/**
	 * 获取用户信息和用户的文章
	 * 
	 * @return
	 */
	public String findUserById() {
		System.out.println("findUserById()");
		HttpSession session = ServletActionContext.getRequest().getSession();
		if (session.getAttribute("user") == null || ((User) session.getAttribute("user")).getId() == 0) {
			System.out.println("炸了");
		} else {
			System.out.println(((User) session.getAttribute("user")).getId() + "哈哈哈");
		}
		// 分页封装
		PageBean<Diary> pageBean = findAllDiaryByUid();
		PageBean<UserMessage> userMessagePageBean = userMessageService.findUserMessageBySendeeId(1, u_id, 0);
		User user = userService.findUser(u_id);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("uid", u_id);
		userMessagePageBean.setParams(hm1);
		HashMap<String, Object> result = new HashMap<String, Object>();
//		session.setAttribute("userMessagePageBean", userMessagePageBean);
//		session.setAttribute("pageBean", pageBean);
//		session.setAttribute("hm", hm1);
//		session.setAttribute("user1", user);
		result.put("userMessagePageBean", userMessagePageBean);
		result.put("pageBean", pageBean);
		result.put("hm", hm1);
		result.put("user1", user);
		ResultUtil.sendDataForView(result);
		// 清零
		page = 0;
		return "Success";
	}

	/**
	 * 获取用户留言并且返回json值
	 * 
	 * @return
	 */
	public void findUserMessageByUidToJson() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		page = page == 0 ? 1 : page;
		PageBean<UserMessage> userMessagePageBean = userMessageService.findUserMessageBySendeeId(page, u_id, addCount);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		if (session.getAttribute("user") == null || ((User) session.getAttribute("user")).getId() == 0) {
			hm1.put("loginUid", 0);
		} else {
			hm1.put("loginUid", ((User) session.getAttribute("user")).getId());
		}
		hm1.put("uid", u_id);
		hm1.put("list", userMessagePageBean.getList());
		hm1.put("page", userMessagePageBean.getPage());
		hm1.put("talPage", userMessagePageBean.getTotalPage());
		String data1 = JSON.toJSONString(hm1, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(data1);
		page = 0;
	}

	/**
	 * 获取分页JSON数据
	 * 
	 * @throws IOException
	 */
	public void findAllDiaryByUidToJson() throws IOException {
		HttpSession session = ServletActionContext.getRequest().getSession();
		System.out.println("进来findAllDiaryByUidToJson()了");
		PageBean<Diary> pageBean = findAllDiaryByUid();
		List<Diary> diaryList = pageBean.getList();
		session.setAttribute("diaryList", diaryList);
		session.setAttribute("page", getPage());
		for (Diary sss : diaryList) {
			System.out.println(sss.getUser().getUserName());
		}
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("uid", u_id);
		hm1.put("list", pageBean.getList());
		hm1.put("page", pageBean.getPage());
		hm1.put("talPage", pageBean.getTotalPage());
		String data1 = JSON.toJSONString(hm1, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(data1);
		page = 0;
	}

	public PageBean<Diary> findAllDiaryByUid() {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put(" user.id = ", u_id);
		page = (page == 0) ? 1 : page;
		PageBean<Diary> pageBean = null;
		pageBean = diaryService.findByPage(page, hm);
		pageBean.setParams(null);
		return pageBean;
	}

	public String userInfo() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		user = (User) session.getAttribute("user");
		user = userService.findUser(user.getId());
		return "userInfoSuccess";
	}

	public void update() {
		boolean flag = false;
		HttpSession session = ServletActionContext.getRequest().getSession();
		int id1 = ((User) (session.getAttribute("user"))).getId();
		String uName = ((User) (session.getAttribute("user"))).getUserName();
		System.out.println(id1);
		if (user.getUserName().equals(uName) || (!userService.nameIsExistence(user.getUserName()))) {
			user.setId(id1);
			flag = userService.updateUser(user);// 调用数据库更新方法
		}
		if (flag) {
			user = userService.findUser(user.getId());
			session.setAttribute("user", user);
		}
		String data1 = JSON.toJSONString(flag);
		ResultUtil.sendJson(data1);
	}

	public String image() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		String savePath = ServletActionContext.getServletContext().getRealPath("/head");
		System.out.println(savePath);
		savePath = savePath.replace("\\", "\\\\");
		File file = new File(savePath);
		// 判断上传文件的保存目录是否存在
		if (!file.exists()) {
			// 目录不存在需要创建目录
			file.mkdir();
		}
		try {
			// 使用apache文件上传组件处理文件上传步骤
			// 1、创建一个DiskFileItemFactory工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 2、创建一个文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 解决上传文件名的中文乱码
			upload.setHeaderEncoding("UTF-8");
			// 3、判断前端form表单是否为enctype="multipart/form-data"属性
			boolean isF = ServletFileUpload.isMultipartContent(request);
			// 如果前端传过来的是表单是enctype="multipart/form-data"属性
			if (isF) {
				// 4、使用ServletFileUpload解析器上传数据，解析结果返回的是一个List<FileItem>集合
				// 每一个FileItem对应一个Form表单的输入项
				List<FileItem> list = upload.parseRequest(request);
				String filename = "";
				for (FileItem item : list) {
					if (!item.isFormField()) {
						filename = item.getName();
						if (filename == null || filename.trim().equals("")) {
							continue;
						}
						filename = filename.substring(filename.lastIndexOf(".") + 1);
						// 给文件重新取一个名字UUID
						// filename = UUID.randomUUID().toString() + "." +
						// filename;
						filename = user.getId() + "." + filename;
						System.out.println("上传图片名称" + filename);
						// 获取item中的上传文件的输入流
						InputStream in = item.getInputStream();
						// 创建一个文件输出流
						FileOutputStream out = new FileOutputStream(savePath + "\\" + filename);
						// 创建一个缓冲区
						byte[] buffer = new byte[1024];
						// 判断输入流中的数据是否已经读完的标识
						int len = 0;
						// 循环将输入流读入到缓冲区当中，
						while ((len = in.read(buffer)) > 0) {
							// 使用FileOutputStream输入流将缓冲区的数据写入到指定的目录(savePath +
							// "\\"
							// +filename)
							out.write(buffer, 0, len);
						}

						// 关闭流
						in.close();
						out.close();
						// 删除处理文件上传时生成的临时文件
						item.delete();
					} else {

					}
				}
				userService.image("head/" + filename);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "image";
	}

	public void delete() {
		String data1 = JSON.toJSONString(true);
		ResultUtil.sendJson(data1);
	}

	/**
	 * 注册检查用户名
	 */
	public void checkName() {
		String data1 = JSON.toJSONString(userService.nameIsExistence(user.getUserName()));
		ResultUtil.sendJson(data1);
	}

	/**
	 * 修改信息检查用户名
	 */
	public void checkNameByLogined() {
		boolean flag = false;
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		if (user.getUserName().equals(((User) session.getAttribute("user")).getUserName())) {
			flag = false;
		} else {
			flag = userService.nameIsExistence(user.getUserName());
		}
		String data1 = JSON.toJSONString(flag);
		ResultUtil.sendJson(data1);
	}

	public void enable() {
		String data1 = JSON.toJSONString(userService.enableOrdiscontinuation(user.getId(), 1));
		ResultUtil.sendJson(data1);
	}

	public void discontinuation() {
		String data1 = JSON.toJSONString(userService.enableOrdiscontinuation(user.getId(), 2));
		ResultUtil.sendJson(data1);
	}

	/**
	 * 删除用户留言
	 */
	public void delUserMessage() {
		String data1 = JSON.toJSONString(userMessageService.delUserMessage(userMessage.getId()));
		ResultUtil.sendJson(data1);
	}

	/**
	 * 回复用户留言
	 * 
	 */
	public void replyUserMessage() {
		String data1 = JSON
				.toJSONString(userMessageService.replyUserMessage(userMessage.getId(), userMessage.getReplyContent()));
		ResultUtil.sendJson(data1);
	}

	/**
	 * 增加用户留言
	 * 
	 */
	public void addUserMessage() {
		// 解耦合获取session
		Map session = ActionContext.getContext().getSession();
		User sessionUser = (User) session.get("user");
		userMessage.setSendee(userService.findUser(userMessage.getSendee().getId()));
		userMessage.setSender(sessionUser);
		String data1 = JSON.toJSONString(userMessageService.addUserMessage(userMessage));
		ResultUtil.sendJson(data1);
	}

	/**
	 * 获取所有的userMessage
	 * 
	 * @return
	 */
	public String findAllUserMessage() {
		List<UserMessage> userMessage = userMessageService.findAllUserMessage();
		Map session = ActionContext.getContext().getSession();
		session.put("userMessageList", userMessage);
		return "success";
	}


}