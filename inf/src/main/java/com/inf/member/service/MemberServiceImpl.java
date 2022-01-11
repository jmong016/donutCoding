package com.inf.member.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.inf.member.domain.MemberVO;
import com.inf.member.domain.UserVO;
import com.inf.member.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service("memberService")
@Transactional
@Log4j
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;

	//아이디 체크
	@Override
	public int idChk(String member_id) {
		int result = memberMapper.idChk(member_id);
//		log.info("idChk>>>>>" + result );
		System.out.println(result);
		return result;
	}
	// 회원가입
	@Override
	public int register(MemberVO memberVO) {
		int result = memberMapper.register(memberVO);
		return result;
	}
	//이메일 체크
	@Override
	public int emailChk(String member_email) {
		int result = memberMapper.emailChk(member_email);
		return result;
	}
    // 로그인
	@Override
	public UserVO login(String member_id, String member_password) {
		UserVO user = new UserVO();
		MemberVO member = selectOneById(member_id);
		if(member == null) {
			log.info("id에 해당하는 member 없음");
			return null;
		}else {
			log.info("mapper.xml 결과물 >>>>>>> " + member.getMember_id());
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if(encoder.matches(member_password, member.getMember_password())){
				log.info("비밀번호 일치");
				user.setMember_id(member.getMember_id());
				user.setMember_role(member.getMember_role());
				user.setMember_nickNM(member.getMember_nickNM());
				return user;
			}else {
				log.info("비밀번호 불일치");
				return null;
			}
		}
				
		
	}
	
	public MemberVO selectOneById(String member_id) {
		return memberMapper.selectOneById(member_id);
	}


}
