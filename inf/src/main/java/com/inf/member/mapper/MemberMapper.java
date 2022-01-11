package com.inf.member.mapper;

import java.util.Map;

import com.inf.member.domain.MemberVO;

public interface MemberMapper {
	//아이디 체크
	public int idChk(String member_id);
	// 회원가입
	public int register(MemberVO memberVO);
	//이메일 체크
	public int emailChk(String member_email);
	// 아이디에 해당하는 memberVO하나 가져오기
	public MemberVO selectOneById(String member_id);
	

}
