package com.inf.course.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.inf.common.annotation.LoginRequired;
import com.inf.course.domain.CategorySkillVO;
import com.inf.course.domain.CourseVO;
import com.inf.course.domain.SkillVO;
import com.inf.course.service.CourseService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CourseController {

	@Autowired
	private CourseService courseService;

	@GetMapping("/courses")
	public String allCourses(HttpSession session ,@Nullable @RequestParam String order, Model model) {
		if(session.getAttribute("ctMap") == null) {
			List<CategorySkillVO> ctMap = courseService.categorySkillLists();
			session.setAttribute("ctMap", ctMap);
		}
		log.info("강의 리스트 접근 >>>> " + order);
		List<CourseVO> allCourse = courseService.allCourseList(order);
		System.out.println(allCourse.size());
		if(order != null) {
				model.addAttribute("sort", order);
		}
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
	
	@PostMapping("/course/search")
	public String searchCourse(String type,String item,Model model){
		log.info("검색 >>>>>" + type + " || " + item);
		List<CourseVO> course = courseService.searchCourse(type,item);
		model.addAttribute("course", course);
		return "course/courseList";
	}
	

}
