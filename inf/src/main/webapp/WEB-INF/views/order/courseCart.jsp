<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
#course-cart {
	display: flex;
	text-align: center;
}

#course-cart #course-list {
	width: 65%;
}
#course-cart .course-wrapper{
	border: 1px solid var(--gray-color);
	border-radius: 1em;
}
#course-cart .course {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}

#course-cart #purchase {
	width: 34.9%;
}

#course-cart .price {
	border: 1px solid var(--gray-color);
	border-radius: 2em;
	padding: 0.5em;
}

#course-cart #purchase>div {
	width: 80%;
	margin: 0.5em auto;
}

#course-cart .input p, input {
	text-align: center;
}

#course-cart .validiate {
	color: var(--main-color);
	font-weight: bold;
	display: none;
}

#course-cart .checkbox-wrapper {
	display: flex;
	justify-content: space-between;
	background: #f2f2f2;
	border-radius: 1em;
}
#course-cart .thumbnail:hover{
	cursor: pointer;
}

#course-cart .btn-method{
	margin: auto;
	width: 100%;
}
</style>

<div class="container p-3 my-2 white-bg"
	style="border-radius: 1em; border: none;">
	<h3 style="text-align: center;">장바구니</h3>
</div>

<section id="course-cart" class="container">
	<div id="course-list" class="p-2">
		<div class="checkbox-wrapper p-2 my-2">
			<div class="my-auto">
			<h5>강의 정보</h5>
			</div>
			<div>
				<button type="button" id="check-all" class="btn" >전체 선택</button>
				<button type="button" id="cancel-all" class="btn" >전체 해제</button>
			</div>
		</div>
		<!-- 강의 -->
		<div id="course">
			<c:choose>
				<c:when test="${cartList != null}">
					<c:forEach items="${cartList }" var="course">
					<div class="course-wrapper p-2 mb-2">
							<div class="course course-${course.course_seq } m-2">
								<div class="thumbnail my-auto">
									<c:choose>
										<c:when test="${course.course_price == 0 }">
											<input class="select-check" type="checkbox" data-seq="${course.course_seq }"
												data-price="0" data-period="${course.course_available_period }" data-nm="${course.course_NM }" 
												style="zoom: 1.5;" checked="checked">
										</c:when>
										<c:when test="${course.course_sales_price > 0 }">
											<input class="select-check" type="checkbox" data-seq="${course.course_seq }"
												data-nm="${course.course_NM }" data-price="${course.course_sales_price }" data-period="${course.course_available_period }"
												style="zoom: 1.5;" checked="checked">
										</c:when>
										<c:otherwise>
											<input class="select-check" type="checkbox" data-seq="${course.course_seq }" data-period="${course.course_available_period }"
												data-nm="${course.course_NM }" data-price="${course.course_price }" style="zoom: 1.5;" checked="checked">
										</c:otherwise>
									</c:choose>
									<img alt="${course.course_NM }"
										src="${path }/thumbnails?course_seq=${course.course_seq}&img_nm=${course.course_img_nm}"
										style="width: 150px; height: 100px; object-fit: cover; border: none; border-radius: 1em; margin: 0 1em;"
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
							</div>
							<div class="course-info-bottom">
								<button type="button" class="btn btn-success"
									onclick="moveToWishList(${course.course_seq})"
									style="display: inline-block; margin: auto;">위시리스트로 이동</button>
								<button type="button" class="btn btn-danger"
									onclick="deleteFromCart(${course.course_seq})"
									style="display: inline-block; margin: auto;">장바구니에서 삭제</button>
							</div>
						</div>
		</c:forEach>
		</c:when>
		<c:otherwise>
			<div>
				<h4 class="p-3">장바구니가 비었습니다!</h4>
				<button type="button" class="btn btn-warning" onclick="location.href='${path}/courses'"
				style="display: block;margin:auto;">강의 보러가기</button>
			</div>
		</c:otherwise>
		</c:choose>
		</div>
	</div>


	<!-- 구매 정보 및 버튼 -->
	<div id="purchase" class="p-3">

		<c:if test="${cartList !=null }">
			<div class="price">
				<h5 id="price-fmt" class="dark-font" style="font-weight: bold;">
				</h5>
				<input id="price-for-pay" type="number" value="0" hidden="hidden">
			</div>
		</c:if>

		<div class="member-id input mb-2">
			<p>
				<strong>구매인 성명</strong>
			</p>
			<p id="name-check-null" class="validiate">구매인 성명을 입력하세요.</p>
			<input id="buyer-name" type="text" class="form-control"
				value="${user.member_nickNM }" name="member_id" placeholder="구매인 성명"
				maxlength="6" size="6">
		</div>
		<div class="member-phone input mb-2">
			<p>
				<strong>구매인 연락처</strong>
			</p>
			<p id="phone-check-null" class="validiate">구매인 연락처를 입력하세요.</p>
			<p id="phone-check-exp" class="validiate">전화번호 형식이 일치하지 않습니다.</p>
			<div class="input-group">
				<input id="buyer-phone" type="text" class="form-control"
					value="${user.member_phoneNO }" name="member_phoneNO"
					placeholder=" ex) 01012345678" maxlength="11">
				<button id="btn-phone" class="btn btn-primary" type="button"
					onclick="changePhoneNo()" disabled="disabled">수정</button>
			</div>
		</div>
		<div class="member-email input">
			<p>
				<strong>구매인 이메일</strong>
			</p>
			<input id="buyer-email" type="text" class="form-control" value="${user.member_email }"
				name="member_email" readonly="readonly">
		</div>
		<div class="pay-method my-3">
			<button type="button" class="btn btn-outline-light text-dark btn-method"
			onclick="purchase('이니시스')">
				<i class="far fa-credit-card"></i> 신용카드로 결제
			</button>
			<button type="button" class="btn btn-outline-light text-dark btn-method"
			onclick="purchase('kakaopay')">
				<img src="/resources/images/icons/kakao_pay_icon.png"
					style="height: 1.2em;"> 카카오페이로 결제
			</button>
		</div>
		<div class="free-method my-3">
			<button id="btn-purchase" type="button" class="btn btn-success btn-method"
			onclick="purchaseFreeCourse()">
			바로 구매하기</button>
		</div>
	</div>
</section>

<script type="text/javascript">
$(document).ready(function(){
	if("${cartList == null}" == "true"){
		$(".pay-method").css("display","none");
		$(".free-method").css("display","none");
	}else if("${cartList != null}" == "true"){
	var price = 0;
	$(".select-check").each(function(){
		if($(this).prop("checked")){
			price += $(this).data("price");
		}
	});
	$("#price-for-pay").val(price);
	priceCheck(price);
	}
});
/* 강의 전체 선택 */
$("#check-all").on("click",function(){
	var price = 0;
	$(".select-check").each(function(){
		$(this).prop("checked",true);
		price += $(this).data("price");
	});
	$("#price-fmt").text(price.toLocaleString("ko-KR")+"원");
	$("#price-for-pay").val(price);
	priceCheck(price);
});
/* 강의 전체 선택 취소 */
$("#cancel-all").on("click",function(){
	$(".select-check").each(function(){
		$(this).prop("checked",false);
	});
	$("#price-fmt").text("선택된 강의가 없습니다.");
	$("#price-for-pay").val(0);
	$(".pay-method").css("display","none");
	$(".free-method").css("display","none");
});
/* 강의 선택 시 이벤트 */
$(".select-check").on("change",function(){
	var price = parseInt($("#price-for-pay").val());
	if($(this).prop("checked")){
		var curPrice = price += $(this).data("price")
		$("#price-for-pay").val(curPrice);
		$("#price-fmt").text(curPrice.toLocaleString("ko-KR")+"원");
	}else{
		var curPrice = price -= $(this).data("price")
		$("#price-for-pay").val(curPrice);
		$("#price-fmt").text(curPrice.toLocaleString("ko-KR")+"원");
	}
	var checkCnt = 0;
	$(".select-check").each(function(){
		if($(this).prop("checked")){
			checkCnt++;
		}
	});
	if(checkCnt == 0){
		$(".pay-method").css("display","none");
		$(".free-method").css("display","none");
		return;
	}
	priceCheck(price);
});
/* 금액에 따라 버튼 보이기*/
function priceCheck(price){
	if(price > 0){
		$("#price-fmt").text(price.toLocaleString("ko-KR")+"원");
		$(".pay-method").css("display","block");
		$(".free-method").css("display","none");
	}else{
		$("#price-fmt").text("무료");
		$(".free-method").css("display","block");
		$(".pay-method").css("display","none");
	}
}
function purchase(pg){
	var nInput = $("#buyer-name");
	var pInput = $("#buyer-phone");
	var nError = $("#name-check-null");
	var pError = $("#phone-check-null");
	
	if(isNull(nInput,nError) || isNull(pInput,pError)){
		return false;
	}
	
	var name = $("#buyer-name").val().trim();
	var tel = $("#buyer-phone").val().trim();
	var email = $("#buyer-email").val().trim();
	
	var courses = new Array();
	var courseName = "";
	
	class Course { 
		constructor (course_seq,amounted_pay,course_available_period) { 
			this.course_seq = course_seq; 
			this.amounted_pay = amounted_pay; 
			this.course_available_period = course_available_period; 
		} 
	}
	class OrderList{
		constructor (member_id, courses, buyer_name, buyer_phone, buyer_email) { 
			this.member_id = member_id; 
			this.courses = courses; 
			this.buyer_name = buyer_name; 
			this.buyer_phone = buyer_phone; 
			this.buyer_email = buyer_email; 
		}
	}
	
	var price = 0;
	
	$(".select-check").each(function(i){
		if($(this).prop("checked")){
			price += $(this).data("price");
			courseName += "<br>" + $(this).data("nm");
			var course = new Course($(this).data("seq"),0,$(this).data("period"));
			courses.push(course);
		}
	});
	courseName = courseName.substr(4);
	var orderList = new OrderList("${user.member_id}",courses,name,tel,email);
	
	Swal.fire({
		  title: courseName,
		  text: courses.length + '개의 강의를 구매하시겠습니까?', 
		  icon: "question",
		  showCancelButton: true,
		  confirmButtonText: '구매',
		  cancelButtonText: '취소',
		}).then((result) => {
		  if (result.isConfirmed) {
				IMP.init('imp49078716');
				IMP.request_pay({
				    pg : pg,
				    pay_method : 'card',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : courseName , //결제창에서 보여질 이름
				    amount : price, // 실제 결제되는 가격
				    buyer_email : email,
				    buyer_name : name,
				    buyer_tel : tel,
				}, function(rsp) {
					console.log(rsp);
				    if ( rsp.success ) {
				    	var msg = "강의 : ${course.course_NM} <br>결제 금액 : " + rsp.paid_amount +"<br>카드 승인 번호 : " + rsp.apply_num;
				    	Swal.fire({
							  icon: 'success',
							  title: '결제 완료',
							  html: msg,
							  showConfirmButton: false,
						})
							
							$.ajax({
					    	url: "${path}/order/purchaseCourses",
					    	type: "post",
					    	dataType: "json",
					    	contentType : "application/json; charset=UTF-8",
					    	data: JSON.stringify(orderList),
					    	success: function(data){
					    		var ajaxResult = data.result;
					    		var error = data.error;
					    		var msg = data.msg;
					    		var link = data.link;
					    		if(ajaxResult){
					    			Confirm(msg,"success","${path}"+link);
					    		}else{
					    			if(error == 'duplicated'){
					    				Confirm(msg,'warning',"${path}"+link);
					    			}else if(error == 'deleteFailed'){
					    				Swal.fire({
							  				  icon: 'error',
							  				  title: '구매 실패',
							  				  html: msg,
							  				  showConfirmButton: false,
							  				  timer: 1500
							  				})
					    			}else{
					    				Swal.fire({
							  				  icon: 'error',
							  				  title: '구매 실패',
							  				  html: msg,
							  				  showConfirmButton: false,
							  				  timer: 1500
							  				})
					    			}
					    		}
					    	}
					    })
				    } else {
				    	Swal.fire({
							  icon: 'error',
							  title: '결제 실패',
							  text: rsp.error_msg,
							  showConfirmButton: false,
							  timer: 1500
							})
				    }
				});	
		 }
	})
}

/* 선택한 강의가 무료일때, 바로 구매 */
function purchaseFreeCourse(){
	var nInput = $("#buyer-name");
	var pInput = $("#buyer-phone");
	var nError = $("#name-check-null");
	var pError = $("#phone-check-null");
	
	if(isNull(nInput,nError) || isNull(pInput,pError)){
		return false;
	}
	
	var name = $("#buyer-name").val().trim();
	var tel = $("#buyer-phone").val().trim();
	var email = $("#buyer-email").val().trim();
	
	var courses = new Array();
	var courseName = "";
	
	class Course { 
		constructor (course_seq,amounted_pay,course_available_period) { 
			this.course_seq = course_seq; 
			this.amounted_pay = amounted_pay; 
			this.course_available_period = course_available_period; 
		} 
	}
	class OrderList{
		constructor (member_id, courses, buyer_name, buyer_phone, buyer_email) { 
			this.member_id = member_id; 
			this.courses = courses; 
			this.buyer_name = buyer_name; 
			this.buyer_phone = buyer_phone; 
			this.buyer_email = buyer_email; 
		}
	}
	
	$(".select-check").each(function(i){
		if($(this).prop("checked")){
			courseName += "<br>" + $(this).data("nm");
			var course = new Course($(this).data("seq"),0,$(this).data("period"));
			courses.push(course);
		}
	});
	courseName = courseName.substr(4);
	var orderList = new OrderList("${user.member_id}",courses,name,tel,email);
	Swal.fire({
		  title: courseName,
		  text: courses.length + '개의 강의를 구매하시겠습니까?', 
		  icon: "question",
		  showCancelButton: true,
		  confirmButtonText: '구매',
		  cancelButtonText: '취소',
		}).then((result) => {
		  if (result.isConfirmed) {
		    $.ajax({
		    	url: "${path}/order/purchaseFreeCourses",
		    	type: "post",
		    	dataType: "json",
		    	contentType : "application/json; charset=UTF-8",
		    	data: JSON.stringify(orderList),
		    	success: function(data){
		    		var ajaxResult = data.result;
		    		var error = data.error;
		    		var msg = data.msg;
		    		var link = data.link;
		    		if(ajaxResult){
		    			Confirm(msg,"success","${path}"+link);
		    		}else{
		    			if(error == 'duplicated'){
		    				Confirm(msg,'warning',"${path}"+link);
		    			}else if(error == 'deleteFailed'){
		    				Swal.fire({
				  				  icon: 'error',
				  				  title: '구매 실패',
				  				  html: msg,
				  				  showConfirmButton: false,
				  				  timer: 1500
				  				})
		    			}else{
		    				Swal.fire({
				  				  icon: 'error',
				  				  title: '구매 실패',
				  				  html: msg,
				  				  showConfirmButton: false,
				  				  timer: 1500
				  				})
		    			}
		    		}
		    	}
		    })
		 }
	})
}
function moveToWishList(seq){
		$.ajax({
			url : "${path}/order/moveToWishList",
			type : "post",
			dataType : "json",
			data : { "member_id" : "${user.member_id}",
					"course_seq" : seq},
			success : function(data){
				var result = data.result;
				var error = data.error;
				var msg = data.msg;
				if(result == 'true'){
					Confirm(msg,"success","${path}/order/wishList");
				}else{
					if(error == 'duplicated'){
						Confirm(msg,"warning","${path}/order/wishList");
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
function deleteFromCart(seq){
	$.ajax({
		url : "${path}/order/deleteFromCart",
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
$("#buyer-name").on("change input",function(){
	var error = $("#name-check-null");
	if(isNull($(this),error)){
		return false;
	}
});
$("#buyer-phone").on("change input",function(){
	var value = $(this).val().trim();
	var btn = $("#btn-phone");
	
	if(value == "${user.member_phoneNO}"){
		btn.prop("disabled",true);
	}else{
		btn.prop("disabled",false);
	}
	var error = $("#phone-check-null");
	if(isNull($(this),error)){
		return false;
	}
	
	var phoneExp = /^010-?([0-9]{4})-?([0-9]{4})$/;
	
	if(phoneExp.test(value)){
		$("#phone-check-exp").css("display","none");
		$(this).css("background","");
	}else{
		$("#phone-check-exp").css("display","block");
		$(this).css("background","var(--accent-color)").focus();
		return false;
	}
});

function changePhoneNo(){
	var input = $("#buyer-phone");
	var error = $("#phone-check-null");
	var value = $("#buyer-phone").val().trim();
	
	if(isNull(input,error)){
		return false;
	}
	
	var phoneExp = /^010-?([0-9]{4})-?([0-9]{4})$/;
	
	if(phoneExp.test(value)){
		$("#phone-check-exp").css("display","none");
		input.css("background","");
	}else{
		$("#phone-check-exp").css("display","block");
		input.css("background","var(--accent-color)").focus();
		return false;
	}
	Swal.fire({
		  title: value,
		  text: '해당 번호로 정보를 변경하시겠습니까?',
		  icon:"question",
		  showCancelButton: true,
		  confirmButtonText: '저장',
		  cancelButtonText: '취소',
		}).then((result) => {
		  if (result.isConfirmed) {
			$.ajax({
				url : '${path}/mypage/changePhoneNo',
				type: 'post',
				dataType : 'json',
				data : { "member_id" : "${user.member_id}",
						"member_phoneNO" : value},
				success : function(data){
					var result = data.result;
					var msg = data.msg;
					if(result == 'true'){
						Swal.fire({
							  icon: 'success',
							  title: msg,
							  showConfirmButton: false,
							  timer: 1500
							})
						setTimeout("location.reload()", 1550);
					}else{
						Swal.fire({
							  icon: 'error',
							  title: msg,
							  showConfirmButton: false,
							  timer: 1500
							})
					}
					
				}
			}) 
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