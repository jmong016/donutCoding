package com.inf.review.mapper;

import java.util.List;

import com.inf.review.domain.ReviewVO;

public interface ReviewMapper {

	List<ReviewVO> selectAllReviewOfCourse();
	int selectDuplicatedReviewByCourseSeqAndMemberId(ReviewVO review);
	int insertNewReviewOfCourse(ReviewVO review);
	List<ReviewVO> selectAllReviewOfCourseByMemberId(String member_id);
	int deleteReviewOfCourse(ReviewVO review);
	int updateReviewOfCourse(ReviewVO review);
	List<ReviewVO> selectRecentReviewOfCourse();

	

}
