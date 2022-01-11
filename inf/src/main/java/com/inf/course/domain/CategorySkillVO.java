package com.inf.course.domain;

import java.util.List;

import lombok.Data;

@Data
public class CategorySkillVO {
	private int category_seq;
	private String category_nm;
	private List<SkillVO> skill_list;
}
