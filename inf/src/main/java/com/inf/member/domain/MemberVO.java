package com.inf.member.domain;

import lombok.Data;

@Data
public class MemberVO {
	private String member_id; //회원 아이디
	private String member_password; //회원 비밀번호
	private String member_email; //회원 이메일
	private String member_nickNM; //회원 닉네임
	private String member_profile_img_nm; // 프로필 경로
	private String member_content; //자기소개 
	private String member_phoneNO; //휴대폰 번호
	private String member_regDT; //가입일
	private String member_applyDT; //멘토 신청일
	private String member_approveDT; //멘토 승인일
	private String member_stopDT; //자격정지일
	private String member_status; // 승인대기 || 신청취소
	private String member_role; //멘티 || 멘토 || 관리자
	private String enabled; //탈퇴 유무

}
