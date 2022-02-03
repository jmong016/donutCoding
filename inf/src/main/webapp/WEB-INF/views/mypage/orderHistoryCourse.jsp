<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/myPage.css" />
<style>
#order-list-wrapper .course {
	display: flex;
	flex-wrap: wrap;
	border: 1px solid var(--gray-color);
	border-radius: 1em; 
}
#order-list-wrapper .course > div{
	flex: 1;
}
#order-list-wrapper *{
	text-align: center;
}
</style>
<div id="mypage-wrapper">
	<c:choose>
		<c:when test="${user.member_role == '멘토'}">
			<%@ include file="../common/aside_mentor.jsp"%>
		</c:when>
		<c:when test="${user.member_role == '관리자'}">
			<%@ include file="../common/aside_admin.jsp"%>
		</c:when>
		<c:otherwise>
			<%@ include file="../common/aside.jsp"%>
		</c:otherwise>
	</c:choose>
	<section id="mypage-content">
		<div id="order-list-wrapper">
			<div class="p-3 mx-auto">
				<h4>강의 구매 내역</h4>
			</div>

			<div class="order-wrapper">
				<c:choose>
					<c:when test="${orderList != null}">
						<c:forEach items="${orderList }" var="course">
							<div class="course p-2 m-2">
								<div class="order-id p-2 m-2">
									<strong>주문 번호</strong>
									<p class="mt-2">${course.order_id }</p>
								</div>
								<div class="order-item p-2 m-2">
									<strong>강의명</strong>
									<c:forEach items="${course.courses }" var="c">
										<p class="mt-2"><a href="${path }/course/${c.course_seq}">${c.course_nm } 
										<span> (
										<c:choose>
											<c:when test="${c.amounted_pay == 0}">
											무료
											</c:when>
											<c:otherwise>
											<fmt:formatNumber value="${c.amounted_pay }" pattern="#,###원" />
											</c:otherwise>
										</c:choose>
										)</span></a></p>
									</c:forEach>
								</div>
								<div class="order-data p-2 m-2">
									<strong>주문 일자</strong>
									<p class="mt-2">
										<fmt:formatDate value="${course.orderDT }"
											pattern="yyyy년 MM월 dd일" />
									</p>
								</div>
								<div class="btn-wrapper my-auto">
									<button type="button" class="btn btn-primary" onclick="orderDetail('${course.buyer_name}','${course.buyer_phone}','${course.buyer_email}')">
									주문인 정보보기</button>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div>
							<h5 class="p-3" style="text-align: center;">구매 내역이 없습니다!</h5>
							<button type="button" class="btn btn-warning"
								onclick="location.href='${path}/courses'"
								style="display: block; margin: auto;">강의 보러가기</button>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
</div>

<script type="text/javascript">
	function orderDetail(name,phone,email){
		var html =
			"주문인 : "+ name + "<br>" + "주문인 연락처 : " + phone + "<br>" 
			+ "주문인 이메일 : " + email;
		Swal.fire({
			  icon: 'info',
			  confirmButtonText: '닫기',
			  html: html
			})
	}
</script>

<%@ include file="../common/footer.jsp"%>