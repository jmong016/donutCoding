package com.inf.review.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	private int reviewSeq;
	private int courseSeq;
	private String courseName;
	private String courseImg;
	private String memberID;
	private String memberNick;
	private String content;
	private int rate;
	private Date regDate;
}
