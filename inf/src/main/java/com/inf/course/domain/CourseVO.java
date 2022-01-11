package com.inf.course.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class CourseVO {
	private int course_seq; // 강좌 번호 - PK
	private String member_id; // 강사 이름
	private String course_NM; // 강좌 이름
	private String course_level; // 난이도
	private int    course_studyCNT; // 수강생 수
	private String course_img_nm; // 대표 이미지 경로
	private String course_intro; // 소개
	private int    course_price; // 정상가
	private int    course_sales_price; // 할인가
	private int	   course_discount_rate; // 할인율
	private Date   course_applyDT; // 승인 요청일
	private Date   course_regDT; // 승인일
	private Date   course_cancelDT; // 승인 신청 취소일
	private int    course_available_period; // 수강 가능 기간
	private String course_status; // 상태 : (승인완료, 승인대기, 승인 취소)
	private List<CategoryVO> ct_list;
	private List<SkillVO> skill_list;
}
