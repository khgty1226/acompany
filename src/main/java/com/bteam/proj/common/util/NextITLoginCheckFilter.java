package com.bteam.proj.common.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bteam.proj.member.vo.MemberVO;


public class NextITLoginCheckFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		System.out.println("---- ---- ----start NextITLoginCheckFilter");
		HttpServletRequest req = (HttpServletRequest) request;
		
		HttpSession session =  req.getSession();
		MemberVO vo =  (MemberVO) session.getAttribute("login");
		
		String uri = req.getRequestURI();
		System.out.println(uri);

		if(uri.indexOf("/startView") > -1) {
			chain.doFilter(request, response);
		}else if(uri.indexOf("/joinView") > -1){
			chain.doFilter(request, response);
		}else if(uri.indexOf("/loginView") > -1){
			chain.doFilter(request, response);
		}else {
			if(vo != null) {
				System.out.println("success login check filter ");
				chain.doFilter(request, response);
			}else {
				System.out.println("fail login check filter ");
				HttpServletResponse resp = (HttpServletResponse) response;
				//resp.sendRedirect(req.getContextPath()+"/login/login.do");
				resp.sendRedirect(req.getContextPath()+"/startView?msg=none");
			}
		}

		
		chain.doFilter(request, response);
		
		
		System.out.println("---- ---- ----end NextITLoginCheckFilter");
		
	}

}
