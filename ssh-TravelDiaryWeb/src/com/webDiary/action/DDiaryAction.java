package com.webDiary.action;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
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
import com.opensymphony.xwork2.ActionContext;
import com.webDiary.pojo.Comment;
import com.webDiary.pojo.DDiary;
import com.webDiary.pojo.Diary;
import com.webDiary.pojo.Photo;
import com.webDiary.pojo.User;
import com.webDiary.service.CommentService;
import com.webDiary.service.DDiaryService;
import com.webDiary.service.DiaryService;
import com.webDiary.util.PageBean;
import com.webDiary.util.ResultUtil;

public class DDiaryAction {

	private DDiaryService dDiaryService;
	private DiaryService diaryService;
	private DDiary diary = new DDiary();
	private File file;
	private String fileFileName;
	private String fileContentType;
	private File upload;// 动作类上传的属性必须是file类型,upload为表单的name值
	private String uploadFileName; // 上传的文件名称,固定写法:name+FileName;
	private final int length = 3;
	private int page;
	private int nextpage;
	private int id;

	private CommentService commentService;

	public DDiaryService getdDiaryService() {
		return dDiaryService;
	}

	public void setdDiaryService(DDiaryService dDiaryService) {
		this.dDiaryService = dDiaryService;
	}

	public DiaryService getDiaryService() {
		return diaryService;
	}

	public void setDiaryService(DiaryService diaryService) {
		this.diaryService = diaryService;
	}

	public DDiary getDiary() {
		return diary;
	}

	public void setDiary(DDiary diary) {
		this.diary = diary;
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

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public CommentService getCommentService() {
		return commentService;
	}

	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}

	public int getLength() {
		return length;
	}

	public String insert() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String classify_list = "";
		try {
			// 获取文件保存路径，判断是否存在该目录如果不存在创建
			String Path = "/test.txt";
			File file = new File(Path);
			// 判断文件是否存在，不存在就创建
			if (!file.exists() && !file.isDirectory()) {
				file.mkdirs();
			}
			DiskFileItemFactory factroy = new DiskFileItemFactory();
			// 创建文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factroy);
			// 判断前端form表单是否为enctype="multipart/form-data"属性
			boolean isF = ServletFileUpload.isMultipartContent(request);
			// 如果前端传过来的是表单是enctype="multipart/form-data"属性
			if (isF) {
				// 使用解析器解析上传的表单数据，每个FileItem对应一个表单项
				List<FileItem> fileItemList = upload.parseRequest(request);
				for (FileItem fileItem : fileItemList) {
					if (!fileItem.isFormField()) {
						// 不是普通的表单项，即是上传的是文件
						// 获取文件名称
						String fileName = fileItem.getName();
						if (fileName.isEmpty()) {
							// 如果文件名为空
							return "File";
						}
						// 获取上传文件输入流
						InputStream in = fileItem.getInputStream();
						// 创建文件输出流
						Path += "\\" + fileName;
						String str = "";
						String leng = "";
						BufferedReader br = new BufferedReader(new InputStreamReader(in, "utf-8"));
						while ((leng = br.readLine()) != null) {
							str += leng;
						}
						BufferedWriter bw = new BufferedWriter(
								new OutputStreamWriter(new FileOutputStream(new File(Path))));
						bw.write(str);
						bw.flush();
						bw.close();
						br.close();
						// FileItem对象被垃圾收集器收集时会自动清除临时文件，但及时调用delete方法可以更早的清除临时文件，释放系统存储资源。
						// 另外，当系统出现异常时，仍有可能造成有的临时文件被永久保存在了硬盘中。
						fileItem.delete();
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
						if (session.getAttribute("photoList1") != null) {
							String image = ((List<Photo>) session.getAttribute("photoList1")).get(0).getImage();
							diary.setImage(image);
						}

					}

				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (session.getAttribute("user") == null)
			return "Fail";
		diary.setClassify(classify_list.substring(0, classify_list.length() - 1));
		diary.setUser(((User) session.getAttribute("user")));
		System.out.println(upload);
		if (uploadFileName == null) {
			// diary.setImage("diaryImage\\" + uploadFileName);
			diary.setUser(((User) session.getAttribute("user")));
			session.setAttribute("info", diary);
			System.out.println(diary.getClassify());
			if (dDiaryService.insert(diary)) {
				return "Success";
			} else {
				return "Success";
			}
		}

		String path = ServletActionContext.getServletContext().getRealPath("/diaryImage");
		System.out.println(path + "999");
		// 判断路径名是否存在，不存在则创建 mkdir
		File file = new File(path);
		if (!file.exists()) {
			file.mkdir();
		}

		// 将页面传过来的数据通过FileUtils 拷贝到我们刚刚定义的路径下
		FileUtils.copyFile(upload, new File(file, uploadFileName));

		String file2 = new File(file, uploadFileName).toString();
		// diary.setImage("diaryImage\\" + uploadFileName);
		diary.setUser(((User) session.getAttribute("user")));
		System.out.println(diary.getContent() + " *-----" + diary.getTitle() + "--- " + diary.getImage());
		session.setAttribute("info", diary);
		if (dDiaryService.insert(diary)) {

			List<Photo> photoList = diaryService.findByDid(id);
			System.out.println("action" + photoList.size());
			session.setAttribute("photoList", photoList);
			int likenum = commentService.likenum(id);
			List<Comment> commentList = commentService.find(id);
			List<Diary> list = diaryService.findById(id);
			session.setAttribute("commentList", commentList);
			session.setAttribute("likenum", likenum);
			return "Success";
		} else {

		}
		return "Fail";
	}

	public String list() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		// session.setAttribute("page", 1);
		// if (session.getAttribute("user") == null)
		// return "Fail";
		// diary.setUser(((User) session.getAttribute("user")));
		// // 分页
		// List<DDiary> diaryList = dDiaryService.listpage((getPage() - 1) *
		// getLength(), getLength(),
		// ((User) session.getAttribute("user")));
		//
		// session.setAttribute("diafts", diaryList);
		//
		// if (getNextpage() == 1) {
		//
		// setPage(getPage() + 1);
		// session.setAttribute("page", getPage());
		//
		// }
		diary.setUser(((User) session.getAttribute("user")));
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("Uid = ", diary.getUser().getId());
		PageBean<DDiary> pageBean = findAllDdiary(hm);
		ActionContext.getContext().getValueStack().set("DpageBean", pageBean);
		return "Success";

	}

	public PageBean<DDiary> findAllDdiary(HashMap<String, Object> hm) {
		page = (page == 0) ? 1 : page;
		PageBean<DDiary> pageBean = null;
		pageBean = dDiaryService.findByPage(page, hm);
		pageBean.setParams(null);
		return pageBean;
	}

	public void list1() throws IOException {
		HttpSession session = ServletActionContext.getRequest().getSession();
		String data = "";
		if (session.getAttribute("user") == null || ((User) session.getAttribute("user")).getId() == 0) {
			data = JSON.toJSONString(true);
			ResultUtil.sendJson(data);
			return;
		}
		diary.setUser(((User) session.getAttribute("user")));
		HashMap<String, Object> hm = new HashMap<>();
		hm.put("Uid = ", diary.getUser().getId());
		PageBean<DDiary> pageBean = findAllDdiary(hm);
		data = JSON.toJSONString(pageBean);
		ResultUtil.sendJson(data);

	}

	public String findById() {
		List<DDiary> diary = dDiaryService.findByID(id);
		HttpServletRequest request = ServletActionContext.getRequest();
		System.out.println(diary.isEmpty());
		// request.setAttribute("draftsDiary", diary.get(0));
		ActionContext.getContext().getValueStack().set("draftsDiary", diary.get(0));
		HttpSession session = request.getSession();
		session.setAttribute("id", (diary.get(0)).getDid());
		System.out.println("iddsdsds" + id);
		return "Success";
	}

	public String deleteId() {
		dDiaryService.deleteId(id);
		return "Success";
	}

	public String deleteAll() {
		dDiaryService.deleteAll();
		return "Success";
	}

}
