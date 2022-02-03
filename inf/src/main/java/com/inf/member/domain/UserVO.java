package com.inf.member.domain;

import lombok.Data;

@Data
public class UserVO {
	private String member_id; //회원 아이디
	private String member_email; //회원 이메일
	private String member_nickNM; //회원 닉네임
	private String member_profile_img_nm; // 프로필 경로
	private String member_content; //자기소개 
	private String member_phoneNO; //휴대폰 번호
	private String member_status; // 승인대기 || 신청취소
	private String member_role; //멘티 || 멘토 || 관리자
}
