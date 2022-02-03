package com.inf.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.inf.common.annotation.AdminOnly;
import com.inf.common.annotation.LoginRequired;
import com.inf.course.domain.CourseVO;
import com.inf.course.service.CourseService;
import com.inf.member.domain.MemberVO;
import com.inf.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin")
@Controller
public class AdminController {

	@Autowired
	private CourseService courseService;
	@Autowired
	private MemberService memberService;

	@GetMapping("/manageCourse")
	@LoginRequired
	public String manageCourse(Model model) {
		List<CourseVO> await = courseService.allAwaitCourse();
		List<CourseVO> able = courseService.allAbleCourse();
		List<CourseVO> enable = courseService.allEnableCourse();
		model.addAttribute("awaitCourse", await);
		model.addAttribute("enableCourse", enable);
		model.addAttribute("ableCourse", able);
		return "/mypage/admin/manageCourse";
	}

	// 강의 승인
	@ResponseBody
	@PostMapping("/approveCourse")
	public Map<String, String> approveCourse(int course_seq) {
		log.info(course_seq);
		Map<String, String> map = new HashMap<String, String>();

		int result = courseService.approveCourse(course_seq);

		if (result > 0) {
			map.put("result", "true");
			map.put("msg", "강의 승인이 완료되었습니다.");
		} else {
			map.put("result", "false");
			map.put("msg", "강의 승인 실패, 다시 시도해주세요.");
		}
		return map;
	}

	@GetMapping("/approvedCourse")
	public String approveCourse(RedirectAttributes rda) {
		rda.addFlashAttribute("approved", true);
		return "redirect:/admin/manageCourse";
	}

	// 강의 판매 중지
	@ResponseBody
	@PostMapping("/stopCourse")
	public Map<String, String> stopCourse(int course_seq) {
		log.info(course_seq);
		Map<String, String> map = new HashMap<String, String>();

		int result = courseService.stopCourse(course_seq);

		if (result > 0) {
			map.put("result", "true");
			map.put("msg", "해당 강의 판매가 중지되었습니다.");
		} else {
			map.put("result", "false");
			map.put("msg", "강의 판매 중지 실패, 다시 시도해주세요.");
		}
		return map;
	}

	@GetMapping("/stoppedCourse")
	public String stoppedCourse(RedirectAttributes rda) {
		rda.addFlashAttribute("stopped", true);
		return "redirect:/admin/manageCourse";
	}

	// 강의 재판매
	@ResponseBody
	@PostMapping("/restartCourse")
	public Map<String, String> restartCourse(int course_seq) {
		log.info(course_seq);
		Map<String, String> map = new HashMap<String, String>();

		int result = courseService.approveCourse(course_seq);

		if (result > 0) {
			map.put("result", "true");
			map.put("msg", "해당 강의 판매가 시작되었습니다.");
		} else {
			map.put("result", "false");
			map.put("msg", "강의 판매 등록 실패, 다시 시도해주세요.");
		}
		return map;
	}

	@GetMapping("/restartedCourse")
	public String restartedCourse(RedirectAttributes rda) {
		rda.addFlashAttribute("restarted", true);
		return "redirect:/admin/manageCourse";
	}

	// 멘토 관리
	@GetMapping("/manageMentor")
	public String viewApplyForMentor(Model model) {
		List<MemberVO> await = memberService.allMemberApplyToMentor();
		List<MemberVO> approve = memberService.allMentorApproved();
		List<MemberVO> stop = memberService.allMentorStopped();
		model.addAttribute("awaitMember", await);
		model.addAttribute("approvedMentor", approve);
		model.addAttribute("stopMentor", stop);
		return "/mypage/admin/manageMentor";
	}

	// 멘토 승인
	@ResponseBody
	@PostMapping("/approveMentor")
	public Map<String, String> approveMentor(String member_id) {
		Map<String, String> map = new HashMap<String, String>();

		int result = memberService.approveMentor(member_id);

		if (result > 0) {
			map.put("result", "true");
			map.put("msg", "해당 회원 멘토 승인이 완료되었습니다.");
		} else {
			map.put("result", "false");
			map.put("msg", "멘토 승인 실패, 다시 시도하세요.");
		}

		return map;
	}

	@GetMapping("/approvedMentor")
	public String approvedMentor(RedirectAttributes rda) {
		rda.addFlashAttribute("approved", true);
		return "redirect:/admin/manageMentor";
	}

	// 멘토 자격 정지
	@ResponseBody
	@PostMapping("/stopMentor")
	public Map<String, String> stopMentor(String member_id) {
		Map<String, String> map = new HashMap<String, String>();

		int result = memberService.stopMentor(member_id);

		if (result > 0) {
			map.put("result", "true");
			map.put("msg", "해당 회원의 멘토 자격이 정지되었습니다.");
		} else {
			map.put("result", "false");
			map.put("msg", "자격 정지 실패, 다시 시도하세요.");
		}

		return map;
	}

	@GetMapping("/stoppedMentor")
	public String stoppedMentor(RedirectAttributes rda) {
		rda.addFlashAttribute("stopped", true);
		return "redirect:/admin/manageMentor";
	}

	// 멘토 자격 복귀
	@ResponseBody
	@PostMapping("/restartMentor")
	public Map<String, String> restartMentor(String member_id) {
		Map<String, String> map = new HashMap<String, String>();

		int result = memberService.restartMentor(member_id);

		if (result > 0) {
			map.put("result", "true");
			map.put("msg", "해당 회원의 멘토 권한이 복귀되었습니다.");
		} else {
			map.put("result", "false");
			map.put("msg", "권한 복귀 실패, 다시 시도하세요.");
		}

		return map;
	}

	@GetMapping("/restartedMentor")
	public String restartedMentor(RedirectAttributes rda) {
		rda.addFlashAttribute("restarted", true);
		return "redirect:/admin/manageMentor";
	}

}
