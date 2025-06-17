package com.cardgarden.project.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import lombok.extern.slf4j.Slf4j;

/**
 * @WebFilter : ���� 3�������� ����, ���������� web.xml�� ���� .xml���� ��� LoginChkFiilter�� .do
 *            ��û�ÿ��� �����ϵ��� �ϱ�
 */
@Slf4j
//@WebFilter("/sample/*")
public class SampleFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//============================================================
		HttpServletRequest req = (HttpServletRequest) request;
		log.info("LoginChkFiilter ��û�ּ� Ȯ��: " + req.getRequestURL());
		log.info("[SampleFilter] Before chain.doFilter");
		//---------------------------------------------------------
		chain.doFilter(request, response);
		//---------------------------------------------------------
		log.info("[SampleFilter] After chain.doFilter");
		//============================================================
	}

	@Override
	public void destroy() {

	}

}
