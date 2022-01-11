package com.inf.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.inf.common.exception.BadCommandException;
import com.inf.member.domain.MemberVO;
import com.inf.member.domain.UserVO;
import com.inf.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	@Autowired
	private MemberService memberService;

	// 로그인 모달 열기
	@ResponseBody
	@GetMapping("/login")
	public Map<String, String> showLoginModal(HttpServletRequest request) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("login", "show");
		return map;
	}

	// 로그인 후 세션에 user 장착
	@ResponseBody
	@PostMapping("/login")
	public Map<String, String> login(HttpServletRequest request, String member_id, String member_password) {
		Map<String, String> map = new HashMap<String, String>();
		log.info("로그인 시도  >>>>>>>>>> " + member_id);
		UserVO user = memberService.login(member_id, member_password);
		String referer = request.getHeader("Referer");

		if (user != null) {
			log.info("로그인 성공 >>>>>>>>> " + user.getMember_id());
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			map.put("result", "success");
			map.put("path", referer);
			return map;
		} else {
			map.put("result", null);
			map.put("msg", "로그인 실패, 다시 시도해주세요.");
			return map;
		}
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		log.info("로그아웃 >>>>>> " + user.getMember_id());
		session.removeAttribute("user");
		// String referer = request.getHeader("Referer");
		// http://localhost:8080/
		return "redirect:/main";
	}

	// 회원가입 폼이동
	@GetMapping("/join")
	public String join() {
		return "/member/joinForm";
	}

	// 회원가입
	@PostMapping("/join")
	public String register(MemberVO memberVO, RedirectAttributes rda) throws BadCommandException, Exception {
		System.out.println("new register" + memberVO);
		String pw = (String) memberVO.getMember_password();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String BcryptPw = encoder.encode(pw);
		memberVO.setMember_password(BcryptPw);
		int result = memberService.register(memberVO);
		
		if (result == 1) {
			rda.addFlashAttribute("loginMember","true");
			return "redirect:/main";
		} else {
			throw new BadCommandException();
		}
	}

	// 아이디 체크
	@ResponseBody
	@PostMapping("/idChk")
	public int idChk(String member_id) throws Exception {
		int result = memberService.idChk(member_id);
		return result;
	}

	// 이메일 체크
	@ResponseBody
	@PostMapping("/emailChk")
	public int emailChk(String member_email) throws Exception {
		int result = memberService.emailChk(member_email);
		return result;
	}
}
