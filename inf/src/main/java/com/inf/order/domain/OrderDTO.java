package com.inf.order.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDTO {
	private int order_seq;
	private int order_id;
	private int course_seq;
	private String member_id;
	private String buyer_name;
	private String buyer_phone;
	private String buyer_email;
	private int course_available_period;
	private int amounted_pay;
	private Date orderDT;
}
