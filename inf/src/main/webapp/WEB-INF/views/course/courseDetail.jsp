<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<style>
#course-detail-header .star-wrapper span{
	padding: 0;
}
#course-detail-header .star-wrapper .checked{
	color: orange;
}
#course-detail-header .c-rating-star{
	display:inline-block;
	width : max-content;
	position: relative;
}
#course-detail-header .real-star{
  position: absolute;
  z-index: 1;
  top: 0;
  left: 0;
  overflow: hidden;
  white-space: nowrap;
}
#course-detail-header .bg-star {
  z-index: 0;
  padding: 0;
}
</style>
<link rel="stylesheet" href="/resources/css/courseDetail.css" />

<section id="course-detail-header" class="container-fluid">
	<div class="header-wrapper container">
		<div class="course-img-web">
			<img
				src="${path }/detail/thumbnails?img_nm=${course.course_img_nm}&course_seq=${course.course_seq}"
				style="width: 300px;height:200px;object-fit:cover;border:none;border-radius: 1em;">
		</div>
		<div class="course-img-mobile">
			<img
				src="${path }/thumbnails?img_nm=${course.course_img_nm}&course_seq=${course.course_seq}"
				style="width: 300px;height:200px;object-fit:cover;border:none;border-radius: 1em;">
		</div>
		<div class="course_content">
			<h6 class="c_category white-font">
				<c:forEach items="${course.ct_list }" var="ct">
					<span class="white-font">${ct.category_nm }</span>
				</c:forEach>
			</h6>
			<h4 class="c_title white-font">${course.course_NM }</h4>
			<div class="c-rating-star">
				<div class="star-wrapper bg-star">
					<span class="fa fa-star gray-font"></span> 
					<span class="fa fa-star gray-font"></span> 
					<span class="fa fa-star gray-font"></span> 
					<span class="fa fa-star gray-font"></span> 
					<span class="fa fa-star gray-font"></span> 
				</div>
				<div class="star-wrapper real-star" style="width: <fmt:formatNumber type="number" maxFractionDigits="0" value="${course.course_rating.rate *20 }" />%;">
					<span class="fa fa-star checked"></span> 
					<span class="fa fa-star checked"></span> 
					<span class="fa fa-star checked"></span> 
					<span class="fa fa-star checked"></span> 
					<span class="fa fa-star checked"></span> 
				</div>
			</div>
			<div class="c-info" style="font-size: 0.8em;display: inline-block;">
				<span class="c_rating_avg white-font"><strong>(${course.course_rating.rate })</strong></span> 
				<span class="c_rating_cnt white-font" style="margin-left: 1em;"><strong>${course.course_rating.count }개</strong>의 수강평 | </span> 
				<span class="c_study_cnt white-font"><strong>${course.course_studyCNT }명</strong>의 수강생</span>
			</div>
			<h6 class="c_mento_id">
				<a class="white-font" href="#!">${course.member_id }</a>
			</h6>
		</div>
	</div>
</section>

<section id="course-detail-body" class="container">
	<div class="detail-body-wrapper">
		<div class="course-info">
			<div class="tab">
				<button class="tablinks btn" onclick="openTab(event, 'dt-c-info')">강의소개</button>
				<button class="tablinks btn" onclick="openTab(event, 'dt-c-rating')">수강평</button>
				<button class="tablinks btn" onclick="openTab(event, 'dt-c-news')">새
					소식</button>
			</div>

			<div id="dt-c-info" class="tabcontent">
				<h3>강의 소개</h3>
				${course.course_intro }
			</div>

			<div id="dt-c-rating" class="tabcontent">
				<h3>수강평</h3>
			</div>

			<div id="dt-c-news" class="tabcontent">
				<h3>새 소식</h3>
			</div>


		</div>
		<div class="course-purchase">
			<div class="c_price">
				<h4>
					<c:choose>
						<c:when test="${course.course_price == 0 }">
						<strong>무료</strong>
						</c:when>
						<c:when test="${course.course_sales_price > 0 }">
						<p class="badge rounded-pill bg-primary" style="font-size: 0.7em;display: block;width: max-content;margin:auto;">
						${course.course_discount_rate }%</p>
						<span class="gray-font line-through" style="font-size: 0.7em;">${course.course_price }</span>
						<fmt:formatNumber value="${course.course_sales_price }"
							pattern="#,###원" />
						</c:when>
						<c:otherwise>
						<fmt:formatNumber value="${course.course_price }"
							pattern="#,###원" />
						</c:otherwise>
					</c:choose>
				</h4>
			</div>
			<div class="pc_btn my-2">
				<button type="button" class="btn btn-success" onclick="location.href='${path}/order/${course.course_seq}'">
					<span class="white-font">바로 구매하기</span>
				</button>
			</div>
			<div class="sv_btn">
				<c:choose>
					<c:when test="${user != null }">
						<button type="button" class="btn btn-outline-primary" style="border: none;"
						onclick="addToCart(${course.course_seq})">
						<i class="fas fa-cart-plus"></i> 장바구니 </button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-outline-primary" style="border: none;"
						onclick="showLoginModal()">
						<i class="fas fa-cart-plus"></i> 장바구니 </button>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${user != null }">
						<button type="button" class="btn btn-outline-danger" style="border: none;"
						onclick="addToWishList(${course.course_seq})">
						<i class="far fa-heart"></i> 위시리스트 </button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-outline-danger" style="border: none;"
						onclick="showLoginModal()">
						<i class="far fa-heart"></i> 위시리스트 </button>
					</c:otherwise>
				</c:choose>
				
				
			</div>
			<div class="info my-2">
				<ul style="padding: 0; margin: 0;">
					<li>지식공유자 : ${course.member_id }</li>
					<li><c:choose>
					<c:when test="${course.course_available_period == null || course.course_available_period == 0}">
					평생 <strong>무제한</strong> 수강
					</c:when>
					<c:otherwise>
					<strong>${course.course_available_period }개월</strong> 수강 가능
					</c:otherwise>
						</c:choose></li>
					<li><strong>${course.course_level }</strong> 대상</li>
				</ul>
			</div>
		</div>
		<div class="course-purchase-mobile"></div>
	</div>
</section>

<script type="text/javascript">
	$(document).ready(function() {
		if("${isExits}"){
			Swal.fire({
				  icon: 'warning',
				  text: "${msg}",
				  timer: 1500
				});
		}
		openTab("click","dt-c-info");
	});
	
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
							});
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
	
	function openTab(evt, tabName) {
		var i, tabcontent, tablinks;
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		tablinks = document.getElementsByClassName("tablinks");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className
					.replace(" active", "");
		}
		document.getElementById(tabName).style.display = "block";
		evt.currentTarget.className += " active";
	}
</script>

<%@ include file="../common/footer.jsp"%>
