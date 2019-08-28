package com.webDiary.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.opensymphony.xwork2.ActionContext;
import com.webDiary.pojo.Comment;
import com.webDiary.pojo.Diary;
import com.webDiary.pojo.User;
import com.webDiary.service.CommentService;
import com.webDiary.service.DiaryService;
import com.webDiary.util.PageBean;
import com.webDiary.util.ResultUtil;

public class CommentAction {
	private CommentService commentService;
	private DiaryService diaryService;
	private Comment comment;
	private int diaryId;
	private int id;
	private int page;

	public DiaryService getDiaryService() {
		return diaryService;
	}

	public void setDiaryService(DiaryService diaryService) {
		this.diaryService = diaryService;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
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

	public Comment getComment() {
		return comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	public int getDiaryId() {
		return diaryId;
	}

	public void setDiaryId(int diaryId) {
		this.diaryId = diaryId;
	}

	/*
	 * public void likenum() throws IOException { int likenum =
	 * commentService.addLikenum(diaryId); String data =
	 * JSON.toJSONString(likenum); ResultUtil.sendJson(data);
	 * 
	 * try { PrintWriter write;
	 * 
	 * HttpSession session = ServletActionContext.getRequest().getSession();
	 * ServletActionContext.getResponse().setCharacterEncoding("utf-8"); write =
	 * ServletActionContext.getResponse().getWriter(); write.write(data); }
	 * catch (Exception e) { e.printStackTrace(); }
	 * 
	 * 
	 * }
	 */

	public void comment() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		User user = (User) session.getAttribute("user");
		// 留言插入结果
		boolean flag = false;
		// id获取文章
		List<Diary> diarytList = diaryService.findById(diaryId);
		// 用户登陆状态判断或文章列表为空结果
		boolean flag1;
		// 检查用户是否登陆和文章列表为空判断
		flag1 = (diarytList == null || diarytList.size() == 0 || user == null || user.getId() == 0
				|| user.getUserName().length() == 0);
		boolean flag2 = false;
		if (!flag1) {
			// 判断是不是文章作者评论
			flag2 = diarytList.get(0).getUser().getUserName().equals(user.getUserName());
			// 如果不是
			if (!flag2) {
				// 设置评论用户
				comment.setUser(user);
				// 进行留言插入
				flag = commentService.insert(comment, diaryId);
			}
		}
		// 插入结果json数据
		String data;
		// 如果是作者评论返回
		if (flag2) {
			data = JSON.toJSONString(0);
		} else {
			data = JSON.toJSONString(flag);
		}
		ResultUtil.sendJson(data);
		/*
		 * try { PrintWriter write;
		 * 
		 * ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		 * write = ServletActionContext.getResponse().getWriter();
		 * write.write(data); } catch (Exception e) { e.printStackTrace(); }
		 */

	}

	public String findAll() {
		List<Comment> cList = commentService.findAll();
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("cList", cList);
		return "findAll";

	}

	public void delete() throws IOException {
		boolean flag = commentService.delete(id);
		String data = JSON.toJSONString(flag);
		ResultUtil.sendJson(data);
		/*
		 * try { PrintWriter write;
		 * ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		 * write = ServletActionContext.getResponse().getWriter();
		 * write.write(data); } catch (Exception e) { System.out.println("有异常");
		 * }
		 */

	}

	public void reply() {
		// 解耦合获取session
		Map session = ActionContext.getContext().getSession();
		User loginUser = (User) session.get("user");
		boolean flag = false;
		// id获取文章
		List<Diary> diarytList = diaryService.findById(diaryId);
		// 判断用户是否登陆以及文章是否存在
		flag = (diarytList == null || diarytList.size() == 0 || loginUser == null || loginUser.getId() == 0
				|| loginUser.getUserName().length() == 0);
		// 如果存在
		if (!flag) {
			// 判断是否是文章作者本身
			flag = diarytList.get(0).getUser().getId() == loginUser.getId();
		}
		// 如果是
		if (flag) {
			flag = commentService.insertReply(id, comment.getReply());
		}
		String data = "";
		data = JSON.toJSONString(flag);
		ResultUtil.sendJson(data);
	}

	public String findComment() {
		try {
			// 解耦合获取session
			Map session = ActionContext.getContext().getSession();
			User loginUser = (User) session.get("user");
			String whereName = "where diary.user.id = ? ";
			ArrayList<Object> patmList = new ArrayList<>();
			patmList.add(loginUser.getId());
			page = page == 0 ? 1 : page;
			PageBean<Comment> pageBean = commentService.findByPage(page, whereName, patmList);
			ActionContext.getContext().getValueStack().set("commentPageBean", pageBean);
		} catch (Exception e) {
			System.out.println("findComment()出错");
			e.printStackTrace();
			return "Error";
		}
		return "Success";
	}

	public void findCommentForJson() {
		// 解耦合获取session
		Map session = ActionContext.getContext().getSession();
		User loginUser = (User) session.get("user");
		String data = "";
		if (loginUser == null || loginUser.getId() == 0) {
			data = JSON.toJSONString(true);
			ResultUtil.sendJson(data);
			return;
		}
		try {
			String whereName = "where diary.user.id = ? ";
			ArrayList<Object> patmList = new ArrayList<>();
			patmList.add(loginUser.getId());
			page = page == 0 ? 1 : page;
			PageBean<Comment> pageBean = commentService.findByPage(page, whereName, patmList);
			data = JSON.toJSONString(pageBean, SerializerFeature.DisableCircularReferenceDetect);
		} catch (Exception e) {
			System.out.println("findCommentForJson()出错");
			e.printStackTrace();
			data = JSON.toJSONString(true);
		}
		ResultUtil.sendJson(data);
	}
	public String Contribution() {

		HttpSession session = ServletActionContext.getRequest().getSession();
		List<User> contribution = commentService.Contribution();
		session.setAttribute("contribution", contribution);
		String text = "热门";
		session.setAttribute("text",text );
		return "contribution";
	}
}
