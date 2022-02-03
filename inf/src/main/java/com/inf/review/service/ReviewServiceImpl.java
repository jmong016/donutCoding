package com.inf.review.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.inf.review.domain.ReviewVO;
import com.inf.review.mapper.ReviewMapper;

import lombok.Setter;

@Service("reviewService")
public class ReviewServiceImpl implements ReviewService{
	
	@Setter(onMethod_ = @Autowired)
	private ReviewMapper reviewMapper;

	@Override
	public List<ReviewVO> selectAllReviewOfCourse() {
		List<ReviewVO> review = reviewMapper.selectAllReviewOfCourse();
		return review.size() == 0? null : review;
	}
	@Override
	public List<ReviewVO> selectReviewOfCourseByMemberId(String member_id) {
		List<ReviewVO> review = reviewMapper.selectAllReviewOfCourseByMemberId(member_id);
		return review.size() == 0? null : review;
	}
	
	@Override
	public Boolean selectDuplicatedReviewOfCourse(ReviewVO review) {
		int duple = reviewMapper.selectDuplicatedReviewByCourseSeqAndMemberId(review);
		return duple == 0? true : false;
	}
	
	@Override
	public Map<String, Object> insertNewReviewOfCourse(ReviewVO review) {
		Map<String, Object> map = new HashMap<String, Object>();
		int insert = reviewMapper.insertNewReviewOfCourse(review);
			if(insert > 0) {
				map.put("result", true);
				map.put("title","수강평 작성 완료");
				map.put("msg","작성한 수강평으로 이동하시겠습니까?");
				map.put("type","success");
			}else {
				map.put("result", false);
				map.put("title","수강평 작성 실패");
				map.put("msg","다시 시도해주세요.");
				map.put("type","error");
			}
		return map;
	}
	@Transactional
	@Override
	public Map<String, Object> deleteReviewOfCourse(ReviewVO review) {
		Map<String, Object> map = new HashMap<String, Object>();
		int delete = reviewMapper.deleteReviewOfCourse(review);
			if(delete > 0) {
				map.put("title","수강평 삭제 완료");
				map.put("msg","수강평이 성공적으로 삭제되었습니다.");
				map.put("type","success");
			}else {
				map.put("title","수강평 삭제 실패");
				map.put("msg","다시 시도해주세요.");
				map.put("type","error");
			}
		return map;
	}
	@Override
	public Map<String, Object> updateReviewOfCourse(ReviewVO review) {
		Map<String, Object> map = new HashMap<String, Object>();
		int update = reviewMapper.updateReviewOfCourse(review);
			if(update > 0) {
				map.put("title","수강평 수정 완료");
				map.put("msg","수강평이 성공적으로 수정되었습니다.");
				map.put("type","success");
			}else {
				map.put("title","수강평 수정 실패");
				map.put("msg","다시 시도해주세요.");
				map.put("type","error");
			}
		return map;
	}
	@Override
	public List<ReviewVO> selectRecentReviewOfCourse() {
		List<ReviewVO> review = reviewMapper.selectRecentReviewOfCourse();
		return review.size() == 0? null : review;
	}
	
}
