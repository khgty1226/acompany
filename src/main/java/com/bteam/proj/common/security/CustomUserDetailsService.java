package com.bteam.proj.common.security;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.bteam.proj.member.dao.IMemberDAO;
import com.bteam.proj.member.vo.MemberVO;

public class CustomUserDetailsService implements UserDetailsService{

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	private IMemberDAO memberDAO;
	
	@Autowired
	private HttpServletRequest request;
	
	
	@Override
	public UserDetails loadUserByUsername(String memNo) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		logger.info("CustomUserDetailsService loadUserByUsername username: "
				+ memNo);
		
		MemberVO member = memberDAO.getMember(memNo);
		
		if(member == null) {
			return null;
		}
		
		List<String> roleList = memberDAO.getUserRoleList(memNo);
		member.setRoleList(roleList);
		
		HttpSession session = request.getSession();
		session.setAttribute("memberVO", member);
		
		//return null;
		return new CustomUser(member);  //[AD, ME, ST]
		
	}

}
