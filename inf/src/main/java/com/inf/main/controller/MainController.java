package com.inf.main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.inf.course.domain.CategorySkillVO;
import com.inf.course.domain.CourseVO;
import com.inf.course.service.CourseService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/")
@Log4j
public class MainController {
	
	@Autowired
	private CourseService courseService;

	@GetMapping(value = {"/","main"})
	public String main(HttpServletRequest request,Model model) {
		Map<String, List<CourseVO>> courseMap = courseService.indexCourseLists();
		HttpSession session = request.getSession();
		if(session.getAttribute("ctMap") == null) {
			List<CategorySkillVO> ctMap = courseService.categorySkillLists();
			session.setAttribute("ctMap", ctMap);
		}
		model.addAttribute("courseMap",courseMap);
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