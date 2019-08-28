/**
 * 
 */
package com.webDiary.util;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * @author wuzhuhao
 *
 */
public class PageHibernateCallback<T> implements HibernateCallback<List<T>> {

	private String hql;// 执行的hql语句
	private Object[] params;// hql语句的选择条件
	private int startIndex;// 开始的下表
	private int pageSize;// 一页的数量

	public PageHibernateCallback(String hql, Object[] params, int startIndex, int pageSize) {
		super();
		this.hql = hql;
		this.params = params;
		this.startIndex = startIndex;
		this.pageSize = pageSize;
	}

	public List<T> doInHibernate(Session session) throws HibernateException, SQLException {
		// 1 执行hql语句
		Query query = session.createQuery(hql);
		// 2 实际参数填充？的内容
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
		}
		// 3 分页
		query.setFirstResult(startIndex);
		query.setMaxResults(pageSize);

		return query.list();
	}

}
