/**
 * 
 */
package com.webDiary.interceptor;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.webDiary.pojo.User;

/**
 * 权限拦截器:
 * 
 * @author wuzhuhao
 *
 */
public class PrivilegeInterceptor extends MethodFilterInterceptor {

	@Override
	protected String doIntercept(ActionInvocation actionInvocation) throws Exception {
		System.out.println("拦截器123");
		// 判断是否登录,如果登录,放行,没有登录,跳转到登录页面.
		User adminUser = (User) ServletActionContext.getRequest().getSession().getAttribute("user");
		if (adminUser != null && adminUser.getId() != 0) {
			// 已经登录过
			return actionInvocation.invoke();
		} else {
			// 跳转到登录页面:
			return "login";
		}
	}

}
