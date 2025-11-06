package com.bteam.proj.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.bteam.proj.common.vo.RoleInfoVO;
import com.bteam.proj.member.vo.MailAuthVO;
import com.bteam.proj.member.vo.MemberSearchVO;
import com.bteam.proj.member.vo.MemberVO;

@Mapper
public interface IMemberDAO {
	
	// 회원가입 진행(SELECT) members 테이블에 존재하는가
	public MemberVO joinCheckMembers(MemberVO member);
	
	// 회원가입 진행(SELECT) member_email 테이블에 존재하는가
	public MemberVO joinCheckMemberEmail(MemberVO member);
	
	// 회원가입 memEmail 중복 체크
	public MemberVO joinEmailCheck(MemberVO member);
	
	// 회원가입 memEmail 중복 체크
	public MemberVO editEmailCheck(MemberVO member);
	
	// 회원가입 진행(INSERT) email 테이블에 넣기
	public int joinMemberInsertEmail(MemberVO member);

	// 회원가입 진행(INSERT) : member_email 테이블에 넣기
	public int joinMemberInsertMemberEmail(MemberVO member);
	
	// 메일 인증
	public MailAuthVO getMailAuth(String mail);
	public void insertMailAuth(@Param("mail")String mail, @Param("authKey")String authKey);
	public void updateMailAuth(@Param("mail")String mail, @Param("authKey")String authKey);
	public void completeAuth(String mail);
	public int checkMailAuth(String memEmail);
	
	// 로그인 진행(SELECT)
	public MemberVO loginMember(MemberVO member);
	
	// 틸퇴처리한 사원번호 조회(SELECT)
	public List<String> loginDelMember();
	
	// 특정 멤버 조회(SELECT)
	public MemberVO getMember(String memNo);
	
	// 모든 권한 종류 조회(SELECT)
	public List<RoleInfoVO> getRoleInfo();
	
	// 특정 멤버 권한 List로 조회(CustomUser에서만 사용)
	public List<String> getUserRoleList(String memNo);
	
	// 멤버 수 조회
	public int getTotalRowCount(MemberSearchVO searchVO);
	
	// 멤버 목록 조회(관리자)
	public List<MemberVO> getMemberList(MemberSearchVO searchVO);
	
	// 직급 수정(관리자)
	public void updateRole(@Param("memNo") String memNo, @Param("role")String role);
	
	// 회원목록에서 부서/팀 수정(관리자)
	public void updateListRole(List<MemberVO> list);
	
	// 회원 삭제(관리자)
	public int deleteMember(String memNo);
	public int deleteEmail(String memNo);
	public int updateEmailYn(String memNo);
	
	// 회원 수정 후 저장
	public int updateMembers(MemberVO member);
	public int updateMemberEmail(MemberVO member);
	public int updateEmail(MemberVO member);
	
	// 비밀번호 변경 후 저장
	public int updatePass(MemberVO member);
	
	// 로그인, 로그아웃 시간
	public void loginTime(String memNo);
	public void logoutTime(String memNo);
	
	
}
