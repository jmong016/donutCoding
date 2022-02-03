<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<style>
#course-order {
	display: flex;
	text-align: center;
}
#course-order #course {
	width: 65%;
	height: 80%;
	margin: auto;
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
}
#course-order #course>div {
	text-align: center;
}

#course-order #purchase {
	width: 34.9%;
}

#course-order .price{
	border: 1px solid var(--gray-color);
	border-radius:2em;
	padding: 0.5em;
}

#course-order #purchase>div {
	width: 80%;
	min-width: max-content;
	margin: 0.5em auto;
}

#course-order .input p, input {
	text-align: center;
}
#course-order .validiate{
	color: var(--main-color);
	font-weight:bold;
	display:none;
}
#course-order .thumbnail:hover{
	cursor: pointer;
}
</style>

<div class="container p-3 my-2 white-bg"
	style="border-radius: 1em; border: none;">
	<h3 style="text-align: center;">강의 바로 결제</h3>
</div>

<section id="course-order" class="container">
	<!-- 강의 -->
	<div id="course" class="p-2 my-auto mx-auto">
		<div class="thumbnail" onclick="location.href='${path }/course/${course.course_seq }'">
			<img alt="${course.course_NM }"
				src="${path }/thumbnails?course_seq=${course.course_seq}&img_nm=${course.course_img_nm}"
				style="width: 150px; height: 100px; object-fit: cover; border: none; border-radius: 1em;">
		</div>

		<div class="info my-auto mx-auto">
			<h5>
				<a class="dark-font" href="${path }/course/${course.course_seq}">${course.course_NM }</a>
			</h5>
			<c:choose>
				<c:when test="${course.course_available_period > 0}">
					<p>(수강 기한 : ${course.course_available_period }개월)</p>
				</c:when>
				<c:otherwise>
					<p>(수강 기한 : 무제한)</p>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="other my-auto mx-auto">
			<c:choose>
				<c:when test="${course.course_price == 0 }">
					<h5>무료</h5>
				</c:when>
				<c:when test="${course.course_sales_price > 0 }">
					<p class="line-through gray-font">
						<fmt:formatNumber value="${course.course_price }" pattern="#,###원" />
					</p>
					<h5>
						<span class="badge rounded-pill bg-primary"
							style="font-size: 0.6em; width: max-content; margin: auto;">
							${course.course_discount_rate }%</span>
						<fmt:formatNumber value="${course.course_sales_price }"
							pattern="#,###원" />
					</h5>
				</c:when>
				<c:otherwise>
					<fmt:formatNumber value="${course.course_price }" pattern="#,###원" />
				</c:otherwise>
			</c:choose>
			<button type="button" class="btn btn-outline-light text-dark"
				onclick="addToWishList(${course.course_seq})" style="display: block;margin: auto;">위시리스트로 이동</button>
			<button type="button" class="btn btn-outline-light text-dark"
				onclick="addToCart(${course.course_seq})" style="display: block;margin: auto;">장바구니로 이동</button>
		</div>

	</div>

	<!-- 구매 정보 및 버튼 -->
	<div id="purchase" class="p-3">
		<div class="price">
			<c:choose>
				<c:when test="${course.course_price == 0 }">
					<h4>무료</h4>
				</c:when>
				<c:when test="${course.course_sales_price > 0 }">
					<h4>
						<fmt:formatNumber value="${course.course_sales_price }"
							pattern="#,###원" />
					</h4>
					<input id="price-for-pay" type="number" value="${course.course_sales_price }" hidden="hidden">
				</c:when>
				<c:otherwise>
					<h4>
						<fmt:formatNumber value="${course.course_price }" pattern="#,###원" />
					</h4>
					<input id="price-for-pay" type="number" value="${course.course_price }" hidden="hidden">
				</c:otherwise>
			</c:choose>
		</div>

		<div class="member-id input mb-2">
			<p>
				<strong>이름</strong>
			</p>
			<p id="name-check-null" class="validiate">구매인 성명을 입력하세요.</p>
			<input id="buyer-name" type="text" class="form-control" value="${user.member_nickNM }"
				name="member_id" placeholder="구매인 성명" maxlength="6" size="6">
		</div>
		<div class="member-phone input mb-2">
			<p>
				<strong>휴대폰 번호</strong>
			</p>
			<p id="phone-check-null" class="validiate">구매인 연락처를 입력하세요.</p>
			<p id="phone-check-exp" class="validiate">전화번호 형식이 일치하지 않습니다.</p>
			<div class="input-group">
				<input id="buyer-phone" type="text" class="form-control"
					value="${user.member_phoneNO }" name="member_phoneNO"
					placeholder=" ex) 01012345678" maxlength="11">
				<button id="btn-phone" class="btn btn-primary" type="button" onclick="changePhoneNo()"
				disabled="disabled">수정</button>
			</div>
		</div>
		<div class="member-email input">
			<p>
				<strong>이메일 주소</strong>
			</p>
			<input id="buyer-email" type="text" class="form-control" value="${user.member_email }"
				name="member_email" readonly="readonly">
		</div>
		
		<c:choose>
			<c:when test="${course.course_price == 0 }">
				<div class="btn-wrapper mt-3">
					<button type="button" class="btn btn-success" style="width: 100%;"
					onclick="purchaseFreeCourse(${course.course_seq})">
					바로 구매하기</button>
				</div>
			</c:when>
			<c:otherwise>
				<div class="method input">
					<p>
						<strong>결제 수단</strong>
					</p>
					<button type="button" class="btn btn-outline-light text-dark" onclick="pay('이니시스')">
						<i class="far fa-credit-card"></i> 신용카드 결제
					</button>
					<button type="button" class="btn btn-outline-light text-dark" onclick="pay('kakaopay')">
						<img src="/resources/images/icons/kakao_pay_icon.png"
							style="height: 1.2em;"> 카카오페이 결제
					</button>
				</div>
			</c:otherwise>
		</c:choose>
		
	</div>

</section>

<script type="text/javascript">
function pay(pg){
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
	var price = $("#price-for-pay").val().trim();
	//가맹점 식별코드
	IMP.init('imp49078716');
	IMP.request_pay({
	    pg : pg,
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : "${course.course_NM}" , //결제창에서 보여질 이름
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
		    	url: "${path}/order/purchaseDirect",
		    	type: "post",
		    	dataType: "json",
		    	data:{
		    		"member_id":"${user.member_id}",
		    		"course_seq":"${course.course_seq}",
		    		"buyer_name" : name,
		    		"buyer_phone" : tel,
		    		"buyer_email" : email,
		    		"amounted_pay" : price,
		    		"course_available_period" : "${course.course_available_period }"
		    	},
		    	success: function(data){
		    		var ajaxResult = data.result;
		    		var error = data.error;
		    		var msg = data.msg;
		    		if(ajaxResult == 'true'){
		    			Confirm(msg,"success","${path}/mypage/course");
		    		}else{
		    			if(error == 'duplicated'){
		    				Confirm(msg,'warning',"${path}/mypage/course");
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
function purchaseFreeCourse(seq){
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
	Swal.fire({
		  title: '${course.course_NM}',
		  text: '구매하시겠습니까?', 
		  icon: "question",
		  showCancelButton: true,
		  confirmButtonText: '구매',
		  cancelButtonText: '취소',
		}).then((result) => {
		  if (result.isConfirmed) {
		    $.ajax({
		    	url: "${path}/order/purchaseDirect",
		    	type: "post",
		    	dataType: "json",
		    	data:{
		    		"member_id":"${user.member_id}",
		    		"course_seq":"${course.course_seq}",
		    		"buyer_name" : name,
		    		"buyer_phone" : tel,
		    		"buyer_email" : email,
		    		"amounted_pay" : 0,
		    		"course_available_period" : "${course.course_available_period }"
		    	},
		    	success: function(data){
		    		var ajaxResult = data.result;
		    		var error = data.error;
		    		var msg = data.msg;
		    		if(ajaxResult == 'true'){
		    			Confirm(msg,"success","${path}/mypage/course");
		    		}else{
		    			if(error == 'duplicated'){
		    				Confirm(msg,'warning',"${path}/mypage/course");
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

function addToWishList(seq){
		$.ajax({
			url : "${path}/order/addToWishList",
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
					}else if(error == 'duplicated-purchase') {
						Confirm(msg,"warning","${path}/mypage/course");
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
function addToCart(seq){
	$.ajax({
		url : "${path}/order/addToCart",
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
				}else if(error == 'duplicated-purchase') {
					Confirm(msg,"warning","${path}/mypage/course");
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
	
	if(value == null || value == ""){
		$("#phone-check-null").css("display","block");
		$(this).css("background","var(--accent-color)").focus();
		return false;
	}else{
		$("#phone-check-null").css("display","none");
		$(this).css("background","");
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
		$("#buyer-phone").css("background","");
	}else{
		$("#phone-check-exp").css("display","block");
		$("#buyer-phone").css("background","var(--accent-color)").focus();
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
function purchaseCourse(seq){
	var name = $("#member_name");
	var phone = $("#member_phoneNO");
	var nError = $("#name-check-null");
	var pError = $("#phone-check-null");
	
	if(isNull(name,nError) || isNull(phone,pError)){
		return false;
	}
	
	$.ajax({
		url : "${path}/order/purchaseCourse",
		type : "post",
		dataType : "json",
		data : {"member_id" : "${user.member_id}",
				"course_seq" : seq,
				"member_name" : name.val().trim(),				
				"member_phoneNO" : phone.val().trim(),
				"member_email" : "${user.member_email}"
				},
		success : function(data){
			var result = data.result;
			var error = data.error;
			var msg = data.msg;
			if(result == 'true'){
				Confirm(msg,"success");
			}else{
				if(error == 'duplicated'){
					Confirm(msg,"warning");
				}else{
					swal("", msg, "error");
				}
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