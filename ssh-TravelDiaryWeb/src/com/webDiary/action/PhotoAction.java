package com.webDiary.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.webDiary.pojo.Diary;
import com.webDiary.pojo.Photo;
import com.webDiary.service.PhotoService;
import com.webDiary.service.impl.PhotoServiceImpl;
import com.webDiary.util.ResultUtil;

public class PhotoAction {
	private Photo photo;
	private PhotoService photoService;
	private Diary diary;
	private int id;
	private int[] photoId;

	public Diary getDiary() {
		return diary;
	}

	public void setDiary(Diary diary) {
		this.diary = diary;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Photo getPhoto() {
		return photo;
	}

	public void setPhoto(Photo photo) {
		this.photo = photo;
	}

	public PhotoService getPhotoService() {
		return photoService;
	}

	public void setPhotoService(PhotoService photoService) {
		this.photoService = photoService;
	}

	public void uploadServlet() {
		System.out.println("进来了photo");
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse respose = ServletActionContext.getResponse();
		HttpSession session = request.getSession();
		String savePath = ServletActionContext.getServletContext().getRealPath("/upload");
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
			// 4、使用ServletFileUpload解析器上传数据，解析结果返回的是一个List<FileItem>集合
			// 每一个FileItem对应一个Form表单的输入项

			List<FileItem> list = upload.parseRequest(request);
			List<Photo> photoList1 = (List<Photo>) session.getAttribute("photoList1");

			if (session.getAttribute("photoList1") == null)
				photoList1 = new ArrayList<>();

			Photo photo = new Photo();
			for (FileItem item : list) {
				if (!item.isFormField()) {
					String filename = item.getName();

					if (filename == null || filename.trim().equals("")) {
						continue;
					}
					filename = filename.substring(filename.lastIndexOf(".") + 1);
					// 给文件重新取一个名字UUID
					filename = UUID.randomUUID().toString() + "." + filename;
					System.out.println(filename + "8888");
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
						// 使用FileOutputStream输入流将缓冲区的数据写入到指定的目录(savePath + "\\"
						// +filename)
						out.write(buffer, 0, len);
					}
					photo.setImage("upload/" + filename);
					photoList1.add(photo);
					session.setAttribute("photoList1", photoList1);
					// 这三句代码之及其重要的，就是为了返回JSON数据做准备的
					String[] str = { request.getContextPath() + "/upload/" + filename };
					com.webDiary.util.Result result = ResultUtil.success(str);
					respose.getWriter().write(JSON.toJSONString(result));// 返回url地址
					System.out.println(photoList1.size());

					// 关闭流
					in.close();
					out.close();
					// 删除处理文件上传时生成的临时文件
					item.delete();
				} else {

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public boolean insert(int id) {
		boolean flag = photoService.insert(id);
		return flag;
	}

	public List<Photo> findByDid(int id) {

		PhotoServiceImpl photoServiceImpl = new PhotoServiceImpl();
		System.out.println(photoServiceImpl);
		return photoServiceImpl.findByDid(id);

	}

	public String findById() {
		List<Photo> pList = photoService.findByDid(id);
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("pList", pList);
		return "findById";

	}

	public void delete() throws IOException {
		System.out.println(123);
		boolean flag = photoService.delete(id);
		String data = JSON.toJSONString(flag);
		ResultUtil.sendJson(data);

	}

	public String delete2() {
		System.out.println(1234);
		System.out.println(photoId.length);
		for (int i = 0; i < photoId.length; i++) {
			photoService.delete2(photoId[i]);

		}
		List<Photo> pList = photoService.findByDid(id);
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("pList", pList);
		return "delete2";
	}

	public int[] getPhotoId() {
		return photoId;
	}

	public void setPhotoId(int[] photoId) {
		this.photoId = photoId;
	}
}
