package com.inf.main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.inf.course.domain.CategorySkillVO;
import com.inf.course.domain.CourseVO;
import com.inf.course.service.CourseService;
import com.inf.member.service.MemberService;
import com.inf.review.domain.ReviewVO;
import com.inf.review.service.ReviewService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {
	
	@Autowired
	private CourseService courseService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private MemberService memberService;

	@GetMapping(value = {"/","/main"})
	public String main(HttpServletRequest request,Model model) {
		Map<String, List<CourseVO>> courseMap = courseService.indexCourseLists();
		List<ReviewVO> review = reviewService.selectRecentReviewOfCourse();
		int memberCount = memberService.getAllUserCount();
		HttpSession session = request.getSession();
		if(session.getAttribute("ctMap") == null) {
			List<CategorySkillVO> ctMap = courseService.categorySkillLists();
			session.setAttribute("ctMap", ctMap);
		}
		model.addAttribute("courseMap",courseMap);
		model.addAttribute("memberCount",memberCount);
		model.addAttribute("review",review);
		return "main/index";
	}
	
	@GetMapping("/main/login")
	public String showlogin(HttpServletRequest request, String referer, RedirectAttributes rda) {
		Map<String, List<CourseVO>> courseMap = courseService.indexCourseLists();
		HttpSession session = request.getSession();
		if(session.getAttribute("ctMap") == null) {
			List<CategorySkillVO> ctMap = courseService.categorySkillLists();
			session.setAttribute("ctMap", ctMap);
		}
		System.out.println("mainController >>>>>> "+referer);
		rda.addFlashAttribute("loginMember","true");
		rda.addFlashAttribute("referer", referer);
		return "redirect:/main";
	}
}