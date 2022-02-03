package com.inf.order.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CartDTO {
	private int cart_seq;
	private int course_seq;
	private String member_id;
	private Date cart_regdt;
}
