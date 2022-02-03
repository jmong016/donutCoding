package com.inf.order.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.inf.course.domain.CourseVO;
import com.inf.course.domain.PurchaseCourseVO;
import com.inf.course.mapper.CourseMapper;
import com.inf.order.domain.CartDTO;
import com.inf.order.domain.OrderDTO;
import com.inf.order.domain.OrderListVO;
import com.inf.order.domain.WishDTO;
import com.inf.order.mapper.OrderMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Transactional
@Service("orderService")
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = @Autowired)
	private OrderMapper orderMapper;
	
	@Setter(onMethod_ = @Autowired)
	private CourseMapper courseMapper;

	@Override
	public Map<String, String> addToWishList(OrderDTO order) {
		Map<String, String> map = new HashMap<String, String>();
		int duple = orderMapper.selectDuplicatedWishListByMemberIdAndCourseSeq(order);
		int dupleP = orderMapper.selectDuplicatedPurchaseListByMemberIdAndCourseSeq(order);
		if (duple > 0) {
			map.put("result", "false");
			map.put("error", "duplicated");
			map.put("msg", "이미 위시리스트에 추가된 강의입니다.<br>위시리스트로 이동하시겠습니까?");
		}else if(dupleP >0) {
			map.put("result", "false");
			map.put("error", "duplicated-purchase");
			map.put("msg", "이미 구매한 강의입니다.<br>내 학습으로 이동하시겠습니까?");
		} else {
			WishDTO wish = new WishDTO();
			wish.setMember_id(order.getMember_id());
			wish.setCourse_seq(order.getCourse_seq());
			int result = orderMapper.insertNewWishList(wish);
			if (result > 0) {
				map.put("result", "true");
				map.put("msg", "위시리스트에 추가되었습니다.<br>위시리스트로 이동하시겠습니까?");
			} else {
				map.put("result", "false");
				map.put("error", "failed");
				map.put("msg", "위시리스트 추가 실패,<br>다시 시도해주세요.");
			}
		}

		return map;
	}

	@Override
	public Map<String, String> addToCart(OrderDTO order) {
		Map<String, String> map = new HashMap<String, String>();
		int duple = orderMapper.selectDuplicatedCartItemByMemberIdAndCourseSeq(order);
		int dupleP = orderMapper.selectDuplicatedPurchaseListByMemberIdAndCourseSeq(order);
		if (duple > 0) {
			map.put("result", "false");
			map.put("error", "duplicated");
			map.put("msg", "이미 장바구니에 추가된 강의입니다.<br>장바구니로 이동하시겠습니까?");
		}else if(dupleP >0) {
			map.put("result", "false");
			map.put("error", "duplicated-purchase");
			map.put("msg", "이미 구매한 강의입니다.<br>내 학습으로 이동하시겠습니까?");
		}else {
			CartDTO cart = new CartDTO();
			cart.setCourse_seq(order.getCourse_seq());
			cart.setMember_id(order.getMember_id());
			int result = orderMapper.insertNewCartItem(cart);
			if (result > 0) {
				map.put("result", "true");
				map.put("msg", "장바구니에 추가되었습니다.<br>장바구니로 이동하시겠습니까?");
			} else {
				map.put("result", "false");
				map.put("error", "failed");
				map.put("msg", "장바구니 추가 실패,<br>다시 시도해주세요.");
			}
		}

		return map;
	}

	@Override
	public List<CourseVO> selectAllCartItemByMemberId(String member_id) {
		List<CourseVO> course = orderMapper.selectCartItemByMemberId(member_id);
		return course.size() == 0? null : course;
	}

	@Override
	public Map<String, String> moveToWishList(OrderDTO order) {
		Map<String, String> map = new HashMap<String, String>();
		int delete = orderMapper.deleteCartItemByMemberIdAndCourseSeq(order);
		if (delete > 0) {
			int duple = orderMapper.selectDuplicatedWishListByMemberIdAndCourseSeq(order);
			if (duple > 0) {
				map.put("result", "false");
				map.put("error", "duplicated");
				map.put("msg", "이미 위시리스트에 추가된 강의입니다.<br>위시리스트로 이동하시겠습니까?");
			} else {
				WishDTO wish = new WishDTO();
				wish.setMember_id(order.getMember_id());
				wish.setCourse_seq(order.getCourse_seq());
				int insert = orderMapper.insertNewWishList(wish);
				if (insert > 0) {
					map.put("result", "true");
					map.put("msg", "위시리스트에 추가되었습니다.<br>위시리스트로 이동하시겠습니까?");
				} else {
					map.put("result", "false");
					map.put("error", "failed");
					map.put("msg", "위시리스트 추가 실패,<br>다시 시도해주세요.");
				}
			}
		} else {
			map.put("result", "false");
			map.put("error", "failed");
			map.put("msg", "장바구니 삭제 실패,<br>다시 시도해주세요.");
		}
		return map;
	}

	@Override
	public Map<String, String> deleteFromCart(OrderDTO order) {
		Map<String, String> map = new HashMap<String, String>();
		int result = orderMapper.deleteCartItemByMemberIdAndCourseSeq(order);
		if(result>0) {
			map.put("result", "true");
			map.put("msg", "장바구니에서 삭제되었습니다.");
		}else {
			map.put("result", "false");
			map.put("msg", "장바구니 삭제 실패,<br>다시 시도해주세요.");
		}
		return map;
	}

	@Override
	public List<CourseVO> selectAllWishListByMemberId(String member_id) {
		List<CourseVO> course = orderMapper.selectWishListByMemberId(member_id);
		return course.size() == 0? null : course;
	}

	@Override
	public Map<String, String> moveToCart(OrderDTO order) {
		Map<String, String> map = new HashMap<String, String>();
		int delete = orderMapper.deleteWishListByMemberIdAndCourseSeq(order);
		if (delete > 0) {
			int duple = orderMapper.selectDuplicatedCartItemByMemberIdAndCourseSeq(order);
			if (duple > 0) {
				map.put("result", "false");
				map.put("error", "duplicated");
				map.put("msg", "이미 장바구니에 추가된 강의입니다.<br>장바구니로 이동하시겠습니까?");
			} else {
				CartDTO cart = new CartDTO();
				cart.setCourse_seq(order.getCourse_seq());
				cart.setMember_id(order.getMember_id());
				int result = orderMapper.insertNewCartItem(cart);
				if (result > 0) {
					map.put("result", "true");
					map.put("msg", "장바구니에 추가되었습니다.<br>장바구니로 이동하시겠습니까?");
				} else {
					map.put("result", "false");
					map.put("error", "failed");
					map.put("msg", "장바구니 추가 실패,<br>다시 시도해주세요.");
				}
			}
		} else {
			map.put("result", "false");
			map.put("error", "failed");
			map.put("msg", "위시리스트 삭제 실패,<br>다시 시도해주세요.");
		}

		return map;
	}

	@Override
	public Map<String, String> deleteFromWishList(OrderDTO order) {
		Map<String, String> map = new HashMap<String, String>();
		int result = orderMapper.deleteWishListByMemberIdAndCourseSeq(order);
		if(result>0) {
			map.put("result", "true");
			map.put("msg", "위시리스트에서 삭제되었습니다.");
		}else {
			map.put("result", "false");
			map.put("msg", "위시리스트 삭제 실패,<br>다시 시도해주세요.");
		}
		return map;
	}

	@Override
	public Map<String, String> purchaseCourseDirect(OrderDTO order) {
		Map<String, String> map = new HashMap<String, String>();
		int duple = orderMapper.selectDuplicatedPurchaseListByMemberIdAndCourseSeq(order);
		if (duple > 0) {
			map.put("result", "false");
			map.put("error", "duplicated");
			map.put("msg", "이미 수강 중인 강의입니다.<br>내 학습으로 이동하시겠습니까?");
		} else {
			int orderList = orderMapper.insertNewOrderList(order);
			int courseList = orderMapper.insertNewPurchaseCourse(order);
			if (orderList > 0 && courseList > 0) {
				map.put("result", "true");
				map.put("msg", "내 학습으로 이동하시겠습니까?");
			} else {
				map.put("result", "false");
				map.put("error", "failed");
				map.put("msg", "다시 시도해주세요.");
			}
		}
		return map;
	}

	@Override
	public Map<String, Object> isAlreadyExistsInPurchaseCourse(OrderDTO order) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = orderMapper.selectDuplicatedPurchaseListByMemberIdAndCourseSeq(order);
		if(result > 0) {
			map.put("result", false);
			map.put("msg","이미 수강 중인 강의입니다.");
		}else {
			CourseVO course = courseMapper.selectCourseByCourseSeq(order.getCourse_seq());
			map.put("result", true);
			map.put("course", course);
		}
		return map;
	}

	@Override
	public Map<String, Object> purchaseFreeCourses(OrderListVO orderList) {
		Map<String, Object> map = new HashMap<String, Object>();
		int duple = orderMapper.selectDuplicatedPurchaseListByOrderList(orderList);
		if (duple > 0) {
			map.put("result", false);
			map.put("error", "duplicated");
			map.put("msg", "이미 구매한 강의가 포함되어있습니다.<br>내학습으로 이동하시겠습니까?");
			map.put("link", "/mypage/course");
		} else {
			int order = orderMapper.insertNewOrderLists(orderList);
			int course = orderMapper.insertNewPurchaseCourses(orderList);
			if (order > 0 && course > 0) {
				int delete = orderMapper.deleteCartItemforPurchase(orderList);
				if(delete == orderList.getCourses().size()) {
					map.put("result", true);
					map.put("msg", "구매완료<br>내 학습으로 이동하시겠습니까?");
					map.put("link", "/mypage/course");
				}else {
					map.put("result", false);
					map.put("error", "deleteFailed");
					map.put("msg", "다시 시도해주세요.");
				}
			} else {
				map.put("result", false);
				map.put("error", "failed");
				map.put("msg", "다시 시도해주세요.");
			}
		}
		return map;
	}

	@Override
	public Map<String, Object> purchaseCourses(OrderListVO orderList) {
		Map<String, Object> map = new HashMap<String, Object>();
			int order = orderMapper.insertNewOrderLists(orderList);
			int course = orderMapper.insertNewPurchaseCourses(orderList);
			if (order > 0 && course > 0) {
				int delete = orderMapper.deleteCartItemforPurchase(orderList);
				if(delete == orderList.getCourses().size()) {
					map.put("result", true);
					map.put("msg", "구매완료<br>내 학습으로 이동하시겠습니까?");
					map.put("link", "/mypage/course");
				}else {
					map.put("result", false);
					map.put("error", "deleteFailed");
					map.put("msg", "다시 시도해주세요.");
				}
			} else {
				map.put("result", false);
				map.put("error", "failed");
				map.put("msg", "다시 시도해주세요.");
			}
		return map;
	}

	@Override
	public List<OrderListVO> selectAllOrderListByMemberId(String member_id) {
		List<OrderListVO> order = orderMapper.selectAllOrderListByMemberId(member_id);
		return order.size()==0? null : order;
	}

	@Override
	public List<PurchaseCourseVO> selectPurchaseCoursesByMemberId(String member_id) {
		List<PurchaseCourseVO> course = orderMapper.selectPurchaseCoursesByMemberId(member_id);
		return course.size()==0? null : course;
	}

}
