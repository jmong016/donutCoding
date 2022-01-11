package com.inf.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.inf.common.annotation.LoginRequired;
import com.inf.course.domain.CourseVO;
import com.inf.course.service.CourseService;
import com.inf.member.domain.MemberVO;
import com.inf.member.domain.UserVO;
import com.inf.member.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/mypage")
public class MyPageController{
	
	private static String CURR_IMAGE_REPO_PATH = "C:\\inf\\file_repo";
	private static String IMAGE_TEMP_PATH = "C:\\inf\\temp";

	@Autowired
	private CourseService courseService;
	@Autowired
	private MemberService memberService;

	
	@GetMapping(value = { "/main", "/myCourse" })
	@LoginRequired
	public String myCourse(HttpServletRequest request,Model model) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		String member_id = user.getMember_id();
		String role = user.getMember_role();
		String path = getPathByMemberRole(role);
		if (role.equals("멘토")) {
			List<CourseVO> await = courseService.awaitCourse(member_id);
			List<CourseVO> cancle = courseService.cancelCourse(member_id);
			model.addAttribute("awaitCourse", await);
			model.addAttribute("cancleCourse", cancle);
			return path+"/myCourse";
		} else {
			return path+"/myCourse";
		}
	}

	@GetMapping("/myPurchase")
	public String viewMyPurchase(HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		return "/mypage/myPurchase";
	}

	@GetMapping("/myInfo")
	public String viewMyInfo(HttpServletRequest request) {
		return "/mypage/myInfo";
	}
	
	// 멘토 - 강의 등록 신청
	@ResponseBody
	@PostMapping("/applyCourse")
	public Map<String, String> applyCourse(@RequestParam(value = "cts[]") List<Integer> category_seq,
			@RequestParam(value = "sks[]") List<String> skill_nm, CourseVO course) throws IOException {
		log.info(category_seq);
		log.info(skill_nm);
		log.info(course);
		Map<String, String> map = new HashMap<String, String>();

		int course_seq = courseService.addNewCourse(course, category_seq, skill_nm);
		File srcFile = new File(IMAGE_TEMP_PATH + "\\" + course.getCourse_img_nm() + "\\" + course.getCourse_img_nm());
		File destDir = new File(CURR_IMAGE_REPO_PATH + "\\" + course_seq);
		FileUtils.moveFileToDirectory(srcFile, destDir, true);
		
		map.put("result", "강의 등록 신청이 완료되었습니다.");

		return map;
	}
	
	// 멘토 - 신청 취소
	@ResponseBody
	@PostMapping("/cancelCourse")
	public Map<String, String> cancelCourse(int course_seq){
		log.info(course_seq);
		Map<String, String> map = new HashMap<String, String>();

		CourseVO course = courseService.cancelCourse(course_seq);
		
		if(course != null) {
			map.put("result", "강의 등록 취소가 완료되었습니다.");
		}else {
			map.put("result", "강의 등록 취소 실패, 다시 시도해주세요.");
		}
		return map;
	}

	// 멘토 - 등록 신청 후 대기중인 강의 보기
	@GetMapping("/awaitCourse")
	public String awaitCourse(RedirectAttributes rda) {
		rda.addFlashAttribute("await", true);
		return "redirect:/mypage/myCourse";
	}
	
	// 멘토 - 신청 취소후 취소한 강의보기
	@GetMapping("/cancelCourse")
	public String cancleCourse(RedirectAttributes rda) {
		rda.addFlashAttribute("cancle", true);
		return "redirect:/mypage/myCourse";
	}
	
	// 회원의 권한(멘티,멘토,관리자)에 따라 경로 반환
	private String getPathByMemberRole(String role) {
		if (role.equals("멘티")) {
			return "/mypage/mentee";
		} else if (role.equals("멘토")) {
			return "/mypage/mentor";
		} else {
			return "/mypage/admin";
		}
	}
}
