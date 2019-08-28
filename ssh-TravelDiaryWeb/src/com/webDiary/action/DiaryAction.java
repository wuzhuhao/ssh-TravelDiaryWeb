package com.webDiary.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.webDiary.pojo.Comment;
import com.webDiary.pojo.Diary;
import com.webDiary.pojo.Photo;
import com.webDiary.pojo.User;
import com.webDiary.service.CommentService;
import com.webDiary.service.DiaryLikeService;
import com.webDiary.service.DiaryService;
import com.webDiary.util.PageBean;
import com.webDiary.util.ResultUtil;

public class DiaryAction extends ActionSupport {
	private DiaryService diaryService;
	private DiaryLikeService diaryLikeService;
	private Diary diary = new Diary();
	private File file;
	private String fileFileName;
	private String fileContentType;
	private File upload;// 动作类上传的属性必须是file类型,upload为表单的name值
	private String uploadFileName; // 上传的文件名称,固定写法:name+FileName;
	private final int length = 5;
	private int page = 0;
	private int nextpage;
	private String type;
	private int shengHuo;
	private int lvTu;
	private int youQing;
	private int xueLang;
	private int qingXU;
	private int xiaoYuan;
	private int id;
	private String seach;
	private String countryRegion;
	private CommentService commentService;
	// 判断查询类型，0是查询条件，1是查询地址;2是类别查询
	private int type__;
	private int index = 0;// 0是主页，时间排序;1是推荐游记，点赞排序;
	private String destinationName;

	public String getDestinationName() {
		return destinationName;
	}

	public void setDestinationName(String destinationName) {
		this.destinationName = destinationName;
	}

	public String getCountryRegion() {
		return countryRegion;
	}

	public void setCountryRegion(String countryRegion) {
		this.countryRegion = countryRegion;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getType__() {
		return type__;
	}

	public void setType__(int type__) {
		this.type__ = type__;
	}

	public DiaryLikeService getDiaryLikeService() {
		return diaryLikeService;
	}

	public void setDiaryLikeService(DiaryLikeService diaryLikeService) {
		this.diaryLikeService = diaryLikeService;
	}

	public CommentService getCommentService() {
		return commentService;
	}

	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}

	public String getSeach() {
		return seach;
	}

	public void setSeach(String seach) {
		this.seach = seach;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getShengHuo() {
		return shengHuo;
	}

	public void setShengHuo(int shengHuo) {
		this.shengHuo = shengHuo;
	}

	public int getYouQing() {
		return youQing;
	}

	public void setYouQing(int youQing) {
		this.youQing = youQing;
	}

	public int getXueLang() {
		return xueLang;
	}

	public void setXueLang(int xueLang) {
		this.xueLang = xueLang;
	}

	public int getQingXU() {
		return qingXU;
	}

	public void setQingXU(int qingXU) {
		this.qingXU = qingXU;
	}

	public int getXiaoYuan() {
		return xiaoYuan;
	}

	public void setXiaoYuan(int xiaoYuan) {
		this.xiaoYuan = xiaoYuan;
	}

	public int getLength() {
		return length;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
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

	public DiaryService getDiaryService() {
		return diaryService;

	}

	public void setDiaryService(DiaryService diaryService) {
		this.diaryService = diaryService;
	}

	public Diary getDiary() {
		return diary;
	}

	public void setDiary(Diary diary) {
		diary.getdTime();
	}

	public String insert() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String classify_list = "";
		String image = "";
		String savePath = ServletActionContext.getServletContext().getRealPath("/upload");
		System.out.println(savePath);
		savePath = savePath.replace("\\", "\\\\");
		File file = new File(savePath);
		List<Photo> photoList1 = new ArrayList<>();
		// 判断上传文件的保存目录是否存在
		if (!file.exists()) {
			// 目录不存在需要创建目录
			file.mkdir();
		}
		try {
			DiskFileItemFactory factroy = new DiskFileItemFactory();
			// 创建文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factroy);
			// 解决上传文件名的中文乱码
			upload.setHeaderEncoding("UTF-8");
			// 判断前端form表单是否为enctype="multipart/form-data"属性
			boolean isF = ServletFileUpload.isMultipartContent(request);
			// 如果前端传过来的是表单是enctype="multipart/form-data"属性
			if (isF) {
				// 使用解析器解析上传的表单数据，每个FileItem对应一个表单项
				List<FileItem> fileItemList = upload.parseRequest(request);
				for (FileItem fileItem : fileItemList) {
					if (!fileItem.isFormField()) {
						// Photo photo = new Photo();
						// // 不是普通的表单项，即是上传的是文件
						// // 获取文件名称
						// String filename = fileItem.getName();
						//
						// if (filename == null || filename.trim().equals("")) {
						// continue;
						// }
						// filename =
						// filename.substring(filename.lastIndexOf(".") + 1);
						// // 给文件重新取一个名字UUID
						// filename = UUID.randomUUID().toString() + "." +
						// filename;
						// System.out.println(filename + "8888");
						// // 获取item中的上传文件的输入流
						// InputStream in = fileItem.getInputStream();
						// // 创建一个文件输出流
						// FileOutputStream out = new FileOutputStream(savePath
						// + "\\" + filename);
						// // 创建一个缓冲区
						// byte[] buffer = new byte[1024];
						// // 判断输入流中的数据是否已经读完的标识
						// int len = 0;
						// // 循环将输入流读入到缓冲区当中，
						// while ((len = in.read(buffer)) > 0) {
						// // 使用FileOutputStream输入流将缓冲区的数据写入到指定的目录(savePath +
						// // "\\"
						// // +filename)
						// out.write(buffer, 0, len);
						// }
						// photo.setImage("upload/" + filename);
						// photoList1.add(photo);
						// // session.setAttribute("photoList1", photoList1);
						// // 这三句代码之及其重要的，就是为了返回JSON数据做准备的
						// String[] str = { request.getContextPath() +
						// "/upload/" + filename };
						// com.webDiary.util.Result result =
						// ResultUtil.success(str);
						// ResultUtil.sendJson(JSON.toJSONString(result));//
						// 返回url地址
						// /* System.out.println(photoList1.size()); */
						//
						// // 关闭流
						// in.close();
						// out.close();
						// // 删除处理文件上传时生成的临时文件
						// fileItem.delete();
					} else {
						if (fileItem.getFieldName().equals("diary.title"))
							diary.setTitle(fileItem.getString("UTF-8"));
						if (fileItem.getFieldName().equals("diary.classify")) {
							classify_list += fileItem.getString("UTF-8") + "-";
						}
						if (fileItem.getFieldName().equals("diary.content"))
							diary.setContent(fileItem.getString("UTF-8"));
						if (fileItem.getFieldName().equals("diary.content2"))
							diary.setContent2(fileItem.getString("UTF-8"));
						if (fileItem.getFieldName().equals("diary.province"))
							diary.setProvince(fileItem.getString("UTF-8"));
						if (fileItem.getFieldName().equals("diary.city"))
							diary.setCity(fileItem.getString("UTF-8"));
						if (fileItem.getFieldName().equals("image1"))
							image = fileItem.getString("UTF-8");
						if (fileItem.getFieldName().equals("diary.countryRegion"))
							diary.setCountryRegion(fileItem.getString("UTF-8"));
						if (fileItem.getFieldName().equals("diary.monthTime")) {
							try {
								diary.setMonthTime(Integer.parseInt(fileItem.getString("UTF-8")));
							} catch (Exception e) {
								e.printStackTrace();
								return "fail";
							}
						}
						if (fileItem.getFieldName().equals("diary.totalTime")) {
							try {
								diary.setTotalTime(Integer.parseInt(fileItem.getString("UTF-8")));
							} catch (Exception e) {
								e.printStackTrace();
								return "fail";
							}
						}
						if (fileItem.getFieldName().equals("diary.keyLandscape"))
							diary.setKeyLandscape(fileItem.getString("UTF-8"));

						if (image == null || image.length() == 0) {
							if (session.getAttribute("photoList1") != null) {
								image = ((List<Photo>) session.getAttribute("photoList1")).get(0).getImage();
							}
						}
						diary.setImage(image);
					}

				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 裁剪类别字符
		diary.setClassify(classify_list.substring(0, classify_list.length() - 1));
		// 设置用户
		diary.setUser(((User) session.getAttribute("user")));
		// 把内容传入页面参数
		session.setAttribute("info", diary);
		if (diaryService.insert(diary)) {
			List<Photo> photoList = diaryService.find(diary);
			// 把照片内容传入页面参数
			session.setAttribute("photoList", photoList);

		}
		id = diary.getDid();
		info();
		return "Success";

	}

	public void insert1() throws IOException {
		HttpSession session = ServletActionContext.getRequest().getSession();

		String path = ServletActionContext.getServletContext().getRealPath("/diaryImage");

		System.out.println(path);
		// 判断路径名是否存在，不存在则创建 mkdir
		File file = new File(path);
		if (!file.exists()) {
			file.mkdir();
		}
		// 将页面传过来的数据通过FileUtils 拷贝到我们刚刚定义的路径下
		FileUtils.copyFile(upload, new File(file, uploadFileName));
		String file2 = new File(file, uploadFileName).toString();
		session.setAttribute("image", ("diaryImage\\" + uploadFileName));
		String data = JSON.toJSONString("1");
		ResultUtil.sendJson(data);

	}

	public String preview() throws IOException {
		HttpSession session = ServletActionContext.getRequest().getSession();
		if (session.getAttribute("user") == null)
			return "Fail";
		if (upload == null) {
			diary.setImage("diaryImage\\" + "wutu.png");
			session.setAttribute("info", diary);
			return "Success";
		}
		String path = ServletActionContext.getServletContext().getRealPath("/diaryImage");
		// 判断路径名是否存在，不存在则创建 mkdir
		File file = new File(path);
		if (!file.exists()) {
			file.mkdir();
		}
		// 将页面传过来的数据通过FileUtils 拷贝到我们刚刚定义的路径下
		FileUtils.copyFile(upload, new File(file, uploadFileName));

		String file2 = new File(file, uploadFileName).toString();
		diary.setImage("diaryImage\\" + uploadFileName);
		session.setAttribute("info", diary);
		return "Success";
	}

	/**
	 * 原本用来区分点赞排行和正常排行分页的函数
	 * 
	 * @param hm
	 * @return
	 */
	public PageBean<Diary> findAllDiary(HashMap<String, Object> hm) {
		page = (page == 0) ? 1 : page;
		PageBean<Diary> pageBean = null;
		if (index == 0) {
			pageBean = diaryService.findByPage(page, hm);
		} else {
			pageBean = diaryService.findAllForLikeSort(page, hm);
		}
		pageBean.setParams(null);
		return pageBean;
	}

	public void initIndex() {
		// 获取前五的城市，并且存到session里面
		List<Object>[] citys_result = diaryService.getTopCity();
		List<Object> citys = citys_result[0];
		List<Object> citys_counts = citys_result[1];
		ActionContext.getContext().getValueStack().set("citys", citys);
		ActionContext.getContext().getValueStack().set("citys_counts", citys_counts);
		// 标签云数据初始化
		int zijiayou = diaryService.classifyCount(null, "自驾游");
		int haibianyou = diaryService.classifyCount(null, "海边游");
		int chujingyou = diaryService.classifyCount(null, "出境游");
		int gentuanyou = diaryService.classifyCount(null, "跟团游");
		int ziyouxing = diaryService.classifyCount(null, "自由行");
		int qiongyou = diaryService.classifyCount(null, "穷游");
		int sum = zijiayou + haibianyou + chujingyou + gentuanyou + ziyouxing + qiongyou;
		int zijiayou2 = zijiayou * 90 / sum;
		int haibianyou2 = haibianyou * 90 / sum;
		int chujingyou2 = chujingyou * 90 / sum;
		int gentuanyou2 = gentuanyou * 90 / sum;
		int ziyouxing2 = ziyouxing * 90 / sum;
		int qiongyou2 = qiongyou * 90 / sum;
		// 标签云数据
		ActionContext.getContext().getValueStack().set("zijiayou2", zijiayou2);
		ActionContext.getContext().getValueStack().set("haibianyou2", haibianyou2);
		ActionContext.getContext().getValueStack().set("chujingyou2", chujingyou2);
		ActionContext.getContext().getValueStack().set("gentuanyou2", gentuanyou2);
		ActionContext.getContext().getValueStack().set("ziyouxing2", ziyouxing2);
		ActionContext.getContext().getValueStack().set("qiongyou2", qiongyou2);
		// 类型数量
		ActionContext.getContext().getValueStack().set("zijiayou", zijiayou);
		ActionContext.getContext().getValueStack().set("haibianyou", haibianyou);
		ActionContext.getContext().getValueStack().set("chujingyou", chujingyou);
		ActionContext.getContext().getValueStack().set("gentuanyou", gentuanyou);
		ActionContext.getContext().getValueStack().set("ziyouxing", ziyouxing);
		ActionContext.getContext().getValueStack().set("qiongyou", qiongyou);
		// 获取推荐游记
		List<Diary> recommendedDiary = findRecommendedDiary();
		ActionContext.getContext().getValueStack().set("recommendedDiary", recommendedDiary);
	}

	public String list() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		diary.setUser(((User) session.getAttribute("user")));
		// 分页封装
		PageBean<Diary> pageBean = findAllDiary(new HashMap<>());
		initIndex();
		session.setAttribute("index", index);
		// 复位
		index = 0;

		initIndex();
		ServletActionContext.getRequest().getSession().setAttribute("pageBean", pageBean);
		// 清零
		page = 0;
		return "Success";

	}

	public void list2() throws IOException {
		int a = 0;
		HttpSession session = ServletActionContext.getRequest().getSession();

		diary.setUser(((User) session.getAttribute("user")));
		// 分页
		List<Diary> diaryList = diaryService.listpage((getPage() - 1) * getLength(), getLength(),
				((User) session.getAttribute("user")));
		PrintWriter write;
		if ((getPage() - 1) * getLength() > (diaryService.list(diary.getUser())).size()) {
			a = 1;
		}
		String data = JSON.toJSONString(a);
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			write = ServletActionContext.getResponse().getWriter();
			write.write(data);
		} catch (Exception e) {
			e.printStackTrace();
		}

		session.setAttribute("diaryList", diaryList);
		session.setAttribute("page", getPage());
		session.setAttribute("shengHuo", diaryService.classifyCount(diary.getUser(), "生活彩屏"));
		session.setAttribute("lvTu", diaryService.classifyCount(diary.getUser(), "旅途浏览"));
		session.setAttribute("youQing", diaryService.classifyCount(diary.getUser(), "友情互联"));
		session.setAttribute("xueHai", diaryService.classifyCount(diary.getUser(), "学海冲浪"));
		session.setAttribute("qingXu", diaryService.classifyCount(diary.getUser(), "情绪下载"));
		session.setAttribute("xiaoYuan", diaryService.classifyCount(diary.getUser(), "校园琐记"));

		List<Diary> diaryList2 = diaryService.LikenumSort();
		session.setAttribute("diaryList2", diaryList2);
		List<Diary> diaryList3 = new ArrayList<>();
		for (int i = 0; i < 8 && i < diaryList.size(); i++) {
			diaryList3.add(diaryList.get(i));
		}
		session.setAttribute("diaryList3", diaryList3);

		if (getNextpage() == 1) {

			setPage(getPage() + 1);
			session.setAttribute("page", getPage());

		}
	}

	/**
	 * 获取index2.jsp分页JSON数据
	 * 
	 * @throws IOException
	 */
	public void list3() throws IOException {
		HttpSession session = ServletActionContext.getRequest().getSession();
		page = page == 0 ? 1 : page;
		PageBean<Diary> pageBean = diaryService.findByPage(page, new HashMap<String, Object>());
		List<Diary> diaryList = pageBean.getList();
		session.setAttribute("diaryList", diaryList);
		session.setAttribute("page", getPage());
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("list", pageBean.getList());
		hm1.put("page", pageBean.getPage());
		hm1.put("talPage", pageBean.getTotalPage());
		String data1 = JSON.toJSONString(hm1, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(data1);
	}

	/**
	 * 获取文章信息以及推荐信息等
	 * 
	 * @return
	 */
	public String info() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		User user = (User) session.getAttribute("user");
		int likenum = diaryLikeService.findLikeCount(id);
		List<Comment> commentList = commentService.find(id);
		Diary info;
		// 检测是否已经点赞了
		int flag = 0;
		if (user != null) {
			if (diaryLikeService.isLike(id, user.getId())) {
				flag = 1;
			}
		}
		initIndex();
		session.setAttribute("flag", flag);
		List<Diary> list = diaryService.findById(id);
		System.out.println(list);
		session.setAttribute("commentList", commentList);
		if (!list.isEmpty()) {
			info = list.get(0);
		} else {
			info = ((List<Diary>) session.getAttribute("info1")).get(0);
		}
		if (list.isEmpty())
			session.setAttribute("info", ((List<Diary>) session.getAttribute("info1")));
		info.setLikenum(likenum);
		session.setAttribute("info", info);
		// 获取猜你喜欢文章
		List<Diary> guessLikeList = GuessLike(list.get(0).getClassify(), list.get(0).getKeyLandscape());
		session.setAttribute("guessLikeList", guessLikeList);
		List<Photo> photoList = diaryService.findByDid(id);
		session.setAttribute("photoList", photoList);
		List<Diary> relevantDiary = new ArrayList<>();
		if (!list.isEmpty()) {
			relevantDiary = findRelevantDiary(list.get(0).getProvince(), list.get(0).getCity());
		}
		List<Diary> recommendedDiary = findRecommendedDiary();
		session.setAttribute("relevantDiary", relevantDiary);
		session.setAttribute("recommendedDiary", recommendedDiary);

		return "Success";
	}

	/**
	 * 获取猜你喜欢的游记前五
	 * 
	 * @param classify
	 *            文章类型
	 * @param keyLandscape
	 *            文章主要景点
	 * @return
	 */
	public List<Diary> GuessLike(String classify, String keyLandscape) {
		return diaryService.GuessLike(classify, keyLandscape);
	}

	/**
	 * 获取相关游记（获取省市的前九）
	 * 
	 * @param province
	 *            省份
	 * @param city
	 *            市
	 * @return
	 */
	public List<Diary> findRelevantDiary(String province, String city) {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("province =", province);
		hm.put("city =", province);
		hm.put("province =", city);
		hm.put("city =", city);
		PageBean<Diary> pageBean = diaryService.findDiaryForSeachByPage(1, hm);
		return pageBean.getList();
	}

	/**
	 * 获取推荐游记
	 * 
	 * @return
	 */
	public List<Diary> findRecommendedDiary() {
		List<Integer> five = diaryLikeService.findLikeTopFive();
		List<Diary> fives = new ArrayList<>();
		for (Integer f : five) {
			fives.addAll(diaryService.findById(f));
		}
		return fives;
	}

	public String seach() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		List<Diary> diaryList = diaryService.seach(seach);
		session.setAttribute("diaryList", diaryList);
		return "Success";
	}

	/**
	 * 使用查询条件查询游记
	 * 
	 * @return
	 */
	public String findDiarybySeach() {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("content like", "%" + seach + "%");
		hm.put("title like", "%" + seach + "%");
		hm.put("countryRegion like", "%" + seach + "%");
		hm.put("province like", "%" + seach + "%");
		hm.put("city like", "%" + seach + "%");
		page = (page == 0) ? 1 : page;
		PageBean<Diary> pageBean = diaryService.findDiaryForSeachByPage(page, hm);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("seach", seach);
		pageBean.setParams(hm1);
		initIndex();
		ActionContext.getContext().getValueStack().set("pageBean", pageBean);
		ActionContext.getContext().getValueStack().set("type_", 0);
		page = 0;
		return "Success";
	}

	/**
	 * 使用查询条件查询游记返回JSON数据
	 * 
	 * @return
	 */
	public void findDiarybySeachForJson() {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("content like", "%" + seach + "%");
		hm.put("title like", "%" + seach + "%");
		hm.put("countryRegion like", "%" + seach + "%");
		hm.put("province like", "%" + seach + "%");
		hm.put("city like", "%" + seach + "%");
		page = (page == 0) ? 1 : page;
		PageBean<Diary> pageBean = diaryService.findDiaryForSeachByPage(page, hm);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("seach", seach);
		hm1.put("list", pageBean.getList());
		hm1.put("page", page);
		hm1.put("talPage", pageBean.getTotalPage());
		String data1 = JSON.toJSONString(hm1, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(data1);
	}

	/**
	 * 使用地址查询条件查询游记
	 * 
	 * @return
	 */
	public String findByCity() {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("province like", "%" + seach + "%");
		hm.put("city like", "%" + seach + "%");
		page = (page == 0) ? 1 : page;
		PageBean<Diary> pageBean = diaryService.findDiaryForSeachByPage(page, hm);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("seach", seach);
		pageBean.setParams(hm1);
		ActionContext.getContext().getValueStack().set("pageBean", pageBean);
		ActionContext.getContext().getValueStack().set("type_", 1);
		initIndex();
		page = 0;
		return "Success";
	}

	/**
	 * 使用地址加国家查询条件查询游记
	 * 
	 * @return
	 */
	public String findByCountryRegion() {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		System.out.println("countryRegion：" + countryRegion);
		if (countryRegion != null && countryRegion.length() != 0) {
			if (countryRegion.equals("中国")) {
				hm.put("countryRegion =", "中国");
			} else if (countryRegion.equals("外国")) {
				hm.put("countryRegion =", "外国");
			}
		}
		destinationName = destinationName == null ? "" : destinationName;
		System.out.println("%" + destinationName + "%");
		hm.put("province like", "%" + destinationName + "%");
		hm.put("city like", "%" + destinationName + "%");
		page = (page == 0) ? 1 : page;
		PageBean<Diary> pageBean = diaryService.findDiaryForSeachByPage(page, hm);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("countryRegion", countryRegion);
		hm1.put("destinationName", destinationName);
		pageBean.setParams(hm1);
		initIndex();
		ActionContext.getContext().getValueStack().set("pageBean", pageBean);
		return "Success";
	}

	/**
	 * 使用地址加国家查询条件查询游记返回JSON数据
	 * 
	 * @return
	 */
	public void findByCountryRegionForJson() {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		if (countryRegion != null && countryRegion.length() != 0) {
			if (countryRegion.equals("中国")) {
				hm.put("countryRegion =", "中国");
			} else if (countryRegion.equals("外国")) {
				hm.put("countryRegion =", "外国");
			}
		}
		destinationName = destinationName == null ? "" : destinationName;
		hm.put("province like", "%" + destinationName + "%");
		hm.put("city like", "%" + destinationName + "%");
		page = (page == 0) ? 1 : page;
		PageBean<Diary> pageBean = diaryService.findDiaryForSeachByPage(page, hm);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("countryRegion", countryRegion);
		hm1.put("seach", destinationName);
		hm1.put("list", pageBean.getList());
		hm1.put("page", page);
		hm1.put("talPage", pageBean.getTotalPage());
		String data1 = JSON.toJSONString(hm1, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(data1);
	}

	/**
	 * 使用地址加国家查询条件查询游记
	 * 
	 * @return
	 */
	public String seachByFour() {
		String whereName = "";
		StringBuilder stringBuilder = new StringBuilder();
		ArrayList<Object> patmList = new ArrayList<>();
		if (diary.getClassify() != null && diary.getClassify().length() != 0) {
			if (!diary.getClassify().equals("全部")) {
				stringBuilder.append("classify like ? ");
				patmList.add("%" + diary.getClassify() + "%");
			} else {
				stringBuilder.append("classify like ? ");
				patmList.add("%%");
			}
		}
		if (diary.getMonthTime() != 0) {
			if (stringBuilder.length() != 0) {
				stringBuilder.append("and monthTime = ?");
			} else {
				stringBuilder.append("monthTime = ?");

			}
			patmList.add(diary.getMonthTime());
		}
		if (diary.getCountryRegion() != null) {
			if (stringBuilder.length() != 0) {
				stringBuilder.append("and (countryRegion like ? or province like ? or city like ?) ");
			} else {
				stringBuilder.append("(countryRegion like ? or province like ? or city like ?) ");
			}
			patmList.add("%" + diary.getCountryRegion() + "%");
			patmList.add("%" + diary.getCountryRegion() + "%");
			patmList.add("%" + diary.getCountryRegion() + "%");
		}
		if (diary.getTotalTime() != 0) {
			if (stringBuilder.length() != 0) {
				stringBuilder.append("and totalTime = ?");
			} else {
				stringBuilder.append("totalTime = ?");
			}
			patmList.add(diary.getTotalTime());
		}
		if (stringBuilder.length() != 0) {
			stringBuilder.insert(0, " where ");
		}
		whereName = stringBuilder.toString();
		page = (page == 0) ? 1 : page;
		PageBean<Diary> pageBean = diaryService.findByPageForFour(page, whereName, patmList);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("countryRegion", diary.getCountryRegion());
		hm1.put("classify", diary.getClassify());
		hm1.put("monthTime", diary.getMonthTime());
		hm1.put("totalTime", diary.getTotalTime());
		pageBean.setParams(hm1);
		initIndex();
		ActionContext.getContext().getValueStack().set("pageBean", pageBean);
		return "Success";
	}

	public void seachByFourForJson() {
		String whereName = "";
		StringBuilder stringBuilder = new StringBuilder();
		ArrayList<Object> patmList = new ArrayList<>();
		if (diary.getClassify() != null && diary.getClassify().length() != 0) {
			if (!diary.getClassify().equals("全部")) {
				stringBuilder.append("classify like ? ");
				patmList.add("%" + diary.getClassify() + "%");
			} else {
				stringBuilder.append("classify like ? ");
				patmList.add("%%");
			}
		}
		if (diary.getMonthTime() != 0) {
			if (stringBuilder.length() != 0) {
				stringBuilder.append("and monthTime = ?");
			} else {
				stringBuilder.append("monthTime = ?");

			}
			patmList.add(diary.getMonthTime());
		}
		if (diary.getCountryRegion() != null) {
			if (stringBuilder.length() != 0) {
				stringBuilder.append("and (countryRegion like ? or province like ? or city like ?) ");
			} else {
				stringBuilder.append("(countryRegion like ? or province like ? or city like ?) ");
			}
			patmList.add("%" + diary.getCountryRegion() + "%");
			patmList.add("%" + diary.getCountryRegion() + "%");
			patmList.add("%" + diary.getCountryRegion() + "%");
		}
		if (diary.getTotalTime() != 0) {
			if (stringBuilder.length() != 0) {
				stringBuilder.append("and totalTime = ?");
			} else {
				stringBuilder.append("totalTime = ?");
			}
			patmList.add(diary.getTotalTime());
		}
		if (stringBuilder.length() != 0) {
			stringBuilder.insert(0, " where ");
		}
		whereName = stringBuilder.toString();
		page = (page == 0) ? 1 : page;
		PageBean<Diary> pageBean = diaryService.findByPageForFour(page, whereName, patmList);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("countryRegion", diary.getCountryRegion());
		hm1.put("classify", diary.getClassify());
		hm1.put("monthTime", diary.getMonthTime());
		hm1.put("totalTime", diary.getTotalTime());
		hm1.put("list", pageBean.getList());
		hm1.put("page", page);
		hm1.put("talPage", pageBean.getTotalPage());
		String data1 = JSON.toJSONString(hm1, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(data1);
		page = 0;
	}

	/**
	 * 使用地址查询条件查询游记返回JSON数据
	 * 
	 * @return
	 */
	public void findByCityForJson() {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("province like", "%" + seach + "%");
		hm.put("city like", "%" + seach + "%");
		page = (page == 0) ? 1 : page;
		PageBean<Diary> pageBean = diaryService.findDiaryForSeachByPage(page, hm);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("seach", seach);
		hm1.put("list", pageBean.getList());
		hm1.put("page", page);
		hm1.put("talPage", pageBean.getTotalPage());
		String data1 = JSON.toJSONString(hm1, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(data1);
		page = 0;
	}

	/**
	 * 使用类别条件查询游记
	 * 
	 * @return
	 */
	public String findByType() {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		type = getTypeString();
		hm.put("classify like ", "%" + type + "%");
		PageBean<Diary> pageBean = findAllDiary(hm);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("seach", seach);
		pageBean.setParams(hm1);
		ActionContext.getContext().getValueStack().set("pageBean", pageBean);
		ActionContext.getContext().getValueStack().set("type_", 2);
		initIndex();
		page = 0;
		return "Success";
	}

	/**
	 * 使用类别条件查询游记返回JSON数据
	 * 
	 * @return
	 */
	public void findDiarybyTypeForJson() {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		type = getTypeString();
		hm.put("classify like ", "%" + type + "%");
		PageBean<Diary> pageBean = findAllDiary(hm);
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		hm1.put("seach", seach);
		hm1.put("list", pageBean.getList());
		hm1.put("page", page);
		hm1.put("talPage", pageBean.getTotalPage());
		String data1 = JSON.toJSONString(hm1, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(data1);
		page = 0;
	}

	/**
	 * 获取文字类别
	 * 
	 * @return
	 */
	public String getTypeString() {
		String type = "";
		if (seach.equals("zijiayou"))
			type = "自驾游";
		else if (seach.equals("haibianyou"))
			type = "海边游";
		else if (seach.equals("chujingyou"))
			type = "出境游";
		else if (seach.equals("gentuanyou"))
			type = "跟团游";
		else if (seach.equals("ziyouxing"))
			type = "自由行";
		else
			type = "穷游";
		return type;
	}

	/**
	 * type_ 0是查找条件 1是查找地址
	 */
	public void findType_() {
		System.out.println(type__);
		if (type__ == 1) {
			findByCityForJson();
		} else if (type__ == 0) {
			findDiarybySeachForJson();
		} else {
			findDiarybyTypeForJson();
		}
	}

	public String delete() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		if (session.getAttribute("user") == null)
			return "Fail";
		boolean flag = diaryService.delete(id);
		System.out.println("flag=" + flag);
		if (flag)
			return "Success";
		else
			return "File";
	}

	public String infopic() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		if (session.getAttribute("user") == null)
			return "Fail";
		int likenum = commentService.likenum(id);
		List<Comment> commentList = commentService.find(id);

		List<Diary> list = diaryService.findById(id);

		System.out.println(list.isEmpty());

		session.setAttribute("commentList", commentList);
		if (!list.isEmpty())
			session.setAttribute("info", list.get(0));
		if (list.isEmpty())
			session.setAttribute("info", ((List<Diary>) session.getAttribute("info1")));
		session.setAttribute("likenum", likenum);
		PhotoAction photoAction = new PhotoAction();

		List<Photo> photoList = diaryService.findByDid(id);

		session.setAttribute("photoList", photoList);

		return "Success";
	}

	// 后台
	public String findAll() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		List<Diary> diaryList = diaryService.findAll();
		for (Diary d : diaryList) {
			d.setLikenum(diaryLikeService.findLikeCount(d.getDid()));
		}
		session.setAttribute("diaryList", diaryList);
		return "findAll";
	}

	public String findPhoto() {
		int page = 1;
		HttpSession session = ServletActionContext.getRequest().getSession();
		List<Diary> diaryList = diaryService.findAll();
		session.setAttribute("diaryList", diaryList);
		return "findPhoto";
	}

	public void delete2() throws IOException {
		boolean flag = diaryService.delete(id);
		String data = JSON.toJSONString(flag);
		ResultUtil.sendJson(data);
	}

	public String Contribution() {

		HttpSession session = ServletActionContext.getRequest().getSession();
		List<User> contribution = diaryService.Contribution();
		String text = "贡献";
		session.setAttribute("text", text);
		session.setAttribute("contribution", contribution);
		return "contribution";
	}

	public String destination() {
		return "Success";
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getNextpage() {
		return nextpage;
	}

	public void setNextpage(int nextpage) {
		this.nextpage = nextpage;
	}

	public int getLvTu() {
		return lvTu;
	}

	public void setLvTu(int lvTu) {
		this.lvTu = lvTu;
	}

	public static void main(String[] args) {
		System.out.println(3 / 2);
	}

}