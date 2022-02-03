package com.inf.order.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderListVO {
	private int order_seq;
	private int order_id;
	private List<OrderCourseVO> courses;
	private String member_id;
	private String buyer_name;
	private String buyer_phone;
	private String buyer_email;
	private Date orderDT;
}
