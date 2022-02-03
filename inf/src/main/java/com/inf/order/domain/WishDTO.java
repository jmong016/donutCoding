package com.inf.order.domain;

import java.util.Date;

import lombok.Data;

@Data
public class WishDTO {
	private int wish_seq;
	private int course_seq;
	private String member_id;
	private Date wish_regdt;
}
