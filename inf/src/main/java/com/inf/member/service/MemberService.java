package com.inf.member.service;

import java.util.List;
import java.util.Map;

import com.inf.member.domain.MemberVO;
import com.inf.member.domain.UserVO;

public interface MemberService {

	int idChk(String memberId);

	int register(MemberVO memberVO);

	int emailChk(String member_email);

	UserVO login(String member_id, String member_password);

	Map<String, Object> changeRoleToMentor(String member_id);

	Map<String, Object> cancleApplyforMentor(String member_id);

	List<MemberVO> allMemberApplyToMentor();

	List<MemberVO> allMentorApproved();

	List<MemberVO> allMentorStopped();

	int approveMentor(String member_id);

	int stopMentor(String member_id);

	int restartMentor(String member_id);

	int changeProfileImage(MemberVO member);

	int changeMemberInfo(MemberVO member);

	Map<String, String> changeMemberPassword(MemberVO member, String new_password);

	int changeMemberPhoneNo(MemberVO member);

	int getAllUserCount();
	
}
