package com.webDiary.action;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.webDiary.service.DiaryService;
import com.webDiary.util.ResultUtil;

import recommendation.pojo.City_Subject;
import recommendation.pojo.Content;
import recommendation.pojo.Data;
import recommendation.pojo.DataList;
import recommendation.pojo.Param;
import recommendation.service.RecommendationService;

public class RecommendationAction extends ActionSupport {
	//服务层
	RecommendationService recommendationService;
	//页面详情实体类
	Data data;
	//请求参数实体类
	Param param;
	String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	private DiaryService diaryService;
	
	
	public DiaryService getDiaryService() {
		return diaryService;
	}

	public void setDiaryService(DiaryService diaryService) {
		this.diaryService = diaryService;
	}

	public RecommendationService getRecommendationService() {
		return recommendationService;
	}

	public void setRecommendationService(RecommendationService recommendationService) {
		this.recommendationService = recommendationService;
	}

	public Data getData() {
		return data;
	}

	public void setData(Data data) {
		this.data = data;
	}

	public Param getParam() {
		return param;
	}

	public void setParam(Param param) {
		this.param = param;
	}

	//list页面转发
	public String ListForward() {
		initCloud();
		return "listSuccess";
	}
	
	// 获取景点列表json数据--第一次请求用
	public void listToJson() {
		//获取页面信息
		DataList dataList = recommendationService.getDataList(param);
		String resultJson = "";
		HashMap<String, Object> resultMap = new HashMap<String, Object>();HashMap<String, Object> hm1 = new HashMap<String, Object>();
		if(dataList.getData_list().size()==0) {
			resultMap.put("result", "error");
		}
		else {
			resultMap.put("result", dataList);
		}
		resultJson = JSON.toJSONString(resultMap, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(resultJson);
	}
	
	// 获取类型列表json数据
	public void getCitySubjectToJson() {
		// 获取页面信息
		City_Subject city_Subject = recommendationService.getCity_Subject(param);
		String resultJson = "";
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		if (city_Subject.getSubject_list().size() == 0) {
			resultMap.put("result", "error");
		} else {
			resultMap.put("result", city_Subject);
		}
		resultJson = JSON.toJSONString(resultMap, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(resultJson);
	}
	
	// 获取景点列表json数据--二次请求或分页用
	public void getDataListToJson() {
		// 获取页面信息
		DataList dataList = recommendationService.getDataListByPage(param);
		String resultJson = "";
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> hm1 = new HashMap<String, Object>();
		if (dataList.getData_list().size() == 0) {
			resultMap.put("result", "error");
		} else {
			resultMap.put("result", dataList);
		}
		resultJson = JSON.toJSONString(resultMap, SerializerFeature.DisableCircularReferenceDetect);
		ResultUtil.sendJson(resultJson);
	}

	//获取页面的详细信息
	public String dataInfo() {
		System.out.println("url是" + id);
		Content content = recommendationService.getContent(id);
		Map<String, Object> pageData = new HashMap<String, Object>();
		pageData.put("info", content);
		//发送info到前端页面
		ResultUtil.sendDataForView(pageData);
		initCloud();
		return "infoSuccess";
	}

	public void initCloud() {
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
		ActionContext.getContext().getValueStack().set("zijiayou2", zijiayou2);
		ActionContext.getContext().getValueStack().set("haibianyou2", haibianyou2);
		ActionContext.getContext().getValueStack().set("chujingyou2", chujingyou2);
		ActionContext.getContext().getValueStack().set("gentuanyou2", gentuanyou2);
		ActionContext.getContext().getValueStack().set("ziyouxing2", ziyouxing2);
		ActionContext.getContext().getValueStack().set("qiongyou2", qiongyou2);
	}
}
