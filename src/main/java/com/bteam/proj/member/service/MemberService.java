package com.bteam.proj.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bteam.proj.attach.dao.IAttachDAO;
import com.bteam.proj.attach.vo.AttachVO;
import com.bteam.proj.common.vo.RoleInfoVO;
import com.bteam.proj.member.dao.IMemberDAO;
import com.bteam.proj.member.vo.MailAuthVO;
import com.bteam.proj.member.vo.MemberSearchVO;
import com.bteam.proj.member.vo.MemberVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;


@Service
public class MemberService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	IMemberDAO dao; // => DI(의존성 주입)
	
	@Autowired
	private IAttachDAO attachDAO;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	// 회원가입(SELECT)
	public boolean joinCheck(MemberVO member) {
		
		MemberVO resultMembers = dao.joinCheckMembers(member);
		MemberVO resultMemberEmail = dao.joinCheckMemberEmail(member);
		
		System.out.println("MemberController joinCheck resultMembers : " + resultMembers);
		System.out.println("MemberController joinCheck resultMemberEmail : " + resultMemberEmail);
		
		// members 테이블에 존재하면서 member_email 테이블에 없는 사원번호이면
		if(resultMembers != null && resultMemberEmail == null) {
			return true;
		}
		return false;
	}
	
	// 회원가입 memEmail 중복 체크
	public boolean joinEmailCheck(MemberVO member) {
		
		MemberVO result = dao.joinEmailCheck(member);
		
		System.out.println("MemberController joinEmailCheck result : " + result);
		
		// member_email 테이블에 없는 이메일(중복 X)이면
		if(result == null) {
			return true;
		}
		return false;
	}
	
	// 마이페이지 수정 memEmail 중복 체크
	public boolean editEmailCheck(MemberVO member) {
		
		MemberVO resultJoin = dao.joinEmailCheck(member);
		MemberVO resultEdit = dao.editEmailCheck(member);
		
		System.out.println("MemberController joinEmailCheck resultJoin : " + resultJoin);
		System.out.println("MemberController joinEmailCheck resultEdit : " + resultEdit);
		
		// member_email 테이블에 없는 이메일(중복 X)이면
		if(resultJoin == null) {
			return true;
		}else if(resultEdit != null) {
			return true;
		}else {
			return false;
		}
	}
	
	// 회원가입(INSERT)
	public void joinMemberInsert(MemberVO member) {
		
		List<AttachVO> attachList = member.getAttachList();
		if(attachList != null && attachList.size() > 0) {
			for(AttachVO attch : attachList) {
				attch.setAtchParentNo(member.getMemNo());
				attch.setAtchRegId(member.getMemNo());
				
				attachDAO.insertAttach(attch);
			}
		}
		
		System.out.println("MemberService attachList : " + attachList);
		
		String encodePw = passwordEncoder.encode(member.getMemPass());
		logger.info("encodePw : "+ encodePw);
		member.setMemPass(encodePw);
		
		dao.joinMemberInsertEmail(member);
		dao.joinMemberInsertMemberEmail(member);
	}
	
	// 회원가입 메일 인증
	public void registerMailAut(String mail, String authKey) {
		
		MailAuthVO mailAuth = dao.getMailAuth(mail);
		
		if(mailAuth == null) {
			dao.insertMailAuth(mail, authKey);
		}else {
			dao.updateMailAuth(mail, authKey);
		}
	}
	
	// 회원가입 메일 인증 여부
	public boolean checkMailAuth(String email) {
		
		int emailCheck = dao.checkMailAuth(email);
		if(emailCheck == 1) {
			return true;
		}
		return false;
	}
	
	public boolean authKeyCompare(MailAuthVO mailAuthVO) {
		
		MailAuthVO vo = dao.getMailAuth(mailAuthVO.getMail());
		
		if(vo == null) {
			//해당 메일이 디비에 존재 하지않음 
			return false;
		}else {
			if(vo.getAuthKey().equals(mailAuthVO.getAuthKey()) ) {
				dao.completeAuth(mailAuthVO.getMail());
				return true;
			}else {
				return false;
			}
		}
		//return false;
	}
	
	// 로그인 체크
	public boolean loginCheck(MemberVO member) {
		
		MemberVO vo = null;
		if(member.getMemNo() == null || member.getMemNo().equals("")) {
			return false;
		}else {
			vo = dao.loginMember(member);
		}
		
		if(vo == null) {
			System.out.println("do not get member info");
			return false;
		}else {
			// 존재하는 아이디
			boolean match = passwordEncoder.matches(member.getMemPass(), vo.getMemPass());
			logger.info("match : " + match);
			
			if(!match) {
				return false;
			}
			
			System.out.println("success login");
			return true;
		}
	}
	
	// 로그인
	public MemberVO loginMember(MemberVO member) throws Exception {
		
		MemberVO result = dao.loginMember(member);
		
		// 아이디 혹은 비밀번호가 틀리면 아무 데이터도 조회되지 않으며
		// result에는 null값이 담긴다. (시스템상 에러는 없음)
		// 그래서 직접 에러를 발생시켜 준다.
		if(result == null) {
			throw new Exception("아이디 또는 비밀번호가 틀립니다.");
		}
		return result;
	}
	
	// 틸퇴처리한 사원번호 조회
	public Boolean loginDelMember(String memNo) {
		
		List<String> delMemNo = dao.loginDelMember();
		
		for(int i = 0; i < delMemNo.size(); i++) {
			if(memNo.equals(delMemNo.get(i))) {
				return false;
			}
		}
		return true; 
	}
	
	// 특정 멤버 조회
	public MemberVO getMember(String memNo) throws Exception {
		
		MemberVO member = null;
		if(memNo != null && ! memNo.equals("")) {
			member = dao.getMember(memNo);
		}
		if(member == null) {
			throw new Exception();
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memNo", memNo);
		map.put("atchCategory", "PROFILEPHOTO");
		
		Integer atchNo = attachDAO.getAttachNo(map);
		
		member.setAtchNo(atchNo);
		
		return member;
	}
	
	// 모든 권한 조회
	public List<RoleInfoVO> getRoleInfo() throws Exception {
		
		List<RoleInfoVO> roleInfoList = dao.getRoleInfo();
		System.out.println("MemberService getRoleInfo() roleInfoList : " + roleInfoList);
		
		if(roleInfoList == null) {
			throw new Exception();
		}
		return roleInfoList;
	}
	
	// 직급 설정 페이지 조회(관리자)
	public MemberVO getMemberRole(String memNo) throws Exception {
		
		System.out.println("MemberService getMemberRole memNo : " + memNo);
		
		MemberVO member = null;
		
		if(memNo != null && ! memNo.equals("")) {
			member = dao.getMember(memNo);
		}else {
			throw new Exception();
		}
		
		if(member == null) {
			throw new Exception();
		}
		
		String roleCode = member.getRoleCode();
		System.out.println("MemberService getMemberRole roleCode : " + roleCode);
		
		if(roleCode == null) {
			throw new Exception();
		}
		
		return member;
	}
	
	// 회원 목록 조회(관리자)
	public List<MemberVO> getMemberList(MemberSearchVO searchVO) throws Exception {

		int totalRowCount  = dao.getTotalRowCount(searchVO);
		searchVO.setTotalRowCount(totalRowCount);
		searchVO.pageSetting();
		System.out.println("searchVO.toString() : " + searchVO.toString());

		List<MemberVO> memberVO = dao.getMemberList(searchVO);
		
		if(memberVO == null) {
			throw new Exception();
		}
		return memberVO;
	}
	
	// 직급 수정(관리자)
	public void updateUserRole(String memNo, String role) throws Exception {
		
		System.out.println("role :" + role);
		
		if(memNo != null && ! memNo.equals("") && role != null && ! role.equals("")) {
			dao.updateRole(memNo, role);
		}else {
			throw new Exception();
		}
	}
	
	// 회원목록에서 부서/팀 수정(관리자)
	public void updateUserList(List<MemberVO> list) throws Exception {
		
		System.out.println("MemberService list :" + list);
		
		if(list != null && ! list.equals("")) {
			dao.updateListRole(list);
		}else {
			throw new Exception();
		}
	}
	
	// 회원 삭제(관리자)
	@Transactional
	public void removeMultiMember(String memMultiId) throws Exception {
		
		System.out.println("MemberService removeMultiMember memMultiId: " + memMultiId);
		
		ObjectMapper objectMapper = new ObjectMapper();
		try { 
			List<Object> list = objectMapper.readValue(memMultiId, new TypeReference<List<Object>>(){});
			System.out.println("list: "+ list);
				
			if(list.size() == 0) {
				throw new Exception();
			}
				
			for(int i = 0; i < list.size(); i++) {
				String memNo = (String) list.get(i);
				//MemberVO member = new MemberVO();
				//member.setMemNo(memNo);
				//System.out.println("member = " + member);
				
				int resultCntMember = dao.deleteMember(memNo); // update
				int resultEmailYn = dao.updateEmailYn(memNo);  // update
				int resultCntEmail = dao.deleteEmail(memNo);   // delete(꼭 마지막 순서)
				
				System.out.println("resultCntMember = " + resultCntMember);
				System.out.println("updateEmailYn = " + resultEmailYn);
				System.out.println("resultCntEmail = " + resultCntEmail);
				
				if(resultCntMember == 0 || resultCntEmail == 0 || resultEmailYn == 0) {
					throw new Exception("One of the operations failed. Rolling back.");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception();
		}  
	}
	
	// 회원 수정 후 저장
	public void modifyMember(MemberVO member) throws Exception {
		 
		if(member.getMemNo() != null && ! member.getMemNo().equals("")) {
			int resultCntMembers = dao.updateMembers(member);
			int resultCntEmail = dao.updateEmail(member);
			int resultCntMemberEmail = dao.updateMemberEmail(member);
			
			
			// if(resultCntMembers != 1 && resultCntMemberEmail != 1 && resultCntEmail != 1){
			if(resultCntMembers != 1 || resultCntMemberEmail != 1 || resultCntEmail != 1){
				throw new Exception();
			}
		}
		
		List<AttachVO> attachList = member.getAttachList();
		if(attachList != null) {
			for(AttachVO attach : attachList) {
				attach.setAtchParentNo(member.getMemNo());
				attach.setAtchRegId(member.getMemNo());
				attachDAO.insertAttach(attach);
			}
		}
	}
	
	// 비밀번호 변경 후 저장
	public void modifyPass(MemberVO member) throws Exception {
		 
		MemberVO vo = null;
		if(member.getMemNo() != null && ! member.getMemNo().equals("")) {
			vo = dao.getMember(member.getMemNo());
		}
		
		if(vo == null) {
			throw new Exception();
		}
		
		boolean matchPass = member.getMemPass().equals(vo.getMemPass());
		
		boolean match = passwordEncoder.matches(member.getMemPass(), vo.getMemPass());
		logger.info("match : " + match);
		if(!match && !matchPass) {
			throw new Exception();
		}
		
		String encodedPw = passwordEncoder.encode(member.getMemPassNew());
		member.setMemPassNew(encodedPw);
		int resultCnt = dao.updatePass(member);
		
		if(resultCnt != 1){
			throw new Exception();
		}
	}
	
	// 기존 비밀번호 체크
	public boolean passCheck(MemberVO member) throws Exception{
		
		MemberVO vo = null;
		if(member.getMemNo() != null && ! member.getMemNo().equals("")) {
			vo = dao.getMember(member.getMemNo());
		}
		
		if(vo == null) {
			throw new Exception();
		}
		
		boolean matchPass = member.getMemPass().equals(vo.getMemPass());
		
		boolean match = passwordEncoder.matches(member.getMemPass(), vo.getMemPass());
		logger.info("match : " + match);
		if(!match && !matchPass) {
			return false;
		}
		
		return true;
	}
	
	// 로그인 시간
	public void loginTime(String memNo) {
		
		if(memNo != null && ! memNo.equals("")) {
			dao.loginTime(memNo);
		}
	}
	
	// 로그아웃 시간
	public void logoutTime(String memNo) {
		
		if(memNo != null && ! memNo.equals("")) {
			dao.logoutTime(memNo);
		}
	}
	
}
