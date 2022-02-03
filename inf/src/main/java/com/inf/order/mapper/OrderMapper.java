package com.inf.order.mapper;

import java.util.List;

import com.inf.course.domain.CourseVO;
import com.inf.course.domain.PurchaseCourseVO;
import com.inf.order.domain.CartDTO;
import com.inf.order.domain.OrderDTO;
import com.inf.order.domain.OrderListVO;
import com.inf.order.domain.WishDTO;

public interface OrderMapper {
	// 위시리스트 중복 확인
	int selectDuplicatedWishListByMemberIdAndCourseSeq(OrderDTO order);
	// 위시리스트 추가
	int insertNewWishList(WishDTO wish);
	// 장바구니 중복 확인
	int selectDuplicatedCartItemByMemberIdAndCourseSeq(OrderDTO order);
	// 장바구니 추가
	int insertNewCartItem(CartDTO cart);
	// 해당 회원의 장바구니 가져오기
	List<CourseVO> selectCartItemByMemberId(String member_id);
	// 장바구니에서 삭제
	int deleteCartItemByMemberIdAndCourseSeq(OrderDTO order);
	int deleteCartItemforPurchase(OrderListVO orderList);
	// 해당 회원의 위시리스트 가져오기
	List<CourseVO> selectWishListByMemberId(String member_id);
	// 위시리스트에서 삭제
	int deleteWishListByMemberIdAndCourseSeq(OrderDTO order);
	// 구매내역 중복 확인(내 학습)
	int selectDuplicatedPurchaseListByMemberIdAndCourseSeq(OrderDTO order);
	int selectDuplicatedPurchaseListByOrderList(OrderListVO orderList);
	// 구매내역 추가
	int insertNewOrderList(OrderDTO order);
	int insertNewOrderLists(OrderListVO orderList);
	// 내 학습 추가
	int insertNewPurchaseCourse(OrderDTO order);
	int insertNewPurchaseCourses(OrderListVO orderList);
	// 해당 회원의 구매내역
	List<OrderListVO> selectAllOrderListByMemberId(String member_id);
	// 해당 회원의 내 학습
	List<PurchaseCourseVO> selectPurchaseCoursesByMemberId(String member_id);
	
	
	
	
	
	
	
	

}
