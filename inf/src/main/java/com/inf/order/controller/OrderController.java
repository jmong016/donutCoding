package com.inf.order.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.inf.common.annotation.LoginRequired;
import com.inf.course.domain.CourseVO;
import com.inf.course.service.CourseService;
import com.inf.member.domain.UserVO;
import com.inf.order.domain.OrderDTO;
import com.inf.order.domain.OrderListVO;
import com.inf.order.service.OrderService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private CourseService courseService;

	@GetMapping("/{course_seq}")
	@LoginRequired
	public String courseOrder(@PathVariable("course_seq") int course_seq, HttpServletRequest request,
			RedirectAttributes rda, Model model) {
		UserVO user = (UserVO) request.getSession().getAttribute("user");
		OrderDTO order = new OrderDTO();
		order.setMember_id(user.getMember_id());
		order.setCourse_seq(course_seq);
		Map<String, Object> map = orderService.isAlreadyExistsInPurchaseCourse(order);
		if ((boolean) map.get("result")) {
			model.addAttribute("course", (CourseVO) map.get("course"));
			return "/order/courseDirect";
		} else {
			rda.addFlashAttribute("isExits", true);
			rda.addFlashAttribute("msg", (String) map.get("msg"));
			String referer = request.getHeader("referer");
			return "redirect:" + referer;
		}

	}

	@GetMapping("/cart")
	@LoginRequired
	public String showCart(HttpSession session, Model model) {
		UserVO user = (UserVO) session.getAttribute("user");
		List<CourseVO> course = orderService.selectAllCartItemByMemberId(user.getMember_id());
		log.info(course);
			model.addAttribute("cartList", course);
		return "/order/courseCart";
	}

	@GetMapping("/wishList")
	@LoginRequired
	public String showWishList(HttpSession session, Model model) {
		UserVO user = (UserVO) session.getAttribute("user");
		List<CourseVO> course = orderService.selectAllWishListByMemberId(user.getMember_id());
		model.addAttribute("wishList", course);
		return "/order/courseWishList";
	}
	
	@GetMapping("/courseHistory")
	@LoginRequired
	public String showOrderHistory(HttpSession session, Model model) {
		UserVO user = (UserVO) session.getAttribute("user");
		List<OrderListVO> order = orderService.selectAllOrderListByMemberId(user.getMember_id());
		model.addAttribute("orderList", order);
		return "/mypage/orderHistoryCourse";
	}

	@ResponseBody
	@PostMapping("/purchaseDirect")
	@LoginRequired
	public Map<String, String> purchaseDirect(OrderDTO order) {
		Map<String, String> map = orderService.purchaseCourseDirect(order);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/purchaseFreeCourses")
	public Map<String, Object> purchaseFreeCourses(@RequestBody OrderListVO orderList) {
		log.info("무료 강의 주문 >>>>> " + orderList);
		Map<String, Object> map = orderService.purchaseFreeCourses(orderList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/purchaseCourses")
	public Map<String, Object> purchaseCourses(@RequestBody OrderListVO orderList) {
		log.info("유료 강의 주문 >>>>> " + orderList);
		Map<String, Object> map = orderService.purchaseCourses(orderList);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/addToCart")
	public Map<String, String> addToCart(OrderDTO order) {
		log.info("장바구니 추가 >>>>> " +order);
		Map<String, String> map = orderService.addToCart(order);
		return map;
	}

	@ResponseBody
	@PostMapping("/addToWishList")
	public Map<String, String> addToWishList(OrderDTO order) {
		log.info("위시리스트 추가 >>>>> " +order);
		Map<String, String> map = orderService.addToWishList(order);
		return map;
	}

	@ResponseBody
	@PostMapping("/moveToWishList")
	public Map<String, String> moveToWishList(OrderDTO order) {
		Map<String, String> map = orderService.moveToWishList(order);
		return map;
	}
	
	@ResponseBody
	@PostMapping("/moveToCart")
	public Map<String, String> moveToCart(OrderDTO order) {
		Map<String, String> map = orderService.moveToCart(order);
		return map;
	}

	@ResponseBody
	@PostMapping("/deleteFromCart")
	public Map<String, String> deleteFromCart(OrderDTO order) {
		log.info("장바구니에서 삭제 >>>>> " +order);
		Map<String, String> map = orderService.deleteFromCart(order);
		return map;
	}

	@ResponseBody
	@PostMapping("/deleteFromWishList")
	public Map<String, String> deleteFromWishList(OrderDTO order) {
		log.info("위시리스트에서 삭제 >>>>> " +order);
		Map<String, String> map = orderService.deleteFromWishList(order);
		return map;
	}
}
