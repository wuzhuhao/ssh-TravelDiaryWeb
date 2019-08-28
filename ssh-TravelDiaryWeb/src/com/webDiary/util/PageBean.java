/**
 * 
 */
package com.webDiary.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 分页类的封装
 * 
 * @author wuzhuhao
 *
 * @param <T>
 */
public class PageBean<T> {

	private int page; // 当前页数
	private int totalCount; // 总记录数
	private int totalPage; // 总页数
	private int limit; // 每页显示的记录数
	private List<T> list; // 每页显示数据的集合.
	private Map<String, Object> params;// 查询条件保存

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public Map<String, Object> getParams() {
		return params;
	}

	public void setParams(Map<String, Object> params) {
		this.params = params;
	}

	public void addParam(String key, Object value) {

		if (this.params == null) {
			this.params = new HashMap<>();
		}

		this.params.put(key, value);
	}

	public void clearParams() {

		if (this.params != null) {
			this.params.clear();
		}
	}

	public Integer getStartIndex() {
		return (page - 1) * limit;
	}
}
