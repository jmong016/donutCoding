package com.inf.course.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class PurchaseCourseVO {
	private int course_seq;
	private CourseVO course;
	private Date end_dt;
}
