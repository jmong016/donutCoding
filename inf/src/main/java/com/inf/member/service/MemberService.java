package com.inf.member.service;

import java.util.Map;

import com.inf.member.domain.MemberVO;
import com.inf.member.domain.UserVO;

public interface MemberService {

	int idChk(String memberId);

	int register(MemberVO memberVO);

	int emailChk(String member_email);

	UserVO login(String member_id, String member_password);
	
}
