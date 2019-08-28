package com.webDiary.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession session = req.getSession(true);
		resp.setContentType("text/html;");
		resp.setCharacterEncoding("utf-8");

		String url = req.getRequestURI();
		String ctxPath = req.getContextPath();
		String uri = url.substring(ctxPath.length());
		if (uri.contains("houTai/login.jsp")||!uri.contains("jsp")) {
			chain.doFilter(request, response);
		} else {
			if (session.getAttribute("admin")!= null  ) {
				chain.doFilter(request, response);
			}

			else {
				resp.sendRedirect("login.jsp");
				return;
			}
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
