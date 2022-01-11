package com.inf.member.domain;

import lombok.Data;

@Data
public class MemberVO {
	private String member_id; //회원 아이디
	private String member_password; //회원 비밀번호
	private String blog_url; //블로그 주소
	private String member_email; //회원 이메일
	private String member_nickNM; //회원 닉네임
	private String member_profile_img_path; // 프로필 경로
	private String member_content; //자기소개 
	private String member_phoneNO; //휴대폰 번호
	private String member_regDT; //가입일
	private String member_applyDT; //수정일
	private String member_role; //일반회원 or 강사
	private String enabled; //탈퇴 유무

}
