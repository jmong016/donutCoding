package com.inf.review.service;

import java.util.List;
import java.util.Map;

import com.inf.review.domain.ReviewVO;

public interface ReviewService {

	Boolean selectDuplicatedReviewOfCourse(ReviewVO review);
	Map<String, Object> insertNewReviewOfCourse(ReviewVO review);
	List<ReviewVO> selectAllReviewOfCourse();
	List<ReviewVO> selectReviewOfCourseByMemberId(String member_id);
	Map<String, Object> deleteReviewOfCourse(ReviewVO review);
	Map<String, Object> updateReviewOfCourse(ReviewVO review);
	List<ReviewVO> selectRecentReviewOfCourse();
	

}
