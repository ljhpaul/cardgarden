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
 * @WebFilter : 서블릿 3버전부터 지원, 하위버전은 web.xml을 통해 .xml파일 등록 LoginChkFiilter는 .do
 *            요청시에만 수행하도록 하기
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
      log.info("LoginChkFiilter 요청주소 확인: " + req.getRequestURL());
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
