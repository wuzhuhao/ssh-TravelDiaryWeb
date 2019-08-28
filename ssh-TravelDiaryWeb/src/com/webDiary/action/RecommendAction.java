/**
 * 
 */
package com.webDiary.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.webDiary.pojo.Diary;
import com.webDiary.pojo.Recommend;
import com.webDiary.service.DiaryLikeService;
import com.webDiary.service.DiaryService;
import com.webDiary.service.RecommendService;
import com.webDiary.util.PageBean;

/**
 * @author wuzhuhao
 *
 */
public class RecommendAction extends ActionSupport implements ModelDriven<Recommend> {
	Recommend recommend;
	RecommendService recommendService;
	DiaryService diaryService;
	private DiaryLikeService diaryLikeService;
	int type_, page = 0, id_ = 1;

	public DiaryLikeService getDiaryLikeService() {
		return diaryLikeService;
	}

	public void setDiaryLikeService(DiaryLikeService diaryLikeService) {
		this.diaryLikeService = diaryLikeService;
	}

	public int getType_() {
		return type_;
	}

	public void setType_(int type_) {
		this.type_ = type_;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getId_() {
		return id_;
	}

	public void setId_(int id_) {
		this.id_ = id_;
	}

	public DiaryService getDiaryService() {
		return diaryService;
	}

	public void setDiaryService(DiaryService diaryService) {
		this.diaryService = diaryService;
	}

	public RecommendService getRecommendService() {
		return recommendService;
	}

	public void setRecommendService(RecommendService recommendService) {
		this.recommendService = recommendService;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.opensymphony.xwork2.ModelDriven#getModel()
	 */
	@Override
	public Recommend getModel() {
		// TODO Auto-generated method stub
		return recommend;
	}

	public String findRecommend() {
		page = (page == 0) ? 1 : page;
		PageBean<Recommend> pageBean = null;
		Map<String, Object> hm = new HashMap<>();
		if (type_ == 1) {
			hm.put("type_ =", 1);
		} else if (type_ == 2) {
			hm.put("type_ =", 2);
		} else if (type_ == 3) {
			hm.put("type_ =", 3);
		} else {
			page = 0;
			return "List_Fail";
		}
		System.out.println(type_);
		pageBean = recommendService.findByPage(page, hm);
		Map<String, Object> Params = new HashMap<>();
		Params.put("type_", type_);
		pageBean.setParams(Params);
		ServletActionContext.getRequest().getSession().setAttribute("pageBean", pageBean);

		System.out.println("返回成功");
		return "List_Success";
	}

	public String findById() {
		if (id_ <= 0) {
			return "Find_Fail";
		}
		initIndex();
		System.out.println("id:" + id_);
		recommend = recommendService.findById(id_);
		ServletActionContext.getRequest().getSession().setAttribute("recommend", recommend);
		return "Find_Success";
	}

	public void initIndex() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		// 获取前五的城市，并且存到session里面
		List<Object>[] citys_result = diaryService.getTopCity();
		List<Object> citys = citys_result[0];
		List<Object> citys_counts = citys_result[1];
		session.setAttribute("citys", citys);
		session.setAttribute("citys_counts", citys_counts);
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
		session.setAttribute("zijiayou2", zijiayou2);
		session.setAttribute("haibianyou2", haibianyou2);
		session.setAttribute("chujingyou2", chujingyou2);
		session.setAttribute("gentuanyou2", gentuanyou2);
		session.setAttribute("ziyouxing2", ziyouxing2);
		session.setAttribute("qiongyou2", qiongyou2);
		// 类型数量
		session.setAttribute("zijiayou", zijiayou);
		session.setAttribute("haibianyou", haibianyou);
		session.setAttribute("chujingyou", chujingyou);
		session.setAttribute("gentuanyou", gentuanyou);
		session.setAttribute("ziyouxing", ziyouxing);
		session.setAttribute("qiongyou", qiongyou);
		// 获取推荐游记
		List<Diary> recommendedDiary = findRecommendedDiary();
		session.setAttribute("recommendedDiary", recommendedDiary);
	}

	/**
	 * 获取推荐游记
	 * 
	 * @return
	 */
	public List<Diary> findRecommendedDiary() {
		List<Integer> five = diaryLikeService.findLikeTopFive();
		System.out.println(five.size());
		List<Diary> fives = new ArrayList<>();
		for (Integer f : five) {
			fives.addAll(diaryService.findById(f));
		}
		return fives;
	}
}
