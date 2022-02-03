package com.inf.review.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inf.review.domain.ReviewVO;
import com.inf.review.service.ReviewService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/review")
@Controller
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("/course")
	public String showReviewOfCourse(Model model) {
		List<ReviewVO> review = reviewService.selectAllReviewOfCourse();
		model.addAttribute("courseReview", review);
		return "/review/course";
	}
	
	@ResponseBody
	@PostMapping("/isduplicated")
	public Boolean isduplicated(ReviewVO review){
		log.info("수강 후기 작성 >>>>>> " + review);
		Boolean result = reviewService.selectDuplicatedReviewOfCourse(review);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/writeCourse")
	public Map<String, Object> writeReviewOfCourse(ReviewVO review){
		log.info("수강평 작성 >>>>>> " + review);
		Map<String, Object> map = reviewService.insertNewReviewOfCourse(review);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/deleteCourse")
	public Map<String, Object> deleteReviewOfCourse(ReviewVO review){
		log.info("수강평 삭제 >>>>>> " + review);
		Map<String, Object> map = reviewService.deleteReviewOfCourse(review);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/modifyCourse")
	public Map<String, Object> updateReviewOfCourse(ReviewVO review){
		log.info("수강평 수정 >>>>>> " + review);
		Map<String, Object> map = reviewService.updateReviewOfCourse(review);
		return map;
	}
	
}
