package com.inf.course.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inf.common.annotation.LoginRequired;
import com.inf.course.domain.CategorySkillVO;
import com.inf.course.domain.CourseVO;
import com.inf.course.domain.SkillVO;
import com.inf.course.service.CourseService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/")
@Log4j
public class CourseController {

	@Autowired
	private CourseService courseService;

	@GetMapping("/courses")
	public String allCourses(HttpServletRequest request , Model model) {
		HttpSession session = request.getSession();
		if(session.getAttribute("ctMap") == null) {
			List<CategorySkillVO> ctMap = courseService.categorySkillLists();
			session.setAttribute("ctMap", ctMap);
		}
		log.info("강의 리스트 접근");
		List<CourseVO> allCourse = courseService.allCourseList();
		System.out.println(allCourse.size());

		model.addAttribute("course", allCourse);

		return "course/courseList";
	}
	
	// 강의 상세페이지
	@GetMapping("/course/{course_seq}")
	public String courseDatail(@PathVariable("course_seq") String course_seq, Model model) {
		System.out.println("강의 상세페이지 접근");
		int category_seq = Integer.parseInt(course_seq);
		CourseVO course = courseService.courseByCourseSeq(category_seq);

		model.addAttribute("course", course);
		
		return "course/courseDetail";
	}

	@GetMapping("/courses/{category_seq}")
	public String coursesByCategory(@PathVariable("category_seq") String ct, Model model) {
		System.out.println("카테고리별 강의 리스트 접근");
		int category_seq = Integer.parseInt(ct);
		List<CourseVO> ctCourse = courseService.courseListByCategory(category_seq);
		System.out.println(ctCourse.size());

		model.addAttribute("course", ctCourse);

		return "course/courseList";
	}

	@GetMapping("/courses/{category_seq}/{skill_seq}")
	public String coursesBySkill(@PathVariable("category_seq") String ct, @PathVariable("skill_seq") String ss,
			Model model) {
		System.out.println("카테고리/스킬별 강의 리스트 접근");
		int category_seq = Integer.parseInt(ct);
		int skill_seq = Integer.parseInt(ss);
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("category_seq", category_seq);
		param.put("skill_seq", skill_seq);
		List<CourseVO> ctSkCourse = courseService.courseListByCategoryBySkill(param);
		System.out.println(ctSkCourse.size());

		model.addAttribute("course", ctSkCourse);

		return "course/courseList";
	}
	
//	@ResponseBody
//	@GetMapping("course/showSkills")
//	public Map<String, List<SkillVO>> sendSkills(String course_seq, HttpServletRequest request){
//		Map<String, List<SkillVO>> map = new HashMap<String, List<SkillVO>>();
//		int seq = Integer.parseInt(course_seq);
//		
//		return map;
//	}
	

}
