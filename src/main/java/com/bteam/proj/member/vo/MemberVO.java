package com.bteam.proj.member.vo;

import java.util.List;

import com.bteam.proj.attach.vo.AttachVO;
import com.bteam.proj.carpool.vo.CarVO;

public class MemberVO {
	private String memNo;           /* 사원번호 */
	private String memName;         /* 이름 */
	private String memEmail;        /* 이메일 */
	private String memPass;         /* 비밀번호 */
	private String memPhone;        /* 전화번호 */
	private String memAdd;          /* 주소 */
	private int memMileage;         /* 마일리지 */
	private String roleCode;        /* 권한 */
	private String memDept;         /* 부서코드 */
	private String memTeam;         /* 팀코드 */
	private String memJoinDate;     /* 입사날짜 */
	private String memDelDate;      /* 퇴사날짜 */
	private String memDelYn;        /* 퇴사여부 */
	private String memBirthday;        /* 생일 */
	private String memGender;       /* 성별 */
	private String memAge;          /* 나이 */
	private List<AttachVO> attachList;
	private Integer atchNo;
	private String atchFileName;
	private List<CarVO> carList;
	private List<String> roleList;
	private String rnum;
	private String memPassNew;

	



	public String getAtchFileName() {
		return atchFileName;
	}

	public void setAtchFileName(String atchFileName) {
		this.atchFileName = atchFileName;
	}

	@Override
	public String toString() {
		return "MemberVO [memNo=" + memNo + ", memName=" + memName + ", memEmail=" + memEmail + ", memPass=" + memPass
				+ ", memPhone=" + memPhone + ", memAdd=" + memAdd + ", memMileage=" + memMileage + ", roleCode="
				+ roleCode + ", memDept=" + memDept + ", memTeam=" + memTeam + ", memJoinDate=" + memJoinDate
				+ ", memDelDate=" + memDelDate + ", memDelYn=" + memDelYn + ", memBirthday=" + memBirthday
				+ ", memGender=" + memGender + ", memAge=" + memAge + ", attachList=" + attachList + ", atchNo="
				+ atchNo + ", atchFileName=" + atchFileName + ", carList=" + carList + ", roleList=" + roleList
				+ ", rnum=" + rnum + ", memPassNew=" + memPassNew + "]";
	}

	public MemberVO(String memNo, String memName, String memEmail, String memPass, String memPhone, String memAdd,
			int memMileage, String roleCode, String memDept, String memTeam, String memJoinDate, String memDelDate,
			String memDelYn, String memBirthday, String memGender, String memAge, List<AttachVO> attachList,
			Integer atchNo, String atchFileName, List<CarVO> carList, List<String> roleList, String rnum,
			String memPassNew) {
		super();
		this.memNo = memNo;
		this.memName = memName;
		this.memEmail = memEmail;
		this.memPass = memPass;
		this.memPhone = memPhone;
		this.memAdd = memAdd;
		this.memMileage = memMileage;
		this.roleCode = roleCode;
		this.memDept = memDept;
		this.memTeam = memTeam;
		this.memJoinDate = memJoinDate;
		this.memDelDate = memDelDate;
		this.memDelYn = memDelYn;
		this.memBirthday = memBirthday;
		this.memGender = memGender;
		this.memAge = memAge;
		this.attachList = attachList;
		this.atchNo = atchNo;
		this.atchFileName = atchFileName;
		this.carList = carList;
		this.roleList = roleList;
		this.rnum = rnum;
		this.memPassNew = memPassNew;
	}

	public MemberVO() {
		
	}

	public String getMemNo() {
		return memNo;
	}

	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getMemEmail() {
		return memEmail;
	}

	public void setMemEmail(String memEmail) {
		this.memEmail = memEmail;
	}

	public String getMemPass() {
		return memPass;
	}

	public void setMemPass(String memPass) {
		this.memPass = memPass;
	}

	public String getMemPhone() {
		return memPhone;
	}

	public void setMemPhone(String memPhone) {
		this.memPhone = memPhone;
	}

	public String getMemAdd() {
		return memAdd;
	}

	public void setMemAdd(String memAdd) {
		this.memAdd = memAdd;
	}

	public int getMemMileage() {
		return memMileage;
	}

	public void setMemMileage(int memMileage) {
		this.memMileage = memMileage;
	}

	public String getRoleCode() {
		return roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public String getMemDept() {
		return memDept;
	}

	public void setMemDept(String memDept) {
		this.memDept = memDept;
	}

	public String getMemTeam() {
		return memTeam;
	}

	public void setMemTeam(String memTeam) {
		this.memTeam = memTeam;
	}

	public String getMemJoinDate() {
		return memJoinDate;
	}

	public void setMemJoinDate(String memJoinDate) {
		this.memJoinDate = memJoinDate;
	}

	public String getMemDelDate() {
		return memDelDate;
	}

	public void setMemDelDate(String memDelDate) {
		this.memDelDate = memDelDate;
	}

	public String getMemDelYn() {
		return memDelYn;
	}

	public void setMemDelYn(String memDelYn) {
		this.memDelYn = memDelYn;
	}

	public String getMemBirthday() {
		return memBirthday;
	}

	public void setMemBirthday(String memBirthday) {
		this.memBirthday = memBirthday;
	}

	public String getMemGender() {
		return memGender;
	}

	public void setMemGender(String memGender) {
		this.memGender = memGender;
	}

	public String getMemAge() {
		return memAge;
	}

	public void setMemAge(String memAge) {
		this.memAge = memAge;
	}

	public List<AttachVO> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<AttachVO> attachList) {
		this.attachList = attachList;
	}

	public Integer getAtchNo() {
		return atchNo;
	}

	public void setAtchNo(Integer atchNo) {
		this.atchNo = atchNo;
	}

	public List<CarVO> getCarList() {
		return carList;
	}

	public void setCarList(List<CarVO> carList) {
		this.carList = carList;
	}

	public List<String> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<String> roleList) {
		this.roleList = roleList;
	}

	public String getRnum() {
		return rnum;
	}

	public void setRnum(String rnum) {
		this.rnum = rnum;
	}

	public String getMemPassNew() {
		return memPassNew;
	}

	public void setMemPassNew(String memPassNew) {
		this.memPassNew = memPassNew;
	}
	
	
}
