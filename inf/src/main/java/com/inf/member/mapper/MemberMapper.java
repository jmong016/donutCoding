package com.inf.member.mapper;

import java.util.List;
import java.util.Map;

import com.inf.member.domain.MemberVO;
import com.inf.task.domain.ProfileFileVO;

public interface MemberMapper {
	//아이디 체크
	public int idChk(String member_id);
	// 회원가입
	public int register(MemberVO memberVO);
	//이메일 체크
	public int emailChk(String member_email);
	// 아이디에 해당하는 memberVO하나 가져오기
	public MemberVO selectOneById(String member_id);
	// 멘토 신청한 회원의 status를 승인대기로 변경하기
	public int updateMemberStatusToAwait(String member_id);
	// 멘토 신청을 취소한 회원의 status를 신청취소로 변경하기
	public int updateMemberStatusToCancle(String member_id);
	// 멘토 승인 대기중인 모든 회원
	public List<MemberVO> selectAllAwaitMemberForMentor();
	// 모든 멘토 회원
	public List<MemberVO> selectAllMentor();
	// 모든 자격정지 멘토 회원
	public List<MemberVO> selectAllMentorStopped();
	// 멘티 -> 멘토로 승인
	public int updateMemberRoleToMentor(String member_id);
	// 멘토 자격 정지
	public int updateMemberStatusToStop(String member_id);
	// 멘토 자격 복귀
	public int updateMemberStatusToApprove(String member_id);
	// 프로필 이미지 변경
	public int updateProfileImage(MemberVO member);
	// 회원 정보 변경(일반)
	public int updateMemberInformation(MemberVO member);
	// 회원 정보 변경(비밀번호)
	public int updateMemberPassword(MemberVO member);
	// 회원 정보 변경(전화번호)
	public int updateMemberPhoneNo(MemberVO member);
	// 모든 회원 수
	public int selectAllUserCount();
	public List<ProfileFileVO> selectProfileImageFiles();
	

}
