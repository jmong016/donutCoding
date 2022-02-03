package com.inf.order.domain;

import lombok.Data;

@Data
public class OrderCourseVO {
	private int course_seq;
	private String course_nm;
	private String course_img_nm;
	private int course_available_period;
	private int amounted_pay;
}
