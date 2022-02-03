<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<style>
#course-wish .course{
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
	border: 1px solid var(--gray-color);
	border-radius: 1em;
}
#course-wish .thumbnail img:hover{
	cursor: pointer;
}
</style>

<div class="container p-3 my-2 white-bg"
	style="border-radius: 1em; border: none;">
	<h3 style="text-align: center;">위시리스트</h3>
</div>

<section id="course-wish" class="container">
	<div id="course-list" class="p-2">
		<!-- 강의 -->
		<div id="course">
			<c:choose>
				<c:when test="${wishList != null}">
					<c:forEach items="${wishList }" var="course">
							<div class="course course-${course.course_seq } p-2 m-2">
								<div class="thumbnail my-auto">
									<img alt="${course.course_NM }"
										src="${path }/thumbnails?course_seq=${course.course_seq}&img_nm=${course.course_img_nm}"
										style="width: 200px; height: 150px; object-fit: cover; border: none; border-radius: 1em; margin: 0 1em;"
										onclick="location.href='${path }/course/${course.course_seq }'">
								</div>

										<div class="info my-auto">
											<a class="dark-font"
												href="${path }/course/${course.course_seq}"
												style="word-break: break-word;">${course.course_NM }</a>
											<c:choose>
												<c:when test="${course.course_available_period > 0}">
													<p>(수강 기한 : ${course.course_available_period }개월)</p>
												</c:when>
												<c:otherwise>
													<p>(수강 기한 : 무제한)</p>
												</c:otherwise>
											</c:choose>
										</div>

										<div class="course-price my-auto">
											<c:choose>
												<c:when test="${course.course_price == 0 }">
													<p><strong>무료</strong></p>
												</c:when>
												<c:when test="${course.course_sales_price > 0 }">
													<p class="badge rounded-pill bg-primary"
														style="font-size: 0.6em; width: max-content; margin: auto;">
														${course.course_discount_rate }% 할인</p>
													<p><strong>
														<fmt:formatNumber value="${course.course_sales_price }"
															pattern="#,###원" /></strong>
													</p>
												</c:when>
												<c:otherwise>
													<p><strong>
														<fmt:formatNumber value="${course.course_price }"
															pattern="#,###원" /></strong>
													</p>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="btn-wrapper my-auto">
										<button type="button" class="btn btn-success my-2 mx-auto"
											onclick="moveToCart(${course.course_seq})"
											style="display: block;">장바구니로 이동</button>
										<button type="button" class="btn btn-danger my-2 mx-auto"
											onclick="deleteFromWishList(${course.course_seq})"
											style="display: block;">위시리스트에서 삭제</button>
							</div>
							</div>
		</c:forEach>
		</c:when>
		<c:otherwise>
			<div>
				<h4 class="p-3" style="text-align: center;">위시리스트가 비었습니다!</h4>
				<button type="button" class="btn btn-warning" onclick="location.href='${path}/courses'"
				style="display: block;margin:auto;">강의 보러가기</button>
			</div>
		</c:otherwise>
		</c:choose>
		</div>
	</div>

</section>

<script type="text/javascript">
function moveToCart(seq){
		$.ajax({
			url : "${path}/order/moveToCart",
			type : "post",
			dataType : "json",
			data : { "member_id" : "${user.member_id}",
					"course_seq" : seq},
			success : function(data){
				var result = data.result;
				var error = data.error;
				var msg = data.msg;
				if(result == 'true'){
					Confirm(msg,"success","${path}/order/cart");
				}else{
					if(error == 'duplicated'){
						Confirm(msg,"warning","${path}/order/cart");
					}else{
						Swal.fire({
							  icon: 'error',
							  text: msg
							})
					}
				}
			}
		})
	}
function deleteFromWishList(seq){
	$.ajax({
		url : "${path}/order/deleteFromWishList",
		type : "post",
		dataType : "json",
		data : { "member_id" : "${user.member_id}",
				"course_seq" : seq},
		success : function(data){
			var result = data.result;
			var msg = data.msg;
			if(result == 'true'){
				Swal.fire({
					  icon: 'success',
					  text: msg,
					  timer: 1800
					});
				setTimeout("location.reload()", 1850);
			}else{
				Swal.fire({
					  icon: 'error',
					  text: msg,
					  timer: 2000
					})
			}
		}
	})
}

function Confirm(msg,type,link){
	Swal.fire({
		  html: msg,
		  icon: type,
		  showCancelButton: true,
		  confirmButtonText: '이동',
		  cancelButtonText: '취소',
		}).then((result) => {
		  if (result.isConfirmed) {
		    location.href = link;
		  }else{
			  location.reload();  
		  }
		})
}
/* null check */
function isNull(id, error) {
	var val = id.val().trim();
	if (val == null || val == "") {
		error.css("display", "block");
		id.css("background","var(--accent-color)").focus();
		return true;
	} else {
		error.css("display", "none");
		id.css("background","");
		return false;
	}
}
</script>

<%@ include file="../common/footer.jsp"%>