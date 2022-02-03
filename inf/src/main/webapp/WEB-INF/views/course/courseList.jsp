<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<link rel="stylesheet" href="/resources/css/courseList.css" />
<link rel="stylesheet" href="/resources/css/course.css" />

<style>
section#nav-category #layoutSidenav {
	display: block;
	width: 100%;
	min-height: max-content;
}

section#nav-category #layoutSidenav #layoutSidenav_nav {
	width: 100%;
	min-width: max-content;
	height: max-content;
	position: relative;
}

section#nav-category #layoutSidenav #layoutSidenav_nav .sb-sidenav {
	padding-top: 0;
}

#course_list .c-rating-star {
	display: inline-block;
	width: max-content;
	position: relative;
}

#course_list .real-star {
	position: absolute;
	z-index: 1;
	top: 0;
	left: 0;
	overflow: hidden;
	white-space: nowrap;
}

#course_list .bg-star {
	z-index: 0;
	padding: 0;
}
</style>

<div class="container" id="course-list-wrapper">

	<section id="nav-category">
		<div id="layoutSidenav">
			<div id="layoutSidenav_nav">
				<nav class="sb-sidenav accordion sb-sidenav-light"
					id="sidenavAccordion">
					<div class="sb-sidenav-menu">
						<div class="nav">
							<div class="sb-sidenav-menu-heading">
								<i class="fas fa-book-open"></i>
								<a href="${path }/courses" class="dark-font"> 전체 강의</a>
							</div>
							<c:forEach items="${ctMap }" var="ct" varStatus="vs">
								<a class="nav-link collapsed"
									href="${path }/courses/${ct.category_seq}"
									data-bs-toggle="collapse"
									data-bs-target="#collapse${vs.count }" aria-expanded="false"
									aria-controls="collapseLayouts">
									<div class="sb-nav-link-icon">
										<i class="fas fa-columns"></i>
									</div> ${ct.category_nm }
									<div class="sb-sidenav-collapse-arrow">
										<i class="fas fa-angle-down"></i>
									</div>
								</a>
								<div class="collapse" id="collapse${vs.count }"
									aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
									<nav class="sb-sidenav-menu-nested nav">
										<a class="nav-link" href="${path }/courses/${ct.category_seq}"><strong>ALL</strong></a>
										<c:forEach items="${ct.skill_list }" var="sk">
											<a class="nav-link"
												href="${path }/courses/${ct.category_seq}/${sk.skill_seq}">${sk.skill_nm }</a>
										</c:forEach>
									</nav>
								</div>
							</c:forEach>
						</div>
					</div>
				</nav>
			</div>
		</div>
		<div id="accordion">
	<div class="acoordion-container">
		<div>
			<div class="acoordion-header" id="levelheader">
			<a>난이도</a>
			</div>
			<div class="acoordoion-body" id="level">
				<form name="level_select" action="#">
					<div class="acoordion-content">
					<input type="checkbox" id="level1" name="level1" value="beginner">
					<label for="level1">입문</label>
					</div>
					<div>
					<input type="checkbox" id="level2" name="level2" value="basic">
					<label for="level2">초급</label>
					</div>
					<div>
					<input type="checkbox" id="level3" name="level3" value="intermediate">
					<label for="level3">중급이상</label>
					</div>
				</form>
			</div>
		</div>
		<div>
			<div class="acoordion-header">
			<a>무료/유료/할인중</a>
			</div>
			<div class="acoordoion-body" id="priceContent">
			<form name="price_select" action="#">
					<div class="acoordion-content">
					<input type="checkbox" id="price1" name="price1" value="free">
					<label for="price1">무료</label>
					</div>
					<div>
					<input type="checkbox" id="price2" name="price2" value="pay">
					<label for="price2">유료</label>
					</div>
					<div>
					<input type="checkbox" id="price3" name="price3" value="sale">
					<label for="price3">할인중</label>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
	</section>

	<section id="course_list">
			<div class="my-2">
				<p id="s-null-check" style="display:none;font-weight:bold;text-align: center;">검색어를 입력하세요!</p>
			</div>
		<div class="courses_container courses_body">
			<!-- courses_header -->
			<header class="courses_header">
				<!-- 상단 중앙 서치바 -->
				<div class="course_search_div">
					<form id="course-search" class="course_search" action="${path }/course/search" method="post" >
						<!-- search select -->
						<div class="course-search-select">
							<select id="s-type" name="type">
								<option value="all" selected="selected">전체</option>
								<option value="all">전체</option>
								<option value="name">강의명</option>
								<option value="skill">기술명</option>
							</select>
						</div>
						<!-- input search -->
						<input id="s-item" type="text" placeholder="Search.." name="item">
						<button type="button" class="text-light" onclick="searchCourse()">
							<i class="fa fa-search"></i>
						</button>
					</form>
				</div>
				<!-- 상단 중앙 서치바 end -->
			</header>
			<!-- courses_header end -->
			
			<!-- courses main start -->
			<main class="courses_main">

				<!-- courses_breadcrumb start -->
				<nav class="courses_breadcrumb">
					<ul>
						<li><a href="/courses" class="category_link">전체</a></li>
					</ul>
					<!-- 정렬 순서 선택 -->
					<div class="courses_order_select">
						<select class="form-select" id="sort-item">
							<option id="recent" value="recent">최신순</option>
							<option id="rating" value="rating">평점순</option>
							<option id="famous" value="famous">학생순</option>
						</select>
					</div>
				</nav>
				<!-- courses_breadcrumb end -->

				<!-- courseList start -->
				<div class="courses_card_list_body">
	
					<c:if test="${course != null}">
						<c:forEach var="i" items="${course }">
							<div class="box media course_card_item">
								<div class="course-thumbnail">
									<a href="${path }/course/${i.course_seq}"> <!-- 썸네일 --> <img class="img-thumbnail"
										alt="thumbnail" src="${path }/thumbnails?course_seq=${i.course_seq}&img_nm=${i.course_img_nm}"
										style="width: 200px;height:100px;object-fit:cover;border:none;border-radius: 1em;">
									</a>
								</div>
								<!-- content 시작 -->
								<div class="course_list_content_container">
									<a class="course_info" href="${path }/course/${i.course_seq}"> <!-- 카테고리 -->
									<span class="course_category gray-font"> 
									<c:forEach items="${i.ct_list }" var="ct">
										${ct.category_nm }
									</c:forEach>
									</span>
									 <!-- title -->
										<strong class="course_title">${i.course_NM }<span
											class="badge bg-secondary levelbadge">${i.course_level }</span>
									</strong> <!-- tags -->
									
									<div class="tags">
									<c:forEach items="${i.skill_list }" var="skill">
										<span class="badge rounded-pill bg-success">${skill.skill_nm }</span>
									</c:forEach>
									</div>
										 <!-- 별점 -->
										<div class="c-rating-star">
											<div class="star-wrapper bg-star">
												<span class="fa fa-star gray-font"></span> <span
													class="fa fa-star gray-font"></span> <span
													class="fa fa-star gray-font"></span> <span
													class="fa fa-star gray-font"></span> <span
													class="fa fa-star gray-font"></span>
											</div>
											<div class="star-wrapper real-star"
												style="width: <fmt:formatNumber type="number" maxFractionDigits="0" value="${i.course_rating.rate *20 }" />%;">
												<span class="fa fa-star checked"></span> <span
													class="fa fa-star checked"></span> <span
													class="fa fa-star checked"></span> <span
													class="fa fa-star checked"></span> <span
													class="fa fa-star checked"></span>
											</div>
										</div>
										<span class="c_rating_avg dark-font">(${i.course_rating.rate })</span>
									</a>
									<!-- 가격 -->
									<div class="course_price">
									
										<div class="product_amount">
											<c:choose>
											<c:when test="${i.course_sales_price != null && i.course_sales_price != 0}">
													<span class="gray-font line-through" >${i.course_price }</span>
													<span class="dark-font pay_price"><strong>${i.course_sales_price }</strong></span>
											</c:when>
											<c:when test="${i.course_price == 0}">
												<h6 class="dark-font pay_price">
													<strong>무료</strong>
												</h6>
											</c:when>
											<c:otherwise>
												<span class="dark-font pay_price">${i.course_price }</span>
											</c:otherwise>
										</c:choose>
										</div>

										<div class="cart_btn_container ">
											
											<c:choose>
												<c:when test="${user != null}">
													<!-- 카트 버튼 -->
													<button type="button" class="btn " data-bs-toggle="tooltip"
														data-bs-placement="left" title="장바구니에 추가하기"
														onclick="addToCart(${i.course_seq})">
														<i class="fa fa-shopping-cart"></i>
													</button>
													<!-- 위시리스트 버튼 -->
													<button type="button" class="btn " data-bs-toggle="tooltip"
														data-bs-placement="left" title="위시리스트에 추가하기"
														onclick="addToWishList(${i.course_seq})">
														<i class="far fa-heart"></i>
													</button>
												</c:when>
												<c:otherwise>
															<button type="button" class="btn " data-bs-toggle="tooltip"
														data-bs-placement="left" title="장바구니에 추가하기"
														onclick="showLoginModal()">
														<i class="fa fa-shopping-cart"></i>
													</button>
													<!-- 위시리스트 버튼 -->
													<button type="button" class="btn " data-bs-toggle="tooltip"
														data-bs-placement="left" title="위시리스트에 추가하기"
														onclick="showLoginModal()">
														<i class="far fa-heart"></i>
													</button>
												</c:otherwise>
											</c:choose>
											
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
				<!-- courseList end -->
			</main>
			<!-- courses main end -->

			<footer class="courses_footer">
				<!-- paging 처리 -->
			</footer>
		</div>
	</section>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		if("${sort}" != null || "${sort}" != "" ){
			var sortType = "#"+"${sort}";
			$(sortType).prop("selected",true);
		}
	});
	
	$("div.acoordion-header").on('click', function() {
		$(this).next(".acoordoion-body").slideToggle(100);
	});
	
	function searchCourse(){
		let input = $("#s-item");
		let type = $("#s-type option:selected").val();
		let val = input.val().trim();
		let valid = $("#s-null-check");
		if(val == "" || val == null){
			input.focus();
			valid.css("display","block");
			return;
		}else{
			valid.css("display","none");
		}
		
		$("#course-search").submit();
	}
	
	$("#sort-item").on('select change',function(){
		location.href = '${path}/courses?order='+$(this).val();
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
</script>


<%@ include file="../common/footer.jsp"%>